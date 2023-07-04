/*

Video Game Sales Data Exploration in SQL
Data FROM https://www.kaggle.com/datasets/gregorut/videogamesales
Skills Used: SELECT, WHERE, AND, LIKE/NOT LIKE, MIN/MAX, DISTINCT, BETWEEN,
GROUP BY, HAVING, ORDER BY, COUNT, AVG, ALIAS, LIMIT, UNION.

*/
------------------------------------------------------------------
/*

Step 1: Dataset Examination

*/

--Number of rows
SELECT COUNT(*) FROM vgsales

--Number of columns
SELECT COUNT (column_name) AS Number
FROM information_schema.columns
WHERE table_name='vgsales'

--Column data types
SELECT column_name, DATA_TYPE
FROM information_schema.columns
WHERE table_name='vgsales'

/*

Step 2: Exploratory Data Analysis

*/

--SUMmary statistics (Total, Mean, MIN, MAX)

SELECT 'total',
	SUM(na_sales) AS na_sales,
	SUM(eu_sales) AS eu_sales,
	SUM(jp_sales) AS jp_sales,
	SUM(other_sales) AS ot_sales
FROM vgsales
UNION
SELECT 'average',
	ROUND(AVG(na_sales),2) AS na_sales,
	ROUND(AVG(eu_sales),2) AS eu_sales,
	ROUND(AVG(jp_sales),2) AS jp_sales,
	ROUND(AVG(other_sales),2) AS ot_sales
FROM vgsales
UNION
SELECT 'MIN',
	MIN(na_sales) AS na_sales,
	MIN(eu_sales) AS eu_sales,
	MIN(jp_sales) AS jp_sales,
	MIN(other_sales) AS ot_sales
FROM vgsales
UNION
SELECT 'MAX',
	MAX(na_sales) AS na_sales,
	MAX(eu_sales) AS eu_sales,
	MAX(jp_sales) AS jp_sales,
	MAX(other_sales) AS ot_sales
FROM vgsales

--Quartiles AND MIN/MAX

SELECT 'MIN',
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY na_sales) AS NA_sales,
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY eu_sales) AS EU_sales,
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY jp_sales) AS JP_sales,
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY other_sales) AS OT_sales
FROM vgsales
UNION
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY na_sales) AS NA_25,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY eu_sales) AS EU_25,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY jp_sales) AS JP_25,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY other_sales) AS OT_25
FROM vgsales
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY na_sales) AS NA_50,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY eu_sales) AS EU_50,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY jp_sales) AS JP_50,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY other_sales) AS OT_50
FROM vgsales
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY na_sales) AS NA_75,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY eu_sales) AS EU_75,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY jp_sales) AS JP_75,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY other_sales) AS OT_75
FROM vgsales
UNION
SELECT 'MAX',
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY na_sales) AS NA_100,
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY eu_sales) AS EU_100,
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY jp_sales) AS JP_100,
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY other_sales) AS OT_100
FROM vgsales
ORDER BY 2

--Interquartile Range (IQR)

SELECT
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY na_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY na_sales) AS NA_IQR,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY eu_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY eu_sales) AS EU_IQR,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY jp_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY jp_sales) AS JP_IQR,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY other_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY other_sales) AS OT_IQR
FROM vgsales


--ExaMINing qualitative data

-- Platform names
SELECT DISTINCT(platform) FROM vgsales ORDER BY 1

-- Number of unique Platforms
SELECT COUNT(DISTINCT(platform)) FROM vgsales

-- Year numbers
SELECT DISTINCT(year) FROM vgsales ORDER BY 1
-- 'N/A' is a result here. Need to check other columns for 'N/A'

SELECT COUNT(year) FROM vgsales WHERE year = 'N/A' ORDER BY 1
-- 271 records.

-- Checking Publisher for 'N/A'
SELECT DISTINCT(year) FROM vgsales ORDER BY 1
-- Found 'N/A'

SELECT COUNT(publisher) FROM vgsales WHERE publisher = 'N/A' ORDER BY 1
-- Found 58 rows

-- Number of unique Years
SELECT COUNT(DISTINCT(platform)) FROM vgsales

-- Genre names
SELECT DISTINCT(genre) FROM vgsales ORDER BY 1

-- Number of unique Genres
SELECT COUNT(DISTINCT(genre)) FROM vgsales

/*

Step 3: Data Analysis

*/


/*

Publisher Performance

*/

--Who were the Top 10 Publishers AND how many games did they make?

SELECT publisher, COUNT(publisher) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY publisher
ORDER BY 2 DESC
LIMIT 10

