--Create Database and Schema
CREATE DATABASE LA_DB;

CREATE SCHEMA LA_SCHEMA;

--Create table and insert record
CREATE OR REPLACE TABLE my_table
(
id INTEGER PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL
);

INSERT INTO MY_TABLE (id, name, email)
VALUES
(1, 'John Smith', 'john@example.com'),
(2,'Amit', 'amit@example.com'),
(3, 'Bob Johnson', 'bob@example.com');

--Display data from the table
SELECT * FROM my_table;
SELECT * FROM my_table LIMIT 10;

--Check Meta data of the table
DESCRIBE TABLE my_table;

--Check Meta data of all databases
SHOW DATABASES;

--Check Meta data of LA_DB database
DESCRIBE DATABASE LA_DB;
