Player Data Cleaning and Analysis
Data randomly generated
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, AND, OR, NOT, IS,
NULL, INTERVAL, LIKE/NOT LIKE, MIN/MAX, DISTINCT, BETWEEN, GROUP BY, HAVING,
ORDER BY, COUNT, AVG, ALIAS, LIMIT, UNION, FLOOR.


Step 1: Create Tables

CREATE TABLE customers (
	customer_id TEXT,
	customer_unique_id TEXT,
	customer_zip_code_prefix INT,
	customer_city TEXT,
	customer_state TEXT
)

CREATE TABLE orders (
	order_id TEXT,
	customer_id TEXT,
	order_status TEXT,
	order_purchase_timestamp TIMESTAMP,
	order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP
)

CREATE TABLE sellers (
	seller_id TEXT,
	seller_zip_code_prefix INT,
	seller_city TEXT,
	seller_state TEXT
)
