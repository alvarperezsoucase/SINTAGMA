--------------------------------------------------------
--  DDL for Function FUNC_NULOS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NULOS" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
    Aux VARCHAR2(1000);
BEGIN

    Aux := TRIM(CAMPO);    
    Aux := NVL(Aux,'*');

    RETURN Aux;
END FUNC_NULOS;

/
