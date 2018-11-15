--------------------------------------------------------
--  DDL for Function FUNC_NULOS_INSERT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NULOS_INSERT" RETURN VARCHAR2 AS 
    Aux VARCHAR2(100);
BEGIN

    /* Función para los Creates e Insert.
        Cuando es un CREATE hay que pasar cadena (no zero lenght)
        Cuando es un se modificara a null 
    */    
        
        
--    Aux := 'NULL                  ';
    Aux := NULL;

    RETURN Aux;
END FUNC_NULOS_INSERT;

/
