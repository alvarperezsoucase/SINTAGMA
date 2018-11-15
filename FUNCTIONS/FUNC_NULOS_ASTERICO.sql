--------------------------------------------------------
--  DDL for Function FUNC_NULOS_ASTERICO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NULOS_ASTERICO" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
    Aux VARCHAR2(1000);
BEGIN

    Aux := TRIM(CAMPO);    
    Aux := NVL(Aux,'*');
--    Aux := NVL(Aux,NULL);

    RETURN Aux;
END FUNC_NULOS_ASTERICO;

/
