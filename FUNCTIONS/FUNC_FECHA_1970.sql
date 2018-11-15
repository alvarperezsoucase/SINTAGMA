--------------------------------------------------------
--  DDL for Function FUNC_FECHA_1970
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_FECHA_1970" (Campo IN DATE) RETURN DATE AS 
    Aux DATE;
BEGIN

    Aux := CAMPO;    
    Aux := NVL(CAMPO,TO_DATE('01/01/1970','dd/mm/yyyy'));



    RETURN Aux;

END FUNC_FECHA_1970;

/
