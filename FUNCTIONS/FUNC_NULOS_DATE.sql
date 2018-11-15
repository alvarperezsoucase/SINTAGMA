--------------------------------------------------------
--  DDL for Function FUNC_NULOS_DATE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NULOS_DATE" (CAMPO timestamp) RETURN timestamp AS 
    Aux timestamp;
BEGIN

    /* Función para los Creates e Insert.
        Cuando es un CREATE hay que pasar cadena (no zero lenght)
        Cuando es un se modificara a null 
    */    
    
    IF CAMPO IS NULL THEN   
            Aux := to_timestamp(NULL);
    ELSE
             Aux :=  CAMPO;
    END IF;         
--    Aux := NULL;

    RETURN Aux;
END FUNC_NULOS_DATE;

/
