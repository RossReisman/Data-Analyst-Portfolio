/*

Video Game Sales Data Exploration in SQL
Data from https://www.kaggle.com/datasets/gregorut/videogamesales
Skills Used: Select, Where, And, Like/Not Like, Wildcard, Min/Max,
Distinct, Count, Group By, Having, Order By, Count, Avg, Alias, Limit.

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

--Summary statistics

SELECT 'total',
	sum(na_sales) as na_sales,
	sum(eu_sales) as eu_sales,
	sum(jp_sales) as jp_sales,
	sum(other_sales) as ot_sales
from vgsales
union
select 'average',
	round(avg(na_sales),2) as na_sales,
	round(avg(eu_sales),2) as eu_sales,
	round(avg(jp_sales),2) as jp_sales,
	round(avg(other_sales),2) as ot_sales
from vgsales
union
select 'min',
	min(na_sales) as na_sales,
	min(eu_sales) as eu_sales,
	min(jp_sales) as jp_sales,
	min(other_sales) as ot_sales
from vgsales
union
select 'max',
	max(na_sales) as na_sales,
	max(eu_sales) as eu_sales,
	max(jp_sales) as jp_sales,
	max(other_sales) as ot_sales
from vgsales

--Quartiles

SELECT 'min',
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY na_sales) as NA_sales,
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY eu_sales) as EU_sales,
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY jp_sales) as JP_sales,
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY other_sales) as OT_sales
FROM vgsales
UNION
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY na_sales) as NA_25,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY eu_sales) as EU_25,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY jp_sales) as JP_25,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY other_sales) as OT_25
FROM vgsales
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY na_sales) as NA_50,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY eu_sales) as EU_50,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY jp_sales) as JP_50,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY other_sales) as OT_50
FROM vgsales
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY na_sales) as NA_75,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY eu_sales) as EU_75,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY jp_sales) as JP_75,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY other_sales) as OT_75
FROM vgsales
UNION
SELECT 'max',
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY na_sales) as NA_100,
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY eu_sales) as EU_100,
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY jp_sales) as JP_100,
	PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY other_sales) as OT_100
FROM vgsales
ORDER BY 2

--Interquartile Range (IQR)

SELECT
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY na_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY na_sales) as NA_IQR,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY eu_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY eu_sales) as EU_IQR,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY jp_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY jp_sales) as JP_IQR,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY other_sales) -
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY other_sales) as OT_IQR
FROM vgsales


--Examining qualitative data

-- Platform names
select distinct(platform) from vgsales order by 1

-- Number of unique Platforms
select count(distinct(platform)) from vgsales

-- Year numbers
select distinct(year) from vgsales order by 1
-- 'N/A' is a result here. Need to check other columns for 'N/A'

SELECT count(year) from vgsales where year = 'N/A' order by 1
-- 271 records.

-- Checking Publisher for 'N/A'
select distinct(year) from vgsales order by 1
-- Found 'N/A'

SELECT count(publisher) from vgsales where publisher = 'N/A' order by 1
-- Found 58 rows

-- Number of unique Years
select count(distinct(platform)) from vgsales

-- Genre names
select distinct(genre) from vgsales order by 1

-- Number of unique Genres
select count(distinct(genre)) from vgsales

EDA

Publisher Performance

Who were the Top 10 Publishers and how many games did they make?

SELECT publisher, count(publisher) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by publisher
order by 2 desc
limit 10

/*
"Electronic Arts"	1339
"Activision"	966
"Namco Bandai Games"	928
"Ubisoft"	918
"Konami Digital Entertainment"	823
"THQ"	712
"Nintendo"	696
"Sony Computer Entertainment"	682
"Sega"	632
"Take-Two Interactive"	412
*/

What were the top 10 most prolific years for publishers
and how many games did they make?

SELECT year, publisher, count(publisher) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by year, publisher
order by 3 desc
limit 10

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

Genre Performance

What were the top Genres?

SELECT genre, count(genre) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by genre
order by 2 desc

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

Which genres saw the most releases in a given year?

SELECT year, genre, count(genre) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by year, genre
order by 3 desc
limit 10

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

Year Performance

Which years has the most releases?

SELECT year, count(year) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by year
order by 2 desc
limit 10

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

Platform Performance

Which Platforms Had the Most Games?

SELECT platform, count(platform) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by platform
order by 2 desc
limit 10

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

Sales Performance

5a) Publisher Sales Performance

