--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR_SIGNES
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR_SIGNES" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
   AUX VARCHAR2(500);
BEGIN
    
    Aux :=TRIM(Campo);    
  	
	Aux :=REPLACE(Aux,' ','');
    Aux :=REPLACE(Aux,'-','');
    Aux :=REPLACE(Aux,'.','');
    Aux :=REPLACE(Aux,'/','');
   
    RETURN AUX;
    
END FUNC_NORMALITZAR_SIGNES;

/
