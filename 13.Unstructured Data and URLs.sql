--USE DB and schema
USE DATABASE LA_DB;
USE SCHEMA LA_DB.LA_SCHEMA;

--Use Accountadmin role and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

--Create stage 'internal_UN_stage' with encryption
CREATE OR REPLACE STAGE internal_UN_stage
ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

--Check the listing in stage
LS @internal_UN_stage;

--Load image into the stage 'internal_UN_stage' using snowsight. 

--Test all the functions


/*Scoped File URL: Generates a scoped snowflake-hosted URL to a staged file
using the stage name and relative file path as inputs. It is non deterministic (the URL will change everytime)*/

SELECT BUILD_SCOPED_FILE_URL(@internal_UN_stage, 'Snowflake.png');


/*Stage File URL: Gnerates a snowflake-hosted file URL to a staged file 
using the stage name and relative file as inputs. This will be a permanent link*/

SELECT BUILD_STAGE_FILE_URL(@internal_UN_stage, 'Snowflake.png');

/*Presigned URL: Generates the pre-signed URL to a staged file using the stage name and relative file
path as inputs. Access files in an external stage using the function. It is non deterministic*/

SELECT GET_PRESIGNED_URL(@internal_UN_stage,'Snowflake.png', 10); -- The link will be available only for 10 seconds.



