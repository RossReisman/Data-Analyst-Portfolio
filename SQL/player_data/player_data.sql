Player Data Cleaning and Analysis
Data randomly generated
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, EPOCH, MIN/MAX,
DISTINCT, GROUP BY, HAVING, ORDER BY, COUNT, AVG, ALIAS, UNION, FLOOR, CAST AS.

/*
- join the tables to find the total seconds between logins and logouts
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

/*
"Number of columns"	2
"Number of rows"	10
*/

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

/*
"Number of columns"	2
"Number of rows"	10
*/

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

/*
"Number of columns"	3
"Number of rows"	40
*/

SELECT * FROM damage;

--There are 40 rows of user_id, event_timestamp, and damage_taken

Step 3: Data Questions

--Which player played the longest?

WITH player_time AS (
	SELECT
		l1.user_id,
		l1.login,
		l2.logout,
		CAST(EXTRACT(EPOCH FROM (logout - login)) AS DECIMAL) AS play_duration
	FROM login l1
	JOIN logout l2
	ON l1.user_id = l2.user_id
)
SELECT
	user_id,
	ROUND((play_duration) / 86400, 2) AS days,
	ROUND((play_duration) / 3600, 2) AS hours,
	ROUND((play_duration) / 60, 2) AS minutes,
	ROUND((play_duration), 2) AS seconds
FROM player_time
WHERE play_duration >= 0
ORDER BY 2 DESC;

/*
Player		Days	Hours		Minutes		Seconds
"d5a0c8e2f"	12.85	308.33	18499.97	1109998.00
"a3e7b4c0d9"	9.87	236.80	14208.18	852491.00
"7d1b0e6f4a"	7.68	184.34	11060.45	663627.00
"1b6f3e9d7c"	5.16	123.93	7435.68	446141.00
"c4d9a2b8e"	4.13	99.01	5940.58	356435.00
"f6b2d8a5c"	3.72	89.39	5363.53	321812.00
"8e0c7b5f1d"	3.45	82.77	4966.37	297982.00
"9e4c1f7b3a"	2.96	71.14	4268.20	256092.00
"2f9c6e8d1b"	1.91	45.86	2751.43	165086.00
"b5a8c3f9e2"	0.76	18.31	1098.60	65916.00
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
	ROUND(CAST(SUM(num_deaths) AS DECIMAL) / COUNT(user_id),2) AS avg_deaths
FROM damage
GROUP BY 1
ORDER BY 2 DESC
