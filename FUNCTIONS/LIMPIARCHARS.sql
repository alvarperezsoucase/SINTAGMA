--------------------------------------------------------
--  DDL for Function LIMPIARCHARS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."LIMPIARCHARS" (Campo IN VARCHAR2) RETURN VARCHAR2 IS
    Aux VARCHAR2(32527);
BEGIN
    Aux := LOWER(CAMPO);
	
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','a'),'�','a'),'�','a'),'�','a'),'�','a');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','e'),'�','e'),'�','e'),'�','e');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','i'),'�','i'),'�','i'),'�','i');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','o'),'�','o'),'�','o'),'�','o');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'�','u'),'�','u'),'�','u'),'�','u');
	
	Aux := REPLACE(Aux,'�','ny');

	Aux :=REPLACE(REPLACE(REPLACE(Aux,'"',''),'' || CHR(39) || '',''),'`','');
	Aux :=REPLACE(REPLACE(Aux,' ',''),'-','');
	Aux :=REPLACE(REPLACE(REPLACE(REPLACE(Aux,',',''),'.',''),':',''),';','');
	Aux :=REPLACE(REPLACE(Aux,')',''),'(','');
	Aux :=REPLACE(REPLACE(REPLACE(REPLACE(Aux,'/',''),'�',''),'�',''),'@','');


RETURN Aux;
END;

/
