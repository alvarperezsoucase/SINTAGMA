--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR_TRACTAMENT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR_TRACTAMENT" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 

    Aux VARCHAR2(32527);

 
BEGIN
    Aux := LOWER(CAMPO);
    Aux := TRIM(Aux);
	
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Aux,'á','a'),'ä','a'),'à','a'),'â','a'),'å','a');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'é','e'),'ë','e'),'è','e'),'ê','e');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'í','i'),'ï','i'),'ì','i'),'î','i');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'ó','o'),'ö','o'),'ò','o'),'ô','o');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,'ú','u'),'ü','u'),'ù','u'),'û','u');
	
	Aux := REPLACE(Aux,'ñ','ny');
    Aux := REPLACE(Aux,'·','');
    Aux := REPLACE(Aux,'?','');
    Aux := REPLACE(Aux,'¿','');
    Aux := REPLACE(Aux,'!','');
    Aux := REPLACE(Aux,'¡','');
	Aux := REPLACE(REPLACE(REPLACE(Aux,'"',''),'' || CHR(39) || '',''),'`','');
	Aux := REPLACE(REPLACE(Aux,' ',''),'-','');
	Aux := REPLACE(REPLACE(REPLACE(REPLACE(Aux,',',''),'.',''),':',''),';','');
	Aux := REPLACE(REPLACE(Aux,')',''),'(','');
	Aux := REPLACE(REPLACE(REPLACE(Aux,'ª',''),'º',''),'@','');


RETURN Aux;


END FUNC_NORMALITZAR_TRACTAMENT;

/
