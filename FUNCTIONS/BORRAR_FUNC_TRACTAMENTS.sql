--------------------------------------------------------
--  DDL for Function BORRAR_FUNC_TRACTAMENTS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."BORRAR_FUNC_TRACTAMENTS" (Campo IN VARCHAR2) RETURN VARCHAR2 IS
   AUX VARCHAR2(500);
BEGIN
    AUX := TRIM(TRANSLATE(Campo, ' +-.0123456789', ' '));
    
    RETURN AUX;

END BORRAR_FUNC_TRACTAMENTS;

/
