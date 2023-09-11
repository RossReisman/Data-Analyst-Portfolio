Player Data Cleaning and Analysis
Data randomly generated
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, AND, OR, NOT, IS,
NULL, EPOCH, LIKE/NOT LIKE, MIN/MAX, DISTINCT, BETWEEN, GROUP BY, HAVING,
ORDER BY, COUNT, AVG, ALIAS, LIMIT, UNION, FLOOR.

/*
- join the TABLEs to find the total seconds between logins and logouts
- answer "how much damage did each player take in total"
- what was the average damage taken per player
- what player died the most/least
- what time of day do players die the most (lol not really something anyone would ask)
*/

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

ALTER TABLE login
RENAME COLUMN event_timestamp TO login

ALTER TABLE logout
RENAME COLUMN event_timestamp TO logout

Step 2: EDA

--Get rows and columns for login
SELECT
	'Number of rows',
	COUNT(*)
FROM sellers
UNION
SELECT
	'Number of columns',
	COUNT(column_name)
FROM information_schema.columns
WHERE table_name='sellers';

"Number of columns"	2
"Number of rows"	10


SELECT * FROM login;

--There are 10 user_ids and 10 event_timestamps

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT *
FROM login
GROUP BY 1
HAVING COUNT(*) > 1) AS login_dupes

SELECT COUNT(*)
FROM (SELECT user_id
FROM login
GROUP BY 1
HAVING COUNT(*) > 1) AS user_dupes

--There are no duplicate values

--Get rows and columns for logout
SELECT
	'Number of rows',
	COUNT(*)
FROM logout
UNION
SELECT
	'Number of columns',
	COUNT(column_name)
FROM information_schema.columns
WHERE table_name='logout';

"Number of columns"	2
"Number of rows"	10

SELECT * FROM logout;

--There are 10 user_ids and 10 event_timestamps

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT *
FROM logout
GROUP BY 1
HAVING COUNT(*) > 1) AS logout_dupes

SELECT COUNT(*)
FROM (SELECT user_id
FROM logout
GROUP BY 1
HAVING COUNT(*) > 1) AS user_dupes

--There are no duplicate values

SELECT
	'Number of rows',
	COUNT(*)
FROM damage
UNION
SELECT
	'Number of columns',
	COUNT(column_name)
FROM information_schema.columns
WHERE table_name='damage';

"Number of columns"	3
"Number of rows"	40

SELECT * FROM damage;

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

/*
"d5a0c8e2f"	1109998
"a3e7b4c0d9"	852491
"7d1b0e6f4a"	663627
"1b6f3e9d7c"	446141
"c4d9a2b8e"	356435
"f6b2d8a5c"	321812
"8e0c7b5f1d"	297982
"9e4c1f7b3a"	256092
"2f9c6e8d1b"	165086
"b5a8c3f9e2"	65916
*/

-- How much damage did each player take in total?

SELECT
	user_id AS player,
	SUM(damage_taken) AS total_damage
FROM damage
GROUP BY 1
ORDER BY 2 DESC

/*
"9e1a3c7f5b"	68
"8b0e7f3c9a"	64
"d7f1e9b2a4"	62
"4d6a2f8c1e"	62
"c5d8a9f1e2"	54
"f1d5a7e0c9"	17
"b6f2d5a8c0"	12
"a2e4f8c6b0"	7
"e2b9d4a6f8"	6
"3a5c7e9b1d"	3
*/

--what was the average damage taken per player

SELECT
	user_id AS player,
	ROUND(AVG(damage_taken),2) AS average_damage
FROM damage
GROUP BY 1
ORDER BY 2 DESC

/*
"b6f2d5a8c0"	12.00
"9e1a3c7f5b"	9.71
"8b0e7f3c9a"	9.14
"4d6a2f8c1e"	8.86
"d7f1e9b2a4"	8.86
"c5d8a9f1e2"	7.71
"a2e4f8c6b0"	7.00
"e2b9d4a6f8"	6.00
"3a5c7e9b1d"	3.00
*/

--what player died the most/least? (3 damage = 1 death)

ALTER TABLE damage
ADD num_deaths INT;
UPDATE damage
SET num_deaths = FLOOR(damage_taken/3)

SELECT
	user_id AS player,
	SUM(num_deaths) AS num_deaths
FROM damage
GROUP BY 1
ORDER BY 2 DESC

/*
"9e1a3c7f5b"	21
"d7f1e9b2a4"	19
"8b0e7f3c9a"	19
"4d6a2f8c1e"	18
"c5d8a9f1e2"	17
"f1d5a7e0c9"	5
"b6f2d5a8c0"	4
"e2b9d4a6f8"	2
"a2e4f8c6b0"	2
"3a5c7e9b1d"	1
*/

SELECT
	user_id AS player,
	SUM(num_deaths) AS num_deaths,
	COUNT(user_id) AS num_games,
	ROUND(cast(SUM(num_deaths) AS decimal) / COUNT(user_id),2) AS avg_deaths
FROM damage
GROUP BY 1
ORDER BY 2 DESC
