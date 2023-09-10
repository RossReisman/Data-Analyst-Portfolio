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

alter table login
rename column event_timestamp to login

alter table logout
rename column event_timestamp to logout

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

select * from logout;

--There are 10 user_ids and 10 event_timestamps

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

"Number of columns"	3
"Number of rows"	40

select * from damage;

--There are 40 rows of user_id, event_timestamp, and damage_taken

Step 3: Data Questions

--Which player played the longest?

SELECT
	f.user_id,
	f.login,
	l.logout,
EXTRACT(epoch FROM (logout - login)) AS player_lifetime
FROM login f
JOIN logout l
ON f.user_id = l.user_id
ORDER BY player_lifetime DESC

"d5a0c8e2f"	"2023-08-13 14:29:05"	"2023-08-26 10:49:03"	1109998
"a3e7b4c0d9"	"2023-08-16 11:10:55"	"2023-08-26 07:59:06"	852491
"7d1b0e6f4a"	"2023-08-18 16:55:10"	"2023-08-26 09:15:37"	663627
"1b6f3e9d7c"	"2023-08-20 22:18:47"	"2023-08-26 02:14:28"	446141
"c4d9a2b8e"	"2023-08-22 05:37:15"	"2023-08-26 08:37:50"	356435
"f6b2d8a5c"	"2023-08-22 18:09:50"	"2023-08-26 11:33:22"	321812
"8e0c7b5f1d"	"2023-08-22 18:09:50"	"2023-08-26 04:56:12"	297982
"9e4c1f7b3a"	"2023-08-23 07:02:33"	"2023-08-26 06:10:45"	256092
"2f9c6e8d1b"	"2023-08-24 03:37:28"	"2023-08-26 01:28:54"	165086
"b5a8c3f9e2"	"2023-08-25 09:23:42"	"2023-08-26 03:42:18"	65916























blank space baby
