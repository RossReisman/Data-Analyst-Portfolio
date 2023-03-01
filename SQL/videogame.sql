/*

Video Game Sales Data Exploration in SQL
Data from https://www.kaggle.com/datasets/gregorut/videogamesales
Skills Used: Select, Where, And, Like/Not Like, Wildcard, Min/Max,
Distinct, Count, Group By, Having, Order By, Count, Avg, Alias, Limit.

*/
------------------------------------------------------------------
/*

First let's examine the dataset

see how many rows and columns are in this datasets

*/

SELECT COUNT(*) FROM vgsales

SELECT COUNT (column_name) AS Number
FROM information_schema.columns
WHERE table_name='vgsales'

Checking column data types vvv

SELECT column_name, DATA_TYPE
FROM information_schema.columns
WHERE table_name='vgsales'


Generating summary statistics vvv

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

IQR

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

Quartiles

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
