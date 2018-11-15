--------------------------------------------------------
--  DDL for Package Body E_01_TEMAS_RISPLUS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."E_01_TEMAS_RISPLUS" AS

 /*Se ESTABLECE TABL�A DE INTERCAMBIO DM_AMBIT CON INSTALACION ID*/
 
/* ESTABLECEMOS ID DE PARTICION EN FUNCI�N DEL A�O DE CREACI�N DE LA INSTALACI�N */ 
PROCEDURE E001_PARTICIONES IS
BEGIN
    INSERT INTO Z_E001_PARTICIONES (ANNO, PARTICION_ID)
           SELECT EXTRACT(YEAR FROM DATACREACIO) AS ANNO, ROW_NUMBER() OVER(ORDER BY EXTRACT(YEAR FROM DATACREACIO) DESC) AS PARTICION_ID
                  FROM Z_T_RP_INSTALACIONS
		          GROUP BY EXTRACT(YEAR FROM DATACREACIO)
                  ORDER BY EXTRACT(YEAR FROM DATACREACIO) DESC;

COMMIT;
END;

/*Creamos tablas de intercambio INSTALACION_ID // AMBIT_ID  + PARTICION_ID*/

 PROCEDURE E002_INSTALACIO_AMBITS_PART IS
 BEGIN 
        INSERT INTO Z_E002_INSTALACIO_AMBIT_PART (INSTALACIOID, DESCRIPCIO, NOM, DATACREACIO, AMBIT_ID)
                    SELECT INSTALACIOID, 
                           DESCRIPCIO,
                           NOM, 
                           DATACREACIO AS DATACREACIO,
                           ConstAMBIT_PROTOCOL AS AMBIT_ID
                    FROM Z_T_RP_INSTALACIONS;
 
--        UPDATE Z_E002_INSTALACIO_AMBIT_PART SET AMBIT_ID=99; --COMO NO SABEMOS CU�L CORRESPONDE, RESETEAMOS TODOS A 99 Y POSTEIORMENTE ASIGNAMOS AMBITOS 1 Y 2
        UPDATE Z_E002_INSTALACIO_AMBIT_PART SET AMBIT_ID=ConstAMBIT_ALCALDIA WHERE INSTALACIOID=25 OR INSTALACIOID=30;
        --UPDATE Z_E002_INSTALACIO_AMBIT_PART SET AMBIT_ID=ConstAMBIT_PROTOCOL WHERE INSTALACIOID=19;-- OR INSTALACIOID=30;
        
        
        --BORRAMOS AQUELLOS QUE NO PERTENEZCAN A ALCALD�A. �STOS NO SE MIGRAR�N
        DELETE FROM Z_E002_INSTALACIO_AMBIT_PART  WHERE AMBIT_ID<>ConstAMBIT_ALCALDIA;
 COMMIT;
 END;

 PROCEDURE E003_AMBITS IS
 BEGIN
 
                INSERT INTO Z_E003_AMBITS (AMBIT_ID)
           SELECT AMBIT_ID
           FROM (
                    SELECT AMBIT_ID
                      FROM Z_E002_INSTALACIO_AMBIT_PART
                  GROUP BY AMBIT_ID
                 ) AMBITOS
           WHERE NOT EXISTS (SELECT 1 
                               FROM Z_E003_AMBITS ANTIGUOS
                              WHERE ANTIGUOS.AMBIT_ID = AMBITOS.AMBIT_ID
                            );  
        
 
 COMMIT;
 END;
 
 
 
 
   

PROCEDURE E010_DM_LLOC IS
BEGIN

    INSERT INTO Z_E999_DM_LLOC (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID) 
             SELECT ID, 
                    substr(DESCRIPCIO,1,50), 
                    DATA_CREACIO, 
                    DATA_MODIFICACIO, 
                    DATA_ESBORRAT, 
                    USUARI_CREACIO, 
                    USUARI_MODIFICACIO, 
                    USUARI_ESBORRAT, 
                    AMBIT_ID
             FROM (   
                        SELECT LLOCID AS ID,
                               NOM AS DESCRIPCIO,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = LLOC.InstalacioID) AS AMBIT_ID
        --                       FUNC_AMBIT_RISPLUS(LLOC.InstalacioID) AS AMBIT_ID
        --                       FUNC_AMBIT_RISPLUS(LLOC.INSTALACIOID) AS AMBIT_ID
        --                       FUNC_PARTICION_RISPLUS(LLOC.INSTALACIOID) AS PARTICION_ID 	   
                        FROM Z_T_RP_LLOC LLOC
                        WHERE LLOC.InstalacioID <>12 AND LLOC.InstalacioID <>15--OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS
        		    ) NUEVOS    
            WHERE NOT EXISTS (SELECT 1
                               FROM Z_E999_DM_LLOC ANTIGUOS
                              WHERE  ANTIGUOS.ID = NUEVOS.ID 
                               AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                             );         
              
    COMMIT;
                INSERT INTO AUX_DM_LLOC (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, AMBIT_ID, USUARI_ESBORRAT)
                      SELECT ID, 
                       		  DESCRIPCIO, 
                       		  FUNC_NULOS_DATE(DATA_CREACIO) AS DATA_CREACIO, 
                       		  FUNC_NULOS_DATE(DATA_MODIFICACIO) AS DATA_MODIFICACIO, 
                       		  FUNC_NULOS_DATE(DATA_ESBORRAT) AS DATA_ESBORRAT, 
                       		  USUARI_CREACIO, 
                       		  USUARI_MODIFICACIO, 
                       		  AMBIT_ID, 
                       		  USUARI_ESBORRAT 
                         FROM Z_E999_DM_LLOC NUEVOS
                        WHERE NOT EXISTS  (SELECT 1 
                                             FROM AUX_DM_LLOC ANTIGUOS
                                            WHERE ANTIGUOS.ID = NUEVOS.ID
                                              AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                           );
                                             
COMMIT;
END;

/* CREAMOS CAT�LOGO DE DISTRITOS Y TABLA DE DISTRITOS QUE TIENEN LA DESCRIPCION A NULL */
PROCEDURE E011_DM_DISTRICTE IS
BEGIN

         INSERT INTO Z_E999_DM_DISTRICTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID)
                 SELECT ID, 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_MODIFICACIO, 
                        DATA_ESBORRAT, 
                        USUARI_CREACIO, 
                        USUARI_MODIFICACIO, 
                        USUARI_ESBORRAT, 
                        AMBIT_ID
                 FROM (    
                        SELECT DISTRICTEID AS ID,
                               NOM AS DESCRIPCIO, 
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = DISTRICTE.InstalacioID) AS AMBIT_ID       
                        FROM Z_T_RP_DISTRICTE DISTRICTE
                        WHERE NOM IS NOT NULL 
                          AND DISTRICTE.InstalacioID <>12 AND DISTRICTE.InstalacioID <>15--OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS (15 ES PRUEBAS)
                     ) NUEVOS    
             WHERE NOT EXISTS (SELECT 1
                                 FROM Z_E999_DM_DISTRICTE ANTIGUOS
                                WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                  AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                              );                                     
               
            COMMIT;
            /*hay que quitar las constrains de err */
                    INSERT INTO AUX_DM_DISTRICTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      FUNC_NULOS_DATE(DATA_CREACIO) AS DATA_CREACIO, 
                                      FUNC_NULOS_DATE(DATA_MODIFICACIO) AS DATA_MODIFICACIO, 
                                      FUNC_NULOS_DATE(DATA_ESBORRAT) AS DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARIO_ESBORRAT, 
                                      AMBIT_ID
                                 FROM Z_E999_DM_DISTRICTE NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM AUX_DM_DISTRICTE ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );                      

COMMIT;
END;


PROCEDURE E012_DM_TIPUS_TEMA IS
BEGIN

    INSERT INTO Z_E999_DM_TIPUS_TEMA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
             SELECT AUX_SEQ_DM_TIPUS_TEMA.NEXTVAL AS ID,
                               TipusTema DESCRIPCIO, 
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               Ambit_ID AS AMBIT_ID
                        FROM (
                               SELECT TipusTema TipusTema, 
                                      Ambit_ID AS AMBIT_ID
                                 FROM (	   
                                                    SELECT Tipus AS TipusTema, 
                                                    (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = Tipus_Tema.InstalacioID) AS AMBIT_ID 
                                                    FROM (
                                                            SELECT tipus, 
                                                                   instalacioid
                                                              FROM Z_T_RP_ASPECTES 
                                                             group BY tipus,instalacioid
                                                         ) Tipus_Tema
                                                ) GROUP_AMBIT		 
                                        GROUP BY TipusTema,AMBIT_ID
                              )FINAL_GROUP
                        WHERE NOT EXISTS ( SELECT 1
                                             FROM Z_E999_DM_TIPUS_TEMA ANTIGUOS  
                                            WHERE FINAL_GROUP.TipusTema = ANTIGUOS.DESCRIPCIO
                                              AND FINAL_GROUP.AMBIT_ID = ANTIGUOS.AMBIT_ID
                                         );
        COMMIT;                                  
                                  
         INSERT INTO AUX_DM_TIPUS_TEMA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                               SELECT ID, 
                                      ID AS CODI,
                                      SUBSTR(DESCRIPCIO,1,50) AS DESCRIPCIO, 
                                      FUNC_NULOS_DATE(DATA_CREACIO) AS DATA_CREACIO, 
                                      FUNC_NULOS_DATE(DATA_MODIFICACIO) AS DATA_MODIFICACIO, 
                                      FUNC_NULOS_DATE(DATA_ESBORRAT) AS DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT, 
                                      AMBIT_ID
                                 FROM Z_E999_DM_TIPUS_TEMA NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM AUX_DM_TIPUS_TEMA ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );      
                                  
                              
        COMMIT;


/* este es el tipus de element principal
         INSERT INTO Z_E999_DM_TIPUS_TEMA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                 SELECT ID, 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_MODIFICACIO, 
                        DATA_ESBORRAT, 
                        USUARI_CREACIO, 
                        USUARI_MODIFICACIO, 
                        USUARI_ESBORRAT, 
                        AMBIT_ID
                 FROM (  
                        SELECT TIPUSTEMAELEMENTPRINCIPALID AS ID,
                               NOM AS DESCRIPCIO, 
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = TIPUSTEMA.InstalacioID) AS AMBIT_ID       
                        FROM Z_T_RP_TIPUSTEMAELEMENTPRINCIP TIPUSTEMA
                        WHERE NOM IS NOT NULL
                     		    ) NUEVOS    
                WHERE NOT EXISTS (SELECT 1
                                    FROM Z_E999_DM_TIPUS_TEMA ANTIGUOS
                                   WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                     AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                 );      
                        
                      
                     
          
               
COMMIT;
            --hay que quitar las constrains de err 
                   INSERT INTO AUX_DM_TIPUS_TEMA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                               SELECT ID, 
                                      ID AS CODI,
                                      SUBSTR(DESCRIPCIO,1,50) AS DESCRIPCIO, 
                                      FUNC_NULOS_DATE(DATA_CREACIO) AS DATA_CREACIO, 
                                      FUNC_NULOS_DATE(DATA_MODIFICACIO) AS DATA_MODIFICACIO, 
                                      FUNC_NULOS_DATE(DATA_ESBORRAT) AS DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT, 
                                      AMBIT_ID
                                 FROM Z_E999_DM_TIPUS_TEMA NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM AUX_DM_TIPUS_TEMA ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID

                                                   );      
    COMMIT;
*/                                                   


END;

PROCEDURE E013_DM_ESPECIFIC IS
BEGIN
        INSERT INTO AUX_DM_ESPECIFIC (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID)     
               SELECT ID, 
                      DESCRIPCIO, 
                      DATA_CREACIO, 
                      DATA_MODIFICACIO, 
                      DATA_ESBORRAT, 
                      USUARI_CREACIO, 
                      USUARI_MODIFICACIO, 
                      USUARI_ESBORRAT, 
                      AMBIT_ID
               FROM (
                       SELECT ESPECIFICID AS ID,
                               NOM AS DESCRIPCIO,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               ConstAMBIT_ALCALDIA AS AMBIT_ID 
                          FROM Z_T_RP_ESPECIFICS ESPECIFICS
                      ) NUEVOS    
                 WHERE NOT EXISTS (SELECT 1
                                     FROM AUX_DM_ESPECIFIC ANTIGUOS
                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                  );    
            


