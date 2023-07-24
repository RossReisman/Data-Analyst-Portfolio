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

SELECT COUNT(*)
FROM (SELECT seller_zip_code_prefix
FROM sellers
GROUP BY 1
HAVING COUNT(*) > 1) as seller_zip_dupes

SELECT COUNT(*)
FROM (SELECT seller_city
FROM sellers
GROUP BY 1
HAVING COUNT(*) > 1) as seller_city_dupes

SELECT COUNT(*)
FROM (SELECT seller_state
FROM sellers
GROUP BY 1
HAVING COUNT(*) > 1) as seller_state_dupes

SELECT COUNT(*)
FROM (SELECT seller_city_state
FROM sellers
GROUP BY 1
HAVING COUNT(*) > 1) as seller_city_state_dupes

/*
There are no duplicate rows or seller ids
There are 537 duplicate seller cities
There are 18 duplicate seller states
There are 267 duplicate city/states
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

--Add column to calculate delivery process duration
ALTER TABLE orders
ADD delivery_duration interval;
UPDATE orders
SET delivery_duration = order_delivered_customer_date - order_delivered_carrier_date

--Orders table now has 99441 rows and 10 columns

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

SELECT COUNT(*)
FROM (SELECT customer_id
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_cust_id_dupes

SELECT COUNT(*)
FROM (SELECT order_purchase_timestamp
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_timestamp_dupes

SELECT COUNT(*)
FROM (SELECT order_approved_at
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_approved_dupes

SELECT COUNT(*)
FROM (SELECT order_delivered_carrier_date
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_del_carrier_dupes

SELECT COUNT(*)
FROM (SELECT order_delivered_customer_date
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_del_customer_dupes

SELECT COUNT(*)
FROM (SELECT order_estimated_delivery_date
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_estimated_del_dupes

SELECT COUNT(*)
FROM (SELECT order_month_year
FROM orders
GROUP BY 1
HAVING COUNT(*) > 1) as order_month_year_dupes

/*
There are no duplicate rows, order_ids or customer_ids
There are 556 duplicate order_purchase_timestamps
There are 7046 duplicate order_approved_at times
There are 10093 duplicate order_delivered_carrier_date times
There are 805 duplicate order_delivered_customer_date times
There are 438 duplicate order_estimated_delivery_date times
There are 24 duplicate order_month_year times
*/


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
HAVING COUNT(*) > 1) as item_order_id_dupes

