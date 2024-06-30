/*
Data from
https://www.kaggle.com/datasets/rishikumarrajvansh/marketing-insights-for-e-commerce-company

Pretty sure the data is randomly generated because the coupon statuses don't
make sense but I did the analyses anyway.
*/

/*
Why are some delivery charges so steep?
Which location spends/coupons the most?
Which customers spends/coupons the most?
*/

/*

Sales and Marketing Analysis of Coupon Use and Past Year Transactions

Intro:

The purpose of this dataset is to understand the dynamics between marketing
spend, coupon offerings, and customer behaviors in order to uncover trends and
patterns that businesses can leverage to effect future sales and promote
customer loyalty.

By discovering trends and patterns, businesses can efficiently categorize
large groups of customers into a single "persona" which drastically reduces
the effort required to tailor marketing messages and offerings and can
significantly increase the efficacy of the message or offering.

Some of the methods that we can use include:

RFM Segmentation: An acronym for Recency, Frequency, and Monetary based
                  segmentation that assigns a score-based value to customers
                  (usually expressed in quartiles) based on how recently they've
                  interacted with the business, the frequency with which they
                  interact, and their monetary value.

                  Using this system, customers can be easily grouped into the
                  following categories: Lost, Hibernating, Needs Attention, and
                  Best Customers.

                  Customers can be further segmented for more granularity if
                  desired, but these four basic labels are a good starting
                  point for determining the state of the current customer base.

LTV Analysis:     An acronym for Lifetime Value, which represents the present
                  value of future cash flows associated with a specific
                  customer. Despite the phrasing, the time horizon for these
                  types of analyses can be either short- or long-term,
                  depending on the marketing project under consideration.

                  These types of analyses are used to estimate appropriate
                  marketing budgets as well as associated metrics such as
                  Customer Acquisition Cost (CAC). They can also be used to
                  forecast future revenues.

Churn:            Part of determining the lifetime value of a customer includes
                  estimating the percentage or number of customers who will
                  cease interaction with the business. This analysis has a
                  symbiotic relationship with lifetime value, as it allows for
                  the rough deduction of LTV.

                  Churn can also be used to pinpoint other business issues
                  involving overall customer experience, making it an important
                  tool that extends beyond marketing applications.

Cohort Analysis:  Cohort Analysis is a basic term that encompasses all of the
                  above types of analyses. A cohort is any group of customers
                  that share a similar characteristic, however the most common
                  applications include sign-up or first purchase date, similar
                  demographics such as age, gender, or location, and users who
                  use a specific feature of a service.

                  The purpose of cohort analysis is to identify a problem or
                  figure out what areas of a business to improve, and therefore
                  cohort designs are practically limitless.
*/


/*
Step 1: Basic Dataset Analysis:

In this first step, let's explore some of the characteristics of the past year's
coupon and sales data, before proceeding to more advanced analyses.

First let's explore overall coupon use.
*/

1) What is the coupon use status for each category?

select
  product_cat
  , coupon_status
  , count(coupon_status) as count
  , sum(count(coupon_status)) OVER(PARTITION BY product_cat) AS total_count
