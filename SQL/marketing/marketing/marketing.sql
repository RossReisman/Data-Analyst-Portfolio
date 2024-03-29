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
Customers table holds customers' personal information.
The table has 4 columns and 1,468 rows:
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
Coupon table holds discount information for product categories.
The table has 4 columns and 204 rows
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

2c: Spend Table

/*
Spend table holds the daily offline and online marketing spend data.
The table has 3 columns and 365 rows:
date: the date of the spend
offline_spend: the amount in dollars of offline marketing spend for that day
online_spend: the amount in dollars of online marketing spend for that day
*/

select min(date), max(date)
from spend

--Date column begins on January 1, 2019 and ends on December 31, 2019

select min(offline_spend), max(offline_spend)
from spend

"min"	"max"
 500	 5000

--Offline spend ranges from $500 to $5000 per day.
--Let's look at the interquartile range.

SELECT '25%' as iqt_range,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY offline_spend) AS spend
FROM spend
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY offline_spend) AS spend
FROM spend
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY offline_spend) AS spend
FROM spend
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY offline_spend) AS spend
FROM spend
UNION
SELECT 'Max',
MAX(offline_spend) AS spend
FROM spend
ORDER BY 1

"iqt_range"	"spend"
  "25%"	      2500
  "50%"	      3000
  "75%"	      3500
  "95%"	      4500
  "Max"	      5000

--The offline spend is normally distrubted around $3000.

select min(online_spend), max(online_spend)
from spend

"min"	"max"
320.25	4556.93

--Online spend ranges from $320.25 to $4556.93 per day.
--Let's look at the interquartile range.

SELECT '25%' as iqt_range,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY online_spend) AS spend
FROM spend
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY online_spend) AS spend
FROM spend
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY online_spend) AS spend
FROM spend
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY online_spend) AS spend
FROM spend
UNION
SELECT 'Max',
MAX(online_spend) AS spend
FROM spend
ORDER BY 1

"iqt_range"	"spend"
  "25%"	     1258.6
  "50%"	     1881.94
  "75%"	     2435.12
  "95%"	     3395.076
  "Max"	     4556.93

--Offline spend is slightly less normally distrubted around $1881.94.

2d: Sales Table

/*
Sales table holds the point of sales order data.
The table has 10 columns and 52,924 rows:
customer_id: a unique identifier for each customer
transaction_id: a unique identifier for each transaction
transaction_date: a timestamp of each transaction
product_sku: a unique identifer for the product
product_desc: a text description of a product
product_cat: the product category
quantity: the number of items ordered
avg_price: Price per unit
delivery_charge: the order's delivery charge
coupon_status: Whether or not a discount was applied
*/

select count(distinct transaction_id)
from sales

--There were 25,061 unique transactions

select min(transaction_date), max(transaction_date)
from sales

--All transactions occured between 1/1/19 and 12/31/19

select count(distinct product_sku)
from sales

--There are 1,145 unique product SKUs

select count(distinct product_cat)
from sales

--There are 20 unique product categories

select min(quantity), max(quantity)
from sales

--The quantity of items ordered ranges from 1 to 900 in a single order.
--Let's look at the interquartile range.

SELECT '25%' as iqt_range,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY quantity) AS quantity
FROM sales
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY quantity)
FROM sales
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY quantity)
FROM sales
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY quantity)
FROM sales
UNION
SELECT 'Max',
MAX(quantity)
FROM sales
ORDER BY 1

"iqt_range"	"quantity"
  "25%"	        1
  "50%"	        1
  "75%"	        2
  "95%"	        16
  "Max"	        900

--Most customers only purchase one item.
--Let's see how many purchase more than 2.

select quantity
from sales
where quantity > 2

--There are 10,572 orders where more than 2 of the same item were purchased.

select quantity
from sales
where quantity > 5

--There are 5,313 orders where more than 5 of the same item were purchased.

select quantity
from sales
where quantity > 10

--There are 3,366 orders where more than 10 of the same item were purchased.
--Looks like this company does a fair amount of business for large orders.

select min(avg_price), max(avg_price)
from sales

-- Average price of an order item runs from 39 cents to $355.74
--Let's look at the interquartile range.

SELECT '25%' as iqt_range,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY avg_price) AS avg_price
FROM sales
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY avg_price)
FROM sales
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY avg_price)
FROM sales
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY avg_price)
FROM sales
UNION
SELECT 'Max',
MAX(avg_price)
FROM sales
ORDER BY 1

"iqt_range"	"avg_price"
"25%"	5.7
"50%"	16.99
"75%"	102.13
"95%"	151.88
"Max"	355.74

-- Most items are under $20, but can be as expensive as $355.74
--Let's see a breakdown of the average price per category
--(Technically an average of the avg_price)

select distinct product_cat, round(avg(avg_price),2)
from sales
group by 1

"product_cat"	        "avg_price"
++++++++++++++++++++++++++++++++++
"Accessories"	          8.21
"Android"	              15.90
"Apparel"	              19.79
"Backpacks"	            80.05
"Bags"	                29.83
"Bottles"	              3.44
"Drinkware"	            10.70
"Fun"	                  6.74
"Gift Cards"	          111.36
"Google"	              16.45
"Headgear"	            15.88
"Housewares"	          2.06
"Lifestyle"	            3.86
"More Bags"	            19.78
"Nest"	                194.22
"Nest-Canada"	          157.24
"Nest-USA"	            124.33
"Notebooks & Journals"	11.76
"Office"	              3.77
"Waze"	                6.61


select min(delivery_charge), max(delivery_charge)
from sales

--Delivery charges range from free to $521.36
--Let's look at the interquartile range.

SELECT '25%' as iqt_range,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY delivery_charge) AS delivery_charge
FROM sales
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY delivery_charge)
FROM sales
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY delivery_charge)
FROM sales
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY delivery_charge)
FROM sales
UNION
SELECT 'Max',
MAX(delivery_charge)
FROM sales
ORDER BY 1

"iqt_range"	"delivery_charge"
  "25%"	            6
  "50%"	            6
  "75%"	            6.5
  "95%"	            26.43
  "Max"	            521.36


select coupon_status, count(coupon_status)
from sales
group by 1

"coupon_status"	"count"
    "Used"	     17904
    "Clicked"	   26926
    "Not Used"	 8094

--Looks like most coupons are clicked on the cart gets abandoned.

2e: Tax Table

/*
Sales table holds the category tax data.
The table has 2 columns and 20 rows:
product_cat: the product category
gst: the Goods and Services Tax expressed as a percentage in decimal form
*/

--We've already seen all 20 product categories in the sales table.

select gst from tax
order by 1

--GST ranges from 5% to 18%




/*
Why are some delivery charges so steep?
*/
