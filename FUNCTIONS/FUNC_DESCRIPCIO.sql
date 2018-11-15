--------------------------------------------------------
--  DDL for Function FUNC_DESCRIPCIO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_DESCRIPCIO" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
  Aux VARCHAR2(1000);
BEGIN

    AUX := CAMPO;
    IF AUX IS NOT NULL THEN
       AUX := UPPER(SUBSTR(CAMPO,1,1));
	   AUX := AUX || LOWER(SUBSTR(CAMPO,2));
       AUX := REPLACE(AUX,'barcelona','Barcelona');
	END IF;	


  RETURN Aux;
END FUNC_DESCRIPCIO;

/
