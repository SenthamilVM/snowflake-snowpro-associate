--Use DB and schema
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

--Use Account admin and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

--Create a 'sample_data' table
CREATE OR REPLACE TABLE sample_data
(
id INT,
name VARCHAR(50),
age INT
);

--Insert records
INSERT INTO sample_data (id, name, age)
VALUES
(1, 'John', 25),
(2, 'Mary', 30),
(3, 'Peter', 40),
(4, 'Jane', 35);

--Create a clone table 'cloned_data'

CREATE OR REPLACE TABLE cloned_data CLONE sample_data;

--Check clone_data table
SELECT * FROM cloned_data;


--Create a clone of clone 'cloned_data2'
CREATE OR REPLACE TABLE cloned_data2 CLONE cloned_data;

--Check data
SELECT * FROM cloned_data2;

--Updating sample_data table
INSERT INTO sample_data (id, name, age)
VALUES(5, 'Misc', 15);

--Query ID: 01beb32a-0106-5488-0010-055300021606


--USELECT * FROM cloned_data;pdating original table will not affect other cloned tables and vice versa
SELECT * FROM sample_data; -- original table has 5 records after inserting
SELECT * FROM cloned_data; -- not affected. only has 4 records
SELECT * FROM cloned_data2; -- not affected. only has 4 records

--Time Travel

--Sets the current timezone to UTC
ALTER SESSION SET TIMEZONE = 'UTC';

--Check current timestamp.This retrieves the current timezone in UTC
SELECT SYSTIMESTAMP();

--Timestamp: 2025-08-29 19:26:50.059 +0000
TRUNCATE TABLE sample_data;

--Creating a clone by time travel
CREATE OR REPLACE TABLE sample_data_clone_restore CLONE sample_data
BEFORE (TIMESTAMP => '2025-08-29 19:26:50.059 +0000' ::timestamp);

SELECT * FROM sample_data_clone_restore;

/*Using Query id: 01beb32a-0106-5488-0010-055300021606 -- This query was created to insert 5th record. We need to time travel before this query to get the original table.*/
CREATE OR REPLACE TABLE sample_data_clone_restore2 CLONE sample_data
BEFORE(STATEMENT => '01beb32a-0106-5488-0010-055300021606'); -- 

SELECT * FROM sample_data_clone_restore2;

--Using Offset. Going back 3 minutes ago.
CREATE OR REPLACE TABLE sample_data_clone_restore3 CLONE sample_data AT(OFFSET => -60*3);

SELECT * FROM sample_data_clone_restore3;







