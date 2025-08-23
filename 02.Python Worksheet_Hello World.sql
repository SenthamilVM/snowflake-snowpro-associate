# The Snowpark package is required for Python Worksheets. 
# You can add more packages by selecting them using the Packages control and then importing them.

import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import col

def main (session:snowpark.Session):
    #Code goes here inside the "main" handler
    tablename = 'LA_DB.LA_SCHEMA.MY_TABLE'
    dataframe = session.table(tablename).filter(col("ID") == 2)

    # Print sample of the dataframe to the standard output
    dataframe.show()

    # Return value will appear in the results pane
    return dataframe
    