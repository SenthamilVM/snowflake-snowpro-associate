/* Snowflake cortex -- it is a suite of AI features that use large language models(LLMs) to 
understand unstructured data, answer freeform questions, and provide intelligent assistance.
This suite of Snowflake AI features comprises of:

--Snowflake Cortex LLM functions
--Snowflake Copilot
--Document AI
--Cortex Fine-tuning
--Cortex Search
--Cortex Analyst


---Snowflake Cortex LLM Functions Provide access to industry-leading LLM hosted and managed by snowflake. Like Meta, Mistral, Reka etc.

3 forms of these LLM functions are:
1.COMPLETE()
2.Task-Specific functions:
    i.PARSE_DOCUMENT()
    ii.CLASSIFY_TEXT()
    iii.TRANSLATE()
3.Helper Function:
    i.COUNT_TOKENS()
    ii.TRY_COMPLETE()

Helper functions are purpose built and manage functions that reduce cases of failures when running other LLM functions.


--Task specific function

/*
--Returns the extracted content from a document on a snowflake stage(Server side encryption) as an OBJECT
that contains JSON-encoded objects as strings

--This function supports 2 types of extractions, Optical Character Recognition (OCR) (Text-heavy) and 
layout (Table format, layout element)

--100MB/300 Page max, Supported PDF, PPTX, DOCX

*/

SELECT TO_VARCHAR
(
    SNOWFLAKE.CORTEX.PARSE_DOCUMENT(
    '@LA_DB.LA_SCHEMA.CORTEX_LLM',
    'table.pdf',
    {'mode':'OCR'} -- Default
    )
) AS OCR;

SELECT TO_VARCHAR
(
    SNOWFLAKE.CORTEX.PARSE_DOCUMENT(
    '@LA_DB.LA_SCHEMA.CORTEX_LLM',
    'table.pdf',
    {'mode': 'LAYOUT'} : content
    )
) AS LAYOUT;

--Without content
SELECT TO_VARCHAR
(
    SNOWFLAKE.CORTEX.PARSE_DOCUMENT(
    '@LA_DB.LA_SCHEMA.CORTEX_LLM',
    'table.pdf',
    {'mode': 'LAYOUT'}
    )
) AS LAYOUT;


--Translates the given input text from one language to the other
SELECT SNOWFLAKE.CORTEX.TRANSLATE('How are you?', 'en', 'es');


--Classified free form text into categories you provide
SELECT SNOWFLAKE.CORTEX.CLASSIFY_TEXT('Exploring new cuisines is my favourite hobby', ['cooking', 'hobby', 'travel']);


--General purpose function, Given a prompt, generates a response(Completion) using your choice of supported language model

SELECT SNOWFLAKE.CORTEX.COMPLETE('gemma-7b', 'How many planets are there in solar system?');

SELECT SNOWFLAKE.CORTEX.COMPLETE('llama3.3-70b', 'How many planets are there in solar system?');






