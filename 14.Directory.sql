--USE LA_DB and Schema
USE DATABASE LA_DB;
USE SCHEMA LA_DB.LA_SCHEMA;

--USE Accountadmin role and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

--Create stage with encryption
CREATE OR REPLACE STAGE internal_un_stage
ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE');

--Alter to enable Directory in existing stage
ALTER STAGE internal_UN_stage
SET DIRECTORY = (ENABLE = TRUE);

--Load image using snowsight UI in 'internal_un_stage'

--Check for Data in Directory
SELECT * FROM DIRECTORY(@internal_UN_stage); -- This will not show the loaded image yet. It has to be manually refreshed

--Manually Refresh or REFRESH_ON_CREATE = { TRUE | FALSE }
ALTER STAGE internal_un_stage REFRESH;


--Enable Directory while creating stage
CREATE OR REPLACE STAGE internal_un_stage
ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE')
DIRECTORY = (ENABLE = TRUE);


--For External stage - Auto Refresh
directoryTableParams (for Amazon S3) ::=
[DIRECTORY = (ENABLE = {TRUE | FALSE}
                [REFRESH_ON_CREATE = {TRUE | FALSE}]
                [AUTO_REFRESH = {TRUE | FALSE}]
            )
]