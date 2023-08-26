This project is incomplete
I moved on to video game focused analysis (My desired industry)

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
Cities to be cleaned:
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

/*
Data begins on 2016-09-04 21:15:19
and ends on 2018-10-17 17:30:18
*/

select order_month_year, count(order_month_year)
from orders
group by 1
order by 1

/*
Count of orders by month:

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
*/

select order_month_year,
avg(order_delivered_customer_date - order_delivered_carrier_date)
from orders
group by 1
order by 1

/*
Average delivery time by month:

"2016-09-01 00:00:00"	"1 day 14:35:45"
"2016-10-01 00:00:00"	"5 days 19:35:06.925926"
"2016-12-01 00:00:00"	"1 day 09:40:17"
"2017-01-01 00:00:00"	"8 days 28:46:25.570667"
"2017-02-01 00:00:00"	"9 days 12:50:50.061101"
"2017-03-01 00:00:00"	"9 days 20:00:06.071877"
"2017-04-01 00:00:00"	"10 days 29:38:34.541033"
"2017-05-01 00:00:00"	"7 days 32:09:56.871368"
"2017-06-01 00:00:00"	"8 days 21:06:48.584689"
"2017-07-01 00:00:00"	"8 days 11:35:14.246643"
"2017-08-01 00:00:00"	"7 days 25:31:26.513474"
"2017-09-01 00:00:00"	"8 days 15:31:46.279344"
"2017-10-01 00:00:00"	"7 days 33:45:59.687361"
"2017-11-01 00:00:00"	"10 days 26:16:21.488063"
"2017-12-01 00:00:00"	"11 days 16:11:16.060221"
"2018-01-01 00:00:00"	"9 days 35:35:54.466827"
"2018-02-01 00:00:00"	"12 days 33:15:25.965985"
"2018-03-01 00:00:00"	"12 days 23:13:40.591318"
"2018-04-01 00:00:00"	"8 days 16:07:05.898794"
"2018-05-01 00:00:00"	"8 days 17:37:50.342125"
"2018-06-01 00:00:00"	"6 days 16:24:57.628281"
"2018-07-01 00:00:00"	"5 days 27:17:11.402372"
"2018-08-01 00:00:00"	"4 days 29:08:44.995748"
"2018-09-01 00:00:00"	Null
"2018-10-01 00:00:00"	Null
*/

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

/*
Count of number of items in an order (includes duplicates)

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
*/

--Most orders have fewer than 4 items per order

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

/*
"MAX"	21
"MIN"	1
"average"	1.20
*/

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

/*
"75%"	1
"25%"	1
"50%"	1
"95%"	2
*/

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

--Bins of prices
select
floor(price/100) * 10 as buckets,
count(*)
from items
group by 1
order by 1, 2

/*
Count of bin membership:

0	72165
10	27012
20	6511
30	2717
40	1006
50	917
60	572
70	397
80	323
90	184
100	122
110	134
120	103
130	102
140	48
150	50
160	49
170	30
180	36
190	49
200	8
210	22
220	16
230	10
240	9
250	3
260	11
270	6
280	2
290	11
300	3
310	3
330	1
350	1
360	2
370	1
380	1
390	4
400	2
430	1
450	1
460	1
470	1
640	1
670	2
*/

--interquartile range for price
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS price_25
FROM items
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS price_50
FROM items
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS price_75
FROM items
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY price) AS price_95
FROM items
UNION
SELECT 'Max',
MAX(price) AS price_max
FROM items
order by 1

/*
"25%"	39.9
"50%"	74.99
"75%"	134.9
"95%"	349.9
"Max"	6735
*/

--interquartile range for freight value
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY freight_value)
FROM items
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY freight_value)
FROM items
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY freight_value)
FROM items
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY freight_value)
FROM items
UNION
SELECT 'Max',
MAX(freight_value)
FROM items
order by 1

/*
"25%"	13.08
"50%"	16.26
"75%"	21.15
"95%"	45.12
"Max"	409.68
*/

5e: Customers

select * from customers;


--Check unique values
SELECT COUNT(*)
FROM (SELECT DISTINCT customer_unique_id
FROM customers) as distinct_id;

SELECT COUNT(*)
FROM (SELECT DISTINCT customer_zip_code_prefix
FROM customers) as distinct_zip;

SELECT COUNT(*)
FROM (SELECT DISTINCT customer_city
FROM customers) as distinct_city;

SELECT COUNT(*)
FROM (SELECT DISTINCT customer_state
FROM customers) as distinct_state;

SELECT COUNT(*)
FROM (SELECT DISTINCT customer_city_state
FROM customers) as distinct_city_state;

