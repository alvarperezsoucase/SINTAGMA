--------------------------------------------------------
--  DDL for Function FUNC_ALEATORIO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_ALEATORIO" (VALOR_MAXIMO IN NUMBER) RETURN NUMBER AS 
    Aux NUMBER;
BEGIN

    AUX :=round(dbms_random.value() * (VALOR_MAXIMO-1)) + 1;

  RETURN AUX;
  
END FUNC_ALEATORIO;

/
