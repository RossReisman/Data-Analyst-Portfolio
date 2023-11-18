/*
Mobile Game Player and Level Data and Cohort Analysis
Data from <p><a href="https://www.kaggle.com/datasets/manchvictor/prediction-of-user-loss-in-mobile-games">this link</a></p>
Skills Used: CREATE, COPY, ALTER, UPDATE, SET, SELECT, WHERE, EXTRACT, CTE,
GROUP BY, HAVING, ORDER BY, COUNT, AVG, ALIAS, UNION, FLOOR, CAST, CASE.
*/

Step 1: Import

CREATE TABLE users (
  user_id INT
  , level_id INT
  , success INT
  , duration DECIMAL
  , reststep DECIMAL
  , help INT
  , time TIMESTAMP
)

CREATE TABLE levels (
  avg_duration DECIMAL
  , avg_passrate DECIMAL
  , avg_win_duration DECIMAL
  , avg_retrytimes DECIMAL
  , level_id TEXT
)

/*
Remember that PSQL commands are written on one line
Written on multiple lines here for ease of reading
*/

\COPY public.users(user_id, level_id, success, duration, reststep, help, time) FROM '/Users/raws/Downloads/mobile_game_data/level_seq.csv' DELIMITER E'\t' CSV HEADER;

\COPY public.levels(avg_duration, avg_passrate, avg_win_duration, avg_retrytimes, level_id)
FROM '/Users/raws/Downloads/mobile_game_data/level_meta.csv'
DELIMITER E'\t'
CSV HEADER;

Step 2: Cleaning

--Get rows and columns for users
SELECT
	'Number of rows'
	, COUNT(*)
FROM users
UNION
SELECT
	'Number of columns'
	, COUNT(column_name)
FROM information_schema.columns
WHERE table_name='users';

/*
"Number of columns"	7
"Number of rows"	2194351
*/

--Get rows and columns for levels
SELECT
	'Number of rows'
	, COUNT(*)
FROM levels
UNION
SELECT
	'Number of columns'
	, COUNT(column_name)
FROM information_schema.columns
WHERE table_name='levels';

/*
"Number of columns"	5
"Number of rows"	1509
*/

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT *
FROM users
GROUP BY 1, 2, 3, 4, 5, 6, 7
HAVING COUNT(*) > 1) AS users_dupes

--There are 16,150 duplicate rows

--Check for duplicates
SELECT COUNT(*)
FROM (SELECT *
FROM levels
GROUP BY 1, 2, 3, 4, 5
HAVING COUNT(*) > 1) AS levels_dupes

--There are no duplicate rows

--Drop duplicate rows in users
DELETE FROM users
WHERE user_id in (
				select max(user_id)
				FROM users
				GROUP BY level_id
				HAVING COUNT(*)>1)
