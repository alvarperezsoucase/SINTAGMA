--------------------------------------------------------
--  DDL for Function FUNC_NULOS_ASTERISCO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NULOS_ASTERISCO" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
    Aux VARCHAR2(4000);
BEGIN

    Aux := TRIM(CAMPO);    
    --Aux := NVL(Aux,'*');
--    Aux := NVL(Aux,NULL);
    
     /*A PETICIÓN DE JORGE (05/11/2018) EL ASTERISCO SE SUSTITUYE POR 'SENSE INFORMACION A LA HORA DE MIGRAR')   */
     Aux := NVL(Aux,'Sense informació al migrar');

    RETURN Aux;
END FUNC_NULOS_ASTERISCO;

/
