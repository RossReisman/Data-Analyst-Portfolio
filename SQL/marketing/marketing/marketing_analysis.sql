/*
Why are some delivery charges so steep?
Which gender saved the most by using coupons?
Which location spends/coupons the most?
Which customers spends/coupons the most?
RFM Segmentation and Customer LTV
Cohort analysis and retention
*/

Coupon Behavior
Transaction Behavior


1) What is the coupon use status for each category?

select
  product_cat
  , coupon_status
  , count(coupon_status)
from sales
group by 1,2
order by 1, 2

  Category               Coupon Status   Count
  "Accessories"	           "Clicked"	    125
  "Accessories"	           "Not Used"	     32
  "Accessories"	           "Used"	         77
  "Android"	               "Clicked"	     23
  "Android"	               "Not Used"	     10
  "Android"	               "Used"	         10
  "Apparel"	               "Clicked"	    9223
  "Apparel"	               "Not Used"	    2747
  "Apparel"	               "Used"	        6156
  "Backpacks"	             "Clicked"	     47
  "Backpacks"	             "Not Used"	     15
  "Backpacks"	             "Used"	         27
  "Bags"	                 "Clicked"	    972
  "Bags"	                 "Not Used"	    285
  "Bags"	                 "Used"	        625
  "Bottles"	               "Clicked"	    138
  "Bottles"	               "Not Used"	     48
  "Bottles"	               "Used"	         82
  "Drinkware"	             "Clicked"	    1752
  "Drinkware"	             "Not Used"	     570
  "Drinkware"	             "Used"	        1161
  "Fun"	                   "Clicked"	     83
  "Fun"	                   "Not Used"	     25
  "Fun"	                   "Used"	         52
  "Gift Cards"	           "Clicked"	     81
  "Gift Cards"	           "Not Used"	     22
  "Gift Cards"	           "Used"	         56
  "Google"	               "Clicked"	     51
  "Google"	               "Not Used"	     25
  "Google"	               "Used"	         29
  "Headgear"	             "Clicked"	     401
  "Headgear"	             "Not Used"	     114
  "Headgear"	             "Used"	         256
  "Housewares"	           "Clicked"	     68
  "Housewares"	           "Not Used"	     18
  "Housewares"	           "Used"	         36
  "Lifestyle"	             "Clicked"	    1529
  "Lifestyle"	             "Not Used"	     462
  "Lifestyle"	             "Used"	        1101
  "More Bags"	             "Clicked"	     25
  "More Bags"	             "Not Used"	      3
  "More Bags"	             "Used"	         18
  "Nest"	                 "Clicked"	    1127
  "Nest"	                 "Not Used"	     351
  "Nest"	                 "Used"	         720
  "Nest-Canada"	           "Clicked"	     175
  "Nest-Canada"	           "Not Used"	     47
  "Nest-Canada"	           "Used"	         95
  "Nest-USA"	             "Clicked"	    7141
  "Nest-USA"	             "Not Used"	    2160
  "Nest-USA"	             "Used"	        4712
  "Notebooks & Journals"	 "Clicked"	     389
  "Notebooks & Journals"	 "Not Used"	     103
  "Notebooks & Journals"	 "Used"	         257
  "Office"	               "Clicked"	    3295
  "Office"	               "Not Used"	     968
  "Office"	               "Used"	        2250
  "Waze"	                 "Clicked"	     281
  "Waze"	                 "Not Used"	     89
  "Waze"	                 "Used"	         184



1.5) Express as percentages

with calcs as (select
  product_cat
  , coupon_status
  , count(coupon_status) as count
  , sum(count(coupon_status)) OVER(PARTITION BY product_cat) AS total_count
from sales
group by 1,2
order by 1, 2
)
select
	product_cat
	, coupon_status
	, round(100 * count/total_count, 2) as pct
from calcs

