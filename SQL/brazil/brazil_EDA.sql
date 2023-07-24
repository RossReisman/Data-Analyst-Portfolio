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

SELECT DISTINCT seller_state
FROM sellers
Group by 1
order by 1

--There are 23 unique states


























































































blank space baby
