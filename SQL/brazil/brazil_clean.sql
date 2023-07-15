Step 4: Data Cleaning


4a: Sellers

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM sellers
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='sellers';

--Sellers table has 3095 rows and 4 columns

--Check first 5 rows
SELECT * FROM sellers LIMIT 5;

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

--Sellers table now has 3095 rows and 5 columns

--Check for duplicates

SELECT COUNT(*)
FROM (SELECT *
FROM sellers
GROUP BY 1
HAVING COUNT(*) > 1) as sellers_dupes

SELECT COUNT(*)
FROM (SELECT seller_id
FROM sellers
GROUP BY 1
HAVING COUNT(*) > 1) as seller_id_dupes

--There are no duplicate rows or seller ids

--Check for Null values
SELECT *
FROM sellers
WHERE seller_id IS NULL
OR seller_zip_code_prefix IS NULL
OR seller_city IS NULL
OR seller_state IS NULL;

--There are no Null values

4b: Product Categories

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM categories
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='categoies';

--Categories table has 71 rows and 2 columns

--Check first 5 rows
SELECT * FROM categories LIMIT 5;

--One of the columns is in Portuguese and is of no use

--Drop Portuguese column
ALTER TABLE categories
DROP COLUMN product_category_name;

--Rename English column
ALTER TABLE categories
RENAME COLUMN product_category_name_english TO product_category_name;

--Categories table now has 71 rows and 1 column

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT product_category_name
FROM categories
GROUP BY 1
HAVING COUNT(*) > 1) as prod_cat_dupes

--There are no duplicates

--Check for Null values
SELECT *
FROM categories
WHERE product_category_name IS NULL

--There are no Null values

4c: Orders

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM orders
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='orders';

--Orders table has 99441 rows and 8 columns

--Add column for the just the month and year of the orders
ALTER TABLE orders
ADD order_month_year timestamp;
UPDATE orders
SET order_month_year = date_trunc('month', order_purchase_timestamp);

--Orders table now has 99441 rows and 9 columns

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT *
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as orders_dupes