"product_cat"	    "coupon_status"	    "pct"
"Accessories"	      "Clicked"	        53.42
"Accessories"	      "Not Used"	      13.68
"Accessories"	       "Used"	          32.91
"Android"	          "Clicked"	        53.49
"Android"	          "Not Used"	      23.26
"Android"	            "Used"	        23.26
"Apparel"	          "Clicked" 	      50.88
"Apparel"	          "Not Used"	      15.16
"Apparel"	           "Used"	          33.96
"Backpacks"	        "Clicked"	        52.81
"Backpacks"	        "Not Used"	      16.85
"Backpacks"	         "Used"	          30.34
"Bags"	            "Clicked"	        51.65
"Bags"	            "Not Used"	      15.14
"Bags"	              "Used"	        33.21
"Bottles"	          "Clicked"	        51.49
"Bottles"	          "Not Used"	      17.91
"Bottles"	            "Used"	         30.60
"Drinkware"	        "Clicked"	          50.30
"Drinkware"	      "Not Used"	         16.37
"Drinkware"	           "Used"	          33.33
"Fun"	              "Clicked"	          51.88
"Fun"	            "Not Used"	         15.63
"Fun"	                "Used"	         32.50
"Gift Cards"	     "Clicked"	          50.94
"Gift Cards"	     "Not Used"	         13.84
"Gift Cards"	         "Used"	         35.22
"Google"	         "Clicked"	          48.57
"Google"	         "Not Used"	         23.81
"Google"	             "Used"	         27.62
"Headgear"	       "Clicked"	          52.01
"Headgear"	       "Not Used"	         14.79
"Headgear"	           "Used"	         33.20
"Housewares"	     "Clicked"	          55.74
"Housewares"	     "Not Used"	         14.75
"Housewares"	         "Used"	         29.51
"Lifestyle"	        "Clicked"	          49.45
"Lifestyle"	      "Not Used"	         14.94
"Lifestyle"	          "Used"	         35.61
"More Bags"	        "Clicked"	          54.35
"More Bags"	      "Not Used"	         6.52
"More Bags"	          "Used"	         39.13
"Nest"	           "Clicked"	          51.27
"Nest"	           "Not Used"	         15.97
"Nest"	               "Used"	         32.76
"Nest-Canada"	      "Clicked"	          55.21
"Nest-Canada"	     "Not Used"	          14.83
"Nest-Canada"	        "Used"	         29.97
"Nest-USA"	       "Clicked"	          50.96
"Nest-USA"	       "Not Used"	         15.41
"Nest-USA"	           "Used"	         33.63
"Notebooks & Journals"	"Clicked"	     51.94
"Notebooks & Journals"	"Not Used"	   13.75
"Notebooks & Journals"	"Used"	       34.31
"Office"	           "Clicked"	       50.59
"Office"	           "Not Used"	       14.86
"Office"	           "Used"	           34.55
"Waze"	               "Clicked"	     50.72
"Waze"                	"Not Used"	   16.06
"Waze"                	"Used"	       33.21

1.5b) Show only percentages for Used coupons

with calcs as (select
  product_cat
  , coupon_status
  , count(coupon_status) as count
  , sum(count(coupon_status)) OVER(PARTITION BY product_cat) AS total_count
from sales
group by 1,2
order by 1, 2
),
pcts as (select
	product_cat
	, coupon_status
	, round(100 * count/total_count, 2) as pct
from calcs
)
select *
from pcts
where coupon_status = 'Used'


"product_cat"	      "coupon_status"	    "pct"
"Accessories"	          "Used"	        32.91
"Android"	              "Used"	        23.26
"Apparel"	              "Used"	        33.96
"Backpacks"	            "Used"	        30.34
"Bags"	                "Used"	        33.21
"Bottles"	              "Used"	        30.60
"Drinkware"	            "Used"	        33.33
"Fun"	                  "Used"	        32.50
"Gift Cards"	          "Used"	        35.22
"Google"	              "Used"	        27.62
"Headgear"	            "Used"	        33.20
"Housewares"	          "Used"	        29.51
"Lifestyle"	            "Used"	        35.61
"More Bags"	            "Used"	        39.13
"Nest"	                "Used"	        32.76
"Nest-Canada"	          "Used"	        29.97
"Nest-USA"	            "Used"	        33.63
"Notebooks & Journals"	"Used"	        34.31
"Office"	              "Used"	        34.55
"Waze"	                "Used"	        33.21

/*
Coupon use hovers at around a third of all purchases except for Android at 23%
*/



2) Were coupons used more than unused?

select
  product_cat
  , sum(case when coupon_status = 'Used' then 1 else - 1 end) as use_count
from sales
group by 1
order by 1

