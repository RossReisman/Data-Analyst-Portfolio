Brazil E-Commerce Data Cleaning and Analysis

Step 1: Import Data

/*
Create tables
*/
CREATE TABLE customers (
	customer_id SERIAL,
	customer_unique_id SERIAL,
	customer_zip_code_prefix INT,
	customer_city TEXT,
	customer_state TEXT
)

CREATE TABLE orders (
	order_id SERIAL,
	customer_id SERIAL,
	order_status TEXT,
	order_purchase_timestamp TIMESTAMP,
	order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_delivered_delivery_date TIMESTAMP
)

CREATE TABLE sellers (
	seller_id SERIAL,
	seller_zip_code_prefix INT,
	seller_city TEXT,
	seller_state TEXT
)

CREATE TABLE categories (
	product_category_name TEXT,
	product_category_name_english TEXT
)

CREATE TABLE items (
	order_id TEXT,
	order_item_id INT,
	product_id TEXT,
	seller_id TEXT,
 	shipping_limit_date TIMESTAMP,
	price FLOAT,
	freight_value FLOAT
)

CREATE TABLE geolocation (
	geolocation_zip_code_prefix INT,
	geolocation_lat FLOAT,
	geolocation_lng FLOAT,
	geolocation_city TEXT,
 	geolocation_state TEXT
)

CREATE TABLE payments (
	order_id TEXT,
	payment_sequential INT,
	payment_type TEXT,
	payment_installments INT,
 	payment_value FLOAT
)

CREATE TABLE reviews (
	review_id TEXT,
	order_id TEXT,
	review_score INT,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date TIMESTAMP,
 	review_answer_timestamp TIMESTAMP
)
