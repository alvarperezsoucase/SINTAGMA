--------------------------------------------------------
--  DDL for Function FUNC_USUARI
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_USUARI" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
   AUX VARCHAR2(50);
BEGIN
    
    Aux := TRIM(CAMPO);    
    Aux := NVL(Aux,NULL);  

  RETURN AUX;
END FUNC_USUARI;

/
