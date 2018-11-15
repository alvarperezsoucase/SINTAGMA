--------------------------------------------------------
--  DDL for Function FUNC_FECHA_CHUNGA
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_FECHA_CHUNGA" (Campo VARCHAR2) RETURN DATE AS 
    Aux DATE;
BEGIN

    AUX:=TO_DATE(TRIM(REPLACE(Campo,'0:00','')),'dd/mm/yyyy');    

    RETURN AUX;
    
EXCEPTION
WHEN OTHERS THEN 
   RETURN TO_DATE('01/02/1970','dd/mm/yyyy');    

END FUNC_FECHA_CHUNGA;

/