/*
There are 96,096 unique customers
There are 14,994 unique zip code prefixes
There are 4,119 unique customer cities
There are 27 unique customer states
There are 4,310 unique customer city/states

Discrepancy between unique cities and city/states
is confirmed due to multiple cities sharing a name
*/

SELECT DISTINCT customer_city
FROM customers
Group by 1
order by 1

/*
Cities to be cleaned:
"Arraial D'Ajuda"
"Dias D'Avila"

Looks like cities with "D'" appear both as "D' and D "
*/

SELECT DISTINCT customer_city
FROM customers
WHERE customer_city LIKE 'D%'

--Only those two examples exist

5f: Geolocation

select * from geolocation;

SELECT DISTINCT geolocation_city
FROM geolocation
ORDER BY 1

/*
Cities to be cleaned:
"* Cidade"
"...Arraial Do Cabo"
"4o. Centenario"
"4º Centenario"
"AbadiâNia"
"Abaeté" vs. "Abaete"
"Abare" vs. "Abaré"
"Abatia" vs. "Abatiá"
"AbaíRa"
"AbreulâNdia"
"Acarau" vs. "Acaraú"
"Acegua" vs. "Aceguá"

More
*/

--Check unique values
SELECT COUNT(*)
FROM (SELECT DISTINCT geolocation_city
FROM geolocation) as distinct_city;

SELECT COUNT(*)
FROM (SELECT DISTINCT geolocation_state
FROM geolocation) as distinct_state;

SELECT COUNT(*)
FROM (SELECT DISTINCT geolocation_city_state
FROM geolocation) as distinct_city_state;

/*
There are 8,011 unique geolocation cities
There are 27 unique geolocation states
There are 8,463 unique geolocation city/states

Discrepancy between unique cities and city/states
is confirmed due to multiple cities sharing a name
*/

5g: Payments

select * from payments;

--interquartile range for payment sequential (number of FOPs)
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY payment_sequential)
FROM payments
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY payment_sequential)
FROM payments
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY payment_sequential)
FROM payments
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY payment_sequential)
FROM payments
UNION
SELECT 'Max',
MAX(payment_sequential)
FROM payments
order by 1

/*
"25%"	1
"50%"	1
"75%"	1
"95%"	1
"Max"	29
*/

--Over 95% of customers pay with one FOP, some pay with as many as 29

SELECT distinct payment_sequential, count(payment_sequential)
from payments
group by 1
order by 2 desc

/*
1	99360
2	3039
3	581
4	278
5	170
6	118
7	82
8	54
9	43
10	34
11	29
12	21
13	13
14	10
15	8
16	6
17	6
18	6
19	6
20	4
21	4
22	3
23	2
24	2
25	2
26	2
27	1
28	1
29	1
*/

--Check unique payment types
SELECT distinct payment_type
from payments
order by 1

/*
"boleto"
"credit_card"
"debit_card"
"not_defined"
"voucher"
*/

SELECT payment_type, count(payment_type)
from payments
group by 1
order by 2 desc

/*
"credit_card"	76795
"boleto"	19784
"voucher"	5775
"debit_card"	1529
"not_defined"	3
*/

--Count of number of payment installments
SELECT payment_installments, count(payment_installments)
from payments
group by 1
order by 2 desc

/*
1	52546
2	12413
3	10461
4	7098
10	5328
5	5239
8	4268
6	3920
7	1626
9	644
12	133
15	74
18	27
11	23
24	18
20	17
13	16
14	15
17	8
16	5
21	3
0	2
22	1
23	1

Most customers pay in 4 or fewer installments
but some in as many as 10 and a few in as many as 24
*/

--interquartile range for payment values
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY payment_value)
FROM payments
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY payment_value)
FROM payments
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY payment_value)
FROM payments
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY payment_value)
FROM payments
UNION
SELECT 'Max',
MAX(payment_value)
FROM payments
order by 1

/*
"25%"	56.79
"50%"	100
"75%"	171.8375
"95%"	437.635
"Max"	13664.08
*/

--Most payment values are under $500 with a few extreme outliers


5h: Reviews

select * from reviews

--interquartile range of review scores
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY review_score)
FROM reviews
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY review_score)
FROM reviews
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY review_score)
FROM reviews
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY review_score)
FROM reviews
UNION
SELECT 'Max',
MAX(review_score)
FROM reviews
order by 1

/*
"25%"	4
"50%"	5
"75%"	5
"95%"	5
"Max"	5

Most customers give a 4 or 5 on their satisfaction survey
*/



--interquartile range for review response time
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY review_response_time)
FROM reviews
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY review_response_time)
FROM reviews
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY review_response_time)
FROM reviews
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY review_response_time)
FROM reviews
UNION
SELECT 'Max',
MAX(review_response_time)
FROM reviews
order by 1

