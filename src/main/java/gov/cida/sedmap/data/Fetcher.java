package gov.cida.sedmap.data;

import gov.cida.sedmap.io.FileDownloadHandler;
import gov.cida.sedmap.io.FileInputStreamWithFile;
import gov.cida.sedmap.io.IoUtils;
import gov.cida.sedmap.io.WriterWithFile;
import gov.cida.sedmap.io.util.StringValueIterator;
import gov.cida.sedmap.ogc.OgcUtils;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.opengis.filter.Filter;

public abstract class Fetcher {

	public static final String SEDMAP_DS = "java:comp/env/jdbc/sedmapDS";

	private static final Logger logger = Logger.getLogger(Fetcher.class);

	protected static String NWIS_URL = "http://waterservices.usgs.gov/nwis/dv/?format=_format_&sites=_sites_&startDT=_startDate_&endDT=_endDate_&statCd=00003&parameterCd=00060";

	public static FetcherConfig conf;


	protected String getDataTable(String descriptor) {
		return conf.DATA_TABLES.get(descriptor);
	}
	protected List<Column> getTableMetadata(String tableName) {
		return conf.getTableMetadata(tableName);
	}
	protected Context getContext() throws NamingException {
		return conf.getContext();
	}


	public abstract Fetcher initJndiJdbcStore(String jndiJdbc) throws IOException;

	protected abstract InputStream handleLocalData(String descriptor, Filter filter, Formatter formatter)
			throws IOException, SQLException, NamingException;

	protected InputStream handleNwisData(Iterator<String> sites, Filter filter, Formatter formatter)
			throws IOException, SQLException, NamingException {
		String url = NWIS_URL;

		// NWIS offers RDB only
		String format = "rdb";
		Formatter rdb = new RdbFormatter();
		url = url.replace("_format_",    format);

		// extract expressions from the filter we can handle
		String yr1 = OgcUtils.findFilterValue(filter, "yr1");
		String yr2 = OgcUtils.findFilterValue(filter, "yr1");

		// translate the filters to NWIS Web query params
		String startDate = yr1 + "-01-01"; // Jan  1st of the given year
		String endDate   = yr2 + "-12-31"; // Dec 31st of the given year

		url = url.replace("_startDate_", startDate);
		url = url.replace("_endDate_",   endDate);

		// open temp file
		WriterWithFile tmp = IoUtils.createTmpZipWriter("daily_data", formatter.getFileType());
		try {
			while (sites.hasNext()) {
				int batch = 0;
				String sep = "";
				StringBuilder siteList = new StringBuilder();

				// site list should be in batches of 99 site IDs
				while (batch++<99 && sites.hasNext()) {
					siteList.append(sep).append(sites.next());
					sep=",";
				}
				String sitesUrl = url.replace("_sites_",   siteList);

				// fetch the data from NWIS
				BufferedReader nwis = null;
				try {
					nwis = fetchNwisData(sitesUrl);

					String line;
					while ((line = nwis.readLine()) != null) {
						// translate from NWIS format to requested format
						line = formatter.transform(line, rdb);
						tmp.write(line);
					}
				} finally {
					IoUtils.quiteClose(nwis);
				}
			}
			// TODO
			// } catch (Exception e) {
			//     tmp.deleteFile();
		} finally {
			IoUtils.quiteClose(tmp);
		}

		return IoUtils.createTmpZipStream( tmp.getFile() );
	}

	protected BufferedReader fetchNwisData(String urlStr) throws IOException {
		URL url = new URL(urlStr);
		URLConnection cn = url.openConnection();
		BufferedReader reader = new BufferedReader(new InputStreamReader(cn.getInputStream()));

		return reader;
	}


	public void doFetch(HttpServletRequest req, FileDownloadHandler handler)
			throws ServletException, IOException {
		logger.debug("doFetch");

		String    dataTypes = getDataTypes(req);
		Formatter formatter = getFormatter(req);

		handler.beginWritingFiles(); // start writing files

		Iterator<String> dailySites = null;

		for (String site  : conf.DATA_TYPES) { // check for daily and discrete
			if ( ! dataTypes.contains(site) ) continue;

			String    ogcXml = getFilter(req, site);
			Filter    filter = OgcUtils.ogcXml2Filter(ogcXml);

			for (String value : conf.DATA_VALUES) { // check for sites and data
				if ( ! dataTypes.contains(value) ) continue;

				StringBuilder   name = new StringBuilder();
				String    descriptor = name.append(site).append('_').append(value).toString();
				String      filename = descriptor + formatter.getFileType();

				InputStream fileData = null;
				try {
					if ( "daily_data".equals(descriptor) ) {
						fileData = handleNwisData(dailySites, filter, formatter);
					} else {
						fileData = handleLocalData(descriptor, filter, formatter);
						if (descriptor.contains("daily")) dailySites = makeSiteIterator(fileData, formatter);
					}
					handler.writeFile(formatter.getContentType(), filename, fileData);

				} catch (Exception e) {
					logger.error("failed to fetch from DB", e);
					// TODO empty results and err msg to user
					return;
				} finally {
					IoUtils.quiteClose(fileData);
				}
			}
		}
		handler.finishWritingFiles(); // done writing files

	}


	// TODO this needs a bit of finessing because we want to be able to read the site data twice.
	// once for the use return download and again for the NWIS site list.
	// right now, it assumes that the data comes from a cached file.
	// it uses the formatter that created the file to know how to split the file
	protected Iterator<String> makeSiteIterator(InputStream fileData, Formatter formatter) throws IOException {

		LinkedList<String> sites = new LinkedList<String>();

		if (fileData instanceof FileInputStreamWithFile) {
			File file = ((FileInputStreamWithFile) fileData).getFile();
			InputStreamReader in  = new InputStreamReader( IoUtils.createTmpZipStream(file) );
			BufferedReader reader = new BufferedReader(in);

			String line;
			while ( (line=reader.readLine()) != null ) {
				int pos = line.indexOf( formatter.getSeparator() );
				if (pos == -1) continue; // trap empty lines
				String site = line.substring(0, pos );
				// only preserve site numbers and not comments or header info
				if (site.matches("^\\d+$")) {
					sites.add(site);
				}
			}
		}

		return new StringValueIterator( sites.iterator() );
	}



	protected String getFilter(HttpServletRequest req, String dataType) {
		String ogcXml = req.getParameter(dataType+"Filter");

		if (ogcXml == null) {
			logger.warn("Failed to locate OGC 'filter' parameter - using default");
			// TODO empty result
			return "";
		}

		return ogcXml;
	}



	protected String getDataTypes(HttpServletRequest req) {
		String types = req.getParameter("dataTypes");

		// expecting a string with terms "daily_discrete_sites_data" in it
		// sites means site data - no samples
		// data  means site data - no site info
		// daily and discrete refer to samples
		// - "daily_discrete_sites_data" means they want all data
		// - "daily_sites" means they want all daily site info only

		if (types == null) {
			logger.warn("Failed to locate 'dataTypes' parameter - using default");
			types = "daily_discrete_sites";
		}

		return types;
	}



	protected Formatter getFormatter(HttpServletRequest req) {
		String format = req.getParameter("format");
		format = conf.FILE_FORMATS.containsKey(format) ?format :"rdb";

		Formatter formatter = null;
		try {
			formatter = conf.FILE_FORMATS.get(format).newInstance();
		} catch (Exception e) {
			logger.warn("Could not instantiate formatter for '" +format+"' with class "
					+conf.FILE_FORMATS.get(format)+". Using RDB as fall-back.");
			formatter = new RdbFormatter();
		}

		return formatter;
	}

}