/*
"Electronic Arts"	1339
"Activision"	966
"Namco BANDai Games"	928
"Ubisoft"	918
"Konami Digital Entertainment"	823
"THQ"	712
"Nintendo"	696
"Sony Computer Entertainment"	682
"Sega"	632
"Take-Two Interactive"	412
*/

/*
What were the top 10 most prolific years for publishers
AND how many games did they make?
*/

SELECT year, publisher, COUNT(publisher) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY year, publisher
ORDER BY 3 DESC
LIMIT 10

/*
"2009"	"Activision"	121
"2008"	"Electronic Arts"	120
"2005"	"Electronic Arts"	117
"2008"	"Ubisoft"	112
"2009"	"Electronic Arts"	112
"2007"	"Electronic Arts"	107
"2006"	"Electronic Arts"	102
"2009"	"Ubisoft"	102
"2010"	"Activision"	89
"2007"	"Ubisoft"	88
*/

/*

Genre Performance

*/

-- What were the top Genres?

SELECT genre, COUNT(genre) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY genre
ORDER BY 2 DESC

/*
"Action"	3251
"Sports"	2304
"Misc"	1686
"Role-Playing"	1470
"Shooter"	1282
"Adventure"	1274
"Racing"	1225
"Platform"	875
"Simulation"	848
"Fighting"	836
"Strategy"	670
"Puzzle"	570
*/

-- Which genres saw the most releases in a given year?

SELECT year, genre, COUNT(genre) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY year, genre
ORDER BY 3 DESC
LIMIT 10

/*
"2009"	"Action"	272
"2012"	"Action"	265
"2015"	"Action"	255
"2011"	"Action"	239
"2010"	"Action"	226
"2008"	"Action"	221
"2008"	"Misc"	212
"2007"	"Action"	211
"2009"	"Misc"	207
"2010"	"Misc"	201
*/

/*

Year Performance

*/

-- Which years has the most releases?

SELECT year, COUNT(year) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY year
ORDER BY 2 DESC
LIMIT 10

/*
"2009"	1431
"2008"	1428
"2010"	1257
"2007"	1201
"2011"	1136
"2006"	1008
"2005"	936
"2002"	829
"2003"	775
"2004"	744
*/

/*

Platform Performance

*/

-- Which Platforms Had the Most Games?

SELECT platform, COUNT(platform) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY platform
ORDER BY 2 DESC
LIMIT 10

/*
"DS"	2131
"PS2"	2127
"PS3"	1304
"Wii"	1290
"X360"	1234
"PSP"	1197
"PS"	1189
"PC"	938
"XB"	803
"GBA"	786
*/

/*

Sales Performance

*/

-- Publisher Sales Performance

SELECT publisher, SUM(global_sales) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY publisher
ORDER BY 2 DESC
LIMIT 10

/*
"Nintendo"	1784.43
"Electronic Arts"	1093.39
"Activision"	721.41
"Sony Computer Entertainment"	607.28
"Ubisoft"	473.54
"Take-Two Interactive"	399.30
"THQ"	340.44
"Konami Digital Entertainment"	278.56
"Sega"	270.70
"Namco BANDai Games"	253.65
*/

-- Genre Sales Performance

SELECT genre, SUM(global_sales) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY genre
ORDER BY 2 DESC
LIMIT 10

/*
"Action"	1722.84
"Sports"	1309.24
"Shooter"	1026.20
"Role-Playing"	923.83
"Platform"	829.13
"Misc"	789.87
"Racing"	726.76
"Fighting"	444.05
"Simulation"	389.98
"Puzzle"	242.21
*/

SELECT year, genre, SUM(global_sales) FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
GROUP BY year, genre
ORDER BY 3 DESC
LIMIT 10

/*
"2009"	"Action"	139.36
"2009"	"Sports"	138.52
"2008"	"Action"	136.39
"2006"	"Sports"	136.16
"2013"	"Action"	125.22
"2012"	"Action"	122.01
"2011"	"Action"	118.96
"2010"	"Action"	117.64
"2007"	"Action"	106.50
"2011"	"Shooter"	99.36
*/

-- Year Sales Performance

-- Pre AND Post 2000 Performance

-- Pre 2000 Sales Performance

