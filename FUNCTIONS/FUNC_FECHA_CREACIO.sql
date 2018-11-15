--------------------------------------------------------
--  DDL for Function FUNC_FECHA_CREACIO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_FECHA_CREACIO" (Campo IN DATE) RETURN DATE AS 
    Aux DATE;
BEGIN

    Aux := CAMPO;    
    Aux := NVL(CAMPO,SYSDATE);

    RETURN Aux;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN TO_DATE('31/12/1970','dd/mm/yyyy');    
END FUNC_FECHA_CREACIO;

/
