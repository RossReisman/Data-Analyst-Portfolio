--Check unique values
SELECT COUNT(*)
FROM (SELECT DISTINCT seller_id
FROM sellers) as distinct_id;

SELECT COUNT(*)
FROM (SELECT DISTINCT seller_zip_code_prefix
FROM sellers) as distinct_zip;

SELECT COUNT(*)
FROM (SELECT DISTINCT seller_city
FROM sellers) as distinct_city;

SELECT COUNT(*)
FROM (SELECT DISTINCT seller_state
FROM sellers) as distinct_state;

SELECT COUNT(*)
FROM (SELECT DISTINCT(INITCAP(seller_city) || ', ' || seller_state)
AS seller_city_state
FROM sellers)
AS location_COUNT;

/*
There are 2246 unique zip code prefixes
There are 611 unique seller cities
There are 23 unique seller states
There are 636 unique city states
Discrepancy between unique cities and city/states
may be due to multiple cities sharing a name
*/
