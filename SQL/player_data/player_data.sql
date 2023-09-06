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














blank space baby
