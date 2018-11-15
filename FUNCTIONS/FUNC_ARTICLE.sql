--------------------------------------------------------
--  DDL for Function FUNC_ARTICLE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_ARTICLE" (SEXO VARCHAR2, LETRA VARCHAR2) RETURN NUMBER AS 
   ARTICLE NUMBER;
   ES_VOCAL NUMBER;
BEGIN

/*
CREATE TABLE A1_SUBJECTES_ARTICLE AS
   SELECT SUBJECTE.ID,
   		  NOM,
   		  COGNOM1,
   		  COGNOM2,
          TRACTAMENT_ID, 
          TRACTAMENT.SEXO,
          SUBSTR(SUBJECTE.NOM,1,1) AS LETRA,
          FUNC_ARTICLE(TRACTAMENT.SEXO,SUBSTR(SUBJECTE.NOM,1,1)) AS ARTICLE_ID
   FROM A1_SUBJECTE SUBJECTE,
        TMP_DM_TRACTAMENT TRACTAMENT
--        A0_DM_ARTICLE ARTICLE
   WHERE SUBJECTE.TRACTAMENT_ID = TRACTAMENT.ID     
        
*/        
/*
update A1_SUBJECTE m
set m.ARTICLE_ID=(
	select a.ARTICLE_ID from A1_SUBJECTES_ARTICLE a
	where m.ID=a.ID
)
where m.ID in(
	select a2.ID from A1_SUBJECTES_ARTICLE a2
	where m.ID=a2.ID
);
*/


    ARTICLE := NULL;
    
    ES_VOCAL := FUNC_ES_VOCAL(LETRA);
    
    
    IF SEXO ='H' THEN
        IF ES_VOCAL = 1 THEN
           ARTICLE :=1;
        ELSE
           ARTICLE :=5;
        END IF;   
    ELSE
       IF SEXO IS NOT NULL THEN
            IF ES_VOCAL = 1 THEN
               ARTICLE :=2;
            ELSE
               ARTICLE :=6;
            END IF;   
       ELSE
           ARTICLE := NULL;
       END IF;
    END IF;
    
RETURN ARTICLE;

END FUNC_ARTICLE;

/