/*
"25%"	"1 day 00:07:00.75"
"50%"	"1 day 16:11:55.5"
"75%"	"3 days 02:29:08"
"95%"	"6 days 23:19:57.2"
"Max"	"1 year 5 mons 16:46:52"

Most reviews are responded to in less than a week
*/


--Check number of rows in reviews table
SELECT count(*)
from reviews

--99224 reviews

--Check number of reviews with a title
SELECT count(review_comment_title)
from reviews
where review_comment_title IS NOT NULL

--11568 reviews

--Top 20 review titles
SELECT review_comment_title, count(review_comment_title)
from reviews
group by 1
order by 2 desc
limit 20

/*
"Recomendo"	423
"recomendo"	345
"Bom"	293
"super recomendo"	270
"Excelente"	248
"Muito bom"	247
"Ótimo"	240
"Super recomendo"	217
"Ótimo "	207
"Otimo"	174
"10"	158
"Excelente "	119
"otimo"	105
"bom"	97
"Muito bom "	87
"Boa"	86
"Recomendo "	62
"Perfeito"	57
"RECOMENDO"	55
"Ótima"	55

--Top 20 review titles comprising about 30% of reviews; seem generally positive
*/

5i: Products

SELECT * from products

SELECT count(distinct product_category_name)
from products
order by 1

--There are 73 unique product categories

SELECT distinct(product_category_name)
from products
order by 1

/*
"Agro_Industria_E_Comercio"
"Alimentos"
"Alimentos_Bebidas"
"Artes"
"Artes_E_Artesanato"
"Artigos_De_Festas"
"Artigos_De_Natal"
"Audio"
"Automotivo"
"Bebes"
"Bebidas"
"Beleza_Saude"
"Brinquedos"
"Cama_Mesa_Banho"
"Casa_Conforto"
"Casa_Conforto_2"
"Casa_Construcao"
"Cds_Dvds_Musicais"
"Cine_Foto"
"Climatizacao"
"Consoles_Games"
"Construcao_Ferramentas_Construcao"
"Construcao_Ferramentas_Ferramentas"
"Construcao_Ferramentas_Iluminacao"
"Construcao_Ferramentas_Jardim"
"Construcao_Ferramentas_Seguranca"
"Cool_Stuff"
"Dvds_Blu_Ray"
"Eletrodomesticos"
"Eletrodomesticos_2"
"Eletronicos"
"Eletroportateis"
"Esporte_Lazer"
"Fashion_Bolsas_E_Acessorios"
"Fashion_Calcados"
"Fashion_Esporte"
"Fashion_Roupa_Feminina"
"Fashion_Roupa_Infanto_Juvenil"
"Fashion_Roupa_Masculina"
"Fashion_Underwear_E_Moda_Praia"
"Ferramentas_Jardim"
"Flores"
"Fraldas_Higiene"
"Industria_Comercio_E_Negocios"
"Informatica_Acessorios"
"Instrumentos_Musicais"
"La_Cuisine"
"Livros_Importados"
"Livros_Interesse_Geral"
"Livros_Tecnicos"
"Malas_Acessorios"
"Market_Place"
"Moveis_Colchao_E_Estofado"
"Moveis_Cozinha_Area_De_Servico_Jantar_E_Jardim"
"Moveis_Decoracao"
"Moveis_Escritorio"
"Moveis_Quarto"
"Moveis_Sala"
"Musica"
"Papelaria"
"Pc_Gamer"
"Pcs"
"Perfumaria"
"Pet_Shop"
"Portateis_Casa_Forno_E_Cafe"
"Portateis_Cozinha_E_Preparadores_De_Alimentos"
"Relogios_Presentes"
"Seguros_E_Servicos"
"Sinalizacao_E_Seguranca"
"Tablets_Impressao_Imagem"
"Telefonia"
"Telefonia_Fixa"
"Utilidades_Domesticas"
*/

--interquartile range for product description length
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY product_description_length)
FROM products
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_description_length)
FROM products
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY product_description_length)
FROM products
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY product_description_length)
FROM products
UNION
SELECT 'Max',
MAX(product_description_length)
FROM products
order by 1

/*
"25%"	339
"50%"	595
"75%"	972
"95%"	2063
"Max"	3992
*/

--interquartile range for number of photos
SELECT '25%',
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY product_photos_qty)
FROM products
UNION
SELECT '50%',
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_photos_qty)
FROM products
UNION
SELECT '75%',
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY product_photos_qty)
FROM products
UNION
SELECT '95%',
PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY product_photos_qty)
FROM products
UNION
SELECT 'Max',
MAX(product_photos_qty)
FROM products
order by 1

/*
"25%"	1
"50%"	1
"75%"	3
"95%"	6
"Max"	20
*/
