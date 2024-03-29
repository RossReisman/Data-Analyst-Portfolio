/*
Data from
https://www.kaggle.com/datasets/rishikumarrajvansh/marketing-insights-for-e-commerce-company
*/

Step 1: Import and Cleaning

CREATE TABLE customers (
  index INT
  , customer_id INT
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
  index INT
  , product_cat TEXT
  , GST DECIMAL
)

\COPY public.customers(index, customer_id, gender, location, tenure)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/marketing/customers_data.csv'
DELIMITER ','
CSV HEADER;

\COPY public.coupon(month, category, coupon_code, discount_pct)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/marketing/discount_coupon.csv'
DELIMITER ','
CSV HEADER;

\COPY public.spend(date, offline_spend, online_spend)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/marketing/marketing_spend.csv'
DELIMITER ','
CSV HEADER;

\COPY public.sales(customer_id, transaction_id, transaction_date, product_sku, product_desc, product_cat, quantity, avg_price, delivery_charge, coupon_status)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/marketing/online_sales.csv'
DELIMITER ','
CSV HEADER;

\COPY public.tax(index, product_cat, GST)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/marketing/tax_data.csv'
DELIMITER ','
CSV HEADER;

-- Two tables have an index column that is useless. Let's drop those.

ALTER TABLE customers
DROP COLUMN index;

ALTER TABLE tax
DROP COLUMN index;

ALTER TABLE customers
ADD PRIMARY KEY (customer_id)

Step 2: EDA and Feature Engineering

2a: Customers Table

/*
Customers table has 4 columns:
customer_id: a unique identifier for each customer
gender: the gender of the customer (M or F)
location: the location of the customer
tenure: how long since the customer's first purchase
*/

select count(distinct customer_id)
from customers

-- There are 1,468 customers

select gender, count(gender)
from customers
group by 1

Gender Count
  "M"	  534
  "F"	  934

select location, count(location)
from customers
group by 1

Location        Count
"California"	   464
"Chicago"	       456
"New Jersey"	   149
"New York"	     324
"Washington DC"	  75

select distinct tenure
from customers
group by 1
order by 1

-- Customer tenure ranges from 2 to 50 months

2b: Coupon Table

/*
Coupon table has 4 columns:
month: the month the coupon code is active
category: the product category
coupon_code: the code for the corresponding coupon and category
discount_pct: the percentage discount the coupon awards
*/

select distinct month
from coupon

-- All 12 months are represented

select month, count(month)
from coupon
group by 1
order by 1

-- Each month is represented 17 times. There must be 17 categories

select distinct category
from coupon
order by 1

/*
There are 17 categories:
"Accessories"
"Android"
"Apparel"
"Bags"
"Bottles"
"Drinkware"
"Gift Cards"
"Headgear"
"Housewares"
"Lifestyle"
"Nest"
"Nest-Canada"
"Nest-USA"
"Notebooks"
"Notebooks & Journals"
"Office"
"Waze"
*/

select distinct coupon_code
from coupon
order by 1

--There are 48 unique coupon codes.
--One code must be used for multiple categories.

select coupon_code
from coupon
group by 1
having count(distinct category) > 1

--EXTRA10, EXTRA20, and EXTRA30 are the repeat coupon codes.

select distinct category
from coupon
where coupon_code LIKE 'EXTRA%'

--Drinkware and Lifestyle both use those coupon codes.

select distinct discount_pct
from coupon
order by 1

--The discounts are for 10%, 20%, and 30%
