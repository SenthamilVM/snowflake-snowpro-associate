--USE DB and schema
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

--Create a new table
CREATE OR REPLACE TABLE CUSTOMER_TABLE
(
customer INT NOT NULL,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
region VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
gender VARCHAR(255) NOT NULL,
"order" INT NOT NULL -- order is a keyword in snowflake, hence used ""
);


--List down User Stage files
LIST @~ ;

--Recommended to use 100-250 MB of compressed file
PUT FILE: //D:\Senthamil\Learning\Snowflake SnowPro Associate - Platform Certification Prep\Udemy Resources\MOCK.csv @~/customer_table/staged AUTO_COMPRESS = FALSE;

--To use this PUT command, we need SNOWSQL, we cannot run this in snowsight. SNOWSQL is not installed currently.

--Load into table
COPY INTO CUSTOMER_TABLE
FROM @~Customer_table/staged
FILE_FORMAT = my_csv_ff;

SELECT COUNT(*) FROM CUSTOMER_TABLE;

--Table Stage

--load file via snowsql
PUT FILE: //D:\Senthamil\Learning\Snowflake SnowPro Associate - Platform Certification Prep\Udemy Resources\MOCK.csv @%customer_table/staged AUTO_COMPRESS = FALSE;

--List down Table stage
LIST @%CUSTOMER_TABLE;

--Copy file from stage to table
COPY INTO customer_table
FROM @%customer_table/staged
FILE_FORMAT = my_csv_ff

SELECT COUNT(*) FROM CUSTOMER_TABLE;

--All Command listed here (Except PUT command) can be executed in snowsight as well
PUT FILE: //D:\Senthamil\Learning\Snowflake SnowPro Associate - Platform Certification Prep\Udemy Resources\MOCK.csv @la_stage AUTO_COMPRESS = FALSE;

LIST @LA_STAGE;

COPY INTO customer_table
FROM @la_stage
FILE_FORMAT = my_csv_ff PURGE = TRUE; -- purge deletes the file from stage post loading

LIST @LA_STAGE;

SELECT COUNT(*) FROM CUSTOMER_TABLE;

SHOW STAGES;