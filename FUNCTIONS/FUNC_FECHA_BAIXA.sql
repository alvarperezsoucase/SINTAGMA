--------------------------------------------------------
--  DDL for Function FUNC_FECHA_BAIXA
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_FECHA_BAIXA" (Campo IN DATE) RETURN DATE AS 
    Aux DATE;
BEGIN

    Aux := CAMPO;    
    Aux := NVL(CAMPO,TO_DATE(SYSDATE,'dd/mm/yyyy'));



    RETURN Aux;
END FUNC_FECHA_BAIXA;

/
