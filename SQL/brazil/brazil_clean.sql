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

--Change zip code data type to add leading zeros
ALTER TABLE sellers
ALTER COLUMN seller_zip_code_prefix TYPE text;

--Add leading zeros to zip code
UPDATE sellers
SET seller_zip_code_prefix = LPAD(seller_zip_code_prefix, 5, '0');

--Capitalize seller city
UPDATE sellers
SET seller_city = INITCAP(seller_city);

--Add a column combining city and state
ALTER TABLE sellers
ADD seller_city_state text;
UPDATE sellers
SET seller_city_state = INITCAP(seller_city) || ', ' || seller_state;

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
There are 636 unique city states

Discrepancy between unique cities and city/states
may be due to multiple cities sharing a name
*/

--Check for Null values
SELECT *
FROM sellers
WHERE seller_id IS NULL
OR seller_zip_code_prefix IS NULL
OR seller_city IS NULL
OR seller_state IS NULL;

--There are no Null values

4b: Product Categories

--Get number of rows
select count(*) from categories;

--Get number of columns
select count(column_name) AS number
FROM information_schema.columns
where table_name='categories';

--Categories table has 71 rows and 2 columns

--Check first 5 rows
select * from categories limit 5;

/*
one of the columns is in Portuguese and is of no use
*/

--Drop Portuguese column
ALTER TABLE categories
DROP COLUMN product_category_name;

--Check for duplicates
select *
from categories
group by 1
having count(*) > 1

--There are no duplicates

--Check for Null values
SELECT *
FROM categories
WHERE product_category_name_english IS NULL

--There are no Null values

4c: Orders
