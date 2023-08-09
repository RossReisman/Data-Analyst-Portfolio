Step 5: EDA

5a: Sellers

--Check unique values
SELECT COUNT(*)
FROM (SELECT DISTINCT seller_id
FROM sellers) as distinct_id;

SELECT COUNT(*)
FROM (SELECT DISTINCT seller_zip_code_prefix
FROM sellers) as distinct_zip;

SELECT COUNT(*)
FROM (SELECT DISTINCT seller_city
FROM sellers) as distinct_city;

SELECT COUNT(*)
FROM (SELECT DISTINCT seller_state
FROM sellers) as distinct_state;

SELECT COUNT(*)
FROM (SELECT DISTINCT seller_city_state
FROM sellers)
AS distinct_city_state;

/*
There are 2246 unique zip code prefixes
There are 611 unique seller cities
There are 23 unique seller states
There are 636 unique city states

Discrepancy between unique cities and city/states
may be due to multiple cities sharing a name
*/

SELECT DISTINCT seller_city
FROM sellers
Group by 1
order by 1

/*
One city is a number
There are many versions of:
Angra Dos Reis Rj
Auriflama
Balenario Camboriu
"Barbacena/ Minas Gerais, MG"
"Belo Horizont, MG"
Brasilia
"Carapicuiba / Sao Paulo, SP"
"Cariacica / Es, ES"
"Cascavael, PR"
"Ferraz De  Vasconcelos, SP"
"Jacarei / Sao Paulo, SP"
"Lages - Sc, SC"
"Maua/Sao Paulo, SP"
"Mogi Das Cruzes / Sp, SP"
"Novo Hamburgo, Rio Grande Do Sul, Brasil, RS"
"Pinhais/Pr, PR"
Rio De Janeiro
"Ribeirao Preto / Sao Paulo, SP"
"Santa Barbara D Oeste"
"Santo Andre/Sao Paulo"
"Sao Jose Do Rio Pret, SP"
"Sao Jose Dos Pinhas, PR"
"Sao Miguel D'Oeste"
"SãO Paulo, SP"
"Sao Paluo"
"Sbc/Sp"
"Sp / Sp"
"Vendas@Creditparts.Com.Br"
*/

5b: Product Categories

select * from categories
group by 1
order by 1

/*
"costruction_tools_garden"
"costruction_tools_tools"
"fashio_female_clothing"
"home_appliances_2"
"home_appliances_2"
"home_confort"
*/

5c: Orders

select * from orders

select distinct(order_status)
from orders

select order_status, count(order_status) as count
from orders
group by 1
order by 2 desc

/*
"delivered"	  96,478
"shipped"	  1107
"canceled"	  625
"unavailable"	  609
"invoiced"	  314
"processing"	  301
"created"	  5
"approved"	  2
*/

select min(order_purchase_timestamp),
max(order_purchase_timestamp)
from orders

"2016-09-04 21:15:19"	"2018-10-17 17:30:18"

select order_month_year, count(order_month_year)
from orders
group by 1
order by 1

"2016-09-01 00:00:00"	4
"2016-10-01 00:00:00"	324
"2016-12-01 00:00:00"	1
"2017-01-01 00:00:00"	800
"2017-02-01 00:00:00"	1780
"2017-03-01 00:00:00"	2682
"2017-04-01 00:00:00"	2404
"2017-05-01 00:00:00"	3700
"2017-06-01 00:00:00"	3245
"2017-07-01 00:00:00"	4026
"2017-08-01 00:00:00"	4331
"2017-09-01 00:00:00"	4285
"2017-10-01 00:00:00"	4631
"2017-11-01 00:00:00"	7544
"2017-12-01 00:00:00"	5673
"2018-01-01 00:00:00"	7269
"2018-02-01 00:00:00"	6728
"2018-03-01 00:00:00"	7211
"2018-04-01 00:00:00"	6939
"2018-05-01 00:00:00"	6873
"2018-06-01 00:00:00"	6167
"2018-07-01 00:00:00"	6292
"2018-08-01 00:00:00"	6512
"2018-09-01 00:00:00"	16
"2018-10-01 00:00:00"	4

select order_month_year,
avg(order_delivered_customer_date - order_delivered_carrier_date)
from orders
group by 1
order by 1

"2017-11-01 00:00:00"	"10 days 26:16:21.488063"
"2017-12-01 00:00:00"	"11 days 16:11:16.060221"
"2018-01-01 00:00:00"	"9 days 35:35:54.466827"
"2018-02-01 00:00:00"	"12 days 33:15:25.965985"
"2018-03-01 00:00:00"	"12 days 23:13:40.591318"
"2018-04-01 00:00:00"	"8 days 16:07:05.898794"
"2018-05-01 00:00:00"	"8 days 17:37:50.342125"
"2018-06-01 00:00:00"	"6 days 16:24:57.628281"
"2018-07-01 00:00:00"	"5 days 27:17:11.402372"

5d: Items

select * from items;

select distinct(order_item_id)
from items
order by 1

--Orders have as many as 21 items in a single order

select order_item_id, count(order_item_id)
from items
group by 1
order by 1

1	98666
2	9803
3	2287
4	965
5	460
6	256
7	58
8	36
9	28
10	25
11	17
12	13
13	8
14	7
15	5
16	3
17	3
18	3
19	3
20	3
21	1

--Most orders have fewer than 10 items per order

SELECT 'average',
	ROUND(AVG(order_item_id),2) AS avg_num_items
FROM items
UNION
SELECT 'MIN',
	MIN(order_item_id) AS min_num_items
FROM items
UNION
SELECT 'MAX',
	MAX(order_item_id) AS max_num_items
FROM items
group by 1
order by 1

"MAX"	21
"MIN"	1
"average"	1.20

SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY order_item_id) AS item_25
FROM items
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY order_item_id) AS item_50
FROM items
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY order_item_id) AS item_75
FROM items
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY order_item_id) AS item_95
FROM items

"75%"	1
"25%"	1
"50%"	1
"95%"	2

--Most orders have 1 item.

select order_id, max(order_item_id), price,
case
	when max(price) < 100 then '0-100'
	when max(price) between 101 and 250 then '101-250'
	when max(price) between 250 and 750 then '250-750'
	when max(price) between 250 and 750 then '250-750'
	when max(price) between 750 and 1250 then '750-1250'
	when max(price) between 1250 and 2000 then '1250-2000'
else '2000+'
end as buckets
from items
group by 1, 3

--The max function ensures only one price is returned per order






























































blank space baby