SELECT publisher, sum(global_sales) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by publisher
order by 2 desc
limit 10

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
"Namco Bandai Games"	253.65
*/

5b) Genre Sales Performance

SELECT genre, sum(global_sales) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by genre
order by 2 desc
limit 10

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

SELECT year, genre, sum(global_sales) from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
group by year, genre
order by 3 desc
limit 10

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

5c) Year Sales Performance

5ca) Pre and Post 2000 Performance
Pre 2000
sum global

SELECT sum(global_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1999'
order by 1 desc

-- Total video game sales pre-2000 were $1,655,490,000.

Post 2000
sum global

SELECT sum(global_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2020'
order by 1 desc

-- Total video game sales post-2000 were $7,156,480,000.

5cb) Decade-wise performance

1980s

SELECT name, global_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1989'
group by global_sales, name
having global_sales > 5
order by 2 desc

--205 games total. Only 10 with sales over $5 million.

sum na/eu/jp/global

1990s

SELECT name, global_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1990' and '1999'
group by global_sales, name
having global_sales > 5
order by 2 desc

-- 1767 games total. Only 39 with sales over $5 million.

00

SELECT name, global_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2009'
group by global_sales, name
--having global_sales > 5
order by 2 desc

-- 9090 games total. 88 with sales over $5 million.

10

SELECT name, global_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2010' and '2020'
group by global_sales, name
--having global_sales > 5
order by 2 desc

-- 5026 games total. 67 with sales over $5 million.

5cc) North America Sales performance