"product_cat"	        "use_count"
++++++++++++++++++++++++++++++++
"Accessories"	           -80
"Android"	               -23
"Apparel"	              -5814
"Backpacks"	             -35
"Bags"	                 -632
"Bottles"	               -104
"Drinkware"	             -1161
"Fun"	                    -56
"Gift Cards"	            -47
"Google"	                -47
"Headgear"	             -259
"Housewares"	            -50
"Lifestyle"	             -890
"More Bags"	              -10
"Nest"	                 -758
"Nest-Canada"	           -127
"Nest-USA"	             -4589
"Notebooks & Journals"	 -235
"Office"	               -2013
"Waze"	                 -186

--All categories had net negative coupon use.



3) Which gender spends more?

select
	c.gender
	, sum(s.final_price)
from sales s
join customers c
on c.customer_id = s.customer_id
group by 1

"gender"	"sum"
+++++++++++++++++
  "M"   1,767,124.39
  "F"	  2,903,670.23

  -- Female customers outspent males by almost $1,200,000



4) Which gender uses coupons more?

select
	c.gender
	, s.coupon_status
	, count(s.coupon_status)
from customers c
join sales s
on c.customer_id = s.customer_id
where coupon_status = 'Used'
group by 1, 2
order by 1 desc

"gender"	"coupon_status"	"count"
"M"	"Used"	6752
"F"	"Used"	11152

-- Female customers used nearly coupons on nearly twice as many transactions



5) Which coupon was used the most?

/*
In order to determine which coupon was used the most,
we first need to look at the coupons that were available for each month.
*/

select * from coupon
order by 2, 1

"month"	"category"	"coupon_code"
"Apr"	"Accessories"	"ACC10"
"Aug"	"Accessories"	"ACC20"
"Dec"	"Accessories"	"ACC30"
"Feb"	"Accessories"	"ACC20"
"Jan"	"Accessories"	"ACC10"
"Jul"	"Accessories"	"ACC10"
"Jun"	"Accessories"	"ACC30"
"Mar"	"Accessories"	"ACC30"
"May"	"Accessories"	"ACC20"
"Nov"	"Accessories"	"ACC20"
"Oct"	"Accessories"	"ACC10"
"Sep"	"Accessories"	"ACC30"

/*
Here I've isolated one category to demonstrate that each month used
one unique coupon code per category per month. So if we can see which
categories had the highest coupon use by month, we can determine which
coupons were used the most.
*/

select * from(
	select
	extract(month from transaction_date) as month
	, product_cat
	, count(product_cat)
	, row_number() over(partition by product_cat order by count(product_cat) desc) as product_rank
from sales
where coupon_status = 'Used'
group by 2, 1
order by 3 desc, 2) calcs
where product_rank <= 3
order by 2, 4

"month"	 "product_cat"	"count"	"product_rank"
11	     "Accessories"	          27	1
12	     "Accessories"	          18	2
10	     "Accessories"	          16	3
8	       "Android"	               3	1
1	       "Android"	               2	2
6	       "Android"	               2	3
8	       "Apparel"	               968	1
7	       "Apparel"	               720	2
5	       "Apparel"	               603	3
5	       "Backpacks"	             6	1
8	       "Backpacks"	             5	2
4	       "Backpacks"	             5	3
7	       "Bags"	                  74	1
3	       "Bags"	                  73	2
8	       "Bags"	                  69	3
7	       "Bottles"	               15	1
8	       "Bottles"	               13	2
5	       "Bottles"	               10	3
8	       "Drinkware"	           146	1
3	       "Drinkware"	           132	2
10	     "Drinkware"	            117	3
7	       "Fun"	                   9	1
8	       "Fun"	                   9	2
6	       "Fun"	                   7	3
10	     "Gift Cards"	             30	1
5	       "Gift Cards"	              7	2
6	       "Gift Cards"	              4	3
1	       "Google"	                  8	1
2	       "Google"	                  5	2
3	       "Google"	                  4	3
7	       "Headgear"	                40	1
8	       "Headgear"	                34	2
3	       "Headgear"	                30	3
8	       "Housewares"	              8	1
3	       "Housewares"	              6	2
7	       "Housewares"	              5	3
8	       "Lifestyle"	             149	1
7	       "Lifestyle"	             126	2
9	       "Lifestyle"	             120	3
3	       "More Bags"	             7	1
4	       "More Bags"	             6	2
5	       "More Bags"	             4	3
11       "Nest"	                  226	1
12       "Nest"	                  209	2
10	     "Nest"	                 141	3
6	       "Nest-Canada"	         14	1
1	       "Nest-Canada"	         13	2
4	       "Nest-Canada"	         10	3
1	       "Nest-USA"	              526	1
12	     "Nest-USA"	             510	2
11	     "Nest-USA"	             501	3
8	       "Notebooks & Journals"	68	1
7	       "Notebooks & Journals"	48	2
5	       "Notebooks & Journals"	23	3
3	       "Office"	              234	1
5	       "Office"	              222	2
4	       "Office"	              213	3
8	       "Waze"	                23	1
1	       "Waze"	                20	2
5	       "Waze"	                20	3

