/*
Why are some delivery charges so steep?
Which gender saved the most by using coupons?
Which location spends/coupons the most?
Which month had the highest ROAS?
Which customers spends/coupons the most?
*/

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
Coupon use hovers at around a third of all purchases except for Android
at 23%
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
	, sum(s.avg_price)
from sales s
join customers c
on c.customer_id = s.customer_id
group by 1

"gender"	"sum"
+++++++++++++++++
  "M"	  1,061,017.19
  "F"	  1,703,608.01

  -- Female customers outspent males by almost $700,000

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
we first need to look at the coupons that were available
for certain months.
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
Here we can see that each month used a different coupon
*/

select * from(
	select
	extract(month from transaction_date)
	, product_cat
	, count(product_cat)
	, row_number() over(partition by product_cat order by count(product_cat) desc) as product_rank
from sales
where coupon_status = 'Used'
group by 2, 1
order by 3 desc, 2) calcs
where product_rank <= 3
order by 2, 4
