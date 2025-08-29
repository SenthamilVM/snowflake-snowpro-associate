--USE Database and schema
USE DATABASE LA_DB;
USE SCHEMA LA_DB.LA_SCHEMA;

--Use Account admin and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;


--Set the timezone to UTC
ALTER SESSION SET TIMEZONE = 'UTC';


--Create a table 'Customer'
CREATE TABLE CUSTOMER
(
CUSTOMER_ID INT NOT NULL,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(50),
EMAIL VARCHAR(100),
PHONE VARCHAR(20),
ADDRESS VARCHAR(200),
CITY VARCHAR(50),
STATE VARCHAR(50),
COUNTRY VARCHAR(50),
JOIN_DATE DATE
);

--View the current state of the customer table
SELECT * FROM CUSTOMER;

--show all the tables
SHOW TABLES;

--Insert sample records into customer table
INSERT INTO CUSTOMER (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE, ADDRESS, CITY, STATE, COUNTRY, JOIN_DATE)
VALUES
  (1, 'John', 'Doe', 'johndoe@example.com', '+1-555-1234', '123 Main St', 'Anytown', 'CA', 'USA', '2022-01-01'),
  (2, 'Jane', 'Smith', 'janesmith@example.com', '+1-555-5678', '456 Oak St', 'Anycity', 'NY', 'USA', '2022-01-02'),
  (3, 'Bob', 'Johnson', 'bobjohnson@example.com', '+1-555-9012', '789 Elm St', 'Anyville', 'TX', 'USA', '2022-01-03'),
  (4, 'Alice', 'Lee', 'alicelee@example.com', '+1-555-3456', '321 Pine St', 'Anytown', 'CA', 'USA', '2022-01-04'),
  (5, 'David', 'Kim', 'davidkim@example.com', '+1-555-7890', '654 Maple St', 'Anycity', 'NY', 'USA', '2022-01-05'),
  (6, 'Cathy', 'Wang', 'cathywang@example.com', '+1-555-1234', '987 Cedar St', 'Anyville', 'TX', 'USA', '2022-01-06'),
  (7, 'Michael', 'Garcia', 'michaelgarcia@example.com', '+1-555-5678', '159 Birch St', 'Anytown', 'CA', 'USA', '2022-01-07'),
  (8, 'Linda', 'Nguyen', 'lindanguyen@example.com', '+1-555-9012', '753 Spruce St', 'Anycity', 'NY', 'USA', '2022-01-08'),
  (9, 'Samuel', 'Martinez', 'samuelmartinez@example.com', '+1-555-3456', '246 Oak St', 'Anyville', 'TX', 'USA', '2022-01-09'),
  (10, 'Karen', 'Chen', 'karenchen@example.com', '+1-555-7890', '852 Pine St', 'Anytown', 'CA', 'USA', '2022-01-10');

--Check customer table
SELECT * FROM CUSTOMER;

--This command shows the current timezone used by the session
SHOW PARAMETERS LIKE 'TIMEZONE';


--This command retrieves the current timezone in the UTC timezone
SELECT SYSTIMESTAMP();


--Timestamp: 2025-08-29 18:12:32.797 +0000 


--Change the phone number for customer id 1
UPDATE CUSTOMER SET PHONE = '+3-555-5678' WHERE CUSTOMER_ID = 1;

UPDATE CUSTOMER SET PHONE = '+4-555-5678' WHERE CUSTOMER_ID = 2;

--Query ID:01beb2e8-0106-54ab-0010-05530001e1b6


--View the current state of the customer table
SELECT * FROM CUSTOMER;


--View the state of the customer table as it existed before a specific query
SELECT * FROM CUSTOMER BEFORE (STATEMENT => '01beb2e8-0106-54ab-0010-05530001e1b6' );


--View the state of the customer table as it existed 150 seconds ago
SELECT * FROM CUSTOMER BEFORE (OFFSET => -150);

--View the state of the customer table as it existed at certain timestamp
SELECT * FROM CUSTOMER AT (TIMESTAMP => '2025-08-29 18:12:32.797 +0000' ::timestamp);

--Drop customer table
DROP TABLE CUSTOMER;

--Check the customer table
SELECT * FROM CUSTOMER;

--undrop the customer table
UNDROP TABLE CUSTOMER;

--CHECK THE TABLE NOW
SELECT * FROM CUSTOMER;

--Alter the account data retention
ALTER ACCOUNT SET MIN_DATA_RETENTION_TIME_IN_DAYS = 10; -- This can be till 90 days for Enterprise version and above

/*You can also use DATA_RETENTION_IN_DAYS, Final days will be 
--MAX(DATA_RETENTION_TIME_IN_DAYS, MIN_DATA_RETENTION_TIME_IN_DAYS) -- Max of these two will be considered.*/


--SHOW TABLES
SHOW TABLES;

--SHOW SCHEMAS AND DATABASES
SHOW SCHEMAS;
SHOW DATABASES;


--We can do the time travel for Copy, create schema and databases
CREATE TABLE cust_clone CLONE CUSTOMER
AT(TIMESTAMP => '2025-08-29 18:12:32.797 +0000' ::timestamp);

CREATE SCHEMA restored_schema CLONE LA_SCHEMA BEFORE (OFFSET => -3600); -- schema will be created without customer table

CREATE DATABASE restored_db CLONE LA_DB 
    BEFORE(STATEMENT => '01beb2e8-0106-54ab-0010-05530001e1b6'); -- db will be created without 'restored_schema'schema.