/*
Here we can see the months of highest coupon use in each category.
As the coupon table doesn't have a primary key, we can't join the tables
to display each month's corresponding coupon code, but cross referencing
this information with monthly coupon code info will reveal the most used code.
*/

6) Which month had the highest ROAS?

-- First let's ascertain the total monthly spend on advertising

select
	extract(month from date) as month
	, sum(offline_spend) + sum(online_spend) as total_spend
from spend
group by 1
order by 1

"month"	"total_spend"
1	154928.95
2	137107.92
3	122250.09
4	157026.83
5	118259.64
6	134318.14
7	120217.85
8	142904.15
9	135514.54
10	151224.65
11	161144.96
12	198648.75

/*
The range of total monthly spend is between ~$118,000 and ~$155,000
with a holiday seasonal ramp up to ~$200,000
*/

with calcs as (select
	extract(month from transaction_date) as month
	, sum(final_price) over(partition by extract(month from transaction_date)) as total
from sales
where
	coupon_status = 'Used'
	or
	coupon_status = 'Clicked')
select
	distinct month
	, total
from calcs
order by 1

"month"	"total"
1	343998.17
2	260742.38
3	291469.61
4	341914.33
5	261020.28
6	263818.15
7	311538.26
8	338620.41
9	305455.79
10	348870.68
11	432405.18
12	438231.51

/*
Here I chose to include all transactions where an advertised coupon might be
the reason a customer made a transaction (i.e. all transactions where
coupon_status was not 'Not Used')
*/

with spends as (select
	extract(month from date) as month
	, sum(offline_spend) + sum(online_spend) as total_spend
from spend
group by 1
order by 1
),
sales_data as (select
	extract(month from transaction_date) as month
	, sum(final_price) over(partition by extract(month from transaction_date)) as total
from sales
where
	coupon_status = 'Used'
	or
	coupon_status = 'Clicked')
select
	distinct sales_data.month
	, total
	, spends.total_spend
	, total - spends.total_spend as sales_minus_spend
from sales_data
join spends
on sales_data.month = spends.month
order by 4 desc

"month"	"total"	"total_spend"	"sales_minus_spend"
11	432405.18	161144.96	271260.22
12	438231.51	198648.75	239582.76
10	348870.68	151224.65	197646.03
8	338620.41	142904.15	195716.26
7	311538.26	120217.85	191320.41
1	343998.17	154928.95	189069.22
4	341914.33	157026.83	184887.50
9	305455.79	135514.54	169941.25
3	291469.61	122250.09	169219.52
5	261020.28	118259.64	142760.64
6	263818.15	134318.14	129500.01
2	260742.38	137107.92	123634.46

/*
Probably comes as no surprise that the holiday season months had the highest
return on ad spend. Here we can see that November, December, and October had
the highest ROAS in that order.
*/

7) RFM analysis
Assign score using quartiles for customers who have recently purchased,
purchased a lot, havent recently purchased, might purchase a lot, etc.

/*
First we need to develop a scoring system to measure recency, frequency, and
monetary value for our customers and measure the spread of the results before
we can add labels.
*/

with final_rfm2 as (select
	customer_id
	, rfm_recency*100 + rfm_frequency*10 + rfm_monetary as rfm_combined
from (select
	customer_id
	, NTILE(4) OVER (ORDER BY last_order) as rfm_recency
	, NTILE(4) OVER (ORDER BY order_count) as rfm_frequency
	, NTILE(4) OVER (ORDER BY total_price) as rfm_monetary
from (select
	customer_id
	, transaction_id
	, max(transaction_date) as last_order
	, count(*) as order_count
	, sum(final_price) as total_price
from sales
group by 1, 2
order by 1 desc) as rfm
	  ) as final_rfm
	 )