from sales
group by 1,2
order by 1, 2

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++"product_cat"++++++++++"coupon_status"+++++"count"+++"total_count"++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  "Accessories"	           "Clicked"	         125	        234
  "Accessories"	           "Not Used"	          32	        234
  "Accessories"	           "Used"	              77	        234
  "Android"	               "Clicked"	          23	         43
  "Android"	               "Not Used"	          10	         43
  "Android"       	       "Used"	              10	         43
  "Apparel"       	       "Clicked"	        9223	      18126
  "Apparel"       	       "Not Used"	        2747	      18126
  "Apparel"       	       "Used"	            6156	      18126
  "Backpacks"	             "Clicked"	          47	         89
  "Backpacks"	             "Not Used"	          15	         89
  "Backpacks"	             "Used"	              27	         89
  "Bags"	                 "Clicked"	         972	       1882
  "Bags"	                 "Not Used"	         285	       1882
  "Bags"	                 "Used"	             625	       1882
  "Bottles"	               "Clicked"	         138	        268
  "Bottles"	               "Not Used"	          48	        268
  "Bottles"	               "Used"	              82	        268
  "Drinkware"	             "Clicked"	        1752	       3483
  "Drinkware"	             "Not Used"	         570	       3483
  "Drinkware"	             "Used"	            1161	       3483
  "Fun"	                   "Clicked"	          25	        160
  "Fun"	                   "Used"	              52	        160
  "Gift Cards"	           "Clicked"	          81	        159
  "Gift Cards"	           "Not Used"	          22	        159
  "Gift Cards"	           "Used"	              56	        159
  "Google"	               "Clicked"	          51	        105
  "Google"	               "Not Used"	          25	        105
  "Google"	               "Used"	              29	        105
  "Headgear"	             "Clicked"	         401	        771
  "Headgear"	             "Not Used"	         114	        771
  "Headgear"	             "Used"	             256	        771
  "Housewares"	           "Clicked"	          68	        122
  "Housewares"	           "Not Used"	          18	        122
  "Housewares"	           "Used"	              36	        122
  "Lifestyle"	             "Clicked"	        1529	       3092
  "Lifestyle"	             "Not Used"	        462	         3092
  "Lifestyle"	             "Used"	            1101	       3092
  "More Bags"	             "Clicked"	          25	         46
  "More Bags"	             "Not Used"	           3	         46
  "More Bags"	             "Used"	              18	         46
  "Nest"	                 "Clicked"	        1127	       2198
  "Nest"	                 "Not Used"	         351	       2198
  "Nest"	                 "Used"	             720	       2198
  "Nest-Canada"	           "Clicked"	         175	        317
  "Nest-Canada"	           "Not Used"	          47	        317
  "Nest-Canada"	           "Used"	              95	        317
  "Nest-USA"	             "Clicked"	        7141	      14013
  "Nest-USA"	             "Not Used"	        2160	      14013
  "Nest-USA"	             "Used"	            4712	      14013
  "Notebooks & Journals"	 "Clicked"	         389	        749
  "Notebooks & Journals"	 "Not Used"	         103	        749
  "Notebooks & Journals"	 "Used"	             257	        749
  "Office"	               "Clicked"	        3295	       6513
  "Office"	               "Not Used"	         968	       6513
  "Office"              	 "Used"	            2250	       6513
  "Waze"	                 "Clicked"	         281	        554
  "Waze"	                 "Not Used"	          89	        554
  "Waze"	                 "Used"	             184       	  554

/*
Our results here include:

The product category name
The nominal category of coupon statuses
The count of each category of coupon status
A running total of each category

Coupon status falls into three categories: Not Used, Clicked, and Used. The
data dictionary states that "Clicked" means the customer clicked on a coupon,
but it wasn't applicable to the final purchase they made.

This gives us a raw data overview of coupon use status, but for better
comprehension, let's express these results in percentage form.
*/

with calcs as (select
  product_cat
  , coupon_status
  , count(coupon_status) as count
from sales
group by 1,2
order by 1, 2
)
select
	product_cat
	, coupon_status
	, round(100 * count/total_count, 2) as pct
from calcs

