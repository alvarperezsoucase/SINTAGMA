--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR_ENTITAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR_ENTITAT" (Campo IN VARCHAR2)  RETURN VARCHAR2 IS 
    Aux VARCHAR2(32527);
BEGIN
    Aux := FUNC_NORMALITZAR(CAMPO);
	
    Aux := REPLACE(Aux,' de ','');
    Aux := REPLACE(Aux,'S.A.','');  


RETURN Aux;


END FUNC_NORMALITZAR_ENTITAT;

/
