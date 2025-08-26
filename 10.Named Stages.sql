/* NOTE: Using snowsight UI, we can load upto 250MB of file size, beyond that,
we need to do it programmatically*/

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

--Copy data from LA_stage to customer Table

COPY INTO "LA_DB"."LA_SCHEMA"."CUSTOMER_TABLE"
FROM '@"LA_DB"."LA_SCHEMA"."LA_STAGE"'
FILES = ('MOCK.csv')
FILE_FORMAT = my_csv_ff
ON_ERROR=ABORT_STATEMENT
FORCE = TRUE; -- Forcing it to append the duplicate rows.

-- For more details, see: https://docs.snowflake.com/en/sql-reference/sql/copy-into-table


--Creating file format to simplify the code
CREATE OR REPLACE FILE FORMAT my_csv_ff
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    TRIM_SPACE=TRUE,
    FIELD_OPTIONALLY_ENCLOSED_BY='"',
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO;

--create sample stage without any additional properties
CREATE STAGE SAMPLE_STAGE1;

--Display all named stages
SHOW STAGES;

--List down the stage to find out what is there in my stage
LIST @LA_DB.LA_SCHEMA.LA_STAGE;
LS @LA_DB.LA_SCHEMA.LA_STAGE; -- This will be same as LIST

--Remove stage files
REMOVE @LA_DB.LA_SCHEMA.LA_STAGE;
RM @LA_DB.LA_SCHEMA.LA_STAGE; -- RM is same as REMOVE

--Insert Record into the customer_table
INSERT INTO CUSTOMER_TABLE 
(customer, first_name, last_name, region, email, gender, "order")
VALUES
(1, 'John', 'Doe', 'North', 'johndoe@example.com', 'Male', 101);

--Check the count
SELECT COUNT(*) FROM CUSTOMER_TABLE;