++++++++++++++++++++++++++++++++++++++++++++++++++++
++"product_cat"+++++++++"coupon_status"++++++"pct"++
++++++++++++++++++++++++++++++++++++++++++++++++++++
  "Accessories"	           "Clicked"	       53.42
  "Accessories"	           "Not Used"	       13.68
  "Accessories"	           "Used"	           32.91
  "Android"	               "Clicked"	       53.49
  "Android"	               "Not Used"	       23.26
  "Android"	               "Used"	           23.26
  "Apparel"	               "Clicked" 	       50.88
  "Apparel"	               "Not Used"	       15.16
  "Apparel"	               "Used"	           33.96
  "Backpacks"	             "Clicked"	       52.81
  "Backpacks"	             "Not Used"	       16.85
  "Backpacks"	             "Used"	           30.34
  "Bags"	                 "Clicked"	       51.65
  "Bags"	                 "Not Used"	       15.14
  "Bags"	                 "Used"	           33.21
  "Bottles"	               "Clicked"	       51.49
  "Bottles"	               "Not Used"	       17.91
  "Bottles"	               "Used"	           30.60
  "Drinkware"	             "Clicked"	       50.30
  "Drinkware"	             "Not Used"	       16.37
  "Drinkware"	             "Used"	           33.33
  "Fun"	                   "Clicked"	       51.88
  "Fun"	                   "Not Used"	       15.63
  "Fun"	                   "Used"	           32.50
  "Gift Cards"	           "Clicked"	       50.94
  "Gift Cards"	           "Not Used"	       13.84
  "Gift Cards"	           "Used"	           35.22
  "Google"	               "Clicked"	       48.57
  "Google"	               "Not Used"	       23.81
  "Google"	               "Used"	           27.62
  "Headgear"	             "Clicked"	       52.01
  "Headgear"	             "Not Used"	       14.79
  "Headgear"	             "Used"	           33.20
  "Housewares"	           "Clicked"	       55.74
  "Housewares"	           "Not Used"	       14.75
  "Housewares"	           "Used"	           29.51
  "Lifestyle"	             "Clicked"	       49.45
  "Lifestyle"	             "Not Used"	       14.94
  "Lifestyle"	             "Used"	           35.61
  "More Bags"	             "Clicked"	       54.35
  "More Bags"	             "Not Used"	        6.52
  "More Bags"	             "Used"	           39.13
  "Nest"	                 "Clicked"	       51.27
  "Nest"	                 "Not Used"	       15.97
  "Nest"	                 "Used"	           32.76
  "Nest-Canada"	           "Clicked"	       55.21
  "Nest-Canada"	           "Not Used"	       14.83
  "Nest-Canada"	           "Used"	           29.97
  "Nest-USA"	             "Clicked"	       50.96
  "Nest-USA"	             "Not Used"	       15.41
  "Nest-USA"	             "Used"	           33.63
  "Notebooks & Journals"   "Clicked"	       51.94
  "Notebooks & Journals"   "Not Used"	       13.75
  "Notebooks & Journals"   "Used"	           34.31
  "Office"	               "Clicked"	       50.59
  "Office"	               "Not Used"	       14.86
  "Office"	               "Used"	           34.55
  "Waze"	                 "Clicked"	       50.72
  "Waze"                	 "Not Used"	       16.06
  "Waze"                	 "Used"	           33.21


/*
Our results here include:

The product category name
The nominal category of coupon statuses
The percentage of each category of coupon status

Expressing these counts as percentages is more easily comprehensible, and gives
us a better idea of the breakdown of use across categories.

Finally, let's only display the percentage of transactions where coupons were used.
*/

with calcs as (select
  product_cat
  , coupon_status
  , count(coupon_status) as count
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

+++++++++++++++++++++++++++++++++++++++++++++++++
++"product_cat"++++++"coupon_status"++++++"pct"++
+++++++++++++++++++++++++++++++++++++++++++++++++
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
Our results here include:

The product category name
The nominal coupon status category of "Used" only
The percentage of transactions for each product category where a coupon was used

Here we can see that coupon use hovers at around a third of transactions for
each category. There are a couple outliers:

Android 23.26%
Google 27.62%
More Bags 39.13%

Everything else is comes in around 33% +/- 4%.
*/

2) Were coupons used more than unused?

select
  product_cat
  , sum(case when coupon_status = 'Used' then 1 else - 1 end) as use_count
from sales
group by 1
order by 1

+++++++++++++++++++++++++++++++++++++
++"product_cat"+++++++++"use_count"++
+++++++++++++++++++++++++++++++++++++
  "Accessories"	            -80
  "Android"	                -23
  "Apparel"	              -5814
  "Backpacks"	              -35
  "Bags"	                 -632
  "Bottles"	               -104
  "Drinkware"	            -1161
  "Fun"	                    -56
  "Gift Cards"	            -47
  "Google"	                -47
  "Headgear"	             -259
  "Housewares"	            -50
  "Lifestyle"	             -890
  "More Bags"	              -10
  "Nest"	                 -758
  "Nest-Canada"	           -127
  "Nest-USA"	            -4589
  "Notebooks & Journals"	 -235
  "Office"	              -2013
  "Waze"	                 -186


/*
Our results here include:

The product category name
An integer that represents their net use

As we know from the last question, coupons were unused more than they were used
across categories. Here we can see the number of transactions this represents.


Now that we've completed our look at overall coupon use, let's examine which
ccategories saw the most coupon use over the past year.
*/

3) Which coupons were used the most?

/*
In order to determine which coupon was used the most,
first we need to look at the coupons that were available for each month.
*/

select * from coupon
order by 2, 1

+++++++++++++++++++++++++++++++++++++++
++"month"+++"category"++"coupon_code"++
+++++++++++++++++++++++++++++++++++++++
   "Apr"	 "Accessories"	 "ACC10"
   "Aug"	 "Accessories"	 "ACC20"
   "Dec"	 "Accessories"	 "ACC30"
   "Feb"	 "Accessories"	 "ACC20"
   "Jan"	 "Accessories"	 "ACC10"
   "Jul"	 "Accessories"	 "ACC10"
   "Jun"	 "Accessories"	 "ACC30"
   "Mar"	 "Accessories"	 "ACC30"
   "May"	 "Accessories"	 "ACC20"
   "Nov"	 "Accessories"	 "ACC20"
   "Oct"	 "Accessories"	 "ACC10"
   "Sep"	 "Accessories"	 "ACC30"


/*
Our results here include:

The month name
The product category
The corresponding coupon code

Here I've isolated the Accessories category to demonstrate that each month used
one unique coupon code per category per month. So if we can see which
categories had the highest coupon use by month, we can determine which
coupons were used the most.
*/

select * from(
	select
	product_cat
	, row_number() over(partition by product_cat order by count(product_cat) desc) as product_rank
	, extract(month from transaction_date) as month
	, count(product_cat) as coupon_count
from sales
where coupon_status = 'Used'
group by 1, 3
order by 2 desc, 3) calcs
where product_rank <= 3
order by 1, 2

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++"product_cat"++++"product_rank"++++++++"month"++"coupon_count"++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  "Accessories"	          1	               11	          27
  "Accessories"	          2	               12	          18
  "Accessories"	          3	               10	          16
  "Android"	              1	                8	           3
  "Android"	              2	                1	           2
  "Android"	              3	                6	           2
  "Apparel"	              1	                8	         968
  "Apparel"	              2	                7	         720
  "Apparel"	              3	                5	         603
  "Backpacks"	            1	                5	           6
  "Backpacks"	            2	                8	           5
  "Backpacks"	            3	                4	           5
  "Bags"	                1	                7	          74
  "Bags"	                2	                3	          73
  "Bags"	                3	                8	          69
  "Bottles"	              1	                7	          15
  "Bottles"	              2	                8	          13
  "Bottles"	              3	                5	          10
  "Drinkware"	            1	                8	         146
  "Drinkware"	            2	                3	         132
  "Drinkware"	            3	               10	         117
  "Fun"	                  1	                7	           9
  "Fun"	                  2	                8	           9
  "Fun"	                  3	                6	           7
  "Gift Cards"	          1	               10	          30
  "Gift Cards"	          2	                5	           7
  "Gift Cards"	          3	                6	           4
  "Google"	              1	                1	           8
  "Google"	              2	                2	           5
  "Google"	              3	                3	           4
  "Headgear"	            1	                7	          40
  "Headgear"	            2	                8	          34
  "Headgear"	            3	                3	          30
  "Housewares"	          1	                8	           8
  "Housewares"	          2	                3	           6
  "Housewares"	          3	                7	           5
  "Lifestyle"	            1	                8	         149
  "Lifestyle"	            2	                7	         126
  "Lifestyle"	            3	                9	         120
  "More Bags"	            1	                3	           7
  "More Bags"	            2	                4	           6
  "More Bags"	            3	                5	           4
  "Nest"	                1	               11	         226
  "Nest"	                2	               12	         209
  "Nest"	                3	               10	         141
  "Nest-Canada"	          1	                6	          14
  "Nest-Canada"	          2	                1	          13
  "Nest-Canada"	          3	                4	          10
  "Nest-USA"	            1	                1	         526
  "Nest-USA"	            2	               12	         510
  "Nest-USA"	            3	               11	         501
  "Notebooks & Journals"	1	                8	          68
  "Notebooks & Journals"	2	                7	          48
  "Notebooks & Journals"	3	                5	          23
  "Office"	              1	                3	         234
  "Office"	              2	                5	         222
  "Office"	              3	                4	         213
  "Waze"	                1	                8	          23
  "Waze"	                2	                1	          20
  "Waze"	                3	                5	          20