SELECT COUNT(*)
FROM (SELECT order_id
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_id_dupes

--There are no duplicates

--Check for Null values
SELECT *
FROM orders
WHERE order_id IS NULL
OR customer_id IS NULL
OR order_status IS NULL
OR order_purchase_timestamp IS NULL
OR order_approved_at IS NULL
OR order_delivered_carrier_date IS NULL
OR order_delivered_customer_date IS NULL
OR order_estimated_delivery_date IS NULL
OR order_month_year IS NULL;

/*
There are 2980 rows that contain Null values
The breakdown of Null values by column is as follows:
order_id: 2980
customer_id: 2980
order_status: 2980
order_purchase_timestamp: 2980
order_approved_at: 2820
order_delivered_carrier_date: 1197
order_delivered_customer_date: 15
order_estimated_delivery_date: 2980
order_month_year: 2980
*/

4d: Items

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM items
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='items';

--Items table has 112650 rows 7 columns

--Check first 5 rows
SELECT * FROM items LIMIT 5;

--Data appears correctly formatted

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT order_id
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_order_id

SELECT COUNT(*)
FROM (SELECT order_item_id
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_order_item_id

SELECT COUNT(*)
FROM (SELECT product_id
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_id

SELECT COUNT(*)
FROM (SELECT seller_id
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_seller_id

SELECT COUNT(*)
FROM (SELECT shipping_LIMIT_date
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_ship_date

SELECT COUNT(*)
FROM (SELECT price
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_price

SELECT COUNT(*)
FROM (SELECT freight_value
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_freight_value

/*
order_id has 9,803 duplicate values
order_item_id has 20 duplicate values
product_id has 14,834 duplicate values
seller_id has 2,586 duplicate values
shipping_limit_date has 13,482 duplicate values
price has 3,626 duplicate values
freight_value has 4,924 duplicate values
*/


--Check for Null values
SELECT *
FROM items
WHERE order_id IS NULL
OR order_item_id IS NULL
OR product_id IS NULL
OR seller_id IS NULL
OR shipping_LIMIT_date IS NULL
OR price IS NULL
OR freight_value IS NULL;

--There are no Null values

4e: Customers

--Get number of rows
SELECT COUNT(*) FROM customers;

--Get number of columns
SELECT COUNT(column_name) AS number
FROM information_schema.columns
WHERE table_name='customers';

--Customers table has 99441 rows 5 columns

--Check first 5 rows
SELECT * FROM customers LIMIT 5;

/*
Same issue with Sellers table
Customer zip code prefix needs to be filled so all rows have 5 digits
Customer city is lower case
*/

--Change zip code data type to add leading zeros
ALTER TABLE customers
ALTER COLUMN customer_zip_code_prefix TYPE text;

--Add leading zeros to zip code
UPDATE customers
SET customer_zip_code_prefix = LPAD(customer_zip_code_prefix, 5, '0');

--Add a column combining city and state
ALTER TABLE customers
ADD customer_city_state text;
UPDATE customers
SET customer_city_state = INITCAP(customer_city) || ', ' || customer_state;

--Check for duplicates

SELECT COUNT(*)
FROM (SELECT *
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_all

SELECT COUNT(*)
FROM (SELECT customer_id
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_customer_id

SELECT COUNT(*)
FROM (SELECT customer_unique_id
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_customer_unique

SELECT COUNT(*)
FROM (SELECT customer_zip_code_prefix
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_customer_zip

SELECT COUNT(*)
FROM (SELECT customer_city
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_customer_city

SELECT COUNT(*)
FROM (SELECT customer_state
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_customer_state

SELECT COUNT(*)
FROM (SELECT customer_city_state
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_customer_city_state

/*
There are no duplicate rows
There are no duplicate customer ids (unique order fks)
There are 2997 duplicate customer_unique_id
There are 11982 duplicate customer zip code prefixes
There are 2975 duplicate customer cities
There are 27 duplicate customer states
There are 3050 duplicate customer city states

Discrepancy between unique cities and city/states
may be due to multiple cities sharing a name
*/

--Check for Null values
SELECT *
FROM customers
WHERE customer_id IS NULL
OR customer_unique_id IS NULL
OR customer_zip_code_prefix IS NULL
OR customer_city IS NULL
OR customer_state IS NULL
OR customer_city_state IS NULL;

--There are no Null values

4f: Geolocation

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM sellers
UNION
SELECT 'Number of columns',
COUNT(column_name) AS number
FROM information_schema.columns
WHERE table_name='sellers';

--Geolocation table has 1,000,163 rows 5 columns

--Check first 5 rows
SELECT * FROM geolocation LIMIT 5;

/*
Same issue with Sellers and Customers tables
Geolocation zip code prefix needs to be filled so all rows have 5 digits
Geolocation city is lower case
*/

--Change zip code data type to add leading zeros
ALTER TABLE geolocation
ALTER COLUMN geolocation_zip_code_prefix TYPE text;

--Add leading zeros to zip code
UPDATE geolocation
SET geolocation_zip_code_prefix = LPAD(geolocation_zip_code_prefix, 5, '0');

--Add a column combining city and state
ALTER TABLE geolocation
ADD geolocation_city_state text;
UPDATE geolocation
SET geolocation_city_state = INITCAP(geolocation_city) || ', ' || geolocation_state;


SELECT COUNT(*)
FROM (SELECT geolocation_zip_code_prefix
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_geolocation_zip

SELECT COUNT(*)
FROM (SELECT geolocation_lat
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_geolocation_lat

SELECT COUNT(*)
FROM (SELECT geolocation_lng
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_geolocation_lng

SELECT COUNT(*)
FROM (SELECT geolocation_city
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_geolocation_city

SELECT COUNT(*)
FROM (SELECT geolocation_state
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_geolocation_state

SELECT COUNT(*)
FROM (SELECT geolocation_city_state
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_geolocation_city_state


/*
There are 17972 zip codes with more than one order
There are 132,686 lattitudes with multiple orders
There are 132,585 longitudes with multiple orders
There are 7,188 cities with multiple orders
There are 27 states with multiple orders
There are 7,546 city/states with multiple orders

Discrepancy between unique cities and city/states
may be due to multiple cities sharing a name
*/

--Check for Null values
SELECT *
FROM geolocation
WHERE geolocation_zip_code_prefix IS NULL
OR geolocation_lat IS NULL
OR geolocation_lng IS NULL
OR geolocation_city IS NULL
OR geolocation_state IS NULL
OR geolocation_city_state IS NULL;

--There are no Null values

4g: Payments

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM payments
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='payments';

--Payments table has 103,886 rows and 5 columns

--Check first 5 rows
SELECT *
FROM payments
LIMIT 5

--No issues with data

--Check for duplicates

SELECT COUNT(*)
FROM (SELECT order_id
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_order_id

2961

SELECT COUNT(*)
FROM (SELECT payment_sequential
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_payment_seq

26

SELECT COUNT(*)
FROM (SELECT payment_type
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_payment_type

5

SELECT COUNT(*)
FROM (SELECT payment_installments
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_payment_installments

22

SELECT COUNT(*)
FROM (SELECT payment_value
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_payment_value

15,978

/*
There are 2961 order ids with multiple payments associated
Multiple customers have paid in 26 FOPs
Multiple customers have paid using all FOPs
Multiple customers have paid in as many as 22 payment payment installments
15,978 payments have identical values
*/

--Check for Null values
SELECT *
FROM payments
WHERE order_id IS NULL
OR payment_sequential IS NULL
OR payment_type IS NULL
OR payment_installments IS NULL
OR payment_value IS NULL;

--There are no Null values

4h: Reviews

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM reviews
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='reviews';

--reviews table has 99,224 rows and 7 columns

--Check first 5 rows
SELECT *
FROM reviews
LIMIT 5

--Seems like there's going to be a lot of Null values


SELECT COUNT(*)
FROM (SELECT review_id
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_review_id

789

SELECT COUNT(*)
FROM (SELECT order_id
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_order_id

547

SELECT COUNT(*)
FROM (SELECT review_score
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_review_score

5

SELECT COUNT(*)
FROM (SELECT review_comment_title
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_review_comment_title

765

SELECT COUNT(*)
FROM (SELECT review_comment_message
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_review_comment_message

1183

SELECT COUNT(*)
FROM (SELECT review_creation_date
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_review_creation_date

603

SELECT COUNT(*)
FROM (SELECT review_answer_timestamp
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_review_answer_timestamp

945

--Check for Null values
SELECT *
FROM reviews
WHERE order_id IS NULL
OR review_score IS NULL
OR review_comment_title IS NULL
OR review_comment_message IS NULL
OR review_creation_date IS NULL
OR review_answer_timestamp IS NULL;

--There are 89,385 Null values

ALTER TABLE reviews
ADD COLUMN review_response_time interval;
UPDATE reviews
SET review_response_time = age(review_answer_timestamp, review_creation_date);

4i: Products

--Get rows and columns
SELECT 'Number of rows',
COUNT(*)
FROM products
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='products';

--reviews table has 32,951 rows and 9 columns

SELECT * FROM products LIMIT 5;

--product category name is lower case

--Capitalize product category name
UPDATE products
SET product_category_name = INITCAP(product_category_name);

--Check for duplicates

SELECT COUNT(*)
FROM (SELECT *
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_products

0

SELECT COUNT(*)
FROM (SELECT product_id
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_id

0

SELECT COUNT(*)
FROM (SELECT product_category_name
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_cat_name

73

SELECT COUNT(*)
FROM (SELECT product_name_length
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_name_length

60

SELECT COUNT(*)
FROM (SELECT product_description_length
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_desc_length

2292

SELECT COUNT(*)
FROM (SELECT product_photos_qty
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_photos_qty

18

SELECT COUNT(*)
FROM (SELECT product_weight_g
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_weight_g

1170

SELECT COUNT(*)
FROM (SELECT product_length_cm
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_length_cm

99

SELECT COUNT(*)
FROM (SELECT product_height_cm
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_height_cm

100

SELECT COUNT(*)
FROM (SELECT product_width_cm
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as COUNT_product_width_cm

87

--Check for Null values
SELECT *
FROM products
WHERE product_id IS NULL
OR product_category_name IS NULL
OR product_name_length IS NULL
OR product_description_length IS NULL
OR product_photos_qty IS NULL
OR product_weight_g IS NULL
OR product_length_cm IS NULL
OR product_height_cm IS NULL
OR product_width_cm IS NULL;

--611 rows of null values













Second pass when done data sanity check
