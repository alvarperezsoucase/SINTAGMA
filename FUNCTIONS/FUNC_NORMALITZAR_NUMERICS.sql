--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR_NUMERICS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR_NUMERICS" (Campo IN VARCHAR2) RETURN VARCHAR2 IS 
    Aux VARCHAR2(1000);
BEGIN
    AUX := TRIM(TRANSLATE(Campo, ' +-.0123456789', ' '));
    
    RETURN AUX;

RETURN Aux;


END FUNC_NORMALITZAR_NUMERICS;

/
