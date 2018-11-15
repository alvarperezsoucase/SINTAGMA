--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR" (Campo IN VARCHAR2) RETURN VARCHAR2 IS 
    Aux VARCHAR2(32527);
BEGIN
    Aux := LOWER(CAMPO);
    Aux := trim(Aux);
	
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','a'),'�','a'),'�','a'),'�','a'),'�','a');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','e'),'�','e'),'�','e'),'�','e');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','i'),'�','i'),'�','i'),'�','i');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','o'),'�','o'),'�','o'),'�','o');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','u'),'�','u'),'�','u'),'�','u');
	
	Aux := REPLACE(Aux,'�','ny');
    Aux := REPLACE(Aux,'�','');
    Aux := REPLACE(Aux,'?','');
    Aux := REPLACE(Aux,'�','');
    Aux := REPLACE(Aux,'!','');
    Aux := REPLACE(Aux,'�','');
    Aux := REPLACE(Aux,'*','');
	Aux := REPLACE(REPLACE(REPLACE(Aux,'"',''),'' || CHR(39) || '',''),'`','');
	Aux := REPLACE(REPLACE(Aux,' ',''),'-','');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,',',''),'.',''),':',''),';','');
	Aux := REPLACE(REPLACE(Aux,')',''),'(','');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'/',''),'�',''),'�',''),'@','');


RETURN Aux;

END FUNC_NORMALITZAR;

/
