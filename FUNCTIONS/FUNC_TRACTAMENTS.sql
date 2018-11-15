--------------------------------------------------------
--  DDL for Function FUNC_TRACTAMENTS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_TRACTAMENTS" (Campo IN VARCHAR2) RETURN VARCHAR2 IS
   AUX VARCHAR2(500);
BEGIN
    AUX := TRIM(TRANSLATE(Campo, ' +-.0123456789', ' '));
    
    RETURN AUX;

END FUNC_TRACTAMENTS;

/