/*
Our results here include:

The product category name
The rank of the top three months with the highest coupon use
An integer that represents the months
The count of transactions where a coupon was used

Here we can see the top 3 months of coupon use in each category.
Since the coupon table doesn't have a primary key, we can't join the tables
to display each month's corresponding coupon code, but cross referencing
this information with monthly coupon code info will reveal the most used code.

Some takeaways:

1) Accessories, Nest, and Nest-USA categories were most popular during the holiday season.
2) Apparel, Bottles, Fun, and Lifestyle categories were most popular during the summer months.
3) Google was most popular at the beginning of the year.

The above takeaways could be useful for future sale and inventory planning.

Now let's look at customer demographics.
*/


4) Which gender spends more?

select
	c.gender
	, sum(s.final_price)
from sales s
join customers c
on c.customer_id = s.customer_id
group by 1

++++++++++++++++++++++++
++"gender"+++++++"sum"++
++++++++++++++++++++++++
    "M"    1,767,124.39
    "F"	   2,903,670.23

/*
Our results here include:

Categorical customer gender data
An integer that represents the total revenue

Female customers outspent males by almost $1,200,000
Note that these figures exclude savings from coupons
*/


5) Which gender used coupons more?

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

+++++++++++++++++++++++++++++++++++++++++++
++"gender"++++++"coupon_status"+++"count"++
+++++++++++++++++++++++++++++++++++++++++++
    "M"	            "Used"	        6752
    "F"	            "Used"	       11152

/*
Our results here include:

Categorical customer gender data
Categorial coupon status data "Used" only
An integer that represents the total coupon use count

Female customers used coupons twice as many coupons.

Now let's examine location-based demographics.
*/

6) Which locations spent the most and what did they buy?

select
	c.location
	, sum(s.final_price)
from customers c
join sales s
on c.customer_id = s.customer_id
group by 1
order by 2 desc

+++++++++++++++++++++++++++++++
++"location"++++++++++++"sum"++
+++++++++++++++++++++++++++++++
  "Chicago"	       1,625,885.58
  "California"	   1,442,447.31
  "New York"	       937,022.63
  "New Jersey"	     409,666.86
  "Washington DC"	   255,772.24

/*
Our results here include:

Categorical location data
An integer that represents total revenue

Here we can see the top three locations by revenue are Chicago, California, and
New York, with both Chicago and California spending over $1 million this year.

Let's take a more granular look through the lens of product categories.
*/

select * from(
select
	c.location
	, s.product_cat
	, count(s.product_cat)
	, row_number() over(partition by product_cat order by count(product_cat) desc) as rank
from customers c
join sales s
on c.customer_id = s.customer_id
group by 1, 2
order by 2, 3 desc) calcs
where rank <= 3
order by 2, 4

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++"location"++++++++"product_cat"+++++++++++"count"+++"rank"++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  "Chicago"	        "Accessories"	             86	       1
  "California"	    "Accessories"	             80	       2
  "New York"	      "Accessories"	             41	       3
  "Chicago"	        "Android"	                 18	       1
  "California"	    "Android"	                 13	       2
  "New York"	      "Android"	                  7	       3
  "Chicago"	        "Apparel"	               6158	       1
  "California"	    "Apparel"	               5491	       2
  "New York"	      "Apparel"	               3902	       3
  "Chicago"	        "Backpacks"	               34	       1
  "California"	    "Backpacks"	               29	       2
  "New York"	      "Backpacks"	               14	       3
  "Chicago"	        "Bags"	                  731	       1
  "California"	    "Bags"	                  539	       2
  "New York"	      "Bags"	                  383	       3
  "California"	    "Bottles"	                 91	       1
  "Chicago"	        "Bottles"	                 85	       2
  "New York"      	"Bottles"	                 54	       3
  "Chicago"	        "Drinkware"	             1252	       1
  "California"	    "Drinkware"	             1117	       2
  "New York"  	    "Drinkware"	              675	       3
  "Chicago"	        "Fun"	                     56	       1
  "California"	    "Fun"	                     44	       2
  "New York"	      "Fun"	                     32	       3
  "Chicago"	        "Gift Cards"	             89	       1
  "California"	    "Gift Cards"	             27	       2
  "New York"   	    "Gift Cards"	             24	       3
  "California"	    "Google"	                 40	       1
  "Chicago"	        "Google"	                 33	       2
  "New York"    	  "Google"	                 22	       3
  "Chicago"	        "Headgear"	              264	       1
  "California"	    "Headgear"	              221	       2
  "New York"   	    "Headgear"	              191	       3
  "Chicago"	        "Housewares"	             50	       1
  "California"	    "Housewares"	             38	       2
  "New York"   	    "Housewares"	             23	       3
  "Chicago"	        "Lifestyle"	             1086	       1
  "California"	    "Lifestyle"	              977	       2
  "New York"	      "Lifestyle"	              624	       3
  "Chicago"	        "More Bags"	               17	       1
  "California"	    "More Bags"	               15	       2
  "New York"	      "More Bags"	                8	       3
  "California"	    "Nest"	                  762	       1
  "Chicago"	        "Nest"	                  710	       2
  "New York"	      "Nest"	                  421	       3
  "Chicago"	        "Nest-Canada"	            120	       1
  "California"	    "Nest-Canada"	             91	       2
  "New York"	      "Nest-Canada"	             63	       3
  "Chicago"	        "Nest-USA"	             4855	       1
  "California"	    "Nest-USA"	             4184	       2
  "New York"	      "Nest-USA"	             2975	       3
  "Chicago"	        "Notebooks & Journals"	  260	       1
  "California"	    "Notebooks & Journals"	  238	       2
  "New York"	      "Notebooks & Journals"	  181	       3
  "Chicago"	        "Office"	               2273	       1
  "California"	    "Office"	               1993	       2
  "New York"	      "Office"	               1409	       3
  "Chicago"	        "Waze"	                  203	       1
  "California"	    "Waze"	                  146	       2
  "New York"	      "Waze"	                  124	       3