SELECT '0%',
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY rfm_combined) AS rfm
FROM final_rfm2
UNION
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY rfm_combined)
FROM final_rfm2
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY rfm_combined)
FROM final_rfm2
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY rfm_combined)
FROM final_rfm2
UNION
SELECT '100%',
PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY rfm_combined)
FROM final_rfm2
order by rfm

"?column?"	"rfm"
"0%"	       111
"25%"	       177.5
"50%"	       244
"75%"	       344
"100%"	     444

/*
Now that we have a basic scoring system we can assign labels to these customers
in order to take action on them. Below is are the labels based on score range:

111 - 118 Lost
119 - 244 Hibernating
245 - 344 Customers Needing Attention
345 - 444 Best Customers
*/

-- Next, using the following query we can check the range of recency by itself.

with rec as (select
	customer_id
	, rfm_recency*100 as recency
from (select
	customer_id
	, NTILE(4) OVER (ORDER BY last_order) as rfm_recency
	, NTILE(4) OVER (ORDER BY order_count) as rfm_frequency
	, NTILE(4) OVER (ORDER BY total_price) as rfm_monetary
from (select
	customer_id
	, transaction_id
	, max(transaction_date) as last_order
	, count(*) as order_count
	, sum(final_price) as total_price
from sales
group by 1, 2
order by 1 desc) as rfm
	  ) as final_rfm
		)
select
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY recency) AS pctile_0
	, PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY recency) AS pctile_25
	, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY recency) AS pctile_50
	, PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY recency) AS pctile_75
	, PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY recency) AS pctile_100
from rec
order by 1

"pctile_0"	"pctile_25"	"pctile_50"	"pctile_75"	"pctile_100"
100	          150	        200	         300	       400

/*
Now that we know the recency score range we can assign labels to customers:

100 - 150 Lost
151 - 200 Hibernating
201 - 300 Needs Attention
301 - 400 Loyal Customers

Now let's do the same for frequency.
*/

(Same query as above with the frequency score only)
select
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY frequency) AS pctile_0
	,PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY frequency) AS pctile_25
	,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY frequency) AS pctile_50
	,PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY frequency) AS pctile_75
	, PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY frequency) AS pctile_100
from rec
order by 1

"pctile_0"	"pctile_25"	"pctile_50"	"pctile_75"	"pctile_100"
   10	          15	       20	         30	           40

 /*
 Now that we know the recency score range we can assign labels to customers:

 10 - 15 Lost
 16 - 20 Hibernating
 21 - 30 Needs Attention
 31 - 40 Loyal Customers

 Finally, let's do the same for monetary.
 */

(Same query as above with the monetary score only)
select
  PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY monetary) AS pctile_0
  ,PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY monetary) AS pctile_25
  ,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY monetary) AS pctile_50
  ,PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY monetary) AS pctile_75
  , PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY monetary) AS pctile_100
from rec
order by 1

"pctile_0"	"pctile_25"	"pctile_50"	"pctile_75"	"pctile_100"
    1	          1.5	        2	          3	          4

/*
Here's the label breakdown for recency score range:

1 - 1.5 Lost
1.6 - 2 Hibernating
2.1 - 3 Needs Attention
3.1 - 4 Loyal Customers

We can also create combinations of these filters for more precision targeting.
Below is just one example with the first 8 results displayed:
*/

with final_rfm2 as (select
	customer_id
	, rfm_recency*100 as recency
	, rfm_frequency*10 as frequency
	, rfm_monetary as monetary
from (select
	customer_id
	, NTILE(4) OVER (ORDER BY last_order) as rfm_recency
	, NTILE(4) OVER (ORDER BY order_count) as rfm_frequency
	, NTILE(4) OVER (ORDER BY total_price) as rfm_monetary
from (select
	customer_id
	, transaction_id
	, max(transaction_date) as last_order
	, count(*) as order_count
	, sum(final_price) as total_price
from sales
group by 1, 2
order by 1 desc) as rfm
	  ) as final_rfm
	 )
SELECT
	distinct customer_id as loyal_customers
from final_rfm2
where recency between 300 and 400
and frequency between 30 and 40


"loyal_customers"
      12346
      12347
      12348
      12350
      12356
      12359
      12373
      12377

/*
We can also filter for customers who tend to only shop when there are
coupons available. By adding 'where coupon_status = 'Used' to the initial
calculation query we generate the following first 8 results:
*/

"loyal_customers"
      12346
      12347
      12348
      12356
      12373
      12377
      12383
      12393
