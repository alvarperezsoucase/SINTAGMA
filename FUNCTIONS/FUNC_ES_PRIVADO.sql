--------------------------------------------------------
--  DDL for Function FUNC_ES_PRIVADO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_ES_PRIVADO" (Campo IN VARCHAR2) RETURN INT AS 
   numero NUMBER;
   AUX VARCHAR2(500);
BEGIN
   numero := 0;
   IF CAMPO IS NULL THEN  
       numero := 0;
   ELSE    
      
      AUX := TRIM(Campo);
      AUX := UPPER(Campo);     
      
        IF INSTR(AUX,'PRI')>0 THEN
            numero := 1;            
        END IF;      
        
   END IF;    
   
   RETURN numero;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;
END FUNC_ES_PRIVADO;

/