COMMIT;
END;


--TABLA INTERMEDIA QUE RELACCIONA TIPUSACCIO DE RISPLUS CON EL CAT�LOGO DM_TIPUS_ACCIO DE SINTAGMA
PROCEDURE E020_TIPUSACCIO_DMTIPUSACCIO IS
BEGIN
     INSERT INTO Z_E020_TIPUSACCIO_DMTIPUSACCIO (ID, ACCIO_ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
            SELECT AUX_SEQ_DM_TIPUS_ACCIO.NEXTVAL AS ID,
            
                   NUEVOTIPUSACCIO.ACCIO_ID,
                   NUEVOTIPUSACCIO.DESCRIPCIO,
                   NUEVOTIPUSACCIO.DATA_CREACIO, 
                   NUEVOTIPUSACCIO.DATA_MODIFICACIO, 
                   NUEVOTIPUSACCIO.DATA_ESBORRAT, 
                   NUEVOTIPUSACCIO.USUARI_CREACIO, 
                   NUEVOTIPUSACCIO.USUARI_MODIFICACIO, 
                   NUEVOTIPUSACCIO.USUARI_ESBORRAT, 
                   NUEVOTIPUSACCIO.AMBIT_ID
            FROM(        
                            SELECT TIPUSACCIO.ACCIO_ID,
                                   TIPUSACCIO.DESCRIPCIO,
                                   SYSDATE AS DATA_CREACIO,
	                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
	                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
	                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
	                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
	                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                   TIPUSACCIO.AMBIT_ID
                            FROM (       
                                    SELECT ACCIO.TIPUSACCIOID AS ACCIO_ID,
                                            ACCIO.NOM AS DESCRIPCIO,
                                           (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID =SUBACCIO.INSTALACIOID) AS AMBIT_ID		
                                      FROM  Z_T_RP_TIPUSACCIO ACCIO,
                                            Z_T_RP_SUBTIPUSACCIO SUBACCIO        
                                    WHERE ACCIO.TIPUSACCIOID = SUBACCIO.TIPUSACCIOID
                                    and SUBACCIO.InstalacioID <>12 AND SUBACCIO.InstalacioID <>15--OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS
                                 ) TIPUSACCIO	
                            GROUP BY TIPUSACCIO.ACCIO_ID, TIPUSACCIO.DESCRIPCIO, TIPUSACCIO.AMBIT_ID
            ) NUEVOTIPUSACCIO
            WHERE NOT EXISTS (SELECT 1 
            				    FROM Z_E020_TIPUSACCIO_DMTIPUSACCIO ANTIGUOS
            				   WHERE ANTIGUOS.ACCIO_ID = NUEVOTIPUSACCIO.ACCIO_ID
            				     AND ANTIGUOS.AMBIT_ID = NUEVOTIPUSACCIO.AMBIT_ID
            				 );    
        

COMMIT;
END;


PROCEDURE E021_DMTIPUSACCIO IS
BEGIN
         INSERT INTO Z_E999_DM_TIPUS_ACCIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                  SELECT ID,            
                         DESCRIPCIO,
                         DATA_CREACIO, 
                         DATA_MODIFICACIO, 
                         DATA_ESBORRAT, 
                         USUARI_CREACIO, 
                         USUARI_MODIFICACIO, 
                         USUARI_ESBORRAT, 
                         AMBIT_ID
                    FROM Z_E020_TIPUSACCIO_DMTIPUSACCIO NUEVO
                    WHERE NOT EXISTS (SELECT 1 
                                        FROM Z_E999_DM_TIPUS_ACCIO ANTIGUOS
                                       WHERE ANTIGUOS.DESCRIPCIO = NUEVO.DESCRIPCIO
                                         AND ANTIGUOS.AMBIT_ID = NUEVO.AMBIT_ID
                                     );    
                                     
        INSERT INTO AUX_DM_TIPUS_ACCIO (ID,DESCRIPCIO,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                  SELECT ID,            
                         DESCRIPCIO,
                         DATA_CREACIO, 
                         DATA_MODIFICACIO, 
                         DATA_ESBORRAT, 
                         USUARI_CREACIO, 
                         USUARI_MODIFICACIO, 
                         USUARI_ESBORRAT, 
                         AMBIT_ID
                    FROM Z_E999_DM_TIPUS_ACCIO NUEVO
                   WHERE  NOT EXISTS (SELECT 1 
                                        FROM AUX_DM_TIPUS_ACCIO ANTIGUOS
                                       WHERE ANTIGUOS.DESCRIPCIO = NUEVO.DESCRIPCIO
                                         AND ANTIGUOS.AMBIT_ID = NUEVO.AMBIT_ID
                                     );    
                    
                

COMMIT;
END;


--TABLA INTERMEDIA QUE RELACCIONA TIPUSACCIO DE RISPLUS CON EL CAT�LOGO DM_TIPUS_ACCIO DE SINTAGMA
PROCEDURE E025_DM_SUBTIPUSACCIO IS
BEGIN

            INSERT INTO Z_E025_DM_SUBTIPUSACCIO (ID, DESCRIPCIO, USUARI_PER_DEFECTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID)
                        SELECT SUBTIPOACCIO.ID AS ID, 
                               SUBTIPOACCIO.DESCRIPCIO AS DESCRIPCIO,
                               FUNC_USU_CREACIO() AS USUARI_PER_DEFECTE,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               SUBTIPOACCIO.AMBIT_ID AS AMBIT_ID,
                               SUBTIPOACCIO.TIPUS_ACCIO_ID AS TIPUS_ACCIO_ID
                        FROM (       
                              SELECT SUBTIPO.ID, 
                                     SUBTIPO.DESCRIPCIO,
                                     SUBTIPO.AMBIT_ID,
                                     SUBTIPO.TIPUS_ACCIO_ID
                                 FROM (    
                                            SELECT SUBACCIO.SUBTIPUSACCIOID AS ID, 
                                                   SUBACCIO.NOM AS DESCRIPCIO,
                                                   (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = SUBACCIO.InstalacioID) AS AMBIT_ID,
                                                   ACCIO.ACCIO_ID AS TIPUS_ACCIO_ID       
                                            FROM Z_T_RP_SUBTIPUSACCIO SUBACCIO,
                                                 Z_E020_TIPUSACCIO_DMTIPUSACCIO ACCIO
                                            WHERE SUBACCIO.TIPUSACCIOID = ACCIO.ACCIO_ID
                                            and SUBACCIO.InstalacioID <>12 AND SUBACCIO.InstalacioID <>15--OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS
                                       ) SUBTIPO		
                                    GROUP BY SUBTIPO.ID, SUBTIPO.DESCRIPCIO, SUBTIPO.AMBIT_ID, SUBTIPO.TIPUS_ACCIO_ID
                        ) SUBTIPOACCIO
                        WHERE NOT EXISTS (SELECT 1
                                            FROM  Z_E025_DM_SUBTIPUSACCIO ANTIGUOS 
                                           WHERE ANTIGUOS.ID = SUBTIPOACCIO.ID 
                                             AND ANTIGUOS.TIPUS_ACCIO_ID = SUBTIPOACCIO.TIPUS_ACCIO_ID  
                                             AND ANTIGUOS.AMBIT_ID = SUBTIPOACCIO.AMBIT_ID
                                         );    

            INSERT INTO Z_E999_DM_SUBTIPUS_ACCIO (ID, DESCRIPCIO,USUARI_PER_DEFECTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID)
                 SELECT ID, 
                 		DESCRIPCIO, 
                        USUARI_PER_DEFECTE AS USUARI_PER_DEFECTE,
                 		DATA_CREACIO, 
                 		DATA_MODIFICACIO, 
                 		DATA_ESBORRAT, 
                 		USUARI_CREACIO, 
                 		USUARI_MODIFICACIO, 
                 		USUARI_ESBORRAT AS USUARIO_ESBORRAT, 
                 		AMBIT_ID, 
                 		TIPUS_ACCIO_ID
                  FROM  Z_E025_DM_SUBTIPUSACCIO NUEVOS
                 WHERE NOT EXISTS  (SELECT 1 
                                      FROM Z_E999_DM_SUBTIPUS_ACCIO ANTIGUOS
                                     WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                       AND ANTIGUOS.TIPUS_ACCIO_ID = NUEVOS.TIPUS_ACCIO_ID  
                                       AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                   );                
                                   
            INSERT INTO AUX_DM_SUBTIPUS_ACCIO (ID, DESCRIPCIO, USUARI_PER_DEFECTE,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID)
                 SELECT ID, 
                 		DESCRIPCIO, 
                        USUARI_PER_DEFECTE AS USUARI_PER_DEFECTE,
                 		DATA_CREACIO, 
                 		DATA_MODIFICACIO, 
                 		DATA_ESBORRAT, 
                 		USUARI_CREACIO, 
                 		USUARI_MODIFICACIO, 
                 		USUARIO_ESBORRAT AS USUARIO_ESBORRAT, 
                 		AMBIT_ID, 
                 		TIPUS_ACCIO_ID
                  FROM  Z_E999_DM_SUBTIPUS_ACCIO NUEVOS
                 WHERE NOT EXISTS  (SELECT 1 
                                      FROM AUX_DM_SUBTIPUS_ACCIO ANTIGUOS
                                     WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                       AND ANTIGUOS.TIPUS_ACCIO_ID = NUEVOS.TIPUS_ACCIO_ID  
                                       AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                   );                
                                   
            

COMMIT;
END;


PROCEDURE E030_DM_DESTI_DELEGACIO IS
BEGIN

            INSERT INTO Z_E999_DM_DESTI_DELEGACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                     SELECT ID, 
                            SUBSTR(DESCRIPCIO,1,50),
                            DATA_CREACIO, 
                            DATA_MODIFICACIO, 
                            DATA_ESBORRAT, 
                            USUARI_CREACIO, 
                            USUARI_MODIFICACIO, 
                            USUARI_ESBORRAT, 
                            AMBIT_ID
                     FROM (     
                                    SELECT DELEGACIOID AS ID,
                                           NOM AS DESCRIPCIO, 
                                           SYSDATE AS DATA_CREACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                           FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                           (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = DELEGACIO.InstalacioID) AS AMBIT_ID       
                                    FROM Z_T_RP_DELEGACIO DELEGACIO
                          ) NUEVOS    
                        WHERE NOT EXISTS (SELECT 1
                                           FROM Z_E999_DM_DESTI_DELEGACIO ANTIGUOS
                                          WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                           AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                         );                                      
                               
          
               
            COMMIT;

                    INSERT INTO AUX_DM_DESTI_DELEGACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      DATA_CREACIO, 
                                      DATA_MODIFICACIO, 
                                      DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT AS USUARIO_ESBORRAT, 
                                      AMBIT_ID
                                 FROM Z_E999_DM_DESTI_DELEGACIO NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM AUX_DM_DESTI_DELEGACIO ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                     AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );                 

COMMIT;
END;


--Preguntar por el
PROCEDURE E031_DM_TIPUS_ELEMENT IS
BEGIN 
    INSERT INTO Z_E999_DM_TIPUS_ELEMENT (ID, DESCRIPCIO,  DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                 SELECT ID, 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_MODIFICACIO, 
                        DATA_ESBORRAT, 
                        USUARI_CREACIO, 
                        USUARI_MODIFICACIO, 
                        USUARI_ESBORRAT, 
                        AMBIT_ID
                 FROM (  
                        SELECT TIPUSTEMAELEMENTPRINCIPALID AS ID,
                               substr(NOM,1,25) AS DESCRIPCIO, 
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = TIPUSELEMENT.InstalacioID) AS AMBIT_ID       
                        FROM Z_T_RP_TIPUSTEMAELEMENTPRINCIP TIPUSELEMENT
                        WHERE NOM IS NOT NULL
                     		    ) NUEVOS    
                WHERE NOT EXISTS (SELECT 1
                                    FROM Z_E999_DM_TIPUS_ELEMENT ANTIGUOS
                                   WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                     AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                 );     

        COMMIT;                                  
                                  
        INSERT INTO AUX_DM_TIPUS_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                   SELECT ID, 
                          DESCRIPCIO, 
                          DATA_CREACIO, 
                          DATA_MODIFICACIO, 
                          DATA_ESBORRAT, 
                          USUARI_CREACIO, 
                          USUARI_MODIFICACIO,                       		  
                          USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                          AMBIT_ID
                     FROM Z_E999_DM_TIPUS_ELEMENT NUEVOS                     
                    WHERE NUEVOS.AMBIT_ID<>99
                      AND NOT EXISTS  (SELECT 1 
                                         FROM AUX_DM_TIPUS_ELEMENT ANTIGUOS
                                        WHERE ANTIGUOS.ID = NUEVOS.ID
                                         AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID                                         
                                       );     
                              
        COMMIT;


/*este es el tipus de tema 
        INSERT INTO Z_E999_DM_TIPUS_ELEMENT (ID, DESCRIPCIO,  DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                SELECT AUX_SEQ_DM_TIPUS_ELEMENT.NEXTVAL AS ID,
                       TipusElement DESCRIPCIO, 
                       SYSDATE AS DATA_CREACIO,
				       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                       FUNC_USU_CREACIO() AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                       Ambit_ID AS AMBIT_ID
                FROM (
                       SELECT TipusElement TipusElement, 
                       		  Ambit_ID AS AMBIT_ID
    	                 FROM (	   
				                            SELECT Tipus AS TipusElement, 
				                            (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = Tipus_Elemetns.InstalacioID) AS AMBIT_ID 
				                            FROM (
				                                    SELECT tipus, 
				                                           instalacioid
				                                      FROM Z_T_RP_ASPECTES 
				                                     group BY tipus,instalacioid
				                                 ) Tipus_Elemetns
				                        ) GROUP_AMBIT		 
				                GROUP BY TipusElement,AMBIT_ID
				      )FINAL_GROUP
                WHERE NOT EXISTS ( SELECT 1
                                     FROM Z_E999_DM_TIPUS_ELEMENT ANTIGUOS  
                                    WHERE FINAL_GROUP.TipusElement = ANTIGUOS.DESCRIPCIO
                                      AND FINAL_GROUP.AMBIT_ID = ANTIGUOS.AMBIT_ID
                                 );
        COMMIT;                                  
                                  
        INSERT INTO AUX_DM_TIPUS_ELEMENT
                    SELECT * FROM Z_E999_DM_TIPUS_ELEMENT;
                                  
                              
        COMMIT;
*/        
END;

PROCEDURE E032_DM_DECISIO_AGENDA IS
BEGIN

        INSERT INTO Z_E999_DM_DECISIO_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                 SELECT ID, 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_MODIFICACIO, 
                        DATA_ESBORRAT, 
                        USUARI_CREACIO, 
                        USUARI_MODIFICACIO, 
                        USUARI_ESBORRAT, 
                        AMBIT_ID
                 FROM (     
                                    SELECT DECISIOID AS ID,
                                           NOM AS DESCRIPCIO, 
                                           SYSDATE AS DATA_CREACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                           FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                           (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = DECISIO.InstalacioID) AS AMBIT_ID       
                                    FROM Z_T_RP_DECISIO DECISIO
                       ) NUEVOS    
                                WHERE NOT EXISTS (SELECT 1
                                                   FROM Z_E999_DM_DECISIO_AGENDA ANTIGUOS
--                                                  WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                                  WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                                   AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                                 );                                        
                                                     
                                                     
        COMMIT;
        
        
        
        INSERT INTO AUX_DM_DECISIO_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      DATA_CREACIO, 
                                      DATA_MODIFICACIO, 
                                      DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT AS USUARIO_ESBORRAT, 
                                      AMBIT_ID
                                 FROM Z_E999_DM_DECISIO_AGENDA NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM AUX_DM_DECISIO_AGENDA ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                     AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );                 
        
END;





PROCEDURE E033_DM_PRIORITAT_ELEMENT IS
BEGIN

       INSERT INTO Z_E999_DM_PRIORITAT_ELEMENT (ID, PRIORITATID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                                    SELECT AUX_SEQ_DM_PRIORITAT_ELEMENT.NEXTVAL AS ID,
                                           PRIORITATID AS PRIORITATID,
                                           NOM AS DESCRIPCIO, 
                                           SYSDATE AS DATA_CREACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                           FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                           AMBIT_ID
                                    FROM Z_T_RP_PRIORITAT PRIORITAT,                                    
                                         Z_E003_AMBITS                                     
                                    WHERE NOT EXISTS (SELECT 1
                                                       FROM Z_E999_DM_PRIORITAT_ELEMENT ANTIGUOS
                                                      WHERE  ANTIGUOS.ID = PRIORITAT.PRIORITATID                                                        
                                                     );    
        COMMIT;
    
        INSERT INTO AUX_DM_PRIORITAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      DATA_CREACIO, 
                                      DATA_MODIFICACIO, 
                                      DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT AS USUARIO_ESBORRAT,
                                      AMBIT_ID AS AMBIT_ID
                                 FROM Z_E999_DM_PRIORITAT_ELEMENT NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM AUX_DM_PRIORITAT_ELEMENT ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID                                                     
                                                   );                 
    
    

COMMIT;
END;


PROCEDURE E034_DM_PREFIX_ANY IS
BEGIN

     INSERT INTO Z_E999_DM_PREFIX_ANY (ID, DESCRIPCIO,CONTADOR, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
         SELECT ID, 
                DESCRIPCIO, 
                CONTADOR,
                DATA_CREACIO, 
                DATA_MODIFICACIO, 
                DATA_ESBORRAT, 
                USUARI_CREACIO, 
                USUARI_MODIFICACIO, 
                USUARI_ESBORRAT, 
                AMBIT_ID
         FROM (     
                      SELECT PREFIXDOSSIERID AS ID,
                           PREFIX AS DESCRIPCIO, 
                           ULTIMNUMERO AS CONTADOR,
                           SYSDATE AS DATA_CREACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                           FUNC_USU_CREACIO() AS USUARI_CREACIO,
                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                           (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = PREFIXDOSSIER.InstalacioID) AS AMBIT_ID    
                    FROM Z_T_RP_PREFIXDOSSIER PREFIXDOSSIER
                ) NUEVOS    
            WHERE NOT EXISTS (SELECT 1
                               FROM Z_E999_DM_PREFIX_ANY ANTIGUOS
                              WHERE  ANTIGUOS.ID = NUEVOS.ID 
                               AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                             );    
                             
                             
        INSERT INTO AUX_DM_PREFIX_ANY
             SELECT ID, 
                    DESCRIPCIO, 
                    CONTADOR,
                    DATA_CREACIO, 
                    DATA_MODIFICACIO, 
                    DATA_ESBORRAT, 
                    USUARI_CREACIO, 
                    USUARI_MODIFICACIO, 
                    USUARI_ESBORRAT, 
                    AMBIT_ID
               FROM Z_E999_DM_PREFIX_ANY NUEVOS
              WHERE NOT EXISTS (SELECT 1 
                                  FROM AUX_DM_PREFIX_ANY ANTIGUOS
                                 WHERE  ANTIGUOS.ID = NUEVOS.ID
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                               );    
           
                             
    

COMMIT;
END;


PROCEDURE E035_DM_TIPUS_SUPORT IS
BEGIN

     INSERT INTO Z_E999_DM_TIPUS_SUPORT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
         SELECT SEQ_DM_TIPUS_SUPPORT.NEXTVAL AS ID, 
                ID AS CODI, 
                DESCRIPCIO AS DESCRIPCIO, 
                DATA_CREACIO, 
                DATA_MODIFICACIO, 
                DATA_ESBORRAT, 
                USUARI_CREACIO, 
                USUARI_MODIFICACIO, 
                USUARI_ESBORRAT, 
                AMBIT_ID
         FROM (     
                      SELECT TIPUSSUPORTID AS ID,
                           NOM AS DESCRIPCIO, 
                           SYSDATE AS DATA_CREACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                           FUNC_USU_CREACIO() AS USUARI_CREACIO,
                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                           (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = TIPUSSUSPORT.InstalacioID) AS AMBIT_ID    
                    FROM Z_T_RP_TIPUSSUPORT TIPUSSUSPORT
                ) NUEVOS    
            WHERE NOT EXISTS (SELECT 1
                               FROM Z_E999_DM_TIPUS_SUPORT ANTIGUOS
                              WHERE  ANTIGUOS.ID = NUEVOS.ID 
                               AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                             );    
           COMMIT;
           
           
            INSERT INTO AUX_DM_TIPUS_SUPORT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                                 SELECT ID, 
                                        CODI,
                                        DESCRIPCIO, 
                                        DATA_CREACIO, 
                                        DATA_MODIFICACIO, 
                                        DATA_ESBORRAT, 
                                        USUARI_CREACIO, 
                                        USUARI_MODIFICACIO, 
                                        USUARI_ESBORRAT, 
                                        AMBIT_ID 
                                   FROM Z_E999_DM_TIPUS_SUPORT NUEVOS
                                  WHERE NUEVOS.AMBIT_ID <>99
                                    AND NOT EXISTS (SELECT 1 
                                                      FROM AUX_DM_TIPUS_SUPORT ANTIGUOS
                                                     WHERE  ANTIGUOS.ID = NUEVOS.ID
                                                       AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );           
   

            COMMIT;
END;

--LOS AMBITOS COINCIDEN (MENOS MAL) ENTRE SERIE Y SUBSERIE
PROCEDURE E040_SERIESSUBSERIES IS
BEGIN

   INSERT INTO Z_E040_SERIES_SUBSERIES (ID, SERIEID, SUBSERIEID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
              SELECT AUX_SEQ_SERIE_SUBSERIE.NEXTVAL AS ID, 
                     SERIEID, 
                     SUBSERIEID, 
                     DESCRIPCIO, 
                     DATA_CREACIO, 
                     DATA_MODIFICACIO, 
                     DATA_ESBORRAT, 
                     USUARI_CREACIO, 
                     USUARI_MODIFICACIO, 
                     USUARI_ESBORRAT, 
                     AMBIT_ID
              FROM (                                
                        SELECT  SERIE.SERIEID, 
                                SUBSERIE.SUBSERIEID, 
                                (SERIE.NOM || '//' || SUBSERIE.NOM) AS DESCRIPCIO ,
                                 SYSDATE AS DATA_CREACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                 FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                 FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                 FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = SERIE.INSTALACIOID) AS AMBIT_ID   
                           FROM Z_T_RP_SERIES SERIE,
                                Z_T_RP_SUBSERIES SUBSERIE
                          WHERE SERIE.SERIEID = SUBSERIE.SERIEID
                     ) NUEVOS     
               WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_E040_SERIES_SUBSERIES ANTIGUOS
                                WHERE ANTIGUOS.SERIEID = NUEVOS.SERIEID
                                  AND ANTIGUOS.SUBSERIEID = NUEVOS.SUBSERIEID
                                  AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                );




COMMIT;
END;

PROCEDURE E041_DM_SERIES IS
BEGIN

      INSERT INTO AUX_DM_SERIE (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                  SELECT ID, 
--                         SERIEID,
--                         SUBSERIEID,
                         SUBSTR(DESCRIPCIO,1,50), 
                         DATA_CREACIO, 
                         DATA_MODIFICACIO, 
                         DATA_ESBORRAT, 
                         USUARI_CREACIO, 
                         USUARI_MODIFICACIO, 
                         USUARI_ESBORRAT, 
                         AMBIT_ID                  
                    FROM Z_E040_SERIES_SUBSERIES NUEVOS
                   WHERE NOT EXISTS (SELECT 1 
                                       FROM AUX_DM_SERIE ANTIGUOS
                                      WHERE NUEVOS.DESCRIPCIO = ANTIGUOS.DESCRIPCIO
                                       AND NUEVOS.AMBIT_ID = ANTIGUOS.AMBIT_ID
                                     );


COMMIT;
END;

PROCEDURE E042_DM_CATALEG_DOCUMENT IS
BEGIN

     INSERT INTO Z_E042_DM_CATALEG_DOCUMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT)
                         SELECT  TIPUSANNEXID AS ID, 
                                 NOM AS DESCRIPCIO ,
                                 SYSDATE AS DATA_CREACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                 FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                 FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                 FUNC_NULOS_STRING() AS USUARI_ESBORRAT
                           FROM Z_T_RP_TIPUSANNEX NUEVOS     
               WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_E042_DM_CATALEG_DOCUMENT ANTIGUOS
                                WHERE ANTIGUOS.ID = NUEVOS.TIPUSANNEXID
                                );


      INSERT INTO AUX_DM_CATALEG_DOCUMENT 
               SELECT *
                 FROM Z_E042_DM_CATALEG_DOCUMENT NUEVOS 
                WHERE NOT EXISTS (SELECT *
                                    FROM AUX_DM_CATALEG_DOCUMENT ANTIGUOS
                                   WHERE ANTIGUOS.ID = NUEVOS.ID
                                 ) ;

COMMIT;
END;


--OJO EL CONTADOR SE ACTUALIZAR� DE CONTINUO. �UPDATE!
PROCEDURE E043_DM_PREFIX IS
BEGIN


      INSERT INTO Z_E043_DM_PREFIX (ID, DESCRIPCIO, CONTADOR,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
         SELECT ID AS ID, 
                DESCRIPCIO AS DESCRIPCIO, 
                NVL(CONTADOR,0) AS CONTADOR,
                DATA_CREACIO AS DATA_CREACIO, 
                DATA_MODIFICACIO AS DATA_MODIFICACIO, 
                DATA_ESBORRAT AS DATA_ESBORRAT, 
                USUARI_CREACIO AS USUARI_CREACIO, 
                USUARI_MODIFICACIO AS USUARI_MODIFICACIO, 
                USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                AMBIT_ID AS AMBIT_ID
          FROM (                                
                     SELECT NUMEROREGISTREPREFIXID AS ID,
                            PREFIX AS DESCRIPCIO,
                            ULTIMNUMERO AS CONTADOR,
                            SYSDATE AS DATA_CREACIO,
                            FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                            FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                            FUNC_USU_CREACIO() AS USUARI_CREACIO,
                            FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                            FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                            (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = PREFIX.INSTALACIOID) AS AMBIT_ID   
                       FROM Z_T_RP_NUMEROSREGISTREPREFIX PREFIX
                       WHERE PREFIX.InstalacioID <>12 AND PREFIX.InstalacioID <>15 --ojo INSTALACION ID 12 PERTENEDCE A LA PATRICIA y el 15 es de pruebas
                 ) NUEVOS      
          WHERE NOT EXISTS (SELECT 1
                             FROM Z_E043_DM_PREFIX ANTIGUOS
                            WHERE ANTIGUOS.ID = NUEVOS.ID
                              AND ANTIGUOS.AMBIT_ID=NUEVOS.AMBIT_ID
                           );    

        
           INSERT INTO AUX_DM_PREFIX (ID, DESCRIPCIO, CONTADOR,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
              SELECT *
                FROM Z_E043_DM_PREFIX NUEVOS
               WHERE NOT EXISTS (SELECT *
                                   FROM AUX_DM_PREFIX ANTIGUOS
                                  WHERE ANTIGUOS.ID = NUEVOS.ID
                                    AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                 );
                                 


COMMIT;
END;

/*
PROCEDURE E044_ANNEX_REGISTRE IS
BEGIN
    
        


COMMIT:
END;
*/

PROCEDURE E050_ESTAT_ELEMENT IS
BEGIN

     --CREATE TABLE Z_E050_ESTAT_ELEMENT AS SELECT * FROM Z_E060_PAS_ACCIO WHERE ROWNUM=0
     INSERT INTO Z_E050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(1, 'REGISTRE INICIAL');

      INSERT INTO Z_E050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(2, 'DISTRIBUCIO');
  
      INSERT INTO Z_E050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(3, 'GESTIO');
                
      INSERT INTO Z_E050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(4, 'CONCLUSIO');
COMMIT;
END;

PROCEDURE E051_DM_ESTAT_ELEMENT IS
BEGIN

        INSERT INTO Z_E999_DM_ESTAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARIO_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT AUX_SEQ_DM_ESTAT_ELEMENT.NEXTVAL AS ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARIO_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_E050_ESTAT_ELEMENT,
                                Z_E003_AMBITS 
                      ) ESTAT_ELEMENT
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_E999_DM_ESTAT_ELEMENT ANTIGUOS
                                 WHERE ANTIGUOS.ID =ESTAT_ELEMENT.ID
                                   AND ANTIGUOS.AMBIT_ID =ESTAT_ELEMENT.AMBIT_ID
                               );    

            COMMIT;
            
            
            INSERT INTO AUX_DM_ESTAT_ELEMENT
                SELECT ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM Z_E999_DM_ESTAT_ELEMENT NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM AUX_DM_ESTAT_ELEMENT ANTIGUOS
                                 WHERE ANTIGUOS.ID = NUEVOS.ID 
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                               );  
            

COMMIT;
END;




PROCEDURE E060_PAS_ACCIO IS
BEGIN

    --CREATE TABLE Z_E060_PAS_ACCIO AS SELECT * FROM Z_E060_PAS_ACCIO WHERE ROWNUM=0
     INSERT INTO Z_E060_PAS_ACCIO (ID, DESCRIPCIO) VALUES(1, 'PETICIO');
     INSERT INTO Z_E060_PAS_ACCIO (ID, DESCRIPCIO) VALUES(2, 'REALITZACI�');
     INSERT INTO Z_E060_PAS_ACCIO (ID, DESCRIPCIO) VALUES(3, 'RESOLUCIO');

COMMIT;
END;


PROCEDURE E061_DM_PAS_ACCIO IS
BEGIN

     INSERT INTO Z_E061_DM_PAS_ACCIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID, TIPUS_ACCIO)
            SELECT  AUX_SEQ_DM_PAS_ACCIO.NEXTVAL AS  ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_MODIFICACIO, 
                    DATA_ESBORRAT, 
                    USUARI_CREACIO, 
                    USUARI_MODIFICACIO, 
                    USUARIO_ESBORRAT, 
                    AMBIT_ID, 
                    TIPUS_ACCIO 
              FROM (      
                        SELECT ACCIO.ID,
                               ACCIO.DESCRIPCIO,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARIO_ESBORRAT,     
                               TIPUS.AMBIT_ID AS AMBIT_ID,
                               TIPUS.ID AS TIPUS_ACCIO
                          FROM AUX_DM_TIPUS_ACCIO TIPUS,
                               Z_E060_PAS_ACCIO ACCIO
                               
                    ) COMBINADOS           
             WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_E061_DM_PAS_ACCIO ANTIGUOS
                                WHERE ANTIGUOS.ID = COMBINADOS.ID
                                  AND ANTIGUOS.AMBIT_ID = COMBINADOS.AMBIT_ID
                                  AND ANTIGUOS.TIPUS_ACCIO = COMBINADOS.TIPUS_ACCIO
                               );

      COMMIT;
      
             INSERT INTO AUX_DM_PAS_ACCIO
                         SELECT *
                           FROM Z_E061_DM_PAS_ACCIO NUEVOS
                          WHERE NOT EXISTS (SELECT 1 
                                             FROM AUX_DM_PAS_ACCIO ANTIGUOS
                                            WHERE ANTIGUOS.ID = NUEVOS.ID
                                              AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                              AND ANTIGUOS.TIPUS_ACCIO = NUEVOS.TIPUS_ACCIO
                                           ); 
     
COMMIT;
END;




PROCEDURE E070_TIPUS_AGENDA IS
BEGIN

    --CREATE TABLE Z_E070_TIPUS_AGENDA AS SELECT * FROM Z_E060_PAS_ACCIO WHERE ROWNUM=0
    INSERT INTO Z_E070_TIPUS_AGENDA (ID, DESCRIPCIO)
            VALUES(1, 'CONCRETA');
     INSERT INTO Z_E070_TIPUS_AGENDA (ID, DESCRIPCIO)
                VALUES(2, 'RANG');
     INSERT INTO Z_E070_TIPUS_AGENDA (ID, DESCRIPCIO)
                VALUES(3, 'PROVISIONAL');
     INSERT INTO Z_E070_TIPUS_AGENDA (ID, DESCRIPCIO)
                VALUES(4, 'PENDENT');

COMMIT;
END;


PROCEDURE E071_DM_TIPUS_AGENDA IS
BEGIN

        INSERT INTO Z_E999_DM_TIPUS_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARIO_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT AUX_SEQ_DM_TIPUS_AGENDA.NEXTVAL AS ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARIO_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_E070_TIPUS_AGENDA,
                                Z_E003_AMBITS 
                      ) TIPUS_AGENDA
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_E999_DM_TIPUS_AGENDA ANTIGUOS
                                 WHERE ANTIGUOS.ID =TIPUS_AGENDA.ID
                                   AND ANTIGUOS.AMBIT_ID =TIPUS_AGENDA.AMBIT_ID
                               );    

            COMMIT;
            
            
            INSERT INTO AUX_DM_TIPUS_AGENDA
                SELECT ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM Z_E999_DM_TIPUS_AGENDA NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM AUX_DM_TIPUS_AGENDA ANTIGUOS
                                 WHERE ANTIGUOS.ID = NUEVOS.ID 
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                               );  
            

COMMIT;
END;


PROCEDURE E080_ORIGEN_ELEMENT IS
BEGIN
    --CREATE TABLE Z_E080_ORIGEN_ELEMENT AS SELECT * FROM z_E060_PAS_ACCIO  WHERE rownum=0
    
    INSERT INTO Z_E080_ORIGEN_ELEMENT (ID, DESCRIPCIO)
                VALUES(1, 'CONCRETA');
    INSERT INTO Z_E080_ORIGEN_ELEMENT (ID, DESCRIPCIO)
                VALUES(2, 'RANG');           

COMMIT;
END;


PROCEDURE E081_DM_ORIGEN_ELEMENT IS
BEGIN


          INSERT INTO Z_E999_DM_ORIGEN_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARIO_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT AUX_SEQ_DM_ORIGEN_ELEMENT.NEXTVAL as  ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARIO_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_E080_ORIGEN_ELEMENT,
                                Z_E003_AMBITS 
                      ) ORIGEN_ELEMENT
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_E999_DM_ORIGEN_ELEMENT ANTIGUOS
                                 WHERE ANTIGUOS.ID =ORIGEN_ELEMENT.ID
                                   AND ANTIGUOS.AMBIT_ID =ORIGEN_ELEMENT.AMBIT_ID
                               );  

            COMMIT;   
    
            --CREATE TABLE  AUX_DM_ORIGEN_ELEMENT AS SELECT * FROM DM_ORIGEN_ELEMENT WHERE ROWNUM=0
           INSERT INTO AUX_DM_ORIGEN_ELEMENT 
                    SELECT * 
                      FROM Z_E999_DM_ORIGEN_ELEMENT NUEVOS
                     WHERE NOT EXISTS (SELECT 1
                                         FROM AUX_DM_ORIGEN_ELEMENT ANTIGUOS
                                        WHERE ANTIGUOS.ID = NUEVOS.ID
                                          AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                       );
                               
COMMIT;
END;

/*
PROCEDURE E090_TIPUS_ARG IS
BEGIN
    
    INSERT INTO Z_E090_TIPUS_ARG (ID, DESCRIPCIO)
                VALUES(1, 'A');
    INSERT INTO Z_E090_TIPUS_ARG (ID, DESCRIPCIO)
                VALUES(2, 'R');               
    INSERT INTO Z_E090_TIPUS_ARG (ID, DESCRIPCIO)
                VALUES(3, 'G');

COMMIT;
END;
*/

PROCEDURE E090_DM_TIPUS_ARG IS
BEGIN

    INSERT INTO Z_E999_DM_TIPUS_ARG (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARIO_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                NOM AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARIO_ESBORRAT,     
                                ConstAMBIT_ALCALDIA AS AMBIT_ID
                           FROM Z_T_RP_CAMPSESPECIALS_TAULA2
                          WHERE  INSTALACIOID = ConstInstalacioAlcaldia 
                      ) TIPUS_ARG
              WHERE  NOT EXISTS (SELECT 1
                                  FROM Z_E999_DM_TIPUS_ARG ANTIGUOS
                                 WHERE ANTIGUOS.ID =TIPUS_ARG.ID
                                   AND ANTIGUOS.AMBIT_ID =TIPUS_ARG.AMBIT_ID
                               );

            COMMIT;   


           --CREATE TABLE AUX_DM_TIPUS_ARG AS SELECT * FROM DM_ORIGEN_ELEMENT WHERE ROWNUM=0
           INSERT INTO AUX_DM_TIPUS_ARG 
                    SELECT * 
                      FROM Z_E999_DM_TIPUS_ARG NUEVOS
                     WHERE NOT EXISTS (SELECT 1
                                         FROM AUX_DM_TIPUS_ARG ANTIGUOS
                                        WHERE ANTIGUOS.ID = NUEVOS.ID
                                          AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                       );

COMMIT;
END;


PROCEDURE E100_TIPUS_DATA IS
BEGIN

    --CREATE TABLE Z_E100_TIPUS_DATA AS SELECT * FROM Z_E060_PAS_ACCIO WHERE ROWNUM=0
    INSERT INTO Z_E100_TIPUS_DATA (ID, DESCRIPCIO)
            VALUES(1, 'CONCRETA');
     INSERT INTO Z_E100_TIPUS_DATA (ID, DESCRIPCIO)
                VALUES(2, 'RANG');
     INSERT INTO Z_E100_TIPUS_DATA (ID, DESCRIPCIO)
                VALUES(3, 'PROVISIONAL');
     INSERT INTO Z_E100_TIPUS_DATA (ID, DESCRIPCIO)
                VALUES(4, 'PENDENT');

COMMIT;
END;


PROCEDURE E101_DM_TIPUS_DATA IS
BEGIN
        --CREATE TABLE Z_E999_DM_TIPUS_DATA AS SELECT * FROM Z_E999_DM_TIPUS_ARG WHERE ROWNUM=0
        INSERT INTO Z_E999_DM_TIPUS_DATA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARIO_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT AUX_SEQ_DM_TIPUS_DATA.NEXTVAL AS ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARIO_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_E100_TIPUS_DATA,
                                Z_E003_AMBITS 
                      ) TIPUS_DATA
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_E999_DM_TIPUS_DATA ANTIGUOS
                                 WHERE ANTIGUOS.ID =TIPUS_DATA.ID
                                   AND ANTIGUOS.AMBIT_ID =TIPUS_DATA.AMBIT_ID
                               );    

            COMMIT;
            
             --CREATE TABLE AUX_DM_TIPUS_DATA AS SELECT * FROM DM_ORIGEN_ELEMENT WHERE ROWNUM=0
            INSERT INTO AUX_DM_TIPUS_DATA
                SELECT ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARIO_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM Z_E999_DM_TIPUS_DATA NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM AUX_DM_TIPUS_DATA ANTIGUOS
                                 WHERE ANTIGUOS.ID = NUEVOS.ID 
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                               );  
            

COMMIT;
END;

PROCEDURE E110_ASPECTES IS
BEGIN
    
    /*
    --a) extraemos
     INSERT INTO ASPECTE 
          SELECT el.aspecteid AS id,
                 El.EXTRACTE AS descripcio, 
                 EL.DATAASSENTAMENT AS DATA_ASSENTAMENT, 
                 FUNC_USU_CREACIO() AS USUARI_ASSENTAMENT,
                 SYSDATE AS DATA_CREACIO,
                 FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                 FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                 FUNC_USU_CREACIO() AS USUARI_CREACIO,
                 FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                 FUNC_NULOS_STRING() AS USUARIO_ESBORRAT,     
                 Asp.tipus as tipus_tema_id,
                 (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID =  Asp.INSTALACIOID ) AS AMBIT_ID   

FROM Z_T_RP_ELEMENTS EL,
     Z_T_RP_ASPECTES ASP,
     Z_T_RP_ACCIONS ACC
WHERE asp.ASPECTEID = el.ASPECTEID
  AND    asp.ASPECTEID = ACC.ASPECTEID
AND el.aspecteid >0  
  ORDER BY 1;
*/

            INSERT INTO AUX_ASPECTE (ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID)
                      SELECT ASP.aspecteid AS id,
                             NVL(NULL,'*') AS DESCRIPCIO,
                             SYSDATE  AS DATA_ASSENTAMENT, 
                             FUNC_USU_CREACIO() AS USUARI_ASSENTAMENT,
                             SYSDATE AS DATA_CREACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                             FUNC_USU_CREACIO() AS USUARI_CREACIO,
                             FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                             FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                             (SELECT ID FROM DM_TIPUS_TEMA TEMA WHERE TEMA.DESCRIPCIO = ASP.TIPUS AND TEMA.AMBIT_ID =  (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = ASP.InstalacioID)) AS TIPUS_TEMA_ID,
                             (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = ASP.InstalacioID) AS AMBIT_ID
                        FROM Z_T_RP_ASPECTES ASP
                       WHERE NOT EXISTS (SELECT 1
                                           FROM AUX_ASPECTE ANTIGUOS
                                          WHERE ANTIGUOS.ID = ASP.aspecteid
                                         );

COMMIT;
END;



PROCEDURE E120_DOSSIER IS
BEGIN
              INSERT INTO AUX_DOSSIER (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, PREFIX_ANY_ID, ASPECTE_ID)
                        SELECT TO_NUMBER(DOSIER.NUMEROREGISTREDOSSIER) AS ID,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO() AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               (SELECT ID FROM DM_PREFIX_ANY WHERE ID = DOSIER.PREFIXDOSSIERID) AS PREFIX_ANY_ID,
                               DOSIER.ASPECTEID AS ASPECTE_ID                  
                          FROM Z_T_RP_DOSSIER DOSIER
                         WHERE DOSIER.PREFIXDOSSIERID IS NOT NULL  
                           AND NOT EXISTS (SELECT 1
                                             FROM AUX_DOSSIER ANTIGUOS
                                            WHERE ANTIGUOS.ID = TO_NUMBER(DOSIER.NUMEROREGISTREDOSSIER)
                                          );
    --OJO EL NUMEROREGISTREDOSSIER ESTA REP�TIDO
  COMMIT;
END;


--CREAMOS TABLA QUE RELACIONA EL USUARIO_ID + ASPECTE_ID CON LA NUEVA SECUENCIA DE TITULAR 8USADA EN ELEMEN_PRINCIPAL9
PROCEDURE E130_TITULARSDINS_ASPECTE IS
BEGIN
    --DROP SEQUENCE  AUX_SEQ_TITULAR_DINS;
    --CREATE SEQUENCE AUX_SEQ_TITULAR_DINS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;



    INSERT INTO Z_E130_TITULARDINS (ID, ASPECTE_ID, USUARI_ID, NOM_USUARI, MATRICULA_USUARI, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT)
	        SELECT AUX_SEQ_TITULAR_DINS.NEXTVAL AS ID, 
				   ASPECTE_ID,
				   USUARI_ID,
				   NOM_USUARI,
				   MATRICULA_USUARI,
				   DATA_CREACIO,
				   DATA_MODIFICACIO,
				   DATA_ESBORRAT,
				   USUARI_CREACIO,
				   USUARI_MODIFICACIO,
				   USUARI_ESBORRAT
			FROM (	   
				        SELECT EL.ASPECTEID AS ASPECTE_ID,
							   USUARIID AS  USUARI_ID,
			                   NOM || ' ' || COGNOMS AS NOM_USUARI,
			                   USUARI AS MATRICULA_USUARI,
			                   SYSDATE AS DATA_CREACIO,
			                   FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
			                   FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
			                   FUNC_USU_CREACIO() AS USUARI_CREACIO,
			                   FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
			                   FUNC_NULOS_STRING() AS USUARI_ESBORRAT                   
			              FROM Z_T_RP_USUARIS TIT,
			                   Z_T_RP_ELEMENTS EL,
			                   Z_T_RP_ASPECTES ASP
			              WHERE EL.TITULARDINSID = TIT.USUARIID
			                AND ASP.ASPECTEID =  EL.ASPECTEID
			          )TITULARS_DINS
			         WHERE NOT EXISTS (SELECT 1
			         					 FROM Z_E130_TITULARDINS ANTIGUOS
			         					WHERE ANTIGUOS.USUARI_ID =TITULARS_DINS.USUARI_ID
			         					  AND ANTIGUOS.ASPECTE_ID =TITULARS_DINS.ASPECTE_ID
			         				);	
        
COMMIT;
END;

PROCEDURE E131_TITULAR_DINS IS
BEGIN

    INSERT INTO AUX_TITULAR_DINS (ID, NOM_USUARI, MATRICULA_USUARI, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, ASPECTE_ID)
            SELECT ID, 
                   NOM_USUARI, 
                   MATRICULA_USUARI,
                   DATA_CREACIO, 
                   DATA_MODIFICACIO, 
                   DATA_ESBORRAT, 
                   USUARI_CREACIO, 
                   USUARI_MODIFICACIO, 
                   USUARI_ESBORRAT, 
                   ASPECTE_ID
              FROM Z_E130_TITULARDINS NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM AUX_TITULAR_DINS ANTIGUOS
                                 WHERE ANTIGUOS.MATRICULA_USUARI = NUEVOS.MATRICULA_USUARI
                                   AND ANTIGUOS.ASPECTE_ID = NUEVOS.ASPECTE_ID
                                );
                                
                                

COMMIT;
END;


procedure E140_ELEMENT_PRINCIPAL IS
BEGIN

   INSERT INTO AUX_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_INICI_ACTE, DATA_FI_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID)
             SELECT ID,
                    NUMERO_REGISTRE,
                    ES_RELACIO_ENTRADA,
                    DATA_RELACIO_ENTRADA,
                    ES_VALIDAT_RE,
                    DATA_REGISTRE_GENERAL,
                    DATA_INICI_SEGUIMENT,
                    DATA_FI_SEGUIMENT,
                    NOM_USUARI_RESPONSABLE,
                    MATRICULA_USUARI_RESPONSABLE,
                    DATA_DOCUMENT,
                    DATA_TERMINI,
                    DATA_RESPOSTA,
                    DATA_RESOLUCIO,
                    NOM_ACTE,
                    DATA_INICI_ACTE,
                    DATA_FI_ACTE,
                    DATA_CREACIO,
                    DATA_MODIFICACIO,
                    DATA_ESBORRAT,
                    USUARI_CREACIO,
                    USUARI_MODIFICACIO,
                    USUARI_ESBORRAT,
                    AFECTA_AGENDA_ID,
                    ORIGEN_ID,
                    PRIORITAT_ID,
                    TIPUS_ELEMENT_ID,
                    ASPECTE_ID,
                    DOSSIER_ID,
                    ESTAT_ELEMENT_PRINCIPAL_ID,
                    TIPUS_SUPORT_ID,
                    TIPUS_AMBIT_ID,
                    TIPUS_ARG_ID,
                    PREFIX_ID,
                    NUMERO_REGISTRE_GENERAL_ID,
                    ELEMENT_PRINCIPAL_ORIGEN_ID   
              FROM (      
                     SELECT EP.ASPECTEID AS ID,	
                       EL.NUMEROREGISTREPREFIXID AS NUMERO_REGISTRE,
                       EL.ESENTRADA AS ES_RELACIO_ENTRADA,
                       EL.DATAASSENTAMENT AS DATA_RELACIO_ENTRADA,
                       1 AS ES_VALIDAT_RE,
                       EL.DATAENTRADAREGISTREGENERAL AS DATA_REGISTRE_GENERAL,
                       EL.DATAASSENTAMENT AS DATA_INICI_SEGUIMENT,
                       EP.DATATERMINI AS DATA_FI_SEGUIMENT,
                       (SELECT NOM_USUARI FROM AUX_TITULAR_DINS WHERE ID = EL.TITULARDINSID AND ASPECTE_ID = el.ASPECTEID) AS NOM_USUARI_RESPONSABLE,
                       (SELECT MATRICULA_USUARI FROM AUX_TITULAR_DINS WHERE ID = EL.TITULARDINSID AND ASPECTE_ID = el.ASPECTEID) AS MATRICULA_USUARI_RESPONSABLE,
                       EP.DATADOCUMENT AS DATA_DOCUMENT,
                       EP.DATATERMINI AS DATA_TERMINI,
                       EP.RESPINTERESSAT AS DATA_RESPOSTA,
                       EP.DATARESOLUCIO AS DATA_RESOLUCIO, 
                       AGENDA.ASSUMPTE AS NOM_ACTE,
                       AGENDA.DATAINICI AS DATA_INICI_ACTE,
                       AGENDA.DATAFINAL AS DATA_FI_ACTE ,
                       SYSDATE AS DATA_CREACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                       FUNC_USU_CREACIO() AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                       AGENDA.AFECTAAGENDA AS AFECTA_AGENDA_ID,
                       (CASE WHEN EL.ESENTRADA = 1 THEN 
                              Const_ORIGENELEMENT_RANG -- DM_ORIGEN_ELEMENT
                        ELSE
                              Const_ORIGENELEMENT_CONCRETA
                        END) AS ORIGEN_ID,
                        (SELECT id FROM Z_E999_DM_PRIORITAT_ELEMENT WHERE prioritatid = EP.PRIORITATID AND ambit_id = ConstAMBIT_ALCALDIA) AS PRIORITAT_ID,
                        EP.TIPUSELEMENTPRINCIPALID AS TIPUS_ELEMENT_ID,
                        EL.ASPECTEID AS ASPECTE_ID,
                        EP.DOSSIERID AS DOSSIER_ID,
                        Const_ESTAT_ELEMENT_CONCLUSIO AS ESTAT_ELEMENT_PRINCIPAL_ID,
                        EL.TIPUSSUPORTID AS TIPUS_SUPORT_ID,
                        ConstAMBIT_ALCALDIA AS TIPUS_AMBIT_ID,
                        CAMPS.RESPOSTACAMPG AS TIPUS_ARG_ID,
                        EL.NUMEROREGISTREPREFIXID AS PREFIX_ID,
                        NULL AS NUMERO_REGISTRE_GENERAL_ID,
                        NULL AS ELEMENT_PRINCIPAL_ORIGEN_ID
                    FROM Z_T_RP_ELEMENTS EL,
                         Z_T_RP_ELEMENTSPRINCIPAL EP,
                         Z_T_RP_FITXESAGENDES AGENDA,
                         Z_T_RP_ASPECTES ASP,
                         Z_T_RP_RESPOSTESCAMPSESPECIALS CAMPS
                    WHERE EL.ASPECTEID = EP.ASPECTEID
                      AND EP.ASPECTEID = AGENDA.ASPECTEID
                      AND ASP.ASPECTEID = EP.ASPECTEID
                      AND CAMPS.ASPECTEID = EP.ASPECTEID
                      AND EL.TIPUSSUPORTID IS NOT NULL
                      AND EL.NUMEROREGISTREPREFIXID IS NOT null
                      AND (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = ASP.InstalacioID) = ConstAMBIT_ALCALDIA
                  )ELEMENTS_PRINCIPALS
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM AUX_ELEMENT_PRINCIPAL ANTIGUOS
                                    WHERE  ANTIGUOS.ID = ELEMENTS_PRINCIPALS.ID
                                   );

COMMIT;
END;

--ELEMENTS CON SUPPORTID A NULL EN RESGITRAR_ERRORES
--ELEMENTS CON NUMEROREGISTREPREFIXID a NULL RESGITRAR_ERRORES

PROCEDURE E150_ELEMENTS_SECUNDARIS IS
BEGIN
            INSERT INTO AUX_ELEMENT_SECUNDARI (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_DOCUMENT, COMENTARIS, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, ASPECTE_ID, ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, ORIGEN_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID)
              SELECT ID,
                     NUMERO_REGISTRE,
                     ES_RELACIO_ENTRADA,
                     DATA_RELACIO_ENTRADA,
                     ES_VALIDAT_RE,
                     DATA_REGISTRE_GENERAL,
                     DATA_DOCUMENT,
                     COMENTARIS,
                     DATA_CREACIO,
                     DATA_MODIFICACIO,
                     DATA_ESBORRAT,
                     USUARI_CREACIO,
                     USUARI_MODIFICACIO,
                     USUARI_ESBORRAT,
                     ASPECTE_ID,
                     ELEMENT_PRINCIPAL_ID,
                     TIPUS_SUPORT_ID,
                     ORIGEN_ID,
                     PREFIX_ID,
                     NUMERO_REGISTRE_GENERAL_ID
              FROM (    
                                SELECT EP.ASPECTEID AS ID,	
                                       EL.NUMEROREGISTREPREFIXID AS NUMERO_REGISTRE,
                                       EL.ESENTRADA AS ES_RELACIO_ENTRADA,
                                       EL.DATAASSENTAMENT AS DATA_RELACIO_ENTRADA,
                                       1 AS ES_VALIDAT_RE,
                                       EL.DATAENTRADAREGISTREGENERAL AS DATA_REGISTRE_GENERAL,
                                       EP.DATADOCUMENT AS DATA_DOCUMENT,
                                       EL.COMENTARIS AS COMENTARIS,
                                       SYSDATE AS DATA_CREACIO,
                                       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                       FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                        EL.ASPECTEID AS ASPECTE_ID,
                                        EP.ASPECTEID AS ELEMENT_PRINCIPAL_ID,
                                        EL.TIPUSSUPORTID AS TIPUS_SUPORT_ID,
                                       (CASE WHEN EL.ESENTRADA = 1 THEN 
                                              Const_ORIGENELEMENT_RANG -- DM_ORIGEN_ELEMENT
                                        ELSE
                                              Const_ORIGENELEMENT_CONCRETA
                                        END) AS ORIGEN_ID,
                                        EL.NUMEROREGISTREPREFIXID AS PREFIX_ID,
                                        NULL AS NUMERO_REGISTRE_GENERAL_ID                 
                                   FROM 
                                        Z_T_RP_ELEMENTS EL,
                                        Z_T_RP_ELEMENTSSECUNDARIS ESC,
                                        Z_T_RP_ACCIONS ACC,
                                        Z_T_RP_ASPECTES ASP,
                                        Z_T_RP_HISTORICACCIONS HIST,
                                        Z_T_RP_ELEMENTSPRINCIPAL EP     
                                  WHERE ESC.ASPECTEID = EL.ASPECTEID
                                    AND EL.ACCIOID = ACC.ASPECTEID
                                    AND ACC.ASPECTEID = ASP.ASPECTEID
                                    AND ASP.ASPECTEID=HIST.ASPECTEID  
                                    AND HIST.HISTORICACCIONSID= EP.ASPECTEID
                                    AND (SELECT AMBIT.AMBIT_ID FROM Z_E002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = ASP.InstalacioID) = 1
                        ) ELEMENTS_SEUNDARIOS
                    WHERE NOT EXISTS (SELECT 1 
                                        FROM AUX_ELEMENT_SECUNDARI ANTIGUOS
                                       WHERE  ANTIGUOS.ID = ELEMENTS_SEUNDARIOS.ID
                                     );

    
        
    

COMMIT;
END;


PROCEDURE E160_ACCION_ELEMENTS_PPALS IS
BEGIN

         INSERT INTO Z_E160_ACCION_ELEMENTS_PPAL ( ELEMENT_PRINCIPAL_ID, ACCIONID, TIPUS)
              SELECT ELEMENT_PRINCIPAL_ID, 
                     ACCIONID,
                     TIPUS
                FROM (     
                          SELECT  ASP.ASPECTEID AS ELEMENT_PRINCIPAL_ID, 
                                  HIST.ASPECTEID AS ACCIONID, 
                                  ASP.TIPUS AS TIPUS
                            FROM Z_T_RP_ASPECTES ASP, 
                                 Z_T_RP_HISTORICACCIONS HIST
                           WHERE ASP.ASPECTEID = HIST.HISTORICACCIONSID
                             AND ASP.TIPUS ='ElementPrincipal'
                      )ACCION_EL_PPAL        
                 WHERE NOT EXISTS (SELECT 1
                                   FROM Z_E160_ACCION_ELEMENTS_PPAL ANTIGUOS
                                  WHERE ANTIGUOS.ELEMENT_PRINCIPAL_ID = ACCION_EL_PPAL.ELEMENT_PRINCIPAL_ID
                                    AND ANTIGUOS.ACCIONID = ACCION_EL_PPAL.ACCIONID
                                );  


COMMIT;
END;

--SE HACE EN DOS PARTES PARA INCLUIR LOS USUARIOS DE QUE EST�N EN INFORMACIONSACCIONS
PROCEDURE E161_ACCIONS_PART1 IS 
BEGIN
        INSERT INTO Z_E161_ACCIONS_PART1 (ACCION_ID, RESPOSTA, ESPERARESPOSTA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ELEMENT_PRINCIPAL_ID, ASPECTE_ID, ACCION_PRINCIPAL, AMBIT_ORIGEN_ID, PASS_ACCIO_ID)
                      SELECT ACCION_ID,
                             RESPOSTA,
                             ESPERARESPOSTA,
                             DATA_CREACIO,
                             DATA_MODIFICACIO,
                             DATA_ESBORRAT,
                             USUARI_CREACIO,
                             USUARI_MODIFICACIO,
                             USUARI_ESBORRAT,
                             SUBTIPUS_ACCIO_ID,
                             ELEMENT_PRINCIPAL_ID,
                             ASPECTE_ID,
                             ACCION_PRINCIPAL,
                             AMBIT_ORIGEN_ID,
                             PASS_ACCIO_ID
                        FROM (    
                             
                                    SELECT  acc.ASPECTEID AS ACCION_ID,
                                            ACC.RESPOSTA,
                                            ACC.ESPERARESPOSTA,
                                    --		(SELECT USU.NOM || ' ' || USU.COGNOMS FROM Z_T_RP_USUARIS USU WHERE USU.USUARIID = INF.USUARIID) AS NOM_USUARI_ACCIO,
                                    --		(SELECT USU.USUARI  FROM Z_T_RP_USUARIS USU WHERE USU.USUARIID = INF.USUARIID) AS MATRICULA_USUARI_ACCIO,
                                    --		INF.USUARIID AS USUARI_ACCIO,
                                            acc.DATAINICI AS DATA_CREACIO,
                                            FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                            FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                            FUNC_USU_CREACIO() AS USUARI_CREACIO,
                                            FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                            FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                    --        TA.TIPUSACCIOID AS TIPUS_ACCIO_ID,
                                            STA.SUBTIPUSACCIOID AS SUBTIPUS_ACCIO_ID,
                                            (SELECT ELEMENT_PRINCIPAL_ID FROM  Z_E160_ACCION_ELEMENTS_PPAL HIST WHERE acc.ASPECTEID = HIST.ACCIONID AND ROWNUM=1) AS element_principal_id,       
                                            ASP.ASPECTEID AS ASPECTE_ID,
                                            ACC.ACCIOORIGEN AS ACCION_PRINCIPAL,
                                            ASP.INSTALACIOID AS AMBIT_ORIGEN_ID,
                                            4 AS PASS_ACCIO_ID
                                       FROM Z_T_RP_ASPECTES ASP, 
                                            Z_T_RP_ACCIONS ACC,
                                            Z_T_RP_TIPUSACCIO TA,
                                            Z_T_RP_SUBTIPUSACCIO STA
                                      WHERE ACC.SUBTIPUSACCIOID = STA.SUBTIPUSACCIOID
                                        AND STA.TIPUSACCIOID = TA.TIPUSACCIOID
                                        AND ASP.ASPECTEID = ACC.ASPECTEID
                                )ACCIO_ELEMENT_RP
                                WHERE NOT EXISTS (SELECT 1 
                                                    FROM Z_E161_ACCIONS_PART1 ANTIGUOS
                                                   WHERE ANTIGUOS.ACCION_ID =  ACCIO_ELEMENT_RP.ACCION_ID
                                                 );

COMMIT;
END;


PROCEDURE E162_ACCIONS_PART2 IS 
BEGIN

            INSERT INTO Z_E162_ACCIONS_PART2 (ACCION_ID,NOM_USUARI_ACCIO,MATRICULA_USUARI_ACCIO)
                   SELECT ACCION_ID,
                          NOM_USUARI_ACCIO,
                          MATRICULA_USUARI_ACCIO
                    FROM (   
                            SELECT  ACC.ACCION_ID AS ACCION_ID,
                                    (SELECT USU.NOM || ' ' || USU.COGNOMS FROM Z_T_RP_USUARIS USU WHERE USU.USUARIID = INF.USUARIID) AS NOM_USUARI_ACCIO,
                                    (SELECT USU.USUARI  FROM Z_T_RP_USUARIS USU WHERE USU.USUARIID = INF.USUARIID) AS MATRICULA_USUARI_ACCIO
                               FROM Z_E161_ACCIONS_PART1 ACC, 
                                    Z_T_RP_HISTORICACCIONS INF
                              WHERE ACC.ACCION_ID = INF.HISTORICACCIONSID      
                           )ACCION_USUARIS   
                   WHERE NOT EXISTS (SELECT 1
                                       FROM  Z_E162_ACCIONS_PART2 ANTIGUOS
                                      WHERE ANTIGUOS.ACCION_ID = ACCION_USUARIS.ACCION_ID
                                    );  
                      


COMMIT;
END;

--ACCIONES FINALES CON LOS USUARIOS INFORMADOS
PROCEDURE E163_ACCIONS_PART3 IS
BEGIN

    INSERT INTO Z_E163_ACCIONS_PART3 (ACCION_ID, RESPOSTA, ES_NECESSITA_RESPOSTA, NOM_USUARI_ACCIO, MATRICULA_USUARI_ACCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ASPECTE_ID, ELEMENT_PRINCIPAL_ID, AMBIT_ORIGEN_ID, PAS_ACCIO_ID)
                 SELECT ACCION_ID,
                              RESPOSTA,
                              ES_NECESSITA_RESPOSTA,
                              NOM_USUARI_ACCIO,
                              MATRICULA_USUARI_ACCIO,
                              DATA_CREACIO,
                              DATA_MODIFICACIO,
                              DATA_ESBORRAT,
                              USUARI_CREACIO,
                              USUARI_MODIFICACIO,
                              USUARI_ESBORRAT,
                              SUBTIPUS_ACCIO_ID,
                              ASPECTE_ID,
                              ELEMENT_PRINCIPAL_ID,
                              AMBIT_ORIGEN_ID,
                              PAS_ACCIO_ID
                        FROM (
                                  SELECT PART1.ACCION_ID AS ACCION_ID,
                                         PART1.RESPOSTA,
                                         PART1.ESPERARESPOSTA AS ES_NECESSITA_RESPOSTA,
                                         PART2.NOM_USUARI_ACCIO,
                                         PART2.MATRICULA_USUARI_ACCIO,
                                         PART1.DATA_CREACIO,
                                         PART1.DATA_MODIFICACIO,
                                         PART1.DATA_ESBORRAT,
                                         PART1.USUARI_CREACIO,
                                         PART1.USUARI_MODIFICACIO,
                                         PART1.USUARI_ESBORRAT,
                                         PART1.SUBTIPUS_ACCIO_ID,
                                         PART1.ELEMENT_PRINCIPAL_ID,
                                         PART1.ASPECTE_ID,
                                         PART1.AMBIT_ORIGEN_ID,
                                         PART1.PASS_ACCIO_ID AS PAS_ACCIO_ID
                                    FROM Z_E161_ACCIONS_PART1 PART1,
                                         Z_E162_ACCIONS_PART2 PART2
                                    WHERE PART1.ACCION_ID = PART2.ACCION_ID
                            ) ACCIONS_CON_USUARIOS   
                   WHERE NOT EXISTS (SELECT 1
                                       FROM Z_E163_ACCIONS_PART3 ANTIGUOS
                                      WHERE ANTIGUOS.ACCION_ID =ACCIONS_CON_USUARIOS.ACCION_ID
                                     );


COMMIT;
END;


--ACCIONES FINALES CON LOS USUARIOS NULL
PROCEDURE E164_ACCIONS_PART4 IS
BEGIN

    INSERT INTO Z_E164_ACCIONS_PART4 (ACCION_ID, RESPOSTA, ES_NECESSITA_RESPOSTA, NOM_USUARI_ACCIO, MATRICULA_USUARI_ACCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ASPECTE_ID, ELEMENT_PRINCIPAL_ID, AMBIT_ORIGEN_ID, PAS_ACCIO_ID)
  		   SELECT ACCION_ID,
                  RESPOSTA,
                  ES_NECESSITA_RESPOSTA,
                  NOM_USUARI_ACCIO,
                  MATRICULA_USUARI_ACCIO,
                  DATA_CREACIO,
                  DATA_MODIFICACIO,
                  DATA_ESBORRAT,
                  USUARI_CREACIO,
                  USUARI_MODIFICACIO,
                  USUARI_ESBORRAT,
                  SUBTIPUS_ACCIO_ID,
                  ASPECTE_ID,
                  ELEMENT_PRINCIPAL_ID,
                  AMBIT_ORIGEN_ID,
                  PAS_ACCIO_ID
            FROM (				
				       SELECT ACCIONS_TODAS.ACCION_ID,
				 			  ACCIONS_TODAS.RESPOSTA,
				 			  ACCIONS_TODAS.ESPERARESPOSTA AS ES_NECESSITA_RESPOSTA,
				 			  NULL AS NOM_USUARI_ACCIO,
				     	      NULL AS MATRICULA_USUARI_ACCIO,
				 			  ACCIONS_TODAS.DATA_CREACIO,
				  			  ACCIONS_TODAS.DATA_MODIFICACIO,
							  ACCIONS_TODAS.DATA_ESBORRAT,
							  ACCIONS_TODAS.USUARI_CREACIO,
							  ACCIONS_TODAS.USUARI_MODIFICACIO,
							  ACCIONS_TODAS.USUARI_ESBORRAT,
							  ACCIONS_TODAS.SUBTIPUS_ACCIO_ID,
							  ACCIONS_TODAS.ASPECTE_ID,
							  ACCIONS_TODAS.ELEMENT_PRINCIPAL_ID,			  
							  ACCIONS_TODAS.AMBIT_ORIGEN_ID,
							  ACCIONS_TODAS.PASS_ACCIO_ID AS PAS_ACCIO_ID
				            FROM Z_E161_ACCIONS_PART1 ACCIONS_TODAS
				                 LEFT OUTER JOIN 
				                    Z_E162_ACCIONS_PART2 ACCIONS_CON_USUARIOS
				                 ON   ACCIONS_TODAS.ACCION_ID = ACCIONS_CON_USUARIOS.ACCION_ID 
				            WHERE ACCIONS_CON_USUARIOS.ACCION_ID IS NULL   					 
					)ACCIONES_SIN_USUARIOS
		WHERE NOT EXISTS (SELECT 1 
						    FROM Z_E164_ACCIONS_PART4 ANTIGUOS
						   WHERE ANTIGUOS.ACCION_ID =  ACCIONES_SIN_USUARIOS.ACCION_ID
						 );  

COMMIT;
END;

PROCEDURE AUX_ACCION IS
BEGIN
            INSERT INTO AUX_ACCIO_FINAL (ID, RESPOSTA, ES_NECESSITA_RESPOSTA, NOM_USUARI_ACCIO, MATRICULA_USUARI_ACCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ASPECTE_ID, ELEMENT_PRINCIPAL_ID, AMBIT_ORIGEN_ID, PAS_ACCIO_ID)
           SELECT ACCION_ID AS ID,
                  RESPOSTA,
                  ES_NECESSITA_RESPOSTA,
                  NVL(NOM_USUARI_ACCIO,'*'),
                  NVL(MATRICULA_USUARI_ACCIO,'*'),
                  DATA_CREACIO,
                  DATA_MODIFICACIO,
                  DATA_ESBORRAT,
                  USUARI_CREACIO,
                  USUARI_MODIFICACIO,
                  USUARI_ESBORRAT,
                  SUBTIPUS_ACCIO_ID,
                  ASPECTE_ID,
                  ELEMENT_PRINCIPAL_ID,
                  AMBIT_ORIGEN_ID,
                  PAS_ACCIO_ID
             FROM (
					   SELECT ACCION_ID,
			                  RESPOSTA,
			                  ES_NECESSITA_RESPOSTA,
			                  NOM_USUARI_ACCIO,
			                  MATRICULA_USUARI_ACCIO,
			                  DATA_CREACIO,
			                  DATA_MODIFICACIO,
			                  DATA_ESBORRAT,
			                  USUARI_CREACIO,
			                  USUARI_MODIFICACIO,
			                  USUARI_ESBORRAT,
			                  SUBTIPUS_ACCIO_ID,
			                  ASPECTE_ID,
			                  ELEMENT_PRINCIPAL_ID,
			                  AMBIT_ORIGEN_ID,
			                  PAS_ACCIO_ID
			            FROM Z_E163_ACCIONS_PART3
			                 UNION ALL 
			           SELECT ACCION_ID,
			                  RESPOSTA,
			                  ES_NECESSITA_RESPOSTA,
			                  NOM_USUARI_ACCIO,
			                  MATRICULA_USUARI_ACCIO,
			                  DATA_CREACIO,
			                  DATA_MODIFICACIO,
			                  DATA_ESBORRAT,
			                  USUARI_CREACIO,
			                  USUARI_MODIFICACIO,
			                  USUARI_ESBORRAT,
			                  SUBTIPUS_ACCIO_ID,
			                  ASPECTE_ID,
			                  ELEMENT_PRINCIPAL_ID,
			                  AMBIT_ORIGEN_ID,
			                  PAS_ACCIO_ID
			            FROM Z_E164_ACCIONS_PART4
			        )ACCIO_UNION
			        WHERE NOT EXISTS (SELECT 1 
			        				    FROM AUX_ACCIO_FINAL ANTIGUOS
			        				   WHERE ANTIGUOS.ID = ACCIO_UNION.ACCION_ID
			        				  ); 
                                      
        COMMIT;
        
        
        


COMMIT;
END;

PROCEDURE E170_DOSSIER IS
BEGIN

 INSERT INTO AUX_DOSSIER (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, PREFIX_ANY_ID, ASPECTE_ID)
        SELECT AUX_SEQ_DOSSIER.NEXTVAL AS ID,
               SYSDATE AS DATA_CREACIO,
               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
               FUNC_USU_CREACIO() AS USUARI_CREACIO,
               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
               PREFIXDOSSIERID AS PREFIX_ANY_ID,
               ASPECTEID AS ASPECTE_ID
        FROM Z_T_RP_DOSSIER NUEVOS
        WHERE NOT EXISTS (SELECT 1
                             FROM AUX_DOSSIER ANTIGUOS
                            WHERE ANTIGUOS.ASPECTE_ID = NUEVOS.ASPECTEID
                          );  
				
				


COMMIT;
END;

PROCEDURE E180_ENTRADA_AGENDA IS
BEGIN

                  INSERT INTO AUX_ENTRADA_AGENDA (ID, LLOC_BIS, DATA_INICI_ACTE, DATA_FI_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, ACOMPANYANT, VALORACIO, ASSITENTS, ES_AFECTA_PROTOCOL, ES_DECISIO, ELEMENT_PRINCIPAL_ID, DECISIO_AGENDA_ID, TIPUS_AGENDA_ID, LLOC_ID, TIPUS_DATA_ID, DISTRICTE_ID, BARRI_ID)
                       SELECT FITXAAGENDAID AS ID,
                              NULL AS LLOC_BIS,
                              DATAINICI AS DATA_INICI_ACTE,
                              DATAFINAL AS DATA_FI_ACTE,
                              SYSDATE AS DATA_CREACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                              FUNC_USU_CREACIO() AS USUARI_CREACIO,
                              FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                              FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                              ACOMPANYANTS AS ACOMPANYANT,
                              VALORACIO AS VALORACIO,
                              ASSISTENTS AS ASSITENTS,
                              AFECTAAGENDA AS ES_AFECTA_PROTOCOL,
                              DECISIOID AS ES_DECISIO,
                              (SELECT ID FROM AUX_ELEMENT_PRINCIPAL EP WHERE EP.ASPECTE_ID = ASPECTE_ID AND ROWNUM=1) AS ELEMENT_PRINCIPAL_ID,
                              DECISIOID AS DECISIO_AGENDA_ID,
                              (SELECT ID FROM AUX_DM_TIPUS_AGENDA TIP_AG WHERE TIP_AG.DESCRIPCIO = 'CONCRETA' AND AMBIT_ID=1) AS TIPUS_AGENDA_ID,
                              LLOCID AS LLOC_ID,
                              (SELECT ID FROM AUX_DM_TIPUS_DATA TIP_DAT WHERE TIP_DAT.DESCRIPCIO = 'CONCRETA' AND AMBIT_ID=1) AS TIPUS_DATA_ID,
                              DISTRICTEID AS DISTRICTE_ID,
                              NULL AS BARRI_ID 	  
                        FROM Z_T_RP_FITXESAGENDES NUEVOS
                        WHERE NOT EXISTS (SELECT 1
                                            FROM AUX_ENTRADA_AGENDA ANTIGUOS
                                           WHERE ANTIGUOS.ID = NUEVOS.FITXAAGENDAID
                                         );

                                        


COMMIT;
END;

PROCEDURE E190_AGENDA_DELEGACIO IS
BEGIN

        INSERT INTO AUX_AGENDA_DELEGACIO (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, DESTI_DELEGACIO_ID, ENTRADA_AGENDA_ID) 
                       SELECT AUX_SEQ_AGENDA_DELEGACIO.NEXTVAL AS ID, 
                      		  SYSDATE AS DATA_CREACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                              FUNC_USU_CREACIO() AS USUARI_CREACIO,
                              FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                              FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                              DELEGACIOID AS DESTI_DELEGACIO_ID,
                              FITXAAGENDAID AS ENTRADA_AGENDA_ID                              
                        FROM Z_T_RP_FITXESAGENDES NUEVOS
                        WHERE DELEGACIOID IS NOT NULL
                        AND NOT EXISTS (SELECT 1
                                            FROM AUX_AGENDA_DELEGACIO ANTIGUOS
                                           WHERE ANTIGUOS.ENTRADA_AGENDA_ID = NUEVOS.FITXAAGENDAID
                                             AND NVL(ANTIGUOS.DESTI_DELEGACIO_ID,1) = NVL(NUEVOS.DELEGACIOID,1)
                                         );

                                        


COMMIT;
END;


PROCEDURE E200_CLASSIFICACIO_ARXIU IS
BEGIN

        INSERT INTO AUX_CLASSIFICACIO_ARXIU (ID, DESCRIPTORS_TEMATICS, DATA_TRANSFERENCIA, DATA_ARXIU, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SERIE_ID, ESPECIFIC_ID, ASPECTE_ID)
                SELECT ARXIUID AS ID,
                       DESCRIPTORSTEMATICS AS DESCRIPTORS_TEMATICS,
                       DATATRANSFERENCIA AS DATA_TRANSFERENCIA,
                       DATAARXIU AS DATA_ARXIU,
                       SYSDATE AS DATA_CREACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                       FUNC_USU_CREACIO() AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                       SERIEID AS SERIE_ID,
                       ESPECIFICID AS ESPECIFIC_ID,
                       ASPECTEID AS ASPECTE_ID
                  FROM Z_T_RP_ARXIUS NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                          FROM AUX_CLASSIFICACIO_ARXIU ANTIGUOS
                         WHERE ANTIGUOS.ID = NUEVOS.ARXIUID
                       );  
                       


COMMIT;
END;


PROCEDURE RESETEATOR_TABLAS IS 
BEGIN
 
   DELETE FROM AUX_CLASSIFICACIO_ARXIU;
   
   DELETE FROM AUX_AGENDA_DELEGACIO;
   
   DELETE FROM AUX_ENTRADA_AGENDA; 
   
   DELETE FROM AUX_DOSSIER;

   DELETE FROM AUX_ACCIO_FINAL;
   DELETE FROM Z_E164_ACCIONS_PART4;    --ACCIONES CON USUARIOS NULL
   DELETE FROM Z_E163_ACCIONS_PART3;    --ACCIONES CON USUARIOS RELLENADOS
   DELETE FROM Z_E162_ACCIONS_PART2;
   DELETE FROM Z_E161_ACCIONS_PART1;
   DELETE FROM Z_E160_ACCION_ELEMENTS_PPAL;

   DELETE FROM AUX_ELEMENT_SECUNDARI;
   DELETE FROM AUX_ELEMENT_PRINCIPAL;

   DELETE FROM AUX_TITULAR_DINS;   
   DELETE FROM Z_E130_TITULARDINS;
   
   DELETE FROM AUX_DOSSIER;
   DELETE FROM AUX_ASPECTE;
   --CAT�LOGOS 
   DELETE FROM AUX_DM_TIPUS_DATA;
   DELETE FROM Z_E999_DM_TIPUS_DATA;
   DELETE FROM Z_E100_TIPUS_DATA;

   DELETE FROM AUX_DM_TIPUS_ARG;
   DELETE FROM Z_E999_DM_TIPUS_ARG;   
--   DELETE FROM Z_E090_TIPUS_ARG;

   DELETE FROM AUX_DM_ORIGEN_ELEMENT;
   DELETE FROM Z_E999_DM_ORIGEN_ELEMENT;   
   DELETE FROM Z_E080_ORIGEN_ELEMENT;
    
   DELETE FROM AUX_DM_TIPUS_AGENDA;   
   DELETE FROM Z_E999_DM_TIPUS_AGENDA;
   DELETE FROM Z_E070_TIPUS_AGENDA;
   
   DELETE FROM AUX_DM_PAS_ACCIO;
   DELETE FROM Z_E061_DM_PAS_ACCIO;
   DELETE FROM Z_E060_PAS_ACCIO;

   

   
   DELETE FROM AUX_DM_ESTAT_ELEMENT;
   DELETE FROM Z_E999_DM_ESTAT_ELEMENT;               
   DELETE FROM Z_E050_ESTAT_ELEMENT;

   DELETE FROM AUX_DM_PREFIX; 
   DELETE FROM Z_E043_DM_PREFIX;
   DELETE FROM AUX_DM_CATALEG_DOCUMENT;
   DELETE FROM Z_E042_DM_CATALEG_DOCUMENT;
   DELETE FROM AUX_DM_SERIE;
   DELETE FROM Z_E040_SERIES_SUBSERIES;

    DELETE FROM AUX_DM_TIPUS_SUPORT;
    DELETE FROM Z_E999_DM_TIPUS_SUPORT;

    DELETE FROM AUX_DM_PREFIX_ANY;
    DELETE FROM Z_E999_DM_PREFIX_ANY;

    DELETE FROM AUX_DM_PRIORITAT_ELEMENT;
    DELETE FROM Z_E999_DM_PRIORITAT_ELEMENT;

    DELETE FROM AUX_DM_DECISIO_AGENDA;
    DELETE FROM Z_E999_DM_DECISIO_AGENDA;

    DELETE FROM AUX_DM_TIPUS_ELEMENT;
    DELETE FROM Z_E999_DM_TIPUS_ELEMENT;
    
    DELETE FROM AUX_DM_DESTI_DELEGACIO;
    DELETE FROM Z_E999_DM_DESTI_DELEGACIO;

    DELETE FROM AUX_DM_SUBTIPUS_ACCIO;
    DELETE FROM Z_E999_DM_SUBTIPUS_ACCIO;
    DELETE FROM Z_E025_DM_SUBTIPUSACCIO;    

    
    DELETE FROM AUX_DM_TIPUS_ACCIO;
    DELETE FROM Z_E999_DM_TIPUS_ACCIO;
    DELETE FROM Z_E020_TIPUSACCIO_DMTIPUSACCIO;
    
    DELETE FROM AUX_DM_ESPECIFIC;
    
    DELETE FROM AUX_DM_TIPUS_TEMA;
    DELETE FROM Z_E999_DM_TIPUS_TEMA;
    
    DELETE FROM AUX_DM_DISTRICTE;
    DELETE FROM Z_E999_DM_DISTRICTE;
    
    DELETE FROM AUX_DM_LLOC;
    DELETE FROM Z_E999_DM_LLOC;

    DELETE FROM Z_E003_AMBITS;
    DELETE FROM Z_E002_INSTALACIO_AMBIT_PART;
    DELETE FROM Z_E001_PARTICIONES;
    
    
--    DELETE FROM Z_F010_DM_LLOCS;


COMMIT;
END;


  PROCEDURE RESETEATOR_SECUENCIAS IS         
            TYPE V_Sequence IS VARRAY(1) OF VARCHAR2(100);
            Secuencia V_Sequence;
            total integer;  
    
    BEGIN
    
            
        Secuencia := V_Sequence('AUX_SEQ_DM_TIPUS_ACCIO'
                 );
        
                     
                
        total := Secuencia.count; 


        
        FOR i in 1 .. total LOOP
                execute immediate 'DROP SEQUENCE ' || Secuencia(i);  
                execute immediate 'CREATE SEQUENCE ' || Secuencia(i) || ' MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE';            
        END LOOP;
    END;
  
/*

DROP SEQUENCE AUX_SEQ_DM_TIPUS_ACCIO;
CREATE SEQUENCE AUX_SEQ_DM_TIPUS_ACCIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  AUX_SEQ_DM_TIPUS_ELEMENT;
CREATE SEQUENCE AUX_SEQ_DM_TIPUS_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  AUX_SEQ_SERIE_SUBSERIE;
CREATE SEQUENCE AUX_SEQ_SERIE_SUBSERIE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_ESTAT_ELEMENT;
CREATE SEQUENCE AUX_SEQ_DM_ESTAT_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_ORIGEN_ELEMENT;
CREATE SEQUENCE AUX_SEQ_DM_ORIGEN_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_PAS_ACCIO;
CREATE SEQUENCE AUX_SEQ_DM_PAS_ACCIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_PRIORITAT_ELEMENT;
CREATE SEQUENCE AUX_SEQ_DM_PRIORITAT_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_TIPUS_AGENDA;
CREATE SEQUENCE AUX_SEQ_DM_TIPUS_AGENDA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

--DROP SEQUENCE AUX_SEQ_DM_TIPUS_ARG;
--CREATE SEQUENCE AUX_SEQ_DM_TIPUS_ARG MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_TIPUS_DATA;
CREATE SEQUENCE AUX_SEQ_DM_TIPUS_DATA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  AUX_SEQ_TITULAR_DINS;
CREATE SEQUENCE AUX_SEQ_TITULAR_DINS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  AUX_SEQ_DOSSIER;
CREATE SEQUENCE AUX_SEQ_DOSSIER MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  AUX_SEQ_AGENDA_DELEGACIO;
CREATE SEQUENCE AUX_SEQ_AGENDA_DELEGACIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;


*/
  
  


END E_01_TEMAS_RISPLUS;

/
