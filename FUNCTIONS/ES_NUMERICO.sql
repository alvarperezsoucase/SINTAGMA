--------------------------------------------------------
--  DDL for Function ES_NUMERICO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."ES_NUMERICO" (Campo IN VARCHAR2)
   RETURN INT
IS
   numero NUMBER;
BEGIN
   IF (Campo) IS NULL THEN
    RETURN 1
   ELSE
    numero := TO_NUMBER(Campo);
   
   
   
   RETURN 1;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;
END ES_NUMERICO;

/