/*
Our results here include:

Categorical location name data
Categorical product category data
The count of each product category ordered
The rank of each location by product category

Here we can see that Chicago, California, and New York were always in the top
three locations for number of products ordered. This is unsurprising as per our
last query, these locations outspent New Jersey and Washington DC by a wide
margin.


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
	, NTILE(4) OVER (ORDER BY total_rev) as rfm_monetary
from (select
	customer_id
	, transaction_id
	, max(transaction_date) as last_order
	, count(distinct transaction_id) as order_count
	, sum(final_price) as total_rev
from sales
group by 1, 2
order by 1 desc) as rfm
	  ) as final_rfm
	 )
SELECT
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY rfm_combined) AS rfm_0
	, PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY rfm_combined) AS rfm_25
	, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY rfm_combined) AS rfm_50
	, PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY rfm_combined) AS rfm_75
	, PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY rfm_combined) AS rfm_100
FROM final_rfm2

"rfm_0"	"rfm_25"	"rfm_50"	"rfm_75"	"rfm_100"
  111	    177.5	    244	      344	      444

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
	, NTILE(4) OVER (ORDER BY total_rev) as rfm_monetary
from (select
	customer_id
	, transaction_id
	, max(transaction_date) as last_order
	, count(distinct transaction_id) as order_count
	, sum(final_price) as total_rev
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
	, NTILE(4) OVER (ORDER BY total_rev) as rfm_monetary
from (select
	customer_id
	, transaction_id
	, max(transaction_date) as last_order
	, count(*) as order_count
	, sum(final_price) as total_rev
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
      12350
      12356
      12359
      12373
      12377



8) CV and CLV Analysis

-- First let's generate a list of customer values over this one year period.

select
	customer_id
	, round(avg(final_price),2) as avg_sales
	, count(distinct transaction_id) as order_count
	, sum(final_price) as total_rev
from sales
group by 1
order by 4 desc
limit 8

-- Here are the top 8 results

"customer_id"	"avg_sales"	"order_count"	"total_rev"
    15311	      129.37      	291        	75937.55
    12748	      107.34      	328        	74601.36
    14606	      99.37	        289	        57137.79
    14911	      93.65	        276	        48980.38
    17841	      80.78	        263	        46205.77
    17337	      136.82      	139        	35574.46
    17850	      116.33      	177        	34551.40
    13089	      74.32	        176	        27199.61

/*
Our top 8 customers spent between ~$28,000 and ~$76,000 during 2019.
As these are our most valuable customers, let's see how many purchases
they make per month.
*/

select
	customer_id
	, order_count / 12 as monthly_order_frequency
	from(
	select customer_id
	, round(avg(final_price),2) as avg_sales
	, count(distinct transaction_id) as order_count
	, sum(final_price) as total_rev
from sales
group by 1
order by 4 desc) as calcs
limit 8

