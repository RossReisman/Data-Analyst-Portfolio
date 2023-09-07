Player Data Cleaning and Analysis
Data randomly generated
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, AND, OR, NOT, IS,
NULL, INTERVAL, LIKE/NOT LIKE, MIN/MAX, DISTINCT, BETWEEN, GROUP BY, HAVING,
ORDER BY, COUNT, AVG, ALIAS, LIMIT, UNION, FLOOR.


Step 1: Create Tables

CREATE TABLE login (
	user_id TEXT,
	event_timestamp TIMESTAMP
)

CREATE TABLE logout (
	user_id TEXT,
	event_timestamp TIMESTAMP
)

CREATE TABLE damage (
	user_id TEXT,
	event_timestamp TIMESTAMP,
	damage_taken INT
)

/*
Remember that PSQL commands are written on one line
Written on multiple lines here for ease of reading
*/

\COPY public.login(user_id, event_timestamp)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/player_data/login_df.csv'
DELIMITER ','
CSV HEADER;

\COPY public.logout(user_id, event_timestamp)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/player_data/logout_df.csv'
DELIMITER ','
CSV HEADER;

\COPY public.damage(user_id, event_timestamp, damage_taken)
FROM '/Users/raws/Documents/GitHub/portfolio/SQL/player_data/damage_df.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE login
ADD PRIMARY KEY (user_id)

ALTER TABLE logout
ADD PRIMARY KEY (user_id)

Step 2: EDA

--Get rows and columns for login
SELECT 'Number of rows',
COUNT(*)
FROM sellers
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='sellers';

"Number of columns"	2
"Number of rows"	10


select * from login;

--There are 10 user_ids and 10 event_timestamps

--Check for duplicates
select count(*)
from (select *
from login
group by 1
having count(*) > 1) as login_dupes

select count(*)
from (select user_id
from login
group by 1
having count(*) > 1) as user_dupes

--There are no duplicate values

--Get rows and columns for logout
SELECT 'Number of rows',
COUNT(*)
FROM logout
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='logout';

"Number of columns"	2
"Number of rows"	10

--Check for duplicates
select count(*)
from (select *
from logout
group by 1
having count(*) > 1) as logout_dupes

select count(*)
from (select user_id
from logout
group by 1
having count(*) > 1) as user_dupes

--There are no duplicate values

SELECT 'Number of rows',
COUNT(*)
FROM damage
UNION
SELECT 'Number of columns',
COUNT(column_name)
FROM information_schema.columns
WHERE table_name='damage';



blank space baby
