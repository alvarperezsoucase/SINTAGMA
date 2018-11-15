--------------------------------------------------------
--  DDL for Function FUNC_SIGNES_LITERAL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_SIGNES_LITERAL" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
   AUX VARCHAR2(500);
BEGIN
    
    Aux :=TRIM(Campo);    
  	
	
    Aux := REPLACE(Aux,'·','');
    Aux := REPLACE(Aux,'?','');
    Aux := REPLACE(Aux,'¿','');
    Aux := REPLACE(Aux,'!','');
    Aux := REPLACE(Aux,'¡','');
    Aux := REPLACE(Aux,'*','');
    Aux := REPLACE(Aux,'+','');
    Aux := REPLACE(Aux,'/','');
    Aux := REPLACE(Aux,'-','');                        
    Aux := REPLACE(Aux,'_','');
    Aux := REPLACE(Aux,'"','');
    Aux := REPLACE(Aux,'' || CHR(39) || '','');
    Aux := REPLACE(Aux,'`','');
    Aux := REPLACE(Aux,' ','');	
    Aux := REPLACE(Aux,',','');
    Aux := REPLACE(Aux,'.','');
    Aux := REPLACE(Aux,':','');
    Aux := REPLACE(Aux,';','');    
    Aux := REPLACE(Aux,')','');    
	Aux := REPLACE(Aux,'(','');
    Aux := REPLACE(Aux,'ª','');
    Aux := REPLACE(Aux,'º','');
    Aux := REPLACE(Aux,'@','');

	   
    RETURN AUX;
    
END FUNC_SIGNES_LITERAL;

/