SELECT SUM(global_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1999'
ORDER BY 1 DESC

-- Total video game sales pre-2000 were $1,655,490,000.

-- Post 2000 Sales Performance

SELECT SUM(global_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2020'
ORDER BY 1 DESC

-- Total video game sales post-2000 were $7,156,480,000.

-- Decade-wise performance

-- 1980s

SELECT name, global_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1989'
GROUP BY global_sales, name
HAVING global_sales > 5
ORDER BY 2 DESC

--205 games total. Only 10 with sales over $5 million.

-- 1990s

SELECT name, global_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1990' AND '1999'
GROUP BY global_sales, name
HAVING global_sales > 5
ORDER BY 2 DESC

-- 1767 games total. Only 39 with sales over $5 million.

-- 2000s

SELECT name, global_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2009'
GROUP BY global_sales, name
--HAVING global_sales > 5
ORDER BY 2 DESC

-- 9090 games total. 88 with sales over $5 million.

-- 2010s

SELECT name, global_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2010' AND '2020'
GROUP BY global_sales, name
--HAVING global_sales > 5
ORDER BY 2 DESC

-- 5026 games total. 67 with sales over $5 million.

-- North America Sales Performance by Decade

SELECT 'North America 1980-1989',
SUM(na_sales) AS na_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1989'
UNION
SELECT 'North America 1990-1999',
SUM(na_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1990' AND '1999'
UNION
SELECT 'North America 2000-2009',
SUM(na_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2009'
UNION
SELECT 'North America 2010-2020',
SUM(na_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2010' AND '2020'
ORDER BY 1

/*
"North America 1980-1989"	235.66
"North America 1990-1999"	576.11
"North America 2000-2009"	2403.22
"North America 2010-2020"	1112.66
*/

-- Europe Sales Performance by Decade

SELECT 'Europe 1980-1989',
SUM(eu_sales) AS eu_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1989'
UNION
SELECT 'Europe 1990-1999',
SUM(eu_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1990' AND '1999'
UNION
SELECT 'Europe 2000-2009',
SUM(eu_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2009'
UNION
SELECT 'Europe 2010-2020',
SUM(eu_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2010' AND '2020'
ORDER BY 1

/*
"Europe 1980-1989"	31.20
"Europe 1990-1999"	282.87
"Europe 2000-2009"	1254.08
"Europe 2010-2020"	838.54
*/

-- Japan Sales Performance by Decade

SELECT 'Japan 1980-1989',
SUM(jp_sales) AS na_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1989'
UNION
SELECT 'Japan 1990-1999',
SUM(jp_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1990' AND '1999'
UNION
SELECT 'Japan 2000-2009',
SUM(jp_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2009'
UNION
SELECT 'Japan 2010-2020',
SUM(jp_sales)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2010' AND '2020'
ORDER BY 1

/*
"Japan 1980-1989"	102.49
"Japan 1990-1999"	372.33
"Japan 2000-2009"	510.69
"Japan 2010-2020"	298.76
*/

-- Average North America Sales Performance by Decade

SELECT 'North America 1980-1989',
ROUND(AVG(na_sales),2) AS AVG_na_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1989'
UNION
SELECT 'North America 1990-1999',
ROUND(AVG(na_sales), 2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1990' AND '1999'
UNION
SELECT 'North America 2000-2009',
ROUND(AVG(na_sales),2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2009'
UNION
SELECT 'North America 2010-2020',
ROUND(AVG(na_sales),2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2010' AND '2020'
ORDER BY 1

/*
"North America 1980-1989"	1.15
"North America 1990-1999"	0.33
"North America 2000-2009"	0.26
"North America 2010-2020"	0.22
*/

-- Average Europe Sales Performance by Decade

SELECT 'Europe 1980-1989',
ROUND(AVG(eu_sales),2) AS AVG_eu_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1989'
UNION
SELECT 'Europe 1990-1999',
ROUND(AVG(eu_sales), 2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1990' AND '1999'
UNION
SELECT 'Europe 2000-2009',
ROUND(AVG(eu_sales),2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2009'
UNION
SELECT 'Europe 2010-2020',
ROUND(AVG(eu_sales),2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2010' AND '2020'
ORDER BY 1

/*
"Europe 1980-1989"	0.15
"Europe 1990-1999"	0.16
"Europe 2000-2009"	0.14
"Europe 2010-2020"	0.16
*/

-- Average Japan Sales Performance by Decade

SELECT 'Japan 1980-1989',
ROUND(AVG(jp_sales),2) AS AVG_jp_sales
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1980' AND '1989'
UNION
SELECT 'Japan 1990-1999',
ROUND(AVG(jp_sales), 2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '1990' AND '1999'
UNION
SELECT 'Japan 2000-2009',
ROUND(AVG(jp_sales),2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2000' AND '2009'
UNION
SELECT 'Japan 2010-2020',
ROUND(AVG(jp_sales),2)
FROM vgsales
WHERE year NOT LIKE 'N/A'
AND publisher NOT LIKE 'N/A'
AND year BETWEEN '2010' AND '2020'
ORDER BY 1

/*
"Japan 1980-1989"	0.50
"Japan 1990-1999"	0.21
"Japan 2000-2009"	0.06
"Japan 2010-2020"	0.06
*/
