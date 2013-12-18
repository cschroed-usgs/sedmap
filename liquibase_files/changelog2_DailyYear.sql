--liquibase formatted sql

--This is for the sedmap schema

--changeset duselman:CreateDailyYearTable
create table daily_year (
  SITE_NO varchar2(15),
  SAMPLE_YEAR number(4)
);
alter table daily_year add constraint 
daily_year_pk primary key(SITE_NO,SAMPLE_YEAR);
grant select on daily_year to seduser;
-- rollback drop table daily_year;


--changeset duselman:PopulateDailyYearTableFromDailyYears
-- insert into daily_year select SITE_NO,1900 from daily_years yrs where yrs."1900" is not null;
-- insert into daily_year select SITE_NO,1901 from daily_years yrs where yrs."1901" is not null;
-- insert into daily_year select SITE_NO,1902 from daily_years yrs where yrs."1902" is not null;
-- insert into daily_year select SITE_NO,1903 from daily_years yrs where yrs."1903" is not null;
-- insert into daily_year select SITE_NO,1904 from daily_years yrs where yrs."1904" is not null;
-- insert into daily_year select SITE_NO,1905 from daily_years yrs where yrs."1905" is not null;
-- insert into daily_year select SITE_NO,1906 from daily_years yrs where yrs."1906" is not null;
-- insert into daily_year select SITE_NO,1907 from daily_years yrs where yrs."1907" is not null;
insert into daily_year select SITE_NO,1908 from daily_years yrs where yrs."1908" is not null;
insert into daily_year select SITE_NO,1909 from daily_years yrs where yrs."1909" is not null;
insert into daily_year select SITE_NO,1910 from daily_years yrs where yrs."1910" is not null;
insert into daily_year select SITE_NO,1911 from daily_years yrs where yrs."1911" is not null;
insert into daily_year select SITE_NO,1912 from daily_years yrs where yrs."1912" is not null;
insert into daily_year select SITE_NO,1913 from daily_years yrs where yrs."1913" is not null;
insert into daily_year select SITE_NO,1914 from daily_years yrs where yrs."1914" is not null;
insert into daily_year select SITE_NO,1915 from daily_years yrs where yrs."1915" is not null;
insert into daily_year select SITE_NO,1916 from daily_years yrs where yrs."1916" is not null;
insert into daily_year select SITE_NO,1917 from daily_years yrs where yrs."1917" is not null;
insert into daily_year select SITE_NO,1918 from daily_years yrs where yrs."1918" is not null;
insert into daily_year select SITE_NO,1919 from daily_years yrs where yrs."1919" is not null;
insert into daily_year select SITE_NO,1920 from daily_years yrs where yrs."1920" is not null;
insert into daily_year select SITE_NO,1921 from daily_years yrs where yrs."1921" is not null;
insert into daily_year select SITE_NO,1922 from daily_years yrs where yrs."1922" is not null;
insert into daily_year select SITE_NO,1923 from daily_years yrs where yrs."1923" is not null;
insert into daily_year select SITE_NO,1924 from daily_years yrs where yrs."1924" is not null;
insert into daily_year select SITE_NO,1925 from daily_years yrs where yrs."1925" is not null;
insert into daily_year select SITE_NO,1926 from daily_years yrs where yrs."1926" is not null;
insert into daily_year select SITE_NO,1927 from daily_years yrs where yrs."1927" is not null;
insert into daily_year select SITE_NO,1928 from daily_years yrs where yrs."1928" is not null;
insert into daily_year select SITE_NO,1929 from daily_years yrs where yrs."1929" is not null;
insert into daily_year select SITE_NO,1930 from daily_years yrs where yrs."1930" is not null;
insert into daily_year select SITE_NO,1931 from daily_years yrs where yrs."1931" is not null;
insert into daily_year select SITE_NO,1932 from daily_years yrs where yrs."1932" is not null;
insert into daily_year select SITE_NO,1933 from daily_years yrs where yrs."1933" is not null;
insert into daily_year select SITE_NO,1934 from daily_years yrs where yrs."1934" is not null;
insert into daily_year select SITE_NO,1935 from daily_years yrs where yrs."1935" is not null;
insert into daily_year select SITE_NO,1936 from daily_years yrs where yrs."1936" is not null;
insert into daily_year select SITE_NO,1937 from daily_years yrs where yrs."1937" is not null;
insert into daily_year select SITE_NO,1938 from daily_years yrs where yrs."1938" is not null;
insert into daily_year select SITE_NO,1939 from daily_years yrs where yrs."1939" is not null;
insert into daily_year select SITE_NO,1940 from daily_years yrs where yrs."1940" is not null;
insert into daily_year select SITE_NO,1941 from daily_years yrs where yrs."1941" is not null;
insert into daily_year select SITE_NO,1942 from daily_years yrs where yrs."1942" is not null;
insert into daily_year select SITE_NO,1943 from daily_years yrs where yrs."1943" is not null;
insert into daily_year select SITE_NO,1944 from daily_years yrs where yrs."1944" is not null;
insert into daily_year select SITE_NO,1945 from daily_years yrs where yrs."1945" is not null;
insert into daily_year select SITE_NO,1946 from daily_years yrs where yrs."1946" is not null;
insert into daily_year select SITE_NO,1947 from daily_years yrs where yrs."1947" is not null;
insert into daily_year select SITE_NO,1948 from daily_years yrs where yrs."1948" is not null;
insert into daily_year select SITE_NO,1949 from daily_years yrs where yrs."1949" is not null;
insert into daily_year select SITE_NO,1950 from daily_years yrs where yrs."1950" is not null;
insert into daily_year select SITE_NO,1951 from daily_years yrs where yrs."1951" is not null;
insert into daily_year select SITE_NO,1952 from daily_years yrs where yrs."1952" is not null;
insert into daily_year select SITE_NO,1953 from daily_years yrs where yrs."1953" is not null;
insert into daily_year select SITE_NO,1954 from daily_years yrs where yrs."1954" is not null;
insert into daily_year select SITE_NO,1955 from daily_years yrs where yrs."1955" is not null;
insert into daily_year select SITE_NO,1956 from daily_years yrs where yrs."1956" is not null;
insert into daily_year select SITE_NO,1957 from daily_years yrs where yrs."1957" is not null;
insert into daily_year select SITE_NO,1958 from daily_years yrs where yrs."1958" is not null;
insert into daily_year select SITE_NO,1959 from daily_years yrs where yrs."1959" is not null;
insert into daily_year select SITE_NO,1960 from daily_years yrs where yrs."1960" is not null;
insert into daily_year select SITE_NO,1961 from daily_years yrs where yrs."1961" is not null;
insert into daily_year select SITE_NO,1962 from daily_years yrs where yrs."1962" is not null;
insert into daily_year select SITE_NO,1963 from daily_years yrs where yrs."1963" is not null;
insert into daily_year select SITE_NO,1964 from daily_years yrs where yrs."1964" is not null;
insert into daily_year select SITE_NO,1965 from daily_years yrs where yrs."1965" is not null;
insert into daily_year select SITE_NO,1966 from daily_years yrs where yrs."1966" is not null;
insert into daily_year select SITE_NO,1967 from daily_years yrs where yrs."1967" is not null;
insert into daily_year select SITE_NO,1968 from daily_years yrs where yrs."1968" is not null;
insert into daily_year select SITE_NO,1969 from daily_years yrs where yrs."1969" is not null;
insert into daily_year select SITE_NO,1970 from daily_years yrs where yrs."1970" is not null;
insert into daily_year select SITE_NO,1971 from daily_years yrs where yrs."1971" is not null;
insert into daily_year select SITE_NO,1972 from daily_years yrs where yrs."1972" is not null;
insert into daily_year select SITE_NO,1973 from daily_years yrs where yrs."1973" is not null;
insert into daily_year select SITE_NO,1974 from daily_years yrs where yrs."1974" is not null;
insert into daily_year select SITE_NO,1975 from daily_years yrs where yrs."1975" is not null;
insert into daily_year select SITE_NO,1976 from daily_years yrs where yrs."1976" is not null;
insert into daily_year select SITE_NO,1977 from daily_years yrs where yrs."1977" is not null;
insert into daily_year select SITE_NO,1978 from daily_years yrs where yrs."1978" is not null;
insert into daily_year select SITE_NO,1979 from daily_years yrs where yrs."1979" is not null;
insert into daily_year select SITE_NO,1980 from daily_years yrs where yrs."1980" is not null;
insert into daily_year select SITE_NO,1981 from daily_years yrs where yrs."1981" is not null;
insert into daily_year select SITE_NO,1982 from daily_years yrs where yrs."1982" is not null;
insert into daily_year select SITE_NO,1983 from daily_years yrs where yrs."1983" is not null;
insert into daily_year select SITE_NO,1984 from daily_years yrs where yrs."1984" is not null;
insert into daily_year select SITE_NO,1985 from daily_years yrs where yrs."1985" is not null;
insert into daily_year select SITE_NO,1986 from daily_years yrs where yrs."1986" is not null;
insert into daily_year select SITE_NO,1987 from daily_years yrs where yrs."1987" is not null;
insert into daily_year select SITE_NO,1988 from daily_years yrs where yrs."1988" is not null;
insert into daily_year select SITE_NO,1989 from daily_years yrs where yrs."1989" is not null;
insert into daily_year select SITE_NO,1990 from daily_years yrs where yrs."1990" is not null;
insert into daily_year select SITE_NO,1991 from daily_years yrs where yrs."1991" is not null;
insert into daily_year select SITE_NO,1992 from daily_years yrs where yrs."1992" is not null;
insert into daily_year select SITE_NO,1993 from daily_years yrs where yrs."1993" is not null;
insert into daily_year select SITE_NO,1994 from daily_years yrs where yrs."1994" is not null;
insert into daily_year select SITE_NO,1995 from daily_years yrs where yrs."1995" is not null;
insert into daily_year select SITE_NO,1996 from daily_years yrs where yrs."1996" is not null;
insert into daily_year select SITE_NO,1997 from daily_years yrs where yrs."1997" is not null;
insert into daily_year select SITE_NO,1998 from daily_years yrs where yrs."1998" is not null;
insert into daily_year select SITE_NO,1999 from daily_years yrs where yrs."1999" is not null;
insert into daily_year select SITE_NO,2000 from daily_years yrs where yrs."2000" is not null;
insert into daily_year select SITE_NO,2001 from daily_years yrs where yrs."2001" is not null;
insert into daily_year select SITE_NO,2002 from daily_years yrs where yrs."2002" is not null;
insert into daily_year select SITE_NO,2003 from daily_years yrs where yrs."2003" is not null;
insert into daily_year select SITE_NO,2004 from daily_years yrs where yrs."2004" is not null;
insert into daily_year select SITE_NO,2005 from daily_years yrs where yrs."2005" is not null;
insert into daily_year select SITE_NO,2006 from daily_years yrs where yrs."2006" is not null;
insert into daily_year select SITE_NO,2007 from daily_years yrs where yrs."2007" is not null;
insert into daily_year select SITE_NO,2008 from daily_years yrs where yrs."2008" is not null;
insert into daily_year select SITE_NO,2009 from daily_years yrs where yrs."2009" is not null;
insert into daily_year select SITE_NO,2010 from daily_years yrs where yrs."2010" is not null;
insert into daily_year select SITE_NO,2011 from daily_years yrs where yrs."2011" is not null;
insert into daily_year select SITE_NO,2012 from daily_years yrs where yrs."2012" is not null;
-- rollback truncate table daily_year;