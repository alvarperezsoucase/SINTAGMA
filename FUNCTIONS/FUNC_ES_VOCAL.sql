--------------------------------------------------------
--  DDL for Function FUNC_ES_VOCAL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_ES_VOCAL" (LETRA IN VARCHAR2) RETURN NUMBER AS 
   ES_VOCAL NUMBER;
   AUX VARCHAR2(1);
BEGIN

  AUX := FUNC_NORMALITZAR(LETRA);  

   IF (AUX) IS NULL THEN
    ES_VOCAL := 0;
   ELSE
     IF LOWER(AUX)='a' THEN
        ES_VOCAL := 1;
     END IF;
     IF LOWER(AUX)='e' THEN   
        ES_VOCAL := 1;
     END IF;
     IF LOWER(AUX)='i' THEN   
        ES_VOCAL := 1;     
     END IF;
     IF LOWER(AUX)='o' THEN   
        ES_VOCAL := 1;
     END IF;
     IF LOWER(AUX)='u' THEN   
        ES_VOCAL := 1;   
     END IF;
   END IF;
   
   
RETURN ES_VOCAL;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;
END FUNC_ES_VOCAL;

/
