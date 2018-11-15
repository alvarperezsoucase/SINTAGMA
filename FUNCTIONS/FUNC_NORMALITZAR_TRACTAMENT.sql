--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR_TRACTAMENT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR_TRACTAMENT" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 

    Aux VARCHAR2(32527);

 
BEGIN
    Aux := LOWER(CAMPO);
    Aux := TRIM(Aux);
	
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
	Aux := REPLACE(REPLACE(REPLACE(Aux,'"',''),'' || CHR(39) || '',''),'`','');
	Aux := REPLACE(REPLACE(Aux,' ',''),'-','');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,',',''),'.',''),':',''),';','');
	Aux := REPLACE(REPLACE(Aux,')',''),'(','');
	Aux := REPLACE(REPLACE(REPLACE(Aux,'�',''),'�',''),'@','');


RETURN Aux;


END FUNC_NORMALITZAR_TRACTAMENT;

/
