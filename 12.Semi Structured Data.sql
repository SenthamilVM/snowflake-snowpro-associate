--USE LA DB and LA Schema
USE DATABASE LA_DB;
USE SCHEMA LA_DB.LA_SCHEMA;


--Use Account admin role and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

--Create JSON file format
CREATE OR REPLACE FILE FORMAT myjsonfileformat TYPE = JSON;

--Create a stage
CREATE OR REPLACE STAGE myjsonfile FILE_FORMAT = myjsonfileformat;

--Create a 'raw_source' table with variant option
CREATE OR REPLACE TABLE raw_source (SRC VARIANT);

--Uploading JSON using Snowsight to the stage


--Copy data from stage to 'raw_source' table
COPY INTO raw_source
FROM @LA_DB.LA_SCHEMA.MYJSONFILE FILE_FORMAT = myjsonfileformat;

--Check JSON data in table
SELECT * FROM raw_source;

--Ways to access element in JSON Object

--1.Bracket Notation

SELECT SRC
FROM raw_source;

SELECT SRC, SRC ['salesperson'] ['name']
FROM raw_source;

SELECT SRC ['salesperson'] ['name']
FROM raw_source;

SELECT src, src ['salesperson'] ['name']
FROM raw_source;

--columns here are case sensitive
SELECT src, src ['Salesperson'] ['name']
FROM raw_source;


--2.Dot Notation
SELECT SRC, src:salesperson.name
FROM raw_source;

--Column names are Case sensitive
SELECT SRC, src:Salesperson.name
FROM raw_source;

--Remove Quotes -- casting
SELECT SRC, SRC:salesperson.name :: string
FROM raw_source;


--Insert data into raw_source table
INSERT INTO raw_source
SELECT
PARSE_JSON
('{
    "customer": 
    [
        {
        "address": "New York, NY",
        "name": "Captain America",
        "phone": "12127593751"
        }
    ],
    "date":"2017-04-28",
    "dealership": "Tindel Toyota",
    "salesperson":
        {
        "id": "274",
        "name": "Greg Northrup"
        }
}');

--Check inserted JSON data in the table
SELECT * FROM raw_source;
