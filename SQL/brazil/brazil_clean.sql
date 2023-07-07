Step 4: Data Cleaning

4a: Sellers

--Get number of rows
select count(*) from sellers;

--Get number of columns
select count(column_name) AS number
FROM information_schema.columns
where table_name='sellers';

--Sellers table has 3095 rows and 4 columns

--Check first 5 rows
select * from sellers limit 5;

/*
Seller zip code prefix needs to be filled so all rows have 5 digits
seller city is lower case
*/

--To add leading zeroes to zip code during analysis
select TO_CHAR(seller_zip_code_prefix, 'fm00000')
as seller_zip_code_prefix
from sellers;

--To capitalize city during analysis
select INITCAP(seller_city)
from sellers;

--Check for duplicates

select *
from sellers
group by 1
having count(*) > 1

select seller_id
from sellers
group by 1
having count(*) > 1

--Check unique values

select COUNT(*)
FROM (SELECT DISTINCT seller_id
from sellers) as distinct_id;

select COUNT(*)
FROM (SELECT DISTINCT seller_zip_code_prefix
from sellers) as distinct_zip;

select COUNT(*)
FROM (SELECT DISTINCT seller_city
from sellers) as distinct_city;

select COUNT(*)
FROM (SELECT DISTINCT seller_state
from sellers) as distinct_state;

SELECT COUNT(*)
FROM (SELECT DISTINCT(INITCAP(seller_city) || ', ' || seller_state)
AS seller_city_state
FROM sellers)
AS location_count;

/*
There are no duplicate rows
There are no duplicate seller ids
There are 2246 unique zip code prefixes
There are 611 unique seller cities
There are 23 unique seller states
*/


--Check unique zip code prefixes
select distinct(seller_zip_code_prefix)
from sellers
group by 1
order by 1;

--No non-integer zip code values
