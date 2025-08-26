--Use database and schema

USE DATABASE LA_DB;
USE SCHEMA LA_SCHEMA;

--Use AccountAdmin role and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

--Assume new role to provision new DB and Schema

USE ROLE SYSADMIN;

--Creating new DB and Schema

CREATE OR REPLACE DATABASE DUMMY;
USE DATABASE DUMMY;
CREATE OR REPLACE SCHEMA DUMMY_SC;

--Create Table
CREATE OR REPLACE TABLE DUMMY.DUMMY_SC.CUST_DET
(
ID INT,
NAME VARCHAR(255)
);

--Insert records
INSERT INTO DUMMY.DUMMY_SC.CUST_DET (ID, NAME)
VALUES
(1, 'John Doe'),
(2, 'Alex Doe');

--Create user using User Admin

USE ROLE USERADMIN;

--Creating user
CREATE USER USER1 PASSWORD = 'abc123' MUST_CHANGE_PASSWORD = TRUE;

--create role
USE ROLE USERADMIN;
CREATE ROLE DUMMY_ROLE;

/*Set to SecurityAdmin to grant role to user1. This can even be achieved with useradmin. 
But, we are using securityadmin role here*/

USE ROLE SECURITYADMIN;

GRANT ROLE DUMMY_ROLE TO USER USER1;

--Grant Select on Table

GRANT SELECT ON TABLE DUMMY.DUMMY_SC.CUST_DET TO ROLE DUMMY_ROLE;

/*Even after granting access to the table, the user will not be able to see it. Because, USAGE access for DB and Schema has to be provided*/

GRANT USAGE ON DATABASE DUMMY TO ROLE DUMMY_ROLE;
GRANT USAGE ON SCHEMA DUMMY.DUMMY_SC TO ROLE DUMMY_ROLE;

--Also granting access to the WH to User1
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE DUMMY_ROLE;

--Grant on future tables as well from the schema
GRANT SELECT ON FUTURE TABLES IN SCHEMA DUMMY.DUMMY_SC TO ROLE DUMMY_ROLE;

--Don't leave the role orphan
GRANT ROLE DUMMY_ROLE TO ROLE SYSADMIN;

--Check grants on the role
SHOW GRANTS TO ROLE DUMMY_ROLE;


--Revoke select grants
REVOKE SELECT ON ALL TABLES IN SCHEMA DUMMY.DUMMY_SC FROM ROLE DUMMY_ROLE;

--Grant ownership to new role
GRANT OWNERSHIP ON SCHEMA DUMMY.DUMMY_SC TO ROLE DUMMY_ROLE;
/*The above query will throw an error because there is a usage grant on this role. 
We need to remove it first*/

/*Error message: SQL execution error: Dependent grant of privilege 'USAGE' on securable 'DUMMY.DUMMY_SC' to role 'DUMMY_ROLE' exists. It must be revoked first. More than one dependent grant may exist: use 'SHOW GRANTS' command to view them. To revoke all dependent grants while transferring object ownership, use convenience command 'GRANT OWNERSHIP ON <target_objects> TO <target_role> REVOKE CURRENT GRANTS'.*/

--Revoke Usage from Dummy role
REVOKE USAGE ON SCHEMA DUMMY.DUMMY_SC FROM ROLE DUMMY_ROLE;

--Let's grant the ownership now to dummy role
GRANT OWNERSHIP ON SCHEMA DUMMY.DUMMY_SC TO ROLE DUMMY_ROLE;

--Now let's see the grants after assigning the owenership. We should the ownership privilege
SHOW GRANTS TO ROLE DUMMY_ROLE;

--Check current role
SELECT CURRENT_ROLE();

--Assign secondary role
USE SECONDARY ROLE SYSADMIN;

SELECT CURRENT_ROLE();
SELECT CURRENT_SECONDARY_ROLES();

--Drop Role and User
DROP ROLE DUMMY_ROLE;
DROP USER USER1;

