/*
Data from
https://www.kaggle.com/datasets/rishikumarrajvansh/marketing-insights-for-e-commerce-company
*/

CREATE TABLE customers (
  customer_id INT
  , gender TEXT
  , location TEXT
  , tenure INT
)

CREATE TABLE coupon (
  month TEXT
  , category TEXT
  , coupon_code TEXT
  , discount_pct INT
)

CREATE TABLE spend (
  date TIMESTAMP
  , offline_spend INT
  , online_spend DECIMAL
)

CREATE TABLE sales (
  customer_id INT
  , transaction_id INT
  , transaction_date timestamp
  , product_sku TEXT
  , product_desc TEXT
  , product_cat TEXT
  , quantity INT
  , avg_price DECIMAL
  , delivery_charge DECIMAL
  , coupon_status TEXT
)

CREATE TABLE tax (
  product_cat TEXT
  , GST DECIMAL
)