"customer_id"	"monthly_order_frequency"
    15311	              24
    12748	              27
    14606	              24
    14911	              23
    17841	              21
    17337	              11
    17850	              14
    13089	              14


/*
Here we can see that our top 8 most valuable customers make anywhere from
11 to 27 purchases per month on average.

Let's see a breakdown of the IQT range of monthly orders for all customers.
*/

with calcs as (select customer_id
	, round(avg(final_price),2) as avg_sales
	, count(distinct transaction_id) as order_count
	, sum(final_price) as total_rev
from sales
group by 1
order by 3 desc)
,
order_freq as (select
	customer_id
	, order_count / 12 as monthly_order_frequency
	from calcs
	order by 2 desc)
select
	  PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY monthly_order_frequency) AS pctile_0
  ,PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY monthly_order_frequency) AS pctile_25
  ,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY monthly_order_frequency) AS pctile_50
  ,PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY monthly_order_frequency) AS pctile_75
  , PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY monthly_order_frequency) AS pctile_100
from order_freq

"pctile_0"	"pctile_25"	"pctile_50"	"pctile_75"	"pctile_100"
    0           0           0           1           27

/*
Here we can see that 75% of customers make 1 or fewer purchases per month.

Let's see what those numbers look like.
*/

with calcs as (select customer_id
	, round(avg(final_price),2) as avg_sales
	, count(distinct transaction_id) as order_count
	, sum(final_price) as total_rev
from sales
group by 1
order by 3 desc)
,
order_freq as (select
	customer_id
	, order_count / 12 as monthly_order_frequency
	from calcs
	order by 2 desc)
select
	count(case when monthly_order_frequency <= 1 then 1 end) as "<=1"
	, count(case when monthly_order_frequency >1 and monthly_order_frequency <= 3 then 1 end) as "<=3"
	, count(case when monthly_order_frequency >3 and monthly_order_frequency <= 5 then 1 end) as "<=5"
	, count(case when monthly_order_frequency >5 and monthly_order_frequency <= 10 then 1 end) as "<=10"
	, count(case when monthly_order_frequency >10 and monthly_order_frequency <= 20 then 1 end) as "<=20"
	, count(case when monthly_order_frequency >20 then 1 end) as "> 20"
from order_freq

"<=1"	"<=3"	"<=5"	"<=10"	"<=20"	"> 20"
1102	 267	 64	    26	     4	     5

/*
Here we can see that the top 35 customers are resposible for 10 or more
purchases per month.

Lets see what percentage of annual revenue this comprises.
*/

with calcs as (
	select
		customer_id
		, round(avg(final_price),2) as avg_sales
		, count(transaction_id) as order_count
		, sum(final_price) as total_rev
	from sales
	group by 1
	order by 3 desc)
,
ranked_customers as (
	select
		customer_id
		, total_rev
		, rank() over (order by total_rev desc) as customer_rank
	from calcs
)
,
rev_calcs as (
	select
		sum(case when customer_rank <= 35 then total_rev else 0 end) as top_35
		, sum(total_rev) as total_revenue
	from ranked_customers
)
select
	round((top_35 / total_revenue) * 100,2)
from rev_calcs

"top_35_pct_of_rev"
      19.18

-- Our top 35 customers are responsible for 19.18% of annual revenue.

/*
To obtain the value of each customer we multiply their average purchase by
the number of orders they made in this period.
*/

select
	customer_id
	, order_count
	, avg_sales
	, avg_sales * order_count as customer_value
	from(
	select customer_id
	, round(avg(final_price),2) as avg_sales
	, count(transaction_id) as order_count
	, sum(final_price) as total_rev
from sales
group by 1
order by 4 desc) as calcs
order by 4 desc
limit 8

"customer_id"	"order_count"	"avg_sales"	"customer_value"
    15311	        587	         129.37     	75940.19
    12748	        695	         107.34     	74601.30
    14606	        575	         99.37	      57137.75
    14911	        523	         93.65	      48978.95
    17841	        572	         80.78	      46206.16
    17337	        260	         136.82     	35573.20
    17850	        297	         116.33     	34550.01
    13089	        366	         74.32	      27201.12

