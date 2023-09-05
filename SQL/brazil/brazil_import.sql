Brazil E-Commerce Data Cleaning and Analysis
Data from https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, AND, OR, IS, NULL,
INTERVAL, LIKE/NOT LIKE, MIN/MAX, DISTINCT, BETWEEN, GROUP BY, HAVING, ORDER BY,
COUNT, AVG, ALIAS, LIMIT, UNION, FLOOR, 

Step 1: Create Tables

/*
Create tables
*/
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

CREATE TABLE products (
	product_id TEXT,
	product_category_name TEXT,
	product_name_length FLOAT,
	product_description_length FLOAT,
	product_photos_qty FLOAT,
	product_weight_g FLOAT,
 	product_length_cm FLOAT,
	product_height_cm FLOAT,
	product_width_cm FLOAT
)

Step 2: Import Data (Using PSQL)

/*
Queries are written on multiple lines for ease of reading here
*/
\COPY public.categories(product_category_name, product_category_name_english)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;

\COPY public.sellers(seller_id, seller_zip_code_prefix, seller_city, seller_state)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

\COPY public.customers(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

\COPY public.products(product_id, product_category_name, product_name_length, product_description_length, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

\COPY public.payments(order_id, payment_sequential, payment_type, payment_installments, payment_value)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

\COPY public.geolocation(geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

\COPY public.items(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

\COPY public.reviews(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

\COPY public.orders(order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_delivered_delivery_date)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/brazil/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

Step 3: Add Primary and Foreign Keys

ALTER TABLE customers
ADD PRIMARY KEY (customer_id)

ALTER TABLE orders
ADD PRIMARY KEY (order_id)

ALTER TABLE sellers
ADD PRIMARY KEY (seller_id)

ALTER TABLE categories
ADD PRIMARY KEY (product_category_name_english)

ALTER TABLE products
ADD PRIMARY KEY (product_id)

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);

ALTER TABLE reviews
ADD CONSTRAINT fk_orders_reviews
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE items
ADD CONSTRAINT fk_items_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE items
ADD CONSTRAINT fk_items_products
FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE items
ADD CONSTRAINT fk_items_sellers
FOREIGN KEY (seller_id)
REFERENCES sellers (seller_id);
