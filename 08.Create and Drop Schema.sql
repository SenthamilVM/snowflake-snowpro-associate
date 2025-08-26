--Use DB and schema

USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

--Create Employee Table
CREATE TABLE EMPLOYEE 
(
id INT,
name VARCHAR(35),
department VARCHAR (100),
salary DECIMAL
)

--Insert records into employee table
INSERT INTO EMPLOYEE (id, name, department, salary)
VALUES
(5, 'Alice', 'Engineering', 80000),
(6, 'Bob', 'HR', 60000),
(7, 'Charlie', 'Engineering', 90000),
(8, 'Diana', 'Marketing', 75000);

--Fetch records
SELECT * FROM EMPLOYEE;

--Fetch from a different schema (public schema)
SELECT * FROM LA_DB.PUBLIC.EMPLOYEE; --full path should be mentioned

--Find the value from current context
SELECT CURRENT_WAREHOUSE(), CURRENT_DATABASE(), CURRENT_SCHEMA(), CURRENT_USER()

--Drop schema
DROP SCHEMA IF EXISTS LA_SCHEMA2;
