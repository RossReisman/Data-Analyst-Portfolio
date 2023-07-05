Step 4: Data Cleaning

4a: Sellers

--Get number of rows
select count(*) from sellers;

3095

--Get number of columns
select count(column_name) AS number
FROM information_schema.columns
where table_name='sellers';

4

--Sellers table has 3095 rows and 4 columns

 
