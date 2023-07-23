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
Angra Dos Reis
Auriflama
Balenario Camboriu
Brasilia
"Cariacica"
"Jacarei"
"Maua"
"Mogi Das Cruses"
"Novo Hamburgo"
"Pinhais"
Rio De Janeiro
Ribeiro Preto
"Santa Barbara D Oeste"
"Santo Andre/Sao Paulo"
"Sao Miguel D'Oeste"
"Sao Paluo"
"Sbc/Sp"
"Sp / Sp"
*/




























































































blank space baby