SELECT COUNT(*)
FROM (SELECT order_item_id
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as item_order_item_dupes

SELECT COUNT(*)
FROM (SELECT product_id
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as item_product_id_dupes

SELECT COUNT(*)
FROM (SELECT seller_id
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as item_seller_id_dupes

SELECT COUNT(*)
FROM (SELECT shipping_LIMIT_date
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as item_ship_limit_dupes

SELECT COUNT(*)
FROM (SELECT price
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as item_price_dupes

SELECT COUNT(*)
FROM (SELECT freight_value
FROM items
GROUP BY 1
HAVING COUNT(*) > 1) as item_freight_dupes

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

--Customers table now has 99441 rows and 6 columns

--Check for duplicates

SELECT COUNT(*)
FROM (SELECT *
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as customer_dupes

SELECT COUNT(*)
FROM (SELECT customer_id
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as cust_customer_id_dupes

SELECT COUNT(*)
FROM (SELECT customer_unique_id
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as cust_customer_unique_dupes

SELECT COUNT(*)
FROM (SELECT customer_zip_code_prefix
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as cust_customer_zip_dupes

SELECT COUNT(*)
FROM (SELECT customer_city
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as cust_customer_city_dupes

SELECT COUNT(*)
FROM (SELECT customer_state
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as cust_customer_state_dupes

SELECT COUNT(*)
FROM (SELECT customer_city_state
FROM customers
GROUP BY 1
HAVING COUNT(*) > 1) as cust_customer_city_state_dupes

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
FROM geolocation
UNION
SELECT 'Number of columns',
COUNT(column_name) AS number
FROM information_schema.columns
WHERE table_name='geolocation';

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

--Geolocation table now has 1000163 rows and 6 columns

SELECT COUNT(*)
FROM (SELECT geolocation_zip_code_prefix
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as geolocation_zip_dupes

SELECT COUNT(*)
FROM (SELECT geolocation_lat
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as geolocation_lat_dupes

SELECT COUNT(*)
FROM (SELECT geolocation_lng
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as geolocation_lng_dupes

SELECT COUNT(*)
FROM (SELECT geolocation_city
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as geolocation_city_dupes

SELECT COUNT(*)
FROM (SELECT geolocation_state
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as geolocation_state_dupes

SELECT COUNT(*)
FROM (SELECT geolocation_city_state
FROM geolocation
GROUP BY 1
HAVING COUNT(*) > 1) as geolocation_city_state_dupes


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
HAVING COUNT(*) > 1) as payment_order_id_dupes

SELECT COUNT(*)
FROM (SELECT payment_sequential
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as payment_sequential_dupes

SELECT COUNT(*)
FROM (SELECT payment_type
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as payment_type_dupes

SELECT COUNT(*)
FROM (SELECT payment_installments
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as payment_installments_dupes

SELECT COUNT(*)
FROM (SELECT payment_value
FROM payments
GROUP BY 1
HAVING COUNT(*) > 1) as payment_value_dupes

/*
There are 2961 order_ids with multiple payments associated
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

--Add column for review response time
ALTER TABLE reviews
ADD COLUMN review_response_time interval;
UPDATE reviews
SET review_response_time = age(review_answer_timestamp, review_creation_date);

--Reviews table now has 99,224 rows and 8 columns

SELECT COUNT(*)
FROM (SELECT review_id
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_id_dupes

SELECT COUNT(*)
FROM (SELECT order_id
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_order_id_dupes

SELECT COUNT(*)
FROM (SELECT review_score
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_score_dupes

SELECT COUNT(*)
FROM (SELECT review_comment_title
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_title_dupes

SELECT COUNT(*)
FROM (SELECT review_comment_message
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_message_dupes

SELECT COUNT(*)
FROM (SELECT review_creation_date
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_creation_dupes

SELECT COUNT(*)
FROM (SELECT review_answer_timestamp
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_answer_dupes

SELECT COUNT(*)
FROM (SELECT review_response_time
FROM reviews
GROUP BY 1
HAVING COUNT(*) > 1) as review_response_dupes

/*
There are 789 duplicate review_ids
There are 547 duplicate order_ids
There are 5 duplicate review_scores
There are 765 duplicate review_comment_titles
There are 1183 duplicate review_comment_messages
There are 603 duplicate review_creation_dates
There are 945 duplicate review_answer_timestamps
There are 13,830 duplicate review_response_times
*/

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
HAVING COUNT(*) > 1) as products_dupes

SELECT COUNT(*)
FROM (SELECT product_id
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_id_dupes

SELECT COUNT(*)
FROM (SELECT product_category_name
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_cat_name_dupes

SELECT COUNT(*)
FROM (SELECT product_name_length
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_name_length_dupes

SELECT COUNT(*)
FROM (SELECT product_description_length
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_desc_length_dupes

SELECT COUNT(*)
FROM (SELECT product_photos_qty
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_photos_qty_dupes

SELECT COUNT(*)
FROM (SELECT product_weight_g
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_weight_g_dupes

SELECT COUNT(*)
FROM (SELECT product_length_cm
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_length_cm_dupes

SELECT COUNT(*)
FROM (SELECT product_height_cm
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_height_cm_dupes

SELECT COUNT(*)
FROM (SELECT product_width_cm
FROM products
GROUP BY 1
HAVING COUNT(*) > 1) as product_width_cm_dupes

/*
There are no duplicate rows or product_ids
There are 73 duplicate product_category_names
There are 60 duplicate product_name_lengths
There are 2292 duplicate product_description_lengths
There are 18 duplicate product_photos_qtys
There are 1170 duplicate product_weight_gs
There are 99 duplicate product_length_cms
There are 100 duplicate product_height_cms
There are 87 duplicate product_width_cms
*/

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