SELECT 'North America 1980-1989',
sum(na_sales) as na_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1989'
union
SELECT 'North America 1990-1999',
sum(na_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1990' and '1999'
union
SELECT 'North America 2000-2009',
sum(na_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2009'
union
SELECT 'North America 2010-2020',
sum(na_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2010' and '2020'
order by 1

/*
"North America 1980-1989"	235.66
"North America 1990-1999"	576.11
"North America 2000-2009"	2403.22
"North America 2010-2020"	1112.66
*/

Europe Sales Performance by Decade

SELECT 'Europe 1980-1989',
sum(eu_sales) as eu_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1989'
union
SELECT 'Europe 1990-1999',
sum(eu_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1990' and '1999'
union
SELECT 'Europe 2000-2009',
sum(eu_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2009'
union
SELECT 'Europe 2010-2020',
sum(eu_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2010' and '2020'
order by 1

/*
"Europe 1980-1989"	31.20
"Europe 1990-1999"	282.87
"Europe 2000-2009"	1254.08
"Europe 2010-2020"	838.54
*/

SELECT 'Japan 1980-1989',
sum(jp_sales) as na_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1989'
union
SELECT 'Japan 1990-1999',
sum(jp_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1990' and '1999'
union
SELECT 'Japan 2000-2009',
sum(jp_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2009'
union
SELECT 'Japan 2010-2020',
sum(jp_sales)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2010' and '2020'
order by 1

/*
"Japan 1980-1989"	102.49
"Japan 1990-1999"	372.33
"Japan 2000-2009"	510.69
"Japan 2010-2020"	298.76
*/

SELECT 'North America 1980-1989',
round(avg(na_sales),2) as avg_na_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1989'
union
SELECT 'North America 1990-1999',
round(avg(na_sales), 2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1990' and '1999'
union
SELECT 'North America 2000-2009',
round(avg(na_sales),2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2009'
union
SELECT 'North America 2010-2020',
round(avg(na_sales),2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2010' and '2020'
order by 1

/*
"North America 1980-1989"	1.15
"North America 1990-1999"	0.33
"North America 2000-2009"	0.26
"North America 2010-2020"	0.22
*/

SELECT 'Europe 1980-1989',
round(avg(eu_sales),2) as avg_eu_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1989'
union
SELECT 'Europe 1990-1999',
round(avg(eu_sales), 2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1990' and '1999'
union
SELECT 'Europe 2000-2009',
round(avg(eu_sales),2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2009'
union
SELECT 'Europe 2010-2020',
round(avg(eu_sales),2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2010' and '2020'
order by 1

/*
"Europe 1980-1989"	0.15
"Europe 1990-1999"	0.16
"Europe 2000-2009"	0.14
"Europe 2010-2020"	0.16
*/

SELECT 'Japan 1980-1989',
round(avg(jp_sales),2) as avg_jp_sales
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1980' and '1989'
union
SELECT 'Japan 1990-1999',
round(avg(jp_sales), 2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '1990' and '1999'
union
SELECT 'Japan 2000-2009',
round(avg(jp_sales),2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2000' and '2009'
union
SELECT 'Japan 2010-2020',
round(avg(jp_sales),2)
from vgsales
where year not like 'N/A'
and publisher not like 'N/A'
and year between '2010' and '2020'
order by 1

/*
"Japan 1980-1989"	0.50
"Japan 1990-1999"	0.21
"Japan 2000-2009"	0.06
"Japan 2010-2020"	0.06
*/







/*



There are 16,598 rows and 11 columns.

*/
------------------------------------------------------------------

/*

First let's view a sample of our table.
It's always good to test your query first using LIMIT.

*/

SELECT * FROM vgsales LIMIT 5
------------------------------------------------------------------
/*

While importing the data, we received an error when trying to
set 'year' as numeric. Let's see how many rows this affects.

*/

SELECT * FROM vgsales WHERE year = 'N/A'

SELECT * FROM vgsales
WHERE year NOT LIKE '2%'
AND year NOT LIKE '1%'

/*

Both queries returned 271 rows so we can be sure these are
the only rows affected. Since there are 16598 rows,
these observations should not have an outsized influence.

*/
------------------------------------------------------------------
/*

Let's see what the earliest and latest years are

*/

SELECT MIN(year) FROM vgsales
SELECT MAX(year) FROM vgsales WHERE year NOT LIKE 'N/A'

/*

The earliest year is 1980. My initial query for the latest year
returned 'N/A' so I had to filter those rows using NOT LIKE
Let's see how many genres there are and list them

*/

SELECT COUNT(DISTINCT(genre)) FROM vgsales

SELECT DISTINCT(genre) FROM vgsales ORDER BY 1

/*

There are 12. In alphabetical order they are:
Action, Adventure, Fighting, Misc, Platform, Puzzle,
Racing, Role-Playing, Shooter, Simulation, Sports, and Strategy

*/

------------------------------------------------------------------

/*

Let's do the same for platform and publisher

*/

SELECT DISTINCT(platform) FROM vgsales ORDER BY 1

SELECT DISTINCT(publisher) FROM vgsales ORDER BY 1

/*

There are 31 platforms going all the way back to Atari 2600!
There are 579 different publishers.

*/

------------------------------------------------------------------

-- Let's see which game sold the most in North America and how much it sold

SELECT MAX(na_sales) FROM vgsales

-- We can see that the game that sold the most sold 41.49 million units

SELECT name FROM vgsales WHERE na_sales = 41.49

-- The title was Wii Sports. No surprise there!

-- Alternatively, we could do this in one step with the following query

SELECT name, na_sales FROM vgsales ORDER BY na_sales desc LIMIT 1
------------------------------------------------------------------
-- Let's compare that to other geographic regions

SELECT name, eu_sales FROM vgsales ORDER BY eu_sales desc LIMIT 1

SELECT name, jp_sales FROM vgsales ORDER BY jp_sales desc LIMIT 1

SELECT name, other_sales FROM vgsales ORDER BY other_sales desc LIMIT 1

/*

Wii Sports was top in the EU with 29.02 million units sold
Pokemon Red and Blue was top in Japan with 10.22 million units sold
Grand Theft Auto: San Andreas was top in other regions (non-NA, EU, JP)
with 10.57 million units sold

*/

------------------------------------------------------------------

-- How many games sold less than one million units in North America?

SELECT COUNT(na_sales) FROM vgsales WHERE na_sales < 1

-- Alternatively, we could use this query to get more information

SELECT name, platform, na_sales
FROM vgsales
WHERE na_sales < 1
ORDER BY na_sales desc

/*

There are 15,688 games that sold
less than one million units in North America.

*/

------------------------------------------------------------------

-- Let's compare that to other geographic regions

SELECT name, platform, eu_sales
FROM vgsales
WHERE eu_sales < 1
ORDER BY eu_sales desc
16126

SELECT name, platform, jp_sales
FROM vgsales
WHERE jp_sales < 1
ORDER BY jp_sales desc
16356

SELECT name, platform, other_sales
FROM vgsales
WHERE other_sales < 1
ORDER BY other_sales desc
16518

/*

EU: 16126
JP: 16356
Other: 16518

*/

------------------------------------------------------------------

/*

Let's see how many publishers have average sales of
at least half a million dollars across their games

*/

SELECT publisher, AVG(na_sales) AS avg_sales
FROM vgsales
GROUP BY 1
HAVING AVG(na_sales) > .5
ORDER BY 2 desc

/*

The query returned 27 publishers. There are many notable publishers
as well as some lesser known ones who may have only had a couple big games

*/

------------------------------------------------------------------