/*
Our customer values here roughly match up with what we initially generated
when we first queried the past year's customer revenue data.

Now let's look at customer lifespans
*/

select
	customer_id
	, order_count
	, avg_sales
	, extract(epoch from (last_purchase - first_purchase)/86400) + 1 as lifespan
	, avg_sales * order_count as customer_value
	from(
	select customer_id
	, round(avg(final_price),2) as avg_sales
	, count(distinct transaction_id) as order_count
	, min(distinct transaction_date) as first_purchase
	, max(distinct transaction_date) as last_purchase
	, sum(final_price) as total_rev
from sales
group by 1
order by 4 desc) as calcs
order by 4 desc
limit 8

"customer_id"	"order_count"	"avg_sales"	"lifespan"	"customer_value"
    16029	          31	       98.07	     359	        3040.17
    15311	          291        129.37	     352	        37646.67
    13047	          26	       69.29	     352	        1801.54
    16456	          42	       136.09	     352	        5715.78
    13694	          37	       52.55	     350	        1944.35
    14606	          289        99.37	     350	        28717.93
    12662	          16	       87.34	     345	        1397.44
    14911	          276        93.65	     345	        25847.40

/*
Here we can see that our top eight customers have been making purchases for
almost the entire year we have on record.

Now let's look at the IQR breakdown of customer lifespan
*/

with calcs2 as (
	select
		customer_id
		, order_count
		, avg_sales
		, extract(epoch from (last_purchase - first_purchase)/86400) +1 as lifespan
		, avg_sales * order_count as customer_value
	from(
		select customer_id
		, round(avg(final_price),2) as avg_sales
		, count(transaction_id) as order_count
		, min(distinct transaction_date) as first_purchase
		, max(distinct transaction_date) as last_purchase
		, sum(final_price) as total_rev
	from sales
	group by 1
	order by 4 desc) as calcs1
)
select
	PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY lifespan) AS pctile_0
	, PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY lifespan) AS pctile_25
	, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lifespan) AS pctile_50
	, PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY lifespan) AS pctile_75
	, PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY lifespan) AS pctile_100
from calcs2

"pctile_0"	"pctile_25"	"pctile_50"	"pctile_75"	"pctile_100"
    1	          1	         1.5	       122	        359

/*
It looks like a considerable amount of customers made a bunch of purchases on
one day and then never came back.

Let's see exactly how many
*/

with calcs2 as (
	select
		customer_id
		, order_count
		, avg_sales
		, extract(epoch from (last_purchase - first_purchase)/86400) +1 as lifespan
		, avg_sales * order_count as customer_value
	from(
		select customer_id
		, round(avg(final_price),2) as avg_sales
		, count(transaction_id) as order_count
		, min(distinct transaction_date) as first_purchase
		, max(distinct transaction_date) as last_purchase
		, sum(final_price) as total_rev
	from sales
	group by 1
	order by 4 desc) as calcs1
)
select
	count(customer_id) as num_customers
from calcs2
where lifespan > 1

"num_customers"
      734

/*
734 customers out of our 1,468 made purchase(s) on one day and then churned

Let's see how many customers went more than 30 days without a purchase
*/

Churn

with calcs as (select
	distinct extract(month from this_month.transaction_date) as months
	, count(distinct this_month.customer_id) as this_month_cust
	, count(distinct last_month.customer_id) as last_month_cust
from sales this_month
join sales last_month
on this_month.transaction_date = last_month.transaction_date - interval '1 month'
group by 1
order by 1
)
,
diffs_cte as (
	select
		months
		, this_month_cust
		, last_month_cust
		, this_month_cust - last_month_cust as diffs
	from calcs
)
select
	months + 1 as month_num
	, diffs
	, this_month_cust
	, cast(diffs as float)/cast(this_month_cust as float)
from diffs_cte

"month_num"	"diffs"	"this_month_cust"	"?column?"
2	63	172	0.36627906976744184
3	-99	109	-0.908256880733945
4	-18	206	-0.08737864077669903
5	24	224	0.10714285714285714
6	-68	191	-0.35602094240837695
7	23	259	0.0888030888030888
8	-64	236	-0.2711864406779661
9	100	293	0.3412969283276451
10	-17	193	-0.08808290155440414
11	15	203	0.07389162561576355
12	-48	188	-0.2553191489361702
