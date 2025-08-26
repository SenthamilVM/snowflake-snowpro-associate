--Use LA Database and schema
USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

--Use Account Admin role and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;


--Create dummyrole 2 and 3
CREATE OR REPLACE ROLE DUMMY_ROLE2;
CREATE OR REPLACE ROLE DUMMY_ROLE3;


--grant the privilege of la_db and schema and WH to Dummy role 2
GRANT USAGE ON DATABASE LA_DB TO ROLE DUMMY_ROLE2;
GRANT USAGE ON SCHEMA LA_DB.LA_SCHEMA TO ROLE DUMMY_ROLE2;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE DUMMY_ROLE2;


--Create schema 2
USE DATABASE LA_DB;
CREATE OR REPLACE SCHEMA LA_SCHEMA2;


--Provide usage Access of new schema to dummy role 3
GRANT USAGE ON SCHEMA LA_DB.LA_SCHEMA2 TO ROLE DUMMY_ROLE3;


--Grant dummy role 2  to dummy role 3
GRANT ROLE DUMMY_ROLE2 TO ROLE DUMMY_ROLE3;

--Dummy Role 2 (Has access to Schema1) >> Dummy Role 3 (Has access to schema2) -- Role Hierarchy


--Don't leave the role orphan

GRANT ROLE DUMMY_ROLE3 TO ROLE SYSADMIN;

--Check grants from both the roles
SHOW GRANTS TO ROLE DUMMY_ROLE2;
SHOW GRANTS TO ROLE DUMMY_ROLE3;


--Assign current snowprotraining user to dummyrole 3

GRANT ROLE DUMMY_ROLE3 TO USER SNOWPROTRAINING;

--Assume new role dummy role 3
USE ROLE DUMMY_ROLE3;
USE WAREHOUSE COMPUTE_WH;

--Check the table data FROM LA_DB.LA_SCHEMA
SELECT * FROM LA_DB.LA_SCHEMA.my_table;

--Assign grant on the table
GRANT SELECT ON TABLE LA_DB.LA_SCHEMA.my_table TO ROLE DUMMY_ROLE2;


--Drop the roles
DROP ROLE DUMMY_ROLE2;
DROP ROLE DUMMY_ROLE3;



