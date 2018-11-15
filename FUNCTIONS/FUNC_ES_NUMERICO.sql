--------------------------------------------------------
--  DDL for Function FUNC_ES_NUMERICO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_ES_NUMERICO" (Campo IN VARCHAR2) RETURN INT AS 

   numero NUMBER;
   AUX VARCHAR2(500);
BEGIN
   
   IF CAMPO IS NULL THEN  
       RETURN 0;
   ELSE    
      numero := to_number( Campo );           
   END IF;    
   
   RETURN 1;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;

END FUNC_ES_NUMERICO;

/
