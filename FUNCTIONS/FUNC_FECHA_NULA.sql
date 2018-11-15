--------------------------------------------------------
--  DDL for Function FUNC_FECHA_NULA
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_FECHA_NULA" (Campo IN DATE) RETURN DATE AS 
    Aux DATE;
BEGIN

    Aux := CAMPO;    
    Aux := NVL(CAMPO,NULL);
    

    RETURN Aux;

END FUNC_FECHA_NULA;

/
