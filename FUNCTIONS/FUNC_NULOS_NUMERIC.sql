--------------------------------------------------------
--  DDL for Function FUNC_NULOS_NUMERIC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NULOS_NUMERIC" RETURN NUMBER AS 
    Aux NUMBER(10,0);
BEGIN

    /* Función para los Creates e Insert.
        Cuando es un CREATE hay que pasar cadena (no zero lenght)
        Cuando es un se modificara a null 
    */    
        
        
--    Aux := 'NULL                  ';
    Aux := NULL;

    RETURN Aux;
END FUNC_NULOS_NUMERIC;

/
