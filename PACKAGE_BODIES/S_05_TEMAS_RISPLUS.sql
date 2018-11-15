--------------------------------------------------------
--  DDL for Package Body S_05_TEMAS_RISPLUS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."S_05_TEMAS_RISPLUS" AS


/* comentari_aspecte
   titular_fora 
*/   


PROCEDURE SE001_PARTICIONES IS
BEGIN
    INSERT INTO Z_SE001_PARTICIONES (ANNO, PARTICION_ID)
           SELECT EXTRACT(YEAR FROM DATACREACIO) AS ANNO, ROW_NUMBER() OVER(ORDER BY EXTRACT(YEAR FROM DATACREACIO) DESC) AS PARTICION_ID
                  FROM Z_T_RP_INSTALACIONS
		          GROUP BY EXTRACT(YEAR FROM DATACREACIO)
                  ORDER BY EXTRACT(YEAR FROM DATACREACIO) DESC;

COMMIT;
END;

/*Creamos tablas de intercambio INSTALACION_ID // AMBIT_ID  + PARTICION_ID*/

 PROCEDURE SE002_INSTALACIO_AMBITS_PART IS
 BEGIN 
        INSERT INTO Z_SE002_INSTALACIO_AMBIT_PART (INSTALACIOID, DESCRIPCIO, NOM, DATACREACIO, AMBIT_ID)
                    SELECT INSTALACIOID, 
                           DESCRIPCIO,
                           NOM, 
                           DATACREACIO AS DATACREACIO,
                           ConstAMBIT_PROTOCOL AS AMBIT_ID
                    FROM Z_T_RP_INSTALACIONS;
 
--        UPDATE Z_SE002_INSTALACIO_AMBIT_PART SET AMBIT_ID=99; --COMO NO SABEMOS CUÁL CORRESPONDE, RESETEAMOS TODOS A 99 Y POSTEIORMENTE ASIGNAMOS AMBITOS 1 Y 2
        UPDATE Z_SE002_INSTALACIO_AMBIT_PART SET AMBIT_ID=ConstAMBIT_ALCALDIA WHERE INSTALACIOID IN (ConstInstalacioAlcaldia); --25 OR INSTALACIOID=30;
        --UPDATE Z_SE002_INSTALACIO_AMBIT_PART SET AMBIT_ID=ConstAMBIT_PROTOCOL WHERE INSTALACIOID=19;-- OR INSTALACIOID=30;
        
        
        --BORRAMOS AQUELLOS QUE NO PERTENEZCAN A ALCALDÍA. ÉSTOS NO SE MIGRARÁN
        DELETE FROM Z_SE002_INSTALACIO_AMBIT_PART  WHERE AMBIT_ID<>ConstInstalacioAlcaldia;
 COMMIT;
 END;

 PROCEDURE SE003_AMBITS IS
 BEGIN
 
                INSERT INTO Z_SE003_AMBITS (AMBIT_ID)
           SELECT AMBIT_ID
           FROM (
                    SELECT AMBIT_ID
                      FROM Z_SE002_INSTALACIO_AMBIT_PART
                  GROUP BY AMBIT_ID
                 ) AMBITOS
           WHERE NOT EXISTS (SELECT 1 
                               FROM Z_SE003_AMBITS ANTIGUOS
                              WHERE ANTIGUOS.AMBIT_ID = AMBITOS.AMBIT_ID
                            );  
        
 
 COMMIT;
 END;
 
 
 
 
   

PROCEDURE SE010_DM_LLOC IS
BEGIN

    INSERT INTO Z_SE999_DM_LLOC (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
             SELECT A1_SEQ_DM_LLOC.NEXTVAL AS ID, 
                    substr(DESCRIPCIO,1,50), 
                    DATA_CREACIO, 
                    DATA_MODIFICACIO, 
                    DATA_ESBORRAT, 
                    USUARI_CREACIO, 
                    USUARI_MODIFICACIO, 
                    USUARI_ESBORRAT, 
                    AMBIT_ID,
                    LLOCID as ID_ORIGINAL, 
                    'RISPLUS' AS ESQUEMA_ORIGINAL, 
                    'LLOC' AS TABLA_ORIGINAL, 
                    ConstInstalacioAlcaldia AS INSTALACIOID
             FROM (   
                        SELECT LLOCID AS LLOCID,
                               NOM AS DESCRIPCIO,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               ConstAMBIT_ALCALDIA AS AMBIT_ID
        --                       FUNC_AMBIT_RISPLUS(LLOC.InstalacioID) AS AMBIT_ID
        --                       FUNC_AMBIT_RISPLUS(LLOC.INSTALACIOID) AS AMBIT_ID
        --                       FUNC_PARTICION_RISPLUS(LLOC.INSTALACIOID) AS PARTICION_ID 	   
                        FROM Z_T_RP_LLOC LLOC
                        WHERE LLOC.InstalacioID IN(ConstInstalacioAlcaldia)--OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS
        		    ) NUEVOS    
            WHERE NOT EXISTS (SELECT 1
                               FROM Z_SE999_DM_LLOC ANTIGUOS
                              WHERE  ANTIGUOS.ID_ORIGINAL = NUEVOS.LLOCID 
                               AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                             );         
              
    COMMIT;
                INSERT INTO A1_DM_LLOC (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, AMBIT_ID, USUARI_ESBORRAT,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                      SELECT ID, 
                       		  DESCRIPCIO, 
                       		  FUNC_NULOS_DATE(DATA_CREACIO) AS DATA_CREACIO, 
                       		  FUNC_NULOS_DATE(DATA_MODIFICACIO) AS DATA_MODIFICACIO, 
                       		  FUNC_NULOS_DATE(DATA_ESBORRAT) AS DATA_ESBORRAT, 
                       		  USUARI_CREACIO, 
                       		  USUARI_MODIFICACIO, 
                       		  AMBIT_ID, 
                       		  USUARI_ESBORRAT,
                              ID_ORIGINAL, 
                              ESQUEMA_ORIGINAL, 
                              TABLA_ORIGINAL, 
                              INSTALACIOID
                         FROM Z_SE999_DM_LLOC NUEVOS
                        WHERE NOT EXISTS  (SELECT 1 
                                             FROM A1_DM_LLOC ANTIGUOS
                                            WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                                              AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                           );
                                             
COMMIT;
END;

/* CREAMOS CATÁLOGO DE DISTRITOS Y TABLA DE DISTRITOS QUE TIENEN LA DESCRIPCION A NULL */
PROCEDURE SE011_DM_DISTRICTE IS
BEGIN

         INSERT INTO Z_SE999_DM_DISTRICTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                 SELECT A1_SEQ_DM_DISTRICTE.NEXTVAL AS ID, 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_MODIFICACIO, 
                        DATA_ESBORRAT, 
                        USUARI_CREACIO, 
                        USUARI_MODIFICACIO, 
                        USUARI_ESBORRAT, 
                        AMBIT_ID,
                        DISTRICTEID as ID_ORIGINAL, 
                        'RISPLUS' AS ESQUEMA_ORIGINAL, 
                        'DISTRICTE' AS TABLA_ORIGINAL, 
                        ConstInstalacioAlcaldia AS INSTALACIOID
                 FROM (    
                        SELECT DISTRICTEID AS DISTRICTEID,
                               NOM AS DESCRIPCIO, 
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               ConstAMBIT_ALCALDIA AS AMBIT_ID       
                        FROM Z_T_RP_DISTRICTE DISTRICTE
                        WHERE NOM IS NOT NULL 
                          AND DISTRICTE.InstalacioID IN (ConstInstalacioAlcaldia) --OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS (15 ES PRUEBAS)
                     ) NUEVOS    
             WHERE NOT EXISTS (SELECT 1
                                 FROM Z_SE999_DM_DISTRICTE ANTIGUOS
                                WHERE  ANTIGUOS.ID_ORIGINAL = NUEVOS.DISTRICTEID 
                                  AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                              );                                     
               
            COMMIT;
            /*hay que quitar las constrains de err */
                    INSERT INTO A1_DM_DISTRICTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      FUNC_NULOS_DATE(DATA_CREACIO) AS DATA_CREACIO, 
                                      FUNC_NULOS_DATE(DATA_MODIFICACIO) AS DATA_MODIFICACIO, 
                                      FUNC_NULOS_DATE(DATA_ESBORRAT) AS DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT, 
                                      AMBIT_ID,
                                      ID_ORIGINAL, 
                                      ESQUEMA_ORIGINAL, 
                                      TABLA_ORIGINAL, 
                                      ConstInstalacioAlcaldia AS INSTALACIOID
                                 FROM Z_SE999_DM_DISTRICTE NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM A1_DM_DISTRICTE ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );                      

COMMIT;
END;


PROCEDURE SE012_DM_TIPUS_TEMA IS
BEGIN

    INSERT INTO Z_SE999_DM_TIPUS_TEMA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
             SELECT A1_SEQ_DM_TIPUS_TEMA.NEXTVAL AS ID,
                               TipusTema AS DESCRIPCIO, 
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               Ambit_ID AS AMBIT_ID,
                               ASPECTEID AS ID_ORIGINAL, 
                               'RISPLUS' AS ESQUEMA_ORIGINAL, 
                               'ASPECTES' AS TABLA_ORIGINAL, 
                                ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM (
                               SELECT ASPECTEID AS ASPECTEID,
                                      TipusTema AS TipusTema, 
                                      Ambit_ID AS AMBIT_ID
                                 FROM (	   
                                                    SELECT  ASPECTEID AS ASPECTEID,
                                                            Tipus AS TipusTema, 
                                                            ConstAMBIT_ALCALDIA AS AMBIT_ID 
                                                    FROM (
                                                            SELECT MIN(ASPECTEID) AS ASPECTEID,
                                                                   tipus, 
                                                                   instalacioid
                                                              FROM Z_T_RP_ASPECTES 
                                                             WHERE INSTALACIOID IN (ConstInstalacioAlcaldia) 
                                                             group BY tipus,instalacioid
                                                         ) Tipus_Tema
                                                ) GROUP_AMBIT		 
                                        GROUP BY ASPECTEID,TipusTema,AMBIT_ID
                              )FINAL_GROUP
                        WHERE NOT EXISTS ( SELECT 1
                                             FROM Z_SE999_DM_TIPUS_TEMA ANTIGUOS  
                                            WHERE FINAL_GROUP.TipusTema = ANTIGUOS.DESCRIPCIO
                                              AND FINAL_GROUP.AMBIT_ID = ANTIGUOS.AMBIT_ID
                                         );
        COMMIT;                                  
                                  
         INSERT INTO A1_DM_TIPUS_TEMA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
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
                                 FROM Z_SE999_DM_TIPUS_TEMA NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM A1_DM_TIPUS_TEMA ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );      
                                  
                              
        COMMIT;


/* este es el tipus de element principal
         INSERT INTO Z_SE999_DM_TIPUS_TEMA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
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
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               (SELECT AMBIT.AMBIT_ID FROM Z_SE002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = TIPUSTEMA.InstalacioID) AS AMBIT_ID       
                        FROM Z_T_RP_TIPUSTEMAELEMENTPRINCIP TIPUSTEMA
                        WHERE NOM IS NOT NULL
                     		    ) NUEVOS    
                WHERE NOT EXISTS (SELECT 1
                                    FROM Z_SE999_DM_TIPUS_TEMA ANTIGUOS
                                   WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                     AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                 );      
                        
                      
                     
          
               
COMMIT;
            --hay que quitar las constrains de err 
                   INSERT INTO A1_DM_TIPUS_TEMA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
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
                                 FROM Z_SE999_DM_TIPUS_TEMA NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM A1_DM_TIPUS_TEMA ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID

                                                   );      
    COMMIT;
*/                                                   


END;

PROCEDURE SE013_DM_ESPECIFIC IS
BEGIN
        INSERT INTO A1_DM_ESPECIFIC (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)     
               SELECT A1_SEQ_DM_ESPECIFIC.NEXTVAL AS ID, 
                      DESCRIPCIO, 
                      DATA_CREACIO, 
                      DATA_MODIFICACIO, 
                      DATA_ESBORRAT, 
                      USUARI_CREACIO, 
                      USUARI_MODIFICACIO, 
                      USUARI_ESBORRAT, 
                      AMBIT_ID,
                      ESPECIFICID AS ID_ORIGINAL,
                      'RISPLUS' AS ESQUEMA_ORIGINAL,
                      'ESPECIFICS' AS TABLA_ORIGINAL,
                      ConstInstalacioAlcaldia AS INSTALACIOID
               FROM (
                       SELECT ESPECIFICID AS ESPECIFICID,
                               NOM AS DESCRIPCIO,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               ConstAMBIT_ALCALDIA AS AMBIT_ID                               
                          FROM Z_T_RP_ESPECIFICS ESPECIFICS
                         WHERE ESPECIFICS.INSTALACIOID=ConstInstalacioAlcaldia
                      ) NUEVOS    
                 WHERE NOT EXISTS (SELECT 1
                                     FROM A1_DM_ESPECIFIC ANTIGUOS
                                    WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ESPECIFICID
                                      AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                  );    
            


COMMIT;
END;


--TABLA INTERMEDIA QUE RELACCIONA TIPUSACCIO DE RISPLUS CON EL CATÁLOGO DM_TIPUS_ACCIO DE SINTAGMA
PROCEDURE SE020_TIPUSACCIO_DMTIPUSACCIO IS
BEGIN
     INSERT INTO Z_SE020_TIPUSACCIO_DMTIPUSACCI (ID, ACCIO_ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
            SELECT A1_SEQ_DM_TIPUS_ACCIO.NEXTVAL AS ID,
            
                   NUEVOTIPUSACCIO.ACCIO_ID,
                   NUEVOTIPUSACCIO.DESCRIPCIO,
                   NUEVOTIPUSACCIO.DATA_CREACIO, 
                   NUEVOTIPUSACCIO.DATA_MODIFICACIO, 
                   NUEVOTIPUSACCIO.DATA_ESBORRAT, 
                   NUEVOTIPUSACCIO.USUARI_CREACIO, 
                   NUEVOTIPUSACCIO.USUARI_MODIFICACIO, 
                   NUEVOTIPUSACCIO.USUARI_ESBORRAT, 
                   NUEVOTIPUSACCIO.AMBIT_ID,
                   ACCIO_ID AS ID_ORIGINAL,  
                   'RISPLUS' AS ESQUEMA_ORIGINAL , 
                   'TIPUSACCIO' AS TABLA_ORIGINAL,
                   ConstInstalacioAlcaldia AS INSTALACIOID
            FROM(        
                            SELECT TIPUSACCIO.ACCIO_ID,
                                   TIPUSACCIO.DESCRIPCIO,
                                   SYSDATE AS DATA_CREACIO,
	                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
	                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
	                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
	                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
	                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                   TIPUSACCIO.AMBIT_ID
                            FROM (       
                                    SELECT ACCIO.TIPUSACCIOID AS ACCIO_ID,
                                            ACCIO.NOM AS DESCRIPCIO,
                                            ConstAMBIT_ALCALDIA AS AMBIT_ID		
                                      FROM  Z_T_RP_TIPUSACCIO ACCIO,
                                            Z_T_RP_SUBTIPUSACCIO SUBACCIO        
                                    WHERE ACCIO.TIPUSACCIOID = SUBACCIO.TIPUSACCIOID
                                    and SUBACCIO.InstalacioID in (ConstInstalacioAlcaldia) --OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS
                                 ) TIPUSACCIO	
                            GROUP BY TIPUSACCIO.ACCIO_ID, TIPUSACCIO.DESCRIPCIO, TIPUSACCIO.AMBIT_ID
            ) NUEVOTIPUSACCIO
            WHERE NOT EXISTS (SELECT 1 
            				    FROM Z_SE020_TIPUSACCIO_DMTIPUSACCI ANTIGUOS
            				   WHERE ANTIGUOS.ACCIO_ID = NUEVOTIPUSACCIO.ACCIO_ID
            				     AND ANTIGUOS.AMBIT_ID = NUEVOTIPUSACCIO.AMBIT_ID
            				 );    
        

COMMIT;
END;


PROCEDURE SE021_DMTIPUSACCIO IS
BEGIN
         INSERT INTO Z_SE999_DM_TIPUS_ACCIO (ID, DESCRIPCIO, CODI, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                  SELECT ID,           
                         DESCRIPCIO,
                         DESCRIPCIO AS CODI,
                         DATA_CREACIO, 
                         DATA_MODIFICACIO, 
                         DATA_ESBORRAT, 
                         USUARI_CREACIO, 
                         USUARI_MODIFICACIO, 
                         USUARI_ESBORRAT, 
                         AMBIT_ID,
                         ID_ORIGINAL, 
                         ESQUEMA_ORIGINAL , 
                         TABLA_ORIGINAL,
                         INSTALACIOID
                    FROM Z_SE020_TIPUSACCIO_DMTIPUSACCI NUEVO
                    WHERE NOT EXISTS (SELECT 1 
                                        FROM Z_SE999_DM_TIPUS_ACCIO ANTIGUOS
                                       WHERE ANTIGUOS.CODI = NUEVO.DESCRIPCIO
                                         AND ANTIGUOS.AMBIT_ID = NUEVO.AMBIT_ID
                                     );    
        
        COMMIT; 
        
        INSERT INTO A1_DM_TIPUS_ACCIO (ID,CODI,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID,DESCRIPCIO)
                  SELECT ID,            
                         CODI,
                         DATA_CREACIO, 
                         DATA_MODIFICACIO, 
                         DATA_ESBORRAT, 
                         USUARI_CREACIO, 
                         USUARI_MODIFICACIO, 
                         USUARI_ESBORRAT, 
                         AMBIT_ID,
                         ID_ORIGINAL, 
                         ESQUEMA_ORIGINAL , 
                         TABLA_ORIGINAL,
                         INSTALACIOID,
                         DESCRIPCIO
                    FROM Z_SE999_DM_TIPUS_ACCIO NUEVO
                   WHERE  NOT EXISTS (SELECT 1 
                                        FROM A1_DM_TIPUS_ACCIO ANTIGUOS
                                       WHERE ANTIGUOS.CODI = NUEVO.CODI
                                         AND ANTIGUOS.AMBIT_ID = NUEVO.AMBIT_ID
                                     );    
                    
                

COMMIT;
END;


--TABLA INTERMEDIA QUE RELACCIONA TIPUSACCIO DE RISPLUS CON EL CATÁLOGO DM_TIPUS_ACCIO DE SINTAGMA
PROCEDURE SE025_DM_SUBTIPUSACCIO IS
BEGIN

            INSERT INTO Z_SE025_DM_SUBTIPUSACCIO (ID, DESCRIPCIO, USUARI_PER_DEFECTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                        SELECT A1_SEQ_DM_SUBTIPUS_ACCIO.NEXTVAL AS ID, 
                               SUBTIPOACCIO.DESCRIPCIO AS DESCRIPCIO,
                               FUNC_USU_CREACIO(NULL) AS USUARI_PER_DEFECTE,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               SUBTIPOACCIO.AMBIT_ID AS AMBIT_ID,
                               SUBTIPOACCIO.TIPUS_ACCIO_ID AS TIPUS_ACCIO_ID,
                               SUBTIPOACCIO.ID AS ID_ORIGINAL, 
                               'RISPLUS' AS ESQUEMA_ORIGINAL , 
                               'SUBTIPUSACCIO' AS TABLA_ORIGINAL,
                               ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM (       
                              SELECT SUBTIPO.ID, 
                                     SUBTIPO.DESCRIPCIO,
                                     SUBTIPO.AMBIT_ID,
                                     SUBTIPO.TIPUS_ACCIO_ID
                                 FROM (    
                                            SELECT SUBACCIO.SUBTIPUSACCIOID AS ID, 
                                                   SUBACCIO.NOM AS DESCRIPCIO,
                                                   ConstAMBIT_ALCALDIA AS AMBIT_ID,
                                                   ACCIO.ACCIO_ID AS TIPUS_ACCIO_ID       
                                            FROM Z_T_RP_SUBTIPUSACCIO SUBACCIO,
                                                 Z_SE020_TIPUSACCIO_DMTIPUSACCI ACCIO
                                            WHERE SUBACCIO.TIPUSACCIOID = ACCIO.ACCIO_ID
                                            and SUBACCIO.InstalacioID IN (ConstInstalacioAlcaldia)--OJO CHAPUZA PORQUE SI SE TOMA INSTALACIO 12 COMO AMBITO 2, SE REPITEN DISTRITOS
                                       ) SUBTIPO		
                                    GROUP BY SUBTIPO.ID, SUBTIPO.DESCRIPCIO, SUBTIPO.AMBIT_ID, SUBTIPO.TIPUS_ACCIO_ID
                        ) SUBTIPOACCIO
                        WHERE NOT EXISTS (SELECT 1
                                            FROM  Z_SE025_DM_SUBTIPUSACCIO ANTIGUOS 
                                           WHERE ANTIGUOS.ID = SUBTIPOACCIO.ID 
                                             AND ANTIGUOS.TIPUS_ACCIO_ID = SUBTIPOACCIO.TIPUS_ACCIO_ID  
                                             AND ANTIGUOS.AMBIT_ID = SUBTIPOACCIO.AMBIT_ID
                                         );    
            COMMIT; 
            
            INSERT INTO A1_DM_SUBTIPUS_ACCIO (ID, CODI, USUARI_PER_DEFECTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, DESCRIPCIO)
                    VALUES(28, 'Assignació', NULL, SYSDATE, NULL, NULL, 'SYSTEM', NULL, NULL, 1, 3, '28', NULL, NULL, NULL, 'Assignació');

            
            COMMIT;
            
            INSERT INTO Z_SE999_DM_SUBTIPUS_ACCIO (ID, DESCRIPCIO,USUARI_PER_DEFECTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                 SELECT ID, 
                 		DESCRIPCIO, 
                        USUARI_PER_DEFECTE AS USUARI_PER_DEFECTE,
                 		DATA_CREACIO, 
                 		DATA_MODIFICACIO, 
                 		DATA_ESBORRAT, 
                 		USUARI_CREACIO, 
                 		USUARI_MODIFICACIO, 
                 		USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                 		AMBIT_ID, 
                 		TIPUS_ACCIO_ID,
                        ID_ORIGINAL, 
                        ESQUEMA_ORIGINAL , 
                        TABLA_ORIGINAL,
                        INSTALACIOID
                  FROM  Z_SE025_DM_SUBTIPUSACCIO NUEVOS
                 WHERE NOT EXISTS  (SELECT 1 
                                      FROM Z_SE999_DM_SUBTIPUS_ACCIO ANTIGUOS
                                     WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                       AND ANTIGUOS.TIPUS_ACCIO_ID = NUEVOS.TIPUS_ACCIO_ID  
                                       AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                   );                
            COMMIT; 
            
            INSERT INTO A1_DM_SUBTIPUS_ACCIO (ID, CODI, USUARI_PER_DEFECTE,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID,DESCRIPCIO)
                 SELECT ID, 
                 		DESCRIPCIO AS CODI, 
                        USUARI_PER_DEFECTE AS USUARI_PER_DEFECTE,
                 		DATA_CREACIO, 
                 		DATA_MODIFICACIO, 
                 		DATA_ESBORRAT, 
                 		USUARI_CREACIO, 
                 		USUARI_MODIFICACIO, 
                 		USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                 		AMBIT_ID, 
                        TIPUS_ACCIO_ID,
                        ID_ORIGINAL, 
                        ESQUEMA_ORIGINAL , 
                        TABLA_ORIGINAL,INSTALACIOID,
                        DESCRIPCIO
                  FROM  Z_SE999_DM_SUBTIPUS_ACCIO NUEVOS
                 WHERE NOT EXISTS  (SELECT 1 
                                      FROM A1_DM_SUBTIPUS_ACCIO ANTIGUOS
                                     WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                       AND ANTIGUOS.TIPUS_ACCIO_ID = NUEVOS.TIPUS_ACCIO_ID  
                                       AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                   );                
                                   
            

COMMIT;
END;


PROCEDURE SE026_DM_PASS_ACCIO IS
BEGIN

             INSERT INTO A1_DM_PAS_ACCIO (ID,CODI,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE,DESCRIPCIO,TIPUS_ACCIO_ID) 
						 VALUES ('1','PETICIO',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,'1','Peticio','3');
             INSERT INTO A1_DM_PAS_ACCIO (ID,CODI,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE,DESCRIPCIO,TIPUS_ACCIO_ID) 
						 VALUES ('2','REALITZACIO',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,'2','Realització','3');
             INSERT INTO A1_DM_PAS_ACCIO (ID,CODI,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE,DESCRIPCIO,TIPUS_ACCIO_ID) 
						 VALUES ('3','RESOLUCIO',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,'3','Resolució','3');

             INSERT INTO A1_DM_PAS_ACCIO (ID,CODI,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE,DESCRIPCIO,TIPUS_ACCIO_ID) 
						 VALUES ('4','REALITZACIO',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,'1','Realització','5');
						 
             INSERT INTO  A1_DM_PAS_ACCIO (ID,CODI,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE,DESCRIPCIO,TIPUS_ACCIO_ID) 
						 VALUES ('5','PETICIO',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,'1','Petició','6');
             INSERT INTO  A1_DM_PAS_ACCIO (ID,CODI,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE,DESCRIPCIO,TIPUS_ACCIO_ID) 
						 VALUES ('6','REALITZACIO',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,'2','Realització','6');
COMMIT;
END;

PROCEDURE SE027_TRANSICIO_TRAMITACIO IS
BEGIN

  Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('11','16','16','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('12','16','17','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('13','16','7','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('14','16','11','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('15','16','28','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('1','28','16','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('17','17','17','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('2','28','17','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('3','28','7','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('4','28','11','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('5','28','28','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('16','17','16','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('18','17','7','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('19','17','11','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('20','17','28','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('26','11','16','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('27','11','17','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('28','11','7','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('29','11','11','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('30','11','28','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('21','7','16','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('22','7','17','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('23','7','7','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('24','7','11','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                Insert into A1_TRANSICIO_TRAMITACIO (ID,ACCIO_ORIGEN_ID,ACCIO_DESTI_ID,AMBIT_ID,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
						 VALUES ('25','7','28','1',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
                commit;

COMMIT;
END;


PROCEDURE SE030_DM_DESTI_DELEGACIO IS
BEGIN

            INSERT INTO Z_SE999_DM_DESTI_DELEGACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                     SELECT A1_SEQ_DM_DESTI_DELEGACIO.NEXTVAL AS ID, 
                            SUBSTR(DESCRIPCIO,1,50),
                            DATA_CREACIO, 
                            DATA_MODIFICACIO, 
                            DATA_ESBORRAT, 
                            USUARI_CREACIO, 
                            USUARI_MODIFICACIO, 
                            USUARI_ESBORRAT, 
                            AMBIT_ID, 
                            DELEGACIOID AS ID_ORIGINAL, 
                            'RISPLUS' AS ESQUEMA_ORIGINAL , 
                            'DELEGACIO' AS TABLA_ORIGINAL,
                            ConstInstalacioAlcaldia AS INSTALACIOID
                     FROM (     
                                    SELECT DELEGACIOID AS DELEGACIOID,
                                           NOM AS DESCRIPCIO, 
                                           SYSDATE AS DATA_CREACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                           ConstAMBIT_ALCALDIA AS AMBIT_ID       
                                    FROM Z_T_RP_DELEGACIO DELEGACIO
                                   WHERE DELEGACIO.InstalacioID IN (ConstInstalacioAlcaldia)
                          ) NUEVOS    
                        WHERE NOT EXISTS (SELECT 1
                                           FROM Z_SE999_DM_DESTI_DELEGACIO ANTIGUOS
                                          WHERE  ANTIGUOS.ID = NUEVOS.DELEGACIOID 
                                           AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                         );                                      
                               
          
               
            COMMIT;

                    INSERT INTO A1_DM_DESTI_DELEGACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      DATA_CREACIO, 
                                      DATA_MODIFICACIO, 
                                      DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                                      AMBIT_ID, 
                                      ID_ORIGINAL, 
                                      ESQUEMA_ORIGINAL , 
                                      TABLA_ORIGINAL,
                                      INSTALACIOID
                                 FROM Z_SE999_DM_DESTI_DELEGACIO NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM A1_DM_DESTI_DELEGACIO ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                     AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );                 

COMMIT;
END;


--Preguntar por el
PROCEDURE SE031_DM_TIPUS_ELEMENT IS
BEGIN 
    INSERT INTO Z_SE999_DM_TIPUS_ELEMENT (ID, DESCRIPCIO,  DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                 SELECT A1_SEQ_DM_TIPUS_ELEMENT.NEXTVAL AS ID, 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_MODIFICACIO, 
                        DATA_ESBORRAT, 
                        USUARI_CREACIO, 
                        USUARI_MODIFICACIO, 
                        USUARI_ESBORRAT, 
                        AMBIT_ID, 
                        TIPUSTEMAELEMENTPRINCIPALID AS ID_ORIGINAL, 
                        'RISPLUS' AS ESQUEMA_ORIGINAL , 
                        'TIPUSTEMAELEMENTPRINCIP' AS TABLA_ORIGINAL,
                        ConstInstalacioAlcaldia AS INSTALACIOID
                 FROM (  
                        SELECT TIPUSTEMAELEMENTPRINCIPALID AS TIPUSTEMAELEMENTPRINCIPALID,
                               substr(NOM,1,25) AS DESCRIPCIO, 
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               ConstAMBIT_ALCALDIA AS AMBIT_ID       
                        FROM Z_T_RP_TIPUSTEMAELEMENTPRINCIP TIPUSELEMENT
                        WHERE TIPUSELEMENT.INSTALACIOID IN (ConstInstalacioAlcaldia)	
                     		    ) NUEVOS    
                WHERE NOT EXISTS (SELECT 1
                                    FROM Z_SE999_DM_TIPUS_ELEMENT ANTIGUOS
                                   WHERE  ANTIGUOS.ID_ORIGINAL = NUEVOS.TIPUSTEMAELEMENTPRINCIPALID 
                                     AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                 );     

        COMMIT;                                  
                                  
        INSERT INTO A1_DM_TIPUS_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                   SELECT ID, 
                          DESCRIPCIO, 
                          DATA_CREACIO, 
                          DATA_MODIFICACIO, 
                          DATA_ESBORRAT, 
                          USUARI_CREACIO, 
                          USUARI_MODIFICACIO,                       		  
                          USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                          AMBIT_ID, 
                          ID_ORIGINAL, 
                          ESQUEMA_ORIGINAL , 
                          TABLA_ORIGINAL,
                          INSTALACIOID
                     FROM Z_SE999_DM_TIPUS_ELEMENT NUEVOS                     
                    WHERE NUEVOS.AMBIT_ID<>99
                      AND NOT EXISTS  (SELECT 1 
                                         FROM A1_DM_TIPUS_ELEMENT ANTIGUOS
                                        WHERE ANTIGUOS.ID = NUEVOS.ID
                                         AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID                                         
                                       );     
                              
        COMMIT;


/*este es el tipus de tema 
        INSERT INTO Z_SE999_DM_TIPUS_ELEMENT (ID, DESCRIPCIO,  DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID)
                SELECT A1_SEQ_DM_TIPUS_ELEMENT.NEXTVAL AS ID,
                       TipusElement DESCRIPCIO, 
                       SYSDATE AS DATA_CREACIO,
				       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                       Ambit_ID AS AMBIT_ID
                FROM (
                       SELECT TipusElement TipusElement, 
                       		  Ambit_ID AS AMBIT_ID
    	                 FROM (	   
				                            SELECT Tipus AS TipusElement, 
				                            (SELECT AMBIT.AMBIT_ID FROM Z_SE002_INSTALACIO_AMBIT_PART AMBIT WHERE AMBIT.INSTALACIOID = Tipus_Elemetns.InstalacioID) AS AMBIT_ID 
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
                                     FROM Z_SE999_DM_TIPUS_ELEMENT ANTIGUOS  
                                    WHERE FINAL_GROUP.TipusElement = ANTIGUOS.DESCRIPCIO
                                      AND FINAL_GROUP.AMBIT_ID = ANTIGUOS.AMBIT_ID
                                 );
        COMMIT;                                  
                                  
        INSERT INTO A1_DM_TIPUS_ELEMENT
                    SELECT * FROM Z_SE999_DM_TIPUS_ELEMENT;
                                  
                              
        COMMIT;
*/        
END;

PROCEDURE SE032_DM_DECISIO_AGENDA IS
BEGIN

        INSERT INTO Z_SE999_DM_DECISIO_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                 SELECT A1_SEQ_DM_DECISIO_AGENDA.NEXTVAL AS  ID, 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_MODIFICACIO, 
                        DATA_ESBORRAT, 
                        USUARI_CREACIO, 
                        USUARI_MODIFICACIO, 
                        USUARI_ESBORRAT, 
                        AMBIT_ID, 
                        DECISIOID AS ID_ORIGINAL, 
                        'RISPLUS' AS ESQUEMA_ORIGINAL , 
                        'DECISIO' AS TABLA_ORIGINAL,
                        ConstInstalacioAlcaldia AS INSTALACIOID
                 FROM (     
                                    SELECT DECISIOID AS DECISIOID,
                                           NOM AS DESCRIPCIO, 
                                           SYSDATE AS DATA_CREACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                           ConstAMBIT_ALCALDIA AS AMBIT_ID       
                                    FROM Z_T_RP_DECISIO DECISIO
                                    WHERE DECISIO.INSTALACIOID IN (ConstInstalacioAlcaldia)		
                       ) NUEVOS    
                                WHERE NOT EXISTS (SELECT 1
                                                   FROM Z_SE999_DM_DECISIO_AGENDA ANTIGUOS
--                                                  WHERE  ANTIGUOS.ID = NUEVOS.ID 
                                                  WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                                   AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                                                 );                                        
                                                     
                                                     
        COMMIT;
        
        
        
        INSERT INTO A1_DM_DECISIO_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID,CODI)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      DATA_CREACIO, 
                                      DATA_MODIFICACIO, 
                                      DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                                      AMBIT_ID, 
                                      ID_ORIGINAL, 
                                      ESQUEMA_ORIGINAL , 
                                      TABLA_ORIGINAL,
                                      INSTALACIOID,
                                      UPPER(DESCRIPCIO)
                                 FROM Z_SE999_DM_DECISIO_AGENDA NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM A1_DM_DECISIO_AGENDA ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                                     AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );                 
        
END;





PROCEDURE SE033_DM_PRIORITAT_ELEMENT IS
BEGIN

       INSERT INTO Z_SE999_DM_PRIORITAT_ELEMENT (ID, PRIORITATID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                                    SELECT A1_SEQ_DM_PRIORITAT_ELEMENT.NEXTVAL AS ID,
                                           PRIORITATID AS PRIORITATID,
                                           NOM AS DESCRIPCIO, 
                                           SYSDATE AS DATA_CREACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                           AMBIT_ID, 
                                           PRIORITATID AS ID_ORIGINAL, 
                                           'RISPLUS' AS ESQUEMA_ORIGINAL , 
                                           'PRIORITAT' AS TABLA_ORIGINAL,
                                           NULL AS INSTALACIOID
                                    FROM Z_T_RP_PRIORITAT PRIORITAT,                                    
                                         Z_SE003_AMBITS                                     
                                    WHERE NOT EXISTS (SELECT 1
                                                       FROM Z_SE999_DM_PRIORITAT_ELEMENT ANTIGUOS
                                                      WHERE  ANTIGUOS.ID = PRIORITAT.PRIORITATID                                                        
                                                     );    
        COMMIT;
    
        INSERT INTO A1_DM_PRIORITAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                               SELECT ID, 
                                      DESCRIPCIO, 
                                      DATA_CREACIO, 
                                      DATA_MODIFICACIO, 
                                      DATA_ESBORRAT, 
                                      USUARI_CREACIO, 
                                      USUARI_MODIFICACIO,                       		  
                                      USUARI_ESBORRAT AS USUARI_ESBORRAT,
                                      AMBIT_ID AS AMBIT_ID, 
                                      ID_ORIGINAL, 
                                      ESQUEMA_ORIGINAL , 
                                      TABLA_ORIGINAL,
                                      INSTALACIOID
                                 FROM Z_SE999_DM_PRIORITAT_ELEMENT NUEVOS
                                WHERE NOT EXISTS  (SELECT 1 
                                                     FROM A1_DM_PRIORITAT_ELEMENT ANTIGUOS
                                                    WHERE ANTIGUOS.ID = NUEVOS.ID                                                     
                                                   );                 
    
    

COMMIT;
END;


PROCEDURE SE034_DM_PREFIX_ANY IS
BEGIN

     INSERT INTO Z_SE999_DM_PREFIX_ANY (ID, DESCRIPCIO,CONTADOR, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
         SELECT A1_SEQ_DM_PREFIX_ANY.NEXTVAL AS  ID, 
                DESCRIPCIO, 
                CONTADOR,
                DATA_CREACIO, 
                DATA_MODIFICACIO, 
                FUNC_FECHA_CREACIO(NULL) AS DATA_ESBORRAT, 
                USUARI_CREACIO, 
                USUARI_MODIFICACIO, 
                'MIGRACIO' AS USUARI_ESBORRAT, 
                AMBIT_ID,
                PREFIXDOSSIERID as ID_ORIGINAL,
                'RISPLUS' as ESQUEMA_ORIGINAL,
                'PREFIXDOSSIER' AS TABLA_ORIGINAL,
                ConstInstalacioAlcaldia AS INSTALACIOID
         FROM (     
                      SELECT PREFIXDOSSIERID AS PREFIXDOSSIERID,
                           PREFIX AS DESCRIPCIO, 
                           ULTIMNUMERO AS CONTADOR,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                           ConstAMBIT_ALCALDIA AS AMBIT_ID,
                           ROW_NUMBER ()  OVER (PARTITION BY PREFIX ORDER BY PREFIXDOSSIERID DESC ) AS COLNUM
                    FROM Z_T_RP_PREFIXDOSSIER PREFIXDOSSIER
--                    WHERE PREFIXDOSSIER.INSTALACIOID IN (ConstInstalacioAlcaldia)	/*ANULADO TEMPORALMENTE : PARA DOSSIER UTILIZAN ID DE INSTALACION 25 */
                ) NUEVOS    
            WHERE COLNUM=1
              AND NOT EXISTS (SELECT 1
                               FROM Z_SE999_DM_PREFIX_ANY ANTIGUOS
                              WHERE  ANTIGUOS.ID_ORIGINAL = NUEVOS.PREFIXDOSSIERID 
                               AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                             );    
         COMMIT;                    
                             
       INSERT INTO A1_DM_PREFIX_ANY (ID, DESCRIPCIO, CONTADOR, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
             SELECT ID, 
                    DESCRIPCIO, 
                    CONTADOR,
                    DATA_CREACIO, 
                    DATA_MODIFICACIO, 
                    DATA_ESBORRAT, 
                    USUARI_CREACIO, 
                    USUARI_MODIFICACIO, 
                    USUARI_ESBORRAT, 
                    AMBIT_ID,
                    ID_ORIGINAL,
                    ESQUEMA_ORIGINAL,
                    TABLA_ORIGINAL,
                    INSTALACIOID
               FROM Z_SE999_DM_PREFIX_ANY NUEVOS
              WHERE NOT EXISTS (SELECT 1 
                                  FROM A1_DM_PREFIX_ANY ANTIGUOS
                                 WHERE  ANTIGUOS.ID = NUEVOS.ID
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                               );    
           
       /* MARCOS : HAY QUE CREAR UN REGISTRO NUEVO EN DONDE LA DESCRIPCIÓN SEA 2018, CON FECHA DE CREACIÓN Y USUARIO DE CREACIÓN ¿CUÁL? PUES EN TEORÍA EL USUARIO QUE LO CREA (P469047)....*/
       
    INSERT INTO A1_DM_PREFIX_ANY (ID, DESCRIPCIO, CONTADOR, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                VALUES(A1_SEQ_DM_PREFIX_ANY.NEXTVAL, '2108', 0, SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,ConstAMBIT_ALCALDIA, '', '', '', '');


COMMIT;
END;


PROCEDURE SE035_DM_TIPUS_SUPORT IS
BEGIN

     INSERT INTO Z_SE999_DM_TIPUS_SUPORT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
         SELECT TIPUSSUPORTID AS ID, 
                TIPUSSUPORTID AS CODI, 
                DESCRIPCIO AS DESCRIPCIO, 
                DATA_CREACIO, 
                DATA_MODIFICACIO, 
                DATA_ESBORRAT, 
                USUARI_CREACIO, 
                USUARI_MODIFICACIO, 
                USUARI_ESBORRAT, 
                AMBIT_ID, 
                TIPUSSUPORTID AS ID_ORIGINAL, 
                'RISPLUS' AS ESQUEMA_ORIGINAL, 
                'TIPUSSUPORT' AS TABLA_ORIGINAL, 
                ConstInstalacioAlcaldia AS INSTALACIOID
         FROM (     
                      SELECT TIPUSSUPORTID AS TIPUSSUPORTID,
                           NOM AS DESCRIPCIO, 
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                           FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                           FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                           ConstAMBIT_ALCALDIA AS AMBIT_ID    
                    FROM Z_T_RP_TIPUSSUPORT TIPUSSUSPORT
                    WHERE TIPUSSUSPORT.INSTALACIOID IN (ConstInstalacioAlcaldia)	
                ) NUEVOS    
            WHERE NOT EXISTS (SELECT 1
                               FROM Z_SE999_DM_TIPUS_SUPORT ANTIGUOS
                              WHERE  ANTIGUOS.ID_ORIGINAL = NUEVOS.TIPUSSUPORTID 
                               AND  ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                             );    
           COMMIT;
           
           
            INSERT INTO A1_DM_TIPUS_SUPORT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                                 SELECT A1_SEQ_DM_TIPUS_SUPORT.NEXTVAL AS ID, 
                                        CODI,
                                        DESCRIPCIO, 
                                        DATA_CREACIO, 
                                        DATA_MODIFICACIO, 
                                        DATA_ESBORRAT, 
                                        USUARI_CREACIO, 
                                        USUARI_MODIFICACIO, 
                                        USUARI_ESBORRAT, 
                                        AMBIT_ID , 
                                        ID_ORIGINAL, 
                                        ESQUEMA_ORIGINAL, 
                                        TABLA_ORIGINAL, 
                                        INSTALACIOID
                                   FROM Z_SE999_DM_TIPUS_SUPORT NUEVOS
                                  WHERE NUEVOS.AMBIT_ID <>99
                                    AND NOT EXISTS (SELECT 1 
                                                      FROM A1_DM_TIPUS_SUPORT ANTIGUOS
                                                     WHERE  ANTIGUOS.ID = NUEVOS.ID
                                                       AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                                   );           
   

            COMMIT;
END;

--LOS AMBITOS COINCIDEN (MENOS MAL) ENTRE SERIE Y SUBSERIE
PROCEDURE SE040_SERIESSUBSERIES IS
BEGIN

   INSERT INTO Z_SE040_SERIES_SUBSERIES (ID, SERIEID, SUBSERIEID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
              SELECT A1_SEQ_SERIE_SUBSERIE.NEXTVAL AS ID, 
                     SERIEID, 
                     SUBSERIEID, 
                     DESCRIPCIO, 
                     DATA_CREACIO, 
                     DATA_MODIFICACIO, 
                     DATA_ESBORRAT, 
                     USUARI_CREACIO, 
                     USUARI_MODIFICACIO, 
                     USUARI_ESBORRAT, 
                     AMBIT_ID,
--                     (SERIEID || ' | ' || SUBSERIEID) AS ID_ORIGINAL, 
                     SERIEID AS ID_ORIGINAL, 
                     'RISPLUS' AS ESQUEMA_ORIGINAL , 
                     'SERIES // SUBSERIES'  AS TABLA_ORIGINAL,
                     ConstInstalacioAlcaldia AS INSTALACIOID
              FROM (                                
                        SELECT  SERIE.SERIEID, 
                                SUBSERIE.SUBSERIEID, 
                                (SERIE.NOM || '//' || SUBSERIE.NOM) AS DESCRIPCIO ,
                                 FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                 FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                 FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                 FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                 ConstAMBIT_ALCALDIA AS AMBIT_ID   
                           FROM Z_T_RP_SERIES SERIE,
                                Z_T_RP_SUBSERIES SUBSERIE
                          WHERE SERIE.SERIEID = SUBSERIE.SERIEID
                            AND SERIE.INSTALACIOID IN (ConstInstalacioAlcaldia)	
                     ) NUEVOS     
               WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_SE040_SERIES_SUBSERIES ANTIGUOS
                                WHERE ANTIGUOS.SERIEID = NUEVOS.SERIEID
                                  AND ANTIGUOS.SUBSERIEID = NUEVOS.SUBSERIEID
                                  AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                );




COMMIT;
END;

PROCEDURE SE041_DM_SERIES IS
BEGIN

      INSERT INTO A1_DM_SERIE (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
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
                         AMBIT_ID, 
                         ID_ORIGINAL, 
                         ESQUEMA_ORIGINAL , 
                         TABLA_ORIGINAL,
                         INSTALACIOID
                    FROM Z_SE040_SERIES_SUBSERIES NUEVOS
                   WHERE NOT EXISTS (SELECT 1 
                                       FROM A1_DM_SERIE ANTIGUOS
                                      WHERE NUEVOS.DESCRIPCIO = ANTIGUOS.DESCRIPCIO
                                       AND NUEVOS.AMBIT_ID = ANTIGUOS.AMBIT_ID
                                     );


COMMIT;
END;

PROCEDURE SE042_DM_CATALEG_DOCUMENT IS
BEGIN

     INSERT INTO Z_SE042_DM_CATALEG_DOCUMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)               
                         SELECT  A1_SEQ_DM_CATALEG_DOCUMENT.NEXTVAL AS ID, 
                                 NOM AS DESCRIPCIO ,
                                 FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                 FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                 FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                 FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                 FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                 ConstAMBIT_ALCALDIA AS AMBIT_ID,
                                 TIPUSANNEXID AS ID_ORIGINAL,
                                 'RISPLUS' AS ESQUEMA_ORIGINAL,
                                 'TIPUSANNEX' AS TABLA_ORIGINAL,
                                 ConstInstalacioAlcaldia AS INSTALACIOID
                           FROM Z_T_RP_TIPUSANNEX NUEVOS     
               WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_SE042_DM_CATALEG_DOCUMENT ANTIGUOS
                                WHERE ANTIGUOS.ID = NUEVOS.TIPUSANNEXID
                                );

      COMMIT;
      
      INSERT INTO A1_DM_CATALEG_DOCUMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
               SELECT ID, 
                      DESCRIPCIO, 
                      DATA_CREACIO, 
                      DATA_ESBORRAT, 
                      DATA_MODIFICACIO, 
                      USUARI_CREACIO, 
                      USUARI_ESBORRAT, 
                      USUARI_MODIFICACIO, 
                      AMBIT_ID, 
                      ID_ORIGINAL, 
                      ESQUEMA_ORIGINAL, 
                      TABLA_ORIGINAL, 
                      INSTALACIOID
                 FROM Z_SE042_DM_CATALEG_DOCUMENT NUEVOS 
                WHERE NOT EXISTS (SELECT *
                                    FROM A1_DM_CATALEG_DOCUMENT ANTIGUOS
                                   WHERE ANTIGUOS.ID = NUEVOS.ID
                                 ) ;

COMMIT;
END;


--OJO EL CONTADOR SE ACTUALIZARÁ DE CONTINUO. ¡UPDATE!
PROCEDURE SE043_DM_PREFIX IS
BEGIN


      INSERT INTO Z_SE043_DM_PREFIX (ID, DESCRIPCIO, CONTADOR,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
         SELECT A1_SEQ_DM_PREFIX.NEXTVAL AS ID, 
                DESCRIPCIO AS DESCRIPCIO, 
                NVL(CONTADOR,0) AS CONTADOR,
                DATA_CREACIO AS DATA_CREACIO, 
                DATA_MODIFICACIO AS DATA_MODIFICACIO, 
                DATA_ESBORRAT AS DATA_ESBORRAT, 
                USUARI_CREACIO AS USUARI_CREACIO, 
                USUARI_MODIFICACIO AS USUARI_MODIFICACIO, 
                USUARI_ESBORRAT AS USUARI_ESBORRAT, 
                AMBIT_ID AS AMBIT_ID, 
                NUMEROREGISTREPREFIXID AS ID_ORIGINAL, 
                'RISPLUS' AS ESQUEMA_ORIGINAL , 
                'NUMEROSREGISTREPREFIX' AS TABLA_ORIGINAL,
                ConstInstalacioAlcaldia AS INSTALACIOID
          FROM (                                
                     SELECT NUMEROREGISTREPREFIXID AS NUMEROREGISTREPREFIXID,
                            PREFIX AS DESCRIPCIO,
                            ULTIMNUMERO AS CONTADOR,
                            SYSDATE AS DATA_CREACIO,
                            FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                            FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                            FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                            FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                            ConstAMBIT_ALCALDIA AS AMBIT_ID   
                       FROM Z_T_RP_NUMEROSREGISTREPREFIX PREFIX
                       WHERE PREFIX.InstalacioID IN (ConstInstalacioAlcaldia) --ojo INSTALACION ID 12 PERTENEDCE A LA PATRICIA y el 15 es de pruebas
                 ) NUEVOS      
          WHERE NOT EXISTS (SELECT 1
                             FROM Z_SE043_DM_PREFIX ANTIGUOS
                            WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.NUMEROREGISTREPREFIXID
                              AND ANTIGUOS.AMBIT_ID=NUEVOS.AMBIT_ID
                           );    

        COMMIT;
        
           INSERT INTO A1_DM_PREFIX (ID, DESCRIPCIO, CONTADOR,DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
              SELECT ID, 
                     DESCRIPCIO, 
                     CONTADOR,
                     DATA_CREACIO, 
                     DATA_MODIFICACIO, 
                     DATA_ESBORRAT, 
                     USUARI_CREACIO, 
                     USUARI_MODIFICACIO, 
                     USUARI_ESBORRAT, 
                     AMBIT_ID, 
                     ID_ORIGINAL, 
                     ESQUEMA_ORIGINAL , 
                     TABLA_ORIGINAL,
                     INSTALACIOID
                FROM Z_SE043_DM_PREFIX NUEVOS
               WHERE NOT EXISTS (SELECT *
                                   FROM A1_DM_PREFIX ANTIGUOS
                                  WHERE ANTIGUOS.ID = NUEVOS.ID
                                    AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                 );
                                 


COMMIT;
END;

/*
PROCEDURE SE044_ANNEX_REGISTRE IS
BEGIN
    
        


COMMIT:
END;
*/

/*
PROCEDURE SE050_ESTAT_ELEMENT IS
BEGIN

     --CREATE TABLE Z_SE050_ESTAT_ELEMENT AS SELECT * FROM Z_SE060_PAS_ACCIO WHERE ROWNUM=0
     INSERT INTO Z_SE050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(1, 'REGISTRE INICIAL');

      INSERT INTO Z_SE050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(2, 'DISTRIBUCIO');
  
      INSERT INTO Z_SE050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(3, 'GESTIO');
                
      INSERT INTO Z_SE050_ESTAT_ELEMENT (ID, DESCRIPCIO)
                VALUES(4, 'CONCLUSIO');
COMMIT;
END;

PROCEDURE SE051_DM_ESTAT_ELEMENT IS
BEGIN

        INSERT INTO Z_SE999_DM_ESTAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT A1_SEQ_DM_ESTAT_ELEMENT.NEXTVAL AS ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARI_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_SE050_ESTAT_ELEMENT,
                                Z_SE003_AMBITS 
                      ) ESTAT_ELEMENT
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_SE999_DM_ESTAT_ELEMENT ANTIGUOS
                                 WHERE ANTIGUOS.ID =ESTAT_ELEMENT.ID
                                   AND ANTIGUOS.AMBIT_ID =ESTAT_ELEMENT.AMBIT_ID
                               );    

            COMMIT;
            
            
            INSERT INTO A1_DM_ESTAT_ELEMENT
                SELECT ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM Z_SE999_DM_ESTAT_ELEMENT NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM A1_DM_ESTAT_ELEMENT ANTIGUOS
                                 WHERE ANTIGUOS.ID = NUEVOS.ID 
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                               );  
            

COMMIT;
END;
*/



/*
PROCEDURE SE060_PAS_ACCIO IS
BEGIN

    --CREATE TABLE Z_SE060_PAS_ACCIO AS SELECT * FROM Z_SE060_PAS_ACCIO WHERE ROWNUM=0
     INSERT INTO Z_SE060_PAS_ACCIO (ID, DESCRIPCIO) VALUES(1, 'Petició');
     INSERT INTO Z_SE060_PAS_ACCIO (ID, DESCRIPCIO) VALUES(2, 'Realització');
     INSERT INTO Z_SE060_PAS_ACCIO (ID, DESCRIPCIO) VALUES(3, 'Resolució');

COMMIT;
END;
*/
/* OBSOLETO :
PROCEDURE SE061_DM_PAS_ACCIO IS
BEGIN

     INSERT INTO Z_SE061_DM_PAS_ACCIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, TIPUS_ACCIO_ID,CODI)
            SELECT  A1_SEQ_DM_PAS_ACCIO.NEXTVAL AS  ID, 
                    FUNC_DESCRIPCIO(DESCRIPCIO) AS DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_MODIFICACIO, 
                    DATA_ESBORRAT, 
                    USUARI_CREACIO, 
                    USUARI_MODIFICACIO, 
                    USUARI_ESBORRAT, 
                    AMBIT_ID, 
                    TIPUS_ACCIO,
                    UPPER(DESCRIPCIO) AS CODI
              FROM (      
                        SELECT ACCIO.ID,
                               ACCIO.DESCRIPCIO,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,     
                               TIPUS.AMBIT_ID AS AMBIT_ID,
                               TIPUS.ID AS TIPUS_ACCIO
                          FROM A1_DM_TIPUS_ACCIO TIPUS,
                               Z_SE060_PAS_ACCIO ACCIO
                               
                    ) COMBINADOS           
             WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_SE061_DM_PAS_ACCIO ANTIGUOS
                                WHERE ANTIGUOS.ID = COMBINADOS.ID
                                  AND ANTIGUOS.AMBIT_ID = COMBINADOS.AMBIT_ID
                                  AND ANTIGUOS.TIPUS_ACCIO_ID = COMBINADOS.TIPUS_ACCIO
                               );

      COMMIT;
      
             INSERT INTO A1_DM_PAS_ACCIO
                         SELECT *
                           FROM Z_SE061_DM_PAS_ACCIO NUEVOS
                          WHERE NOT EXISTS (SELECT 1 
                                             FROM A1_DM_PAS_ACCIO ANTIGUOS
                                            WHERE ANTIGUOS.ID = NUEVOS.ID
                                              AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                              AND ANTIGUOS.TIPUS_ACCIO_ID = NUEVOS.TIPUS_ACCIO_ID
                                           ); 
     
COMMIT;
END;
*/


/*
PROCEDURE SE070_TIPUS_AGENDA IS
BEGIN

    --CREATE TABLE Z_SE070_TIPUS_AGENDA AS SELECT * FROM Z_SE060_PAS_ACCIO WHERE ROWNUM=0
    INSERT INTO Z_SE070_TIPUS_AGENDA (ID, DESCRIPCIO)
            VALUES(1, 'CONCRETA');
     INSERT INTO Z_SE070_TIPUS_AGENDA (ID, DESCRIPCIO)
                VALUES(2, 'RANG');
     INSERT INTO Z_SE070_TIPUS_AGENDA (ID, DESCRIPCIO)
                VALUES(3, 'PROVISIONAL');
     INSERT INTO Z_SE070_TIPUS_AGENDA (ID, DESCRIPCIO)
                VALUES(4, 'PENDENT');

COMMIT;
END;


PROCEDURE SE071_DM_TIPUS_AGENDA IS
BEGIN

        INSERT INTO Z_SE999_DM_TIPUS_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT A1_SEQ_DM_TIPUS_AGENDA.NEXTVAL AS ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARI_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_SE070_TIPUS_AGENDA,
                                Z_SE003_AMBITS 
                      ) TIPUS_AGENDA
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_SE999_DM_TIPUS_AGENDA ANTIGUOS
                                 WHERE ANTIGUOS.ID =TIPUS_AGENDA.ID
                                   AND ANTIGUOS.AMBIT_ID =TIPUS_AGENDA.AMBIT_ID
                               );    

            COMMIT;
            
            
            INSERT INTO A1_DM_TIPUS_AGENDA
                SELECT ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM Z_SE999_DM_TIPUS_AGENDA NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM A1_DM_TIPUS_AGENDA ANTIGUOS
                                 WHERE ANTIGUOS.ID = NUEVOS.ID 
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                               );  
            

COMMIT;
END;
*/

/*
PROCEDURE SE080_ORIGEN_ELEMENT IS
BEGIN
    --CREATE TABLE Z_SE080_ORIGEN_ELEMENT AS SELECT * FROM Z_SE060_PAS_ACCIO  WHERE rownum=0
    
    INSERT INTO Z_SE080_ORIGEN_ELEMENT (ID, DESCRIPCIO)
                VALUES(1, 'CONCRETA');
    INSERT INTO Z_SE080_ORIGEN_ELEMENT (ID, DESCRIPCIO)
                VALUES(2, 'RANG');           

COMMIT;
END;


PROCEDURE SE081_DM_ORIGEN_ELEMENT IS
BEGIN


          INSERT INTO Z_SE999_DM_ORIGEN_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT A1_SEQ_DM_ORIGEN_ELEMENT.NEXTVAL as  ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARI_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_SE080_ORIGEN_ELEMENT,
                                Z_SE003_AMBITS 
                      ) ORIGEN_ELEMENT
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_SE999_DM_ORIGEN_ELEMENT ANTIGUOS
                                 WHERE ANTIGUOS.ID =ORIGEN_ELEMENT.ID
                                   AND ANTIGUOS.AMBIT_ID =ORIGEN_ELEMENT.AMBIT_ID
                               );  

            COMMIT;   
    
            --CREATE TABLE  A1_DM_ORIGEN_ELEMENT AS SELECT * FROM DM_ORIGEN_ELEMENT WHERE ROWNUM=0
           INSERT INTO A1_DM_ORIGEN_ELEMENT 
                    SELECT * 
                      FROM Z_SE999_DM_ORIGEN_ELEMENT NUEVOS
                     WHERE NOT EXISTS (SELECT 1
                                         FROM A1_DM_ORIGEN_ELEMENT ANTIGUOS
                                        WHERE ANTIGUOS.ID = NUEVOS.ID
                                          AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                       );
                               
COMMIT;
END;
*/
/*
PROCEDURE SE090_TIPUS_ARG IS
BEGIN
    
    INSERT INTO Z_SE090_TIPUS_ARG (ID, DESCRIPCIO)
                VALUES(1, 'A');
    INSERT INTO Z_SE090_TIPUS_ARG (ID, DESCRIPCIO)
                VALUES(2, 'R');               
    INSERT INTO Z_SE090_TIPUS_ARG (ID, DESCRIPCIO)
                VALUES(3, 'G');

COMMIT;
END;
*/

PROCEDURE SE090_DM_TIPUS_ARG IS
BEGIN

    INSERT INTO Z_SE999_DM_TIPUS_ARG (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
             SELECT A1_SEQ_DM_TIPUS_ARG.NEXTVAL  AS ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID, 
                    CAMPSESPECIALS_ID AS ID_ORIGINAL, 
                    'RISPLUS' AS ESQUEMA_ORIGINAL , 
                    'CAMPSESPECIALS_TAULA2' AS TABLA_ORIGINAL,
                    ConstInstalacioAlcaldia AS INSTALACIOID
               FROM (     
                         SELECT ID AS CAMPSESPECIALS_ID,
                                NOM AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARI_ESBORRAT,     
                                ConstAMBIT_ALCALDIA AS AMBIT_ID
                           FROM Z_T_RP_CAMPSESPECIALS_TAULA2
                          WHERE  INSTALACIOID = ConstInstalacioAlcaldia 
                      ) TIPUS_ARG
              WHERE  NOT EXISTS (SELECT 1
                                  FROM Z_SE999_DM_TIPUS_ARG ANTIGUOS
                                 WHERE ANTIGUOS.ID_ORIGINAL =TIPUS_ARG.CAMPSESPECIALS_ID
                                   AND ANTIGUOS.AMBIT_ID =TIPUS_ARG.AMBIT_ID
                               );

            COMMIT;   


           --CREATE TABLE A1_DM_TIPUS_ARG AS SELECT * FROM DM_ORIGEN_ELEMENT WHERE ROWNUM=0
           INSERT INTO A1_DM_TIPUS_ARG (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                    SELECT ID, 
                           DESCRIPCIO, 
                           DATA_CREACIO, 
                           DATA_ESBORRAT, 
                           DATA_MODIFICACIO, 
                           USUARI_CREACIO, 
                           USUARI_ESBORRAT, 
                           USUARI_MODIFICACIO,
                           AMBIT_ID, 
                           ID_ORIGINAL, 
                           ESQUEMA_ORIGINAL , 
                           TABLA_ORIGINAL,
                           INSTALACIOID
                      FROM Z_SE999_DM_TIPUS_ARG NUEVOS
                     WHERE NOT EXISTS (SELECT 1
                                         FROM A1_DM_TIPUS_ARG ANTIGUOS
                                        WHERE ANTIGUOS.ID = NUEVOS.ID
                                          AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID
                                       );

COMMIT;
END;
/*

PROCEDURE SE100_TIPUS_DATA IS
BEGIN

    --CREATE TABLE Z_SE100_TIPUS_DATA AS SELECT * FROM Z_SE060_PAS_ACCIO WHERE ROWNUM=0
    INSERT INTO Z_SE100_TIPUS_DATA (ID, DESCRIPCIO)
            VALUES(1, 'CONCRETA');
     INSERT INTO Z_SE100_TIPUS_DATA (ID, DESCRIPCIO)
                VALUES(2, 'RANG');
     INSERT INTO Z_SE100_TIPUS_DATA (ID, DESCRIPCIO)
                VALUES(3, 'PROVISIONAL');
     INSERT INTO Z_SE100_TIPUS_DATA (ID, DESCRIPCIO)
                VALUES(4, 'PENDENT');

COMMIT;
END;


PROCEDURE SE101_DM_TIPUS_DATA IS
BEGIN
        --CREATE TABLE Z_SE999_DM_TIPUS_DATA AS SELECT * FROM Z_SE999_DM_TIPUS_ARG WHERE ROWNUM=0
        INSERT INTO Z_SE999_DM_TIPUS_DATA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,AMBIT_ID)
             SELECT A1_SEQ_DM_TIPUS_DATA.NEXTVAL AS ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM (     
                         SELECT ID AS ID,
                                DESCRIPCIO AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_STRING() AS USUARI_ESBORRAT,     
                                AMBIT_ID AS AMBIT_ID
                           FROM Z_SE100_TIPUS_DATA,
                                Z_SE003_AMBITS 
                      ) TIPUS_DATA
              WHERE NOT EXISTS (SELECT 1
                                  FROM Z_SE999_DM_TIPUS_DATA ANTIGUOS
                                 WHERE ANTIGUOS.ID =TIPUS_DATA.ID
                                   AND ANTIGUOS.AMBIT_ID =TIPUS_DATA.AMBIT_ID
                               );    

            COMMIT;
            
             --CREATE TABLE A1_DM_TIPUS_DATA AS SELECT * FROM DM_ORIGEN_ELEMENT WHERE ROWNUM=0
            INSERT INTO A1_DM_TIPUS_DATA
                SELECT ID, 
                    DESCRIPCIO, 
                    DATA_CREACIO, 
                    DATA_ESBORRAT, 
                    DATA_MODIFICACIO, 
                    USUARI_CREACIO, 
                    USUARI_ESBORRAT, 
                    USUARI_MODIFICACIO,
                    AMBIT_ID
               FROM Z_SE999_DM_TIPUS_DATA NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM A1_DM_TIPUS_DATA ANTIGUOS
                                 WHERE ANTIGUOS.ID = NUEVOS.ID 
                                   AND ANTIGUOS.AMBIT_ID = NUEVOS.AMBIT_ID 
                               );  
            

COMMIT;
END;
*/

PROCEDURE SE100_REGISTRE IS
BEGIN

    INSERT INTO Z_SE999_REGISTRE 
    
            SELECT A1_SEQ_REGISTRE.NEXTVAL AS ID,
                    FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                    FUNC_
                    TRIM(NUMREGISTREGENERAL) AS ID_ORIGINAL,
                    ''
              FROM Z_T_RP_ELEMENTS
             WHERE TRIM(NUMREGISTREGENERAL) IS NOT NULL 
             GROUP BY TRIM(NUMREGISTREGENERAL)


COMMIT;
END;

/*CREAMOS LOS ASPECTES DE ACCIO */
PROCEDURE SE110_ASPECTES_ACCIO IS 
BEGIN

           INSERT INTO Z_SE110_ASPECTE_ACCIO (ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                      SELECT A1_SEQ_ASPECTE.NEXTVAL ID,
                             FUNC_NULOS_ASTERISCO(COMENTARI) AS DESCRIPCIO, -- PARA ACCIO HAY QUE METER COMENTARI, PARA ELEMENT P/S EL EXTRACTE Y PARA DOSSIER ELÑ TITULO
                             SYSDATE  AS DATA_ASSENTAMENT, 
                             FUNC_USU_CREACIO(NULL) AS USUARI_ASSENTAMENT,
                             SYSDATE AS DATA_CREACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                             FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                             FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                             FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                             (SELECT ID FROM A1_DM_TIPUS_TEMA TEMA WHERE TEMA.DESCRIPCIO = ASP.TIPUS) AS TIPUS_TEMA_ID,
                             ConstAMBIT_ALCALDIA AS AMBIT_ID,
                             ASP.ASPECTEID AS ID_ORIGINAL, 
                             'RISPLUS' AS ESQUEMA_ORIGINAL , 
                             'ACCIO//ASPECTES' AS TABLA_ORIGINAL,
                             ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM Z_T_RP_ASPECTES ASP,
                             Z_T_RP_ACCIONS ACC
                       WHERE ASP.INSTALACIOID =ConstInstalacioAlcaldia 
                         AND ASP.ASPECTEID = ACC.ASPECTEID
                         AND NOT EXISTS (SELECT 1
                                           FROM Z_SE110_ASPECTE_ACCIO ANTIGUOS
                                          WHERE ANTIGUOS.ID_ORIGINAL = ASP.ASPECTEID
                                         );



COMMIT;
END;


PROCEDURE SE111_ASPECTES_ELEMENT_PPAL IS 
BEGIN

           INSERT INTO Z_SE111_ASPECTES_ELEMENT_PPAL (ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                      SELECT A1_SEQ_ASPECTE.NEXTVAL ID,
                             FUNC_NULOS_ASTERISCO(EL.EXTRACTE) AS DESCRIPCIO, -- PARA ACCIO HAY QUE METER COMENTARI, PARA ELEMENT P/S EL EXTRACTE Y PARA DOSSIER ELÑ TITULO
                             EL.DATAASSENTAMENT  AS DATA_ASSENTAMENT, 
                             FUNC_USU_CREACIO(NULL) AS USUARI_ASSENTAMENT,
                             SYSDATE AS DATA_CREACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                             FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                             FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                             FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                             (SELECT ID FROM A1_DM_TIPUS_TEMA TEMA WHERE TEMA.DESCRIPCIO = ASP.TIPUS) AS TIPUS_TEMA_ID,
                             ConstAMBIT_ALCALDIA AS AMBIT_ID,
                             ASP.ASPECTEID AS ID_ORIGINAL, 
                             'RISPLUS' AS ESQUEMA_ORIGINAL , 
                             'ELEMENTSPRINCIPAL//ASPECTES' AS TABLA_ORIGINAL,
                             ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM Z_T_RP_ELEMENTSPRINCIPAL EP, 
                             Z_T_RP_ELEMENTS EL, 
                             Z_T_RP_ASPECTES ASP 
                        WHERE ASP.INSTALACIOID =ConstInstalacioAlcaldia
                          AND ASP.ASPECTEID = EP.ASPECTEID
                          AND EP.ASPECTEID = EL.ASPECTEID     
                          AND NOT EXISTS (SELECT 1
                                           FROM Z_SE111_ASPECTES_ELEMENT_PPAL ANTIGUOS
                                          WHERE ANTIGUOS.ID_ORIGINAL = ASP.ASPECTEID
                                         );



COMMIT;
END;


PROCEDURE SE112_ASPECTES_ELEMENT_SEC IS 
BEGIN

           INSERT INTO Z_SE112_ASPECTES_ELEMENT_SEC (ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                      SELECT A1_SEQ_ASPECTE.NEXTVAL ID,
                             FUNC_NULOS_ASTERISCO(EL.EXTRACTE) AS DESCRIPCIO, -- PARA ACCIO HAY QUE METER COMENTARI, PARA ELEMENT P/S EL EXTRACTE Y PARA DOSSIER ELÑ TITULO
                             EL.DATAASSENTAMENT  AS DATA_ASSENTAMENT, 
                             FUNC_USU_CREACIO(NULL) AS USUARI_ASSENTAMENT,
                             SYSDATE AS DATA_CREACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                             FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                             FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                             FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                             (SELECT ID FROM A1_DM_TIPUS_TEMA TEMA WHERE TEMA.DESCRIPCIO = ASP.TIPUS) AS TIPUS_TEMA_ID,
                             ConstAMBIT_ALCALDIA AS AMBIT_ID,
                             ASP.ASPECTEID AS ID_ORIGINAL, 
                             'RISPLUS' AS ESQUEMA_ORIGINAL , 
                             'ELEMENTSSECUNDARI//ASPECTES' AS TABLA_ORIGINAL,
                             ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM Z_T_RP_ELEMENTSSECUNDARIS ES, 
                             Z_T_RP_ELEMENTS EL, 
                             Z_T_RP_ASPECTES ASP 
                        WHERE ASP.INSTALACIOID =ConstInstalacioAlcaldia
                        AND ASP.ASPECTEID = ES.ASPECTEID
                        AND ES.ASPECTEID = EL.ASPECTEID
                        AND NOT EXISTS (SELECT 1
                                           FROM Z_SE112_ASPECTES_ELEMENT_SEC ANTIGUOS
                                          WHERE ANTIGUOS.ID_ORIGINAL = ASP.ASPECTEID
                                         );



COMMIT;
END;


PROCEDURE SE113_ASPECTES_DOSSIER IS 
BEGIN

           INSERT INTO Z_SE113_ASPECTES_DOSSIER (ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                      SELECT A1_SEQ_ASPECTE.NEXTVAL ID,
                             FUNC_NULOS_ASTERISCO(EL.EXTRACTE) AS DESCRIPCIO, -- PARA ACCIO HAY QUE METER COMENTARI, PARA ELEMENT P/S EL EXTRACTE Y PARA DOSSIER EL ¿TITULO? (COMO NO SE ENCUENTRA, PONEMOS EL EXTRACTE DE MOMENTO)
                             EL.DATAASSENTAMENT  AS DATA_ASSENTAMENT, 
                             FUNC_USU_CREACIO(NULL) AS USUARI_ASSENTAMENT,
                             SYSDATE AS DATA_CREACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                             FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                             FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                             FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                             FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                             (SELECT ID FROM A1_DM_TIPUS_TEMA TEMA WHERE TEMA.DESCRIPCIO = ASP.TIPUS) AS TIPUS_TEMA_ID,
                             ConstAMBIT_ALCALDIA AS AMBIT_ID,
                             ASP.ASPECTEID AS ID_ORIGINAL, 
                             'RISPLUS' AS ESQUEMA_ORIGINAL , 
                             'ELEMENTSPRINCIPAL//ASPECTES' AS TABLA_ORIGINAL,
                             ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM Z_T_RP_DOSSIER DOSIER, 
                             Z_T_RP_ELEMENTS EL, 
                             Z_T_RP_ASPECTES ASP 
                        WHERE ASP.INSTALACIOID =ConstInstalacioAlcaldia 
                        AND ASP.ASPECTEID = DOSIER.ASPECTEID
                        AND DOSIER.ASPECTEID = EL.ASPECTEID
                        AND NOT EXISTS (SELECT 1
                                           FROM Z_SE113_ASPECTES_DOSSIER ANTIGUOS
                                          WHERE ANTIGUOS.ID_ORIGINAL = ASP.ASPECTEID
                                         );



COMMIT;
END;



PROCEDURE SE114_ASPECTES IS
BEGIN
    
    INSERT INTO Z_SE999_ASPECTE (ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
       SELECT ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID
         FROM ( 
                   SELECT ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID
                          FROM Z_SE110_ASPECTE_ACCIO
                       UNION ALL
                   SELECT ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID
                          FROM Z_SE111_ASPECTES_ELEMENT_PPAL
                       UNION ALL
                   SELECT ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID
                          FROM Z_SE112_ASPECTES_ELEMENT_SEC
                       UNION ALL   
                   SELECT ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID
                          FROM Z_SE113_ASPECTES_DOSSIER
              ) UNIONS;
COMMIT;

       INSERT INTO A1_ASPECTE (ID, DESCRIPCIO, DATA_ASSENTAMENT, USUARI_ASSENTAMENT, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_TEMA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
                   SELECT ID, 
                          SUBSTR(DESCRIPCIO,1,1000) as DESCRIPCIO, 
                          DATA_ASSENTAMENT, 
                          USUARI_ASSENTAMENT, 
                          DATA_CREACIO, 
                          DATA_MODIFICACIO, 
                          DATA_ESBORRAT, 
                          USUARI_CREACIO, 
                          USUARI_MODIFICACIO, 
                          USUARI_ESBORRAT, 
                          TIPUS_TEMA_ID, 
                          AMBIT_ID, 
                          ID_ORIGINAL, 
                          ESQUEMA_ORIGINAL , 
                          TABLA_ORIGINAL,
                          INSTALACIOID
                   FROM Z_SE999_ASPECTE NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM A1_ASPECTE ANTIGUOS
                                     WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                                   );

COMMIT;
END;



PROCEDURE SE120_DOSSIER IS
BEGIN

    /* QUITAMOS LOS ASPECTES Y NO SE INCLUYE EL REGISTRO DE INSTALACION QUE SE HACE (AQUÍ PARECE SER QUE SE METEN LOS DE 25
              INSERT INTO Z_SE999_DOSSIER (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, PREFIX_ANY_ID, ASPECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID,NUMERO_REGISTRE)
                        SELECT A1_SEQ_DOSSIER.NEXTVAL AS ID,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
--                               (SELECT ID FROM DM_PREFIX_ANY WHERE ID = DOSIER.PREFIXDOSSIERID) AS PREFIX_ANY_ID,
                               DOSIER.PREFIXDOSSIERID AS PREFIX_ANY_ID,
                               E113.ID AS ASPECTE_ID,
                               DOSIER.NUMEROREGISTREDOSSIER AS ID_ORIGINAL, 
                               'RISPLUS' AS ESQUEMA_ORIGINAL , 
                               'DOSSIER' AS TABLA_ORIGINAL,
                               --ConstInstalacioAlcaldia AS INSTALACIOID,
                               ASP.ASPECTEID AS INSTALACIOID,
                               TO_NUMBER(DOSIER.NUMEROREGISTREDOSSIER) AS NUMERO_REGISTRE
                          FROM Z_T_RP_DOSSIER DOSIER,
                               Z_SE113_ASPECTES_DOSSIER E113,
                               Z_T_RP_ASPECTES ASP
                         WHERE E113.ID_ORIGINAL = DOSIER.ASPECTEID --AQUÍ YA TENEMOS FILTRADOS POR CONSTINSTALACIO
                           AND ASP.ASPECTEID=DOSIER.ASPECTEID
                           AND NOT EXISTS (SELECT 1
                                             FROM Z_SE999_DOSSIER ANTIGUOS
                                            WHERE ANTIGUOS.ID_ORIGINAL = DOSIER.NUMEROREGISTREDOSSIER
                                          );
                                          
           */
           
            INSERT INTO Z_SE999_DOSSIER (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, PREFIX_ANY_ID, ASPECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID,NUMERO_REGISTRE)
                        SELECT A1_SEQ_DOSSIER.NEXTVAL AS ID,
                               SYSDATE AS DATA_CREACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
--                               (SELECT ID FROM DM_PREFIX_ANY WHERE ID = DOSIER.PREFIXDOSSIERID) AS PREFIX_ANY_ID,
                               DOSIER.PREFIXDOSSIERID AS PREFIX_ANY_ID,
                               E113.ID AS ASPECTE_ID,
                               DOSIER.NUMEROREGISTREDOSSIER AS ID_ORIGINAL, 
                               'RISPLUS' AS ESQUEMA_ORIGINAL , 
                               'DOSSIER' AS TABLA_ORIGINAL,
                               ConstInstalacioAlcaldia AS INSTALACIOID,                               
                               TO_NUMBER(DOSIER.NUMEROREGISTREDOSSIER) AS NUMERO_REGISTRE
                          FROM Z_T_RP_DOSSIER DOSIER,
                               Z_SE113_ASPECTES_DOSSIER E113
                         WHERE E113.ID_ORIGINAL = DOSIER.ASPECTEID --AQUÍ YA TENEMOS FILTRADOS POR CONSTINSTALACIO
                           AND NOT EXISTS (SELECT 1
                                             FROM Z_SE999_DOSSIER ANTIGUOS
                                            WHERE ANTIGUOS.ID_ORIGINAL = DOSIER.NUMEROREGISTREDOSSIER
                                          );
--    UPDATE Z_SE999_DOSSIER SET  PREFIX_ANY_ID =6 WHERE PREFIX_ANY_ID =5;      
           
    COMMIT;
    
              INSERT INTO A1_DOSSIER (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, PREFIX_ANY_ID, ASPECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID,NUMERO_REGISTRE)
                        SELECT ID, 
                               DATA_CREACIO, 
                               DATA_MODIFICACIO, 
                               DATA_ESBORRAT, 
                               USUARI_CREACIO, 
                               USUARI_MODIFICACIO, 
                               USUARI_ESBORRAT, 
--                               PREFIX_ANY_ID, 
                               (SELECT ID FROM A1_DM_PREFIX_ANY WHERE ID_ORIGINAL = PREFIX_ANY_ID) AS PREFIX_ANY_ID,
                               ASPECTE_ID,
                               ID_ORIGINAL, 
                               ESQUEMA_ORIGINAL , 
                               TABLA_ORIGINAL,
                               INSTALACIOID,
                               NUMERO_REGISTRE
                         FROM Z_SE999_DOSSIER NUEVOS
                        WHERE NOT EXISTS (SELECT 1
                                            FROM A1_DOSSIER ANTIGUOS
                                           WHERE NUEVOS.ASPECTE_ID = ANTIGUOS.ASPECTE_ID
                                         );  
    --OJO EL NUMEROREGISTREDOSSIER ESTA REPÈTIDO
  COMMIT;
END;


--CREAMOS TABLA QUE RELACIONA EL USUARI_ID + ASPECTE_ID CON LA NUEVA SECUENCIA DE TITULAR 8USADA EN ELEMEN_PRINCIPAL9
PROCEDURE SE130_TITULARSDINS_ASPECTE IS
BEGIN
    --DROP SEQUENCE  A1_SEQ_TITULAR_DINS;
    --CREATE SEQUENCE A1_SEQ_TITULAR_DINS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;



    INSERT INTO Z_SE130_TITULARDINS (ID, ASPECTE_ID, USUARI_ID, NOM_USUARI, MATRICULA_USUARI, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
	        SELECT A1_SEQ_TITULAR_DINS.NEXTVAL AS ID, 
				   ASPECTE_ID,
				   USUARI_ID,
				   NOM_USUARI,
				   MATRICULA_USUARI,
				   DATA_CREACIO,
				   DATA_MODIFICACIO,
				   DATA_ESBORRAT,
				   USUARI_CREACIO,
				   USUARI_MODIFICACIO,
				   USUARI_ESBORRAT,
                   ASPECTE_ID_RISPLUS AS ID_ORIGINAL, 
                   'RISPLUS' AS ESQUEMA_ORIGINAL , 
                   'ELEMENTS' AS TABLA_ORIGINAL,
                   INSTALACIOID AS INSTALACIOID
			FROM (	   
				        SELECT 
				               ASPECTE.ID AS ASPECTE_ID,
				               EL.ASPECTEID AS ASPECTE_ID_RISPLUS,
							   USUARIID AS  USUARI_ID,
			                   NOM || ' ' || COGNOMS AS NOM_USUARI,
			                   USUARI AS MATRICULA_USUARI,
			                   SYSDATE AS DATA_CREACIO,
			                   FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
			                   FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
			                   FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
			                   FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
			                   FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                               TIT.INSTALACIOID -- <- eN VEZ PONER LA CONSTANTE PONEMOS EL CAMPO DE TITULAR A 'MODO DE COMPROBACIÓN'. HA DE COINCIDIR CON LA CONSTANTE
			              FROM Z_T_RP_USUARIS TIT,
			                   Z_T_RP_ELEMENTS EL,
			                   Z_SE999_ASPECTE ASPECTE 
			              WHERE EL.TITULARDINSID = TIT.USUARIID
    		                AND ASPECTE.ID_ORIGINAL = EL.ASPECTEID
			          )TITULARS_DINS
			         WHERE NOT EXISTS (SELECT 1
			         					 FROM Z_SE130_TITULARDINS ANTIGUOS
			         					WHERE ANTIGUOS.USUARI_ID =TITULARS_DINS.USUARI_ID
			         					  AND ANTIGUOS.ASPECTE_ID =TITULARS_DINS.ASPECTE_ID
			         				);	
        
COMMIT;
END;

PROCEDURE SE131_TITULAR_DINS IS
BEGIN

    INSERT INTO A1_TITULAR_DINS (ID, NOM_USUARI, MATRICULA_USUARI, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, ASPECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,INSTALACIOID)
            SELECT ID, --Aquí ya está la secuencia puesta en SE130
                   NOM_USUARI, 
                   MATRICULA_USUARI,
                   DATA_CREACIO, 
                   DATA_MODIFICACIO, 
                   DATA_ESBORRAT, 
                   USUARI_CREACIO, 
                   USUARI_MODIFICACIO, 
                   USUARI_ESBORRAT, 
                   ASPECTE_ID,
                   ID_ORIGINAL, 
                   ESQUEMA_ORIGINAL , 
                   TABLA_ORIGINAL,
                   INSTALACIOID
              FROM Z_SE130_TITULARDINS NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                  FROM A1_TITULAR_DINS ANTIGUOS
                                 WHERE ANTIGUOS.MATRICULA_USUARI = NUEVOS.MATRICULA_USUARI
                                   AND ANTIGUOS.ASPECTE_ID = NUEVOS.ASPECTE_ID
                                );
                                
                                

COMMIT;
END;




PROCEDURE SE140_ELEMENT_PRINCIPAL IS
BEGIN

   /*
     INSERT INTO Z_SE140_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
        SELECT ASPECTEID AS ID,
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
                    ELEMENT_PRINCIPAL_ORIGEN_ID,
                    ASPECTEID AS ID_ORIGINAL, 
                    'RISPLUS' AS ESQUEMA_ORIGINAL , 
                    'ELEMENTSPRINCIPAL' AS TABLA_ORIGINAL,
                    INSTALACIOID AS INSTALACIOID 
              FROM (      
                     SELECT EP.ASPECTEID AS ASPECTEID,               
                       EL.NUMEROREGISTREPREFIXID AS NUMERO_REGISTRE,
                       EL.ESENTRADA AS ES_RELACIO_ENTRADA,
                       EL.DATAASSENTAMENT AS DATA_RELACIO_ENTRADA,
                       1 AS ES_VALIDAT_RE,
                       EL.DATAENTRADAREGISTREGENERAL AS DATA_REGISTRE_GENERAL,
                       EL.DATAASSENTAMENT AS DATA_INICI_SEGUIMENT,
                       EP.DATATERMINI AS DATA_FI_SEGUIMENT,
                       (SELECT NOM_USUARI FROM A1_TITULAR_DINS WHERE ID = EL.TITULARDINSID AND ASPECTE_ID = el.ASPECTEID) AS NOM_USUARI_RESPONSABLE,
                       (SELECT MATRICULA_USUARI FROM A1_TITULAR_DINS WHERE ID = EL.TITULARDINSID AND ASPECTE_ID = el.ASPECTEID) AS MATRICULA_USUARI_RESPONSABLE,
                       EP.DATADOCUMENT AS DATA_DOCUMENT,
                       EP.DATATERMINI AS DATA_TERMINI,
                       EP.RESPINTERESSAT AS DATA_RESPOSTA,
                       EP.DATARESOLUCIO AS DATA_RESOLUCIO, 
                       AGENDA.ASSUMPTE AS NOM_ACTE,
--                       AGENDA.DATAINICI AS DATA_INICI_ACTE,
--                       AGENDA.DATAFINAL AS DATA_FI_ACTE ,
                       SYSDATE AS DATA_CREACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
--                       AGENDA.AFECTAAGENDA AS AFECTA_AGENDA_ID,
                       (CASE WHEN AGENDA.AFECTAAGENDA=0 THEN 
                                  2
                             WHEN AGENDA.AFECTAAGENDA=1 THEN
                                  1
                        END) AS AFECTA_AGENDA_ID,
                       (CASE WHEN EL.ESENTRADA = 1 THEN 
                              1 -- DM_ORIGEN_ELEMENT
                        ELSE
                              2
                        END) AS ORIGEN_ID,
                        (SELECT id FROM Z_SE999_DM_PRIORITAT_ELEMENT WHERE prioritatid = EP.PRIORITATID) AS PRIORITAT_ID,
                        (SELECT id FROM A1_DM_TIPUS_ELEMENT WHERE ID_ORIGINAL= EP.TIPUSELEMENTPRINCIPALID) AS TIPUS_ELEMENT_ID,
--                        EL.ASPECTEID AS ASPECTE_ID,
--                        ASPECTE.ID AS ASPECTE_ID,
                          EP.ASPECTEID AS ASPECTE_ID,
--                        EP.DOSSIERID AS DOSSIER_ID,
                        (SELECT ID FROM A1_DOSSIER WHERE ID_ORIGINAL=EP.DOSSIERID)  AS  DOSSIER_ID,
                        1 AS ESTAT_ELEMENT_PRINCIPAL_ID,
                       (SELECT ID FROM A1_DM_TIPUS_SUPORT WHERE CODI = EL.TIPUSSUPORTID)  AS TIPUS_SUPORT_ID,
                        1 AS TIPUS_AMBIT_ID,
                        (CASE WHEN CAMPS.RESPOSTACAMPG=10 THEN --ACTE
                                                               3
                                 WHEN CAMPS.RESPOSTACAMPG=11 THEN
                                       1
                                 WHEN CAMPS.RESPOSTACAMPG=12 THEN --REUNIO      
                                                               2
                        END) AS TIPUS_ARG_ID,
                        (SELECT id FROM A1_DM_PREFIX WHERE id_original = EL.NUMEROREGISTREPREFIXID) AS PREFIX_ID,
                        FUNC_NULOS_STRING() AS NUMERO_REGISTRE_GENERAL_ID,
                        FUNC_NULOS_STRING() AS ELEMENT_PRINCIPAL_ORIGEN_ID,                        
                        ASP.INSTALACIOID AS INSTALACIOID
                    FROM Z_T_RP_ELEMENTS EL,
                         Z_T_RP_ELEMENTSPRINCIPAL EP,
                         Z_T_RP_FITXESAGENDES AGENDA,
                         Z_T_RP_ASPECTES ASP,
                         Z_T_RP_RESPOSTESCAMPSESPECIALS CAMPS
                         --A1_DOSSIER DOSIER,
--                         A1_ASPECTE ASPECTE
                    WHERE EL.ASPECTEID = EP.ASPECTEID
                      AND EP.ASPECTEID = AGENDA.ASPECTEID
                      AND ASP.ASPECTEID = EP.ASPECTEID
                      AND CAMPS.ASPECTEID = EP.ASPECTEID
                      AND EL.TIPUSSUPORTID IS NOT NULL
                      AND EL.NUMEROREGISTREPREFIXID IS NOT NULL
                      --AND DOSIER.ID_ORIGINAL = EP.DOSSIERID
--                      AND ASPECTE.ID_ORIGINAL = ASP.ASPECTEID 
                  )ELEMENTS_PRINCIPALS
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_SE140_ELEMENT_PRINCIPAL ANTIGUOS
                                    WHERE  ANTIGUOS.ID_ORIGINAL = ELEMENTS_PRINCIPALS.ASPECTEID
                                   );
    */
    
    INSERT INTO Z_SE140_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
        SELECT ASPECTEID AS ID,
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
                    ELEMENT_PRINCIPAL_ORIGEN_ID,
                    ASPECTEID AS ID_ORIGINAL, 
                    'RISPLUS' AS ESQUEMA_ORIGINAL , 
                    'ELEMENTSPRINCIPAL' AS TABLA_ORIGINAL,
                    INSTALACIOID AS INSTALACIOID 
              FROM (      
                     SELECT EP.ASPECTEID AS ASPECTEID,               
                       EL.NUMEROREGISTREPREFIXID AS NUMERO_REGISTRE,
                       EL.ESENTRADA AS ES_RELACIO_ENTRADA,
                       EL.DATAASSENTAMENT AS DATA_RELACIO_ENTRADA,
                       1 AS ES_VALIDAT_RE,
                       EL.DATAENTRADAREGISTREGENERAL AS DATA_REGISTRE_GENERAL,
                       EL.DATAASSENTAMENT AS DATA_INICI_SEGUIMENT,
                       EP.DATATERMINI AS DATA_FI_SEGUIMENT,
--                       (SELECT NOM_USUARI FROM A1_TITULAR_DINS WHERE ID = EL.TITULARDINSID AND ASPECTE_ID = el.ASPECTEID) AS NOM_USUARI_RESPONSABLE,
                       TIT_DINS.NOM_USUARI AS NOM_USUARI_RESPONSABLE,                       
--                       (SELECT MATRICULA_USUARI FROM A1_TITULAR_DINS WHERE ID = EL.TITULARDINSID AND ASPECTE_ID = el.ASPECTEID) AS MATRICULA_USUARI_RESPONSABLE,
                       TIT_DINS.MATRICULA_USUARI AS MATRICULA_USUARI_RESPONSABLE,
                       EP.DATADOCUMENT AS DATA_DOCUMENT,
                       EP.DATATERMINI AS DATA_TERMINI,
                       EP.RESPINTERESSAT AS DATA_RESPOSTA,
                       EP.DATARESOLUCIO AS DATA_RESOLUCIO, 
                       AGENDA.ASSUMPTE AS NOM_ACTE,
--                       AGENDA.DATAINICI AS DATA_INICI_ACTE,
--                       AGENDA.DATAFINAL AS DATA_FI_ACTE ,
                       SYSDATE AS DATA_CREACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
--                       AGENDA.AFECTAAGENDA AS AFECTA_AGENDA_ID,
                       (CASE WHEN AGENDA.AFECTAAGENDA=0 THEN 
                                  2
                             WHEN AGENDA.AFECTAAGENDA=1 THEN
                                  1
                        END) AS AFECTA_AGENDA_ID,
                       (CASE WHEN EL.ESENTRADA = 1 THEN 
                              1 -- DM_ORIGEN_ELEMENT
                        ELSE
                              2
                        END) AS ORIGEN_ID,
--                        (SELECT id FROM Z_SE999_DM_PRIORITAT_ELEMENT WHERE prioritatid = EP.PRIORITATID) AS PRIORITAT_ID,
                        PRIORITAT.ID AS PRIORITAT_ID,
--                        (SELECT id FROM A1_DM_TIPUS_ELEMENT WHERE ID_ORIGINAL= EP.TIPUSELEMENTPRINCIPALID) AS TIPUS_ELEMENT_ID,
                          TIPUSELEMENT.ID AS TIPUS_ELEMENT_ID,
--                        EL.ASPECTEID AS ASPECTE_ID,
--                        ASPECTE.ID AS ASPECTE_ID,
                          EP.ASPECTEID AS ASPECTE_ID,
--                        EP.DOSSIERID AS DOSSIER_ID,
                        DOSSIER.ID AS DOSSIER_ID,
                        1 AS ESTAT_ELEMENT_PRINCIPAL_ID,
                       TIPUSSUPORT.ID AS TIPUS_SUPORT_ID,
                        1 AS TIPUS_AMBIT_ID,
                        (CASE WHEN CAMPS.RESPOSTACAMPG=10 THEN --ACTE
                                                               3
                                 WHEN CAMPS.RESPOSTACAMPG=11 THEN
                                       1
                                 WHEN CAMPS.RESPOSTACAMPG=12 THEN --REUNIO      
                                                               2
                        END) AS TIPUS_ARG_ID,
                        PREFIX.ID AS PREFIX_ID,
                        FUNC_NULOS_STRING() AS NUMERO_REGISTRE_GENERAL_ID,
                        FUNC_NULOS_STRING() AS ELEMENT_PRINCIPAL_ORIGEN_ID,                        
                        ASP.INSTALACIOID AS INSTALACIOID
                    FROM Z_T_RP_ELEMENTS EL,
                         Z_T_RP_ELEMENTSPRINCIPAL EP,
                         Z_T_RP_FITXESAGENDES AGENDA,
                         Z_T_RP_ASPECTES ASP,
                         Z_T_RP_RESPOSTESCAMPSESPECIALS CAMPS,
                         --A1_DOSSIER DOSIER,
--                         A1_ASPECTE ASPECTE
						 A1_TITULAR_DINS TIT_DINS,
						 A1_DM_PRIORITAT_ELEMENT PRIORITAT,
						 A1_DM_TIPUS_ELEMENT TIPUSELEMENT,
						 A1_DOSSIER DOSSIER,
						 A1_DM_TIPUS_SUPORT TIPUSSUPORT,
						 A1_DM_PREFIX PREFIX
                    WHERE EL.ASPECTEID = EP.ASPECTEID
                      AND EP.ASPECTEID = AGENDA.ASPECTEID
                      AND ASP.ASPECTEID = EP.ASPECTEID
                      AND CAMPS.ASPECTEID = EP.ASPECTEID
                      AND EL.TIPUSSUPORTID IS NOT NULL
                      AND EL.NUMEROREGISTREPREFIXID IS NOT NULL
                      --AND DOSIER.ID_ORIGINAL = EP.DOSSIERID
--                      AND ASPECTE.ID_ORIGINAL = ASP.ASPECTEID 
					AND  EL.TITULARDINSID=TIT_DINS.ID(+)
					AND  EP.PRIORITATID = PRIORITAT.ID_ORIGINAL(+)
					AND EP.TIPUSELEMENTPRINCIPALID = TIPUSELEMENT.ID_ORIGINAL(+)
					AND EP.DOSSIERID = DOSSIER.ID_ORIGINAL(+)
					AND EL.TIPUSSUPORTID = TIPUSSUPORT.CODI(+)
					AND EL.NUMEROREGISTREPREFIXID = PREFIX.id_original(+)
                  )ELEMENTS_PRINCIPALS
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_SE140_ELEMENT_PRINCIPAL ANTIGUOS
                                    WHERE  ANTIGUOS.ID_ORIGINAL = ELEMENTS_PRINCIPALS.ASPECTEID
                                   );

 
  

COMMIT;
END;

--ELEMENTS CON SUPPORTID A NULL EN RESGITRAR_ERRORES
--ELEMENTS CON NUMEROREGISTREPREFIXID a NULL RESGITRAR_ERRORES

/* COGEMOS SÓLO LOS ELEMENTOS PRINCIPALES QUE TENGAN ASPECTES */
PROCEDURE SE141_ELEMENTS_PPAL_ASPECTES IS
BEGIN
        INSERT INTO Z_SE999_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
            SELECT PPAL.ID, 
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
                   PPAL.DATA_CREACIO, 
                   PPAL.DATA_MODIFICACIO, 
                   PPAL.DATA_ESBORRAT, 
                   PPAL.USUARI_CREACIO, 
                   PPAL.USUARI_MODIFICACIO, 
                   PPAL.USUARI_ESBORRAT, 
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
                   ELEMENT_PRINCIPAL_ORIGEN_ID,                    
                   PPAL.ID_ORIGINAL, 
                   PPAL.ESQUEMA_ORIGINAL, 
                   PPAL.TABLA_ORIGINAL, 
                   PPAL.INSTALACIOID
              FROM Z_SE140_ELEMENT_PRINCIPAL PPAL,
                   A1_ASPECTE ASPECTE
             WHERE ASPECTE.ID_ORIGINAL = PPAL.ASPECTE_ID
                AND PPAL.TIPUS_SUPORT_ID IS NOT NULL 
                AND PPAL.PREFIX_ID IS NOT NULL
                AND NOT EXISTS (SELECT 1 
                                  FROM Z_SE999_ELEMENT_PRINCIPAL ANTIGUOS
                                 WHERE ANTIGUOS.ID = PPAL.ID
                               );  
              


COMMIT;
END;



/*ANTES DE METER EN LA A1 HAY QUE SACAR UNA RELACION A LA TABLA 'REGISTRE' DE los ID de REGITSRE*/
PROCEDURE SE142_ELEMENT_PRINCIPAL IS
BEGIN

    INSERT INTO A1_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
         SELECT A1_SEQ_ELEMENT_PRINCIPAL.NEXTVAL AS ID,
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
                NUEVOS.DATA_CREACIO,
                NUEVOS.DATA_MODIFICACIO,
                NUEVOS.DATA_ESBORRAT,
                NUEVOS.USUARI_CREACIO,
                NUEVOS.USUARI_MODIFICACIO,
                NUEVOS.USUARI_ESBORRAT,
                AFECTA_AGENDA_ID,
                ORIGEN_ID,
                PRIORITAT_ID,
                TIPUS_ELEMENT_ID,
                ASPECTE.ID AS ASPECTE_ID,
                DOSSIER_ID,
                ESTAT_ELEMENT_PRINCIPAL_ID,
                TIPUS_SUPORT_ID,
                TIPUS_AMBIT_ID,
                TIPUS_ARG_ID,
                PREFIX_ID,
                NUMERO_REGISTRE_GENERAL_ID,
                ELEMENT_PRINCIPAL_ORIGEN_ID,
                NUEVOS.ID_ORIGINAL,
                NUEVOS.ESQUEMA_ORIGINAL,
                NUEVOS.TABLA_ORIGINAL,
                NUEVOS.INSTALACIOID              
           FROM Z_SE999_ELEMENT_PRINCIPAL NUEVOS,
                A1_ASPECTE ASPECTE           
          WHERE ASPECTE.ID_ORIGINAL = NUEVOS.ASPECTE_ID 
            AND NOT EXISTS (SELECT 1
                              FROM A1_ELEMENT_PRINCIPAL ANTIGUOS
                             WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                           );  

COMMIT;
END;

--A) EXTRAIGO LOS ELEMENTOS SECUNDARIOS (Y SU ACCION)
PROCEDURE SE150_ELEMENTS_SEC_ACCION IS
BEGIN

        /* INFO         
        
                SELECT *
                  FROM Z_T_RP_ELEMENTSPRINCIPAL  -->AQUÍ OBTENEMOS EL ELEMENTO_PRINCIPAL AL QUE PERTENECE EL SECUNDARIO
            WHERE ASPECTEID IN (


						SELECT HISTORICACCIONSID
						FROM Z_T_RP_HISTORICACCIONS
						WHERE ASPECTEID IN (
												SELECT ASPECTEID FROM Z_T_RP_ACCIONS
												WHERE ASPECTEID IN (
																		SELECT ACCIOID
																		FROM Z_T_RP_ELEMENTS -->AQUÍ TENEMOS LA INFO DEL ELEMENTO PRINCIPAL
																		WHERE ASPECTEID IN (
																								SELECT ASPECTEID 
																								FROM Z_T_RP_ELEMENTSSECUNDARIS 
																								WHERE ASPECTEID IN (SELECT ASPECTEID
																														FROM Z_T_RP_ASPECTES
																														WHERE tipus='ElementSecundari'
																													)	
																						)				
																	)					
										)	
					)					
    */

            INSERT INTO Z_SE150_ELEMENTS_SEC_ACCION (ELEMENT_SEC_ID, ACCIOID, ESENTRADA, NUMEROREGISTREPREFIXID, DATAASSENTAMENT, NUMREGISTREGENERAL, DATAENTRADAREGISTREGENERAL, EXTRACTE, TIPUSSUPORTID, DATADOCUMENT, COMENTARIS, NUMEROREGISTRESUFIX, ESTAACTIU, TITULARFORAID, TITULARDINSID, TIPUS, BLOQUEJARPER,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
                SELECT ASPECTEID AS ELEMENT_SEC_ID, 
                       ACCIOID, 
                       ESENTRADA, 
                       NUMEROREGISTREPREFIXID, 
                       DATAASSENTAMENT, 
                       NUMREGISTREGENERAL, 
                       DATAENTRADAREGISTREGENERAL, 
                       EXTRACTE, 
                       TIPUSSUPORTID, 
                       DATADOCUMENT, 
                       COMENTARIS, 
                       NUMEROREGISTRESUFIX, 
                       ESTAACTIU, 
                       TITULARFORAID, 
                       TITULARDINSID, 
                       TIPUS, 
                       BLOQUEJARPER,
                       ID_ORIGINAL,
                       ESQUEMA_ORIGINAL,
                       TABLA_ORIGINAL,
                       INSTALACIO
                 FROM (      
              		    SELECT EL.ASPECTEID, 
                               EL.ACCIOID, 
                               EL.ESENTRADA, 
                               EL.NUMEROREGISTREPREFIXID, 
                               EL.DATAASSENTAMENT, 
                               EL.NUMREGISTREGENERAL, 
                               EL.DATAENTRADAREGISTREGENERAL, 
                               EL.EXTRACTE, 
                               EL.TIPUSSUPORTID, 
                               EL.DATADOCUMENT, 
                               EL.COMENTARIS, 
                               EL.NUMEROREGISTRESUFIX, 
                               EL.ESTAACTIU, 
                               EL.TITULARFORAID, 
                               EL.TITULARDINSID, 
                               EL.TIPUS, 
                               EL.BLOQUEJARPER,
                               EL.ASPECTEID AS ID_ORIGINAL,
                               'RISPLUS' AS ESQUEMA_ORIGINAL,
                               'ELEMENTS' AS TABLA_ORIGINAL,
                               ASP.INSTALACIOID AS INSTALACIO                               
                          FROM Z_T_RP_ELEMENTS EL,
                               Z_T_RP_ELEMENTSSECUNDARIS ES,
                               Z_T_RP_ASPECTES ASP
                          WHERE ASP.INSTALACIOID = 30
                            AND ASP.TIPUS='ElementSecundari'
                            AND ASP.ASPECTEID = ES.ASPECTEID
                            AND ES.ASPECTEID = EL.ASPECTEID
                    )DATOS_ELEMENT_SECUNDARIO
                  WHERE NOT EXISTS (SELECT 1 
                                      FROM Z_SE150_ELEMENTS_SEC_ACCION ANTIGUOS
                                     WHERE ANTIGUOS.ELEMENT_SEC_ID =  DATOS_ELEMENT_SECUNDARIO.ASPECTEID
                                   );      
    

COMMIT;
END;

--B) EXTRAIGO LOS ELEMENTOS PRINCIPALES A LOS QUE PERTENECE (Y SU ACCION)
PROCEDURE SE151_RELAC_ELEMENTS_PPAL_SEC IS
BEGIN
           
         INSERT INTO Z_SE151_RELAC_ELEMENT_PPAL_SEC (ELEMENT_SEC_ID, ELEMENT_PPAL_ID, TIPUSELEMENTPRINCIPALID, TIPUSTEMAELEMENTPRINCIPALID, DATADOCUMENT, RESPONSABLEID, PRIORITATID, DATATERMINI, SEGUIMENTDESDE, SEGUIMENTFINS, DATARESOLUCIO, RESPINTERESSAT, DOSSIERID, TEXTGEOLOC, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                SELECT ELEMENT_SEC_ID, 
                       ELEMENT_PPAL_ID, 
                       TIPUSELEMENTPRINCIPALID, 
                       TIPUSTEMAELEMENTPRINCIPALID, 
                       DATADOCUMENT, 
                       RESPONSABLEID, 
                       PRIORITATID, 
                       DATATERMINI, 
                       SEGUIMENTDESDE, 
                       SEGUIMENTFINS, 
                       DATARESOLUCIO, 
                       RESPINTERESSAT, 
                       DOSSIERID, 
                       TEXTGEOLOC, 
                       ID_ORIGINAL, 
                       ESQUEMA_ORIGINAL, 
                       TABLA_ORIGINAL, 
                       INSTALACIOID
                 FROM ( 
                        SELECT SEC.ELEMENT_SEC_ID,
                               EP.ASPECTEID AS ELEMENT_PPAL_ID,
                               EP.TIPUSELEMENTPRINCIPALID, 
                               EP.TIPUSTEMAELEMENTPRINCIPALID, 
                               EP.DATADOCUMENT, 
                               EP.RESPONSABLEID, 
                               EP.PRIORITATID, 
                               EP.DATATERMINI, 
                               EP.SEGUIMENTDESDE, 
                               EP.SEGUIMENTFINS, 
                               EP.DATARESOLUCIO, 
                               EP.RESPINTERESSAT, 
                               EP.DOSSIERID, 
                               EP.TEXTGEOLOC,
                               EP.ASPECTEID AS ID_ORIGINAL,
                               'RISPLUS' AS ESQUEMA_ORIGINAL,
                               'ELEMENTSPRINCIPAL' AS TABLA_ORIGINAL,
                               SEC.INSTALACIOID AS INSTALACIOID
                        FROM Z_T_RP_ELEMENTSPRINCIPAL EP,
                             Z_T_RP_HISTORICACCIONS HIST, 
                             Z_T_RP_ACCIONS ACC,
                             Z_SE150_ELEMENTS_SEC_ACCION SEC     
                        WHERE SEC.ACCIOID = ACC.ASPECTEID
                          AND ACC.ASPECTEID = HIST.ASPECTEID
                          AND HIST.HISTORICACCIONSID = EP.ASPECTEID
                    )ELEM_PPAL_SEC
                  WHERE NOT EXISTS (SELECT 1
                                      FROM Z_SE151_RELAC_ELEMENT_PPAL_SEC ANTIGUOS
                                    WHERE ANTIGUOS.ELEMENT_PPAL_ID = ELEM_PPAL_SEC.ELEMENT_PPAL_ID
                                      AND ANTIGUOS.ELEMENT_SEC_ID = ELEM_PPAL_SEC.ELEMENT_SEC_ID
                                   );
COMMIT;
END;


PROCEDURE SE160_ACCION_ELEMENTS_PPALS IS
BEGIN

         INSERT INTO Z_SE160_ACCION_ELEMENTS_PPAL ( ELEMENT_PRINCIPAL_ID, ACCIONID, TIPUS)
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
                                   FROM Z_SE160_ACCION_ELEMENTS_PPAL ANTIGUOS
                                  WHERE ANTIGUOS.ELEMENT_PRINCIPAL_ID = ACCION_EL_PPAL.ELEMENT_PRINCIPAL_ID
                                    AND ANTIGUOS.ACCIONID = ACCION_EL_PPAL.ACCIONID
                                );  


COMMIT;
END;

--SE HACE EN DOS PARTES PARA INCLUIR LOS USUARIS DE QUE ESTÁN EN INFORMACIONSACCIONS
PROCEDURE SE161_ACCIONS_PART1 IS 
BEGIN
        INSERT INTO Z_SE161_ACCIONS_PART1 (ACCION_ID, RESPOSTA, ESPERARESPOSTA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ELEMENT_PRINCIPAL_ID, ASPECTE_ID, ACCION_PRINCIPAL, AMBIT_ORIGEN_ID, PASS_ACCIO_ID,
ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
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
                             PASS_ACCIO_ID,                             
                             ACCION_ID AS ID_ORIGINAL,
                             'RISPLUS' AS ESQUEMA_ORIGINAL,
                             'ACCIONS' AS TABLA_ORIGINAL,
                             ConstInstalacioAlcaldia AS INSTALACIOID                             
                        FROM (    
                             
                                    SELECT  acc.ASPECTEID AS ACCION_ID,
                                            ACC.RESPOSTA,
                                            ACC.ESPERARESPOSTA,
                                            acc.DATAINICI AS DATA_CREACIO,
                                            FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                                            FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                            FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                                            FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                                            STA.SUBTIPUSACCIOID AS SUBTIPUS_ACCIO_ID,
-- UPDATE.AHORA HAY QUE SACAR LA SECUENCIA  (SELECT ELEMENT_PRINCIPAL_ID FROM  Z_SE160_ACCION_ELEMENTS_PPAL HIST WHERE acc.ASPECTEID = HIST.ACCIONID AND ROWNUM=1) AS element_principal_id,       
                                            (SELECT ID FROM A1_ELEMENT_PRINCIPAL WHERE ID_ORIGINAL = (SELECT ELEMENT_PRINCIPAL_ID FROM  Z_SE160_ACCION_ELEMENTS_PPAL HIST WHERE acc.ASPECTEID = HIST.ACCIONID AND ROWNUM=1)) AS element_principal_id,       
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
                                        AND ASP.INSTALACIOID =ConstInstalacioAlcaldia 
                                )ACCIO_ELEMENT_RP
                                WHERE NOT EXISTS (SELECT 1 
                                                    FROM Z_SE161_ACCIONS_PART1 ANTIGUOS
                                                   WHERE ANTIGUOS.ACCION_ID =  ACCIO_ELEMENT_RP.ACCION_ID
                                                 );

COMMIT;
END;


PROCEDURE SE162_ACCIONS_PART2 IS 
BEGIN

            INSERT INTO Z_SE162_ACCIONS_PART2 (ACCION_ID,NOM_USUARI_ACCIO,MATRICULA_USUARI_ACCIO)
                   SELECT ACCION_ID,
                          NOM_USUARI_ACCIO,
                          MATRICULA_USUARI_ACCIO
                    FROM (   
                            SELECT  ACC.ACCION_ID AS ACCION_ID,
                                    (SELECT USU.NOM || ' ' || USU.COGNOMS FROM Z_T_RP_USUARIS USU WHERE USU.USUARIID = INF.USUARIID) AS NOM_USUARI_ACCIO,
                                    (SELECT USU.USUARI  FROM Z_T_RP_USUARIS USU WHERE USU.USUARIID = INF.USUARIID) AS MATRICULA_USUARI_ACCIO
                               FROM Z_SE161_ACCIONS_PART1 ACC, 
                                    Z_T_RP_HISTORICACCIONS INF
                              WHERE ACC.ACCION_ID = INF.HISTORICACCIONSID      
                           )ACCION_USUARIS   
                   WHERE NOT EXISTS (SELECT 1
                                       FROM  Z_SE162_ACCIONS_PART2 ANTIGUOS
                                      WHERE ANTIGUOS.ACCION_ID = ACCION_USUARIS.ACCION_ID
                                    );  
                      


COMMIT;
END;

--ACCIONES FINALES CON LOS USUARIS INFORMADOS
PROCEDURE SE163_ACCIONS_PART3 IS
BEGIN

    INSERT INTO Z_SE163_ACCIONS_PART3 (ACCION_ID, RESPOSTA, ES_NECESSITA_RESPOSTA, NOM_USUARI_ACCIO, MATRICULA_USUARI_ACCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ASPECTE_ID, ELEMENT_PRINCIPAL_ID, AMBIT_ORIGEN_ID, PAS_ACCIO_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
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
                              PAS_ACCIO_ID,
                              ID_ORIGINAL,
                              ESQUEMA_ORIGINAL,
                              TABLA_ORIGINAL,
                              INSTALACIOID
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
                                         PART1.PASS_ACCIO_ID AS PAS_ACCIO_ID,
                                         PART1.ID_ORIGINAL,
                                         PART1.ESQUEMA_ORIGINAL,
                                         PART1.TABLA_ORIGINAL,
                                         PART1.INSTALACIOID
                                    FROM Z_SE161_ACCIONS_PART1 PART1,
                                         Z_SE162_ACCIONS_PART2 PART2
                                    WHERE PART1.ACCION_ID = PART2.ACCION_ID
                            ) ACCIONS_CON_USUARIS   
                   WHERE NOT EXISTS (SELECT 1
                                       FROM Z_SE163_ACCIONS_PART3 ANTIGUOS
                                      WHERE ANTIGUOS.ACCION_ID =ACCIONS_CON_USUARIS.ACCION_ID
                                     );


COMMIT;
END;


--ACCIONES FINALES CON LOS USUARIS NULL
PROCEDURE SE164_ACCIONS_PART4 IS
BEGIN

    INSERT INTO Z_SE164_ACCIONS_PART4 (ACCION_ID, RESPOSTA, ES_NECESSITA_RESPOSTA, NOM_USUARI_ACCIO, MATRICULA_USUARI_ACCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ASPECTE_ID, ELEMENT_PRINCIPAL_ID, AMBIT_ORIGEN_ID, PAS_ACCIO_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
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
                  PAS_ACCIO_ID,
                  ID_ORIGINAL,
                  ESQUEMA_ORIGINAL,
                  TABLA_ORIGINAL,
                  INSTALACIOID
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
							  ACCIONS_TODAS.PASS_ACCIO_ID AS PAS_ACCIO_ID,
                              ACCIONS_TODAS.ID_ORIGINAL AS ID_ORIGINAL, 
                              ACCIONS_TODAS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                              ACCIONS_TODAS.TABLA_ORIGINAL AS TABLA_ORIGINAL,
                              ACCIONS_TODAS.INSTALACIOID AS INSTALACIOID
				            FROM Z_SE161_ACCIONS_PART1 ACCIONS_TODAS
				                 LEFT OUTER JOIN 
				                    Z_SE162_ACCIONS_PART2 ACCIONS_CON_USUARIS
				                 ON   ACCIONS_TODAS.ACCION_ID = ACCIONS_CON_USUARIS.ACCION_ID 
				            WHERE ACCIONS_CON_USUARIS.ACCION_ID IS NULL   					 
					)ACCIONES_SIN_USUARIS
		WHERE NOT EXISTS (SELECT 1 
						    FROM Z_SE164_ACCIONS_PART4 ANTIGUOS
						   WHERE ANTIGUOS.ACCION_ID =  ACCIONES_SIN_USUARIS.ACCION_ID
						 );  

COMMIT;
END;

PROCEDURE SE165_ACCION IS
BEGIN
    INSERT INTO A1_ACCIO (ID, RESPOSTA, NOM_USUARI_ACCIO, MATRICULA_USUARI_ACCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SUBTIPUS_ACCIO_ID, ASPECTE_ID, ELEMENT_PRINCIPAL_ID, PAS_ACCIO_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
           SELECT A1_SEQ_ACCIO.NEXTVAL AS ID,
                  RESPOSTA,
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
                  PAS_ACCIO_ID,
                  ACCION_ID AS ID_ORIGINAL,
                  ESQUEMA_ORIGINAL,
                  TABLA_ORIGINAL,
                  INSTALACIOID
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
			                  PAS_ACCIO_ID,
                              ID_ORIGINAL,
                              ESQUEMA_ORIGINAL,
                              TABLA_ORIGINAL,
                              INSTALACIOID
			            FROM Z_SE163_ACCIONS_PART3
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
			                  PAS_ACCIO_ID,
                              ID_ORIGINAL,
                              ESQUEMA_ORIGINAL,
                              TABLA_ORIGINAL,
                              INSTALACIOID			
			            FROM Z_SE164_ACCIONS_PART4
			        )ACCIO_UNION
			        WHERE NOT EXISTS (SELECT 1 
			        				    FROM A1_ACCIO ANTIGUOS
			        				   WHERE ANTIGUOS.ID = ACCIO_UNION.ACCION_ID
			        				  ); 
                                      
        COMMIT;
        
        
        


COMMIT;
END;

PROCEDURE SE170_DOSSIER IS
BEGIN

 INSERT INTO A1_DOSSIER (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, PREFIX_ANY_ID, ASPECTE_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
        SELECT A1_SEQ_DOSSIER.NEXTVAL AS ID,
               SYSDATE AS DATA_CREACIO,
               FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
               FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
               PREFIXDOSSIERID AS PREFIX_ANY_ID,
               ASP.ID_ORIGINAL AS ASPECTE_ID,
               DOSSIER.ASPECTEID AS ID_ORIGINAL,
               'RISPLUS' AS ESQUEMA_ORIGINAL,
               'DOSSIER' AS TABLA_ORIGINAL,
               ConstInstalacioAlcaldia AS INSTALACIOID              
        FROM Z_T_RP_DOSSIER DOSSIER,
--             Z_T_RP_ASPECTES AS ASP
               A1_ASPECTE ASP
--        WHERE ASP.INSTALACIOID=ConstInstalacioAlcaldia
--           AND ASP.ASPECTEID = DOSSIER.ASPECTEID
        WHERE ASP.ID_ORIGINAL = DOSSIER.ASPECTEID
        AND NOT EXISTS (SELECT 1
                             FROM A1_DOSSIER ANTIGUOS
                            WHERE ANTIGUOS.ID_ORIGINAL = DOSSIER.ASPECTEID
                          );  
				
				


COMMIT;
END;

PROCEDURE SE180_ENTRADA_AGENDA IS
BEGIN

                  INSERT INTO A1_ENTRADA_AGENDA (ID, LLOC_BIS, DATA_INICI_ACTE, DATA_FI_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, ACOMPANYANT, VALORACIO, ASSISTENTS, ES_AFECTA_PROTOCOL, ES_DECISIO, ELEMENT_PRINCIPAL_ID, DECISIO_AGENDA_ID, TIPUS_AGENDA_ID, LLOC_ID, TIPUS_DATA_ID, DISTRICTE_ID, BARRI_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
                       SELECT A1_SEQ_ENTRADA_AGENDA.NEXTVAL AS ID,
                              NULL AS LLOC_BIS,
                              DATAINICI AS DATA_INICI_ACTE,
                              DATAFINAL AS DATA_FI_ACTE,
                              SYSDATE AS DATA_CREACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                              FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                              FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                              FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                              ACOMPANYANTS AS ACOMPANYANT,
                              VALORACIO AS VALORACIO,
                              ASSISTENTS AS ASSISTENTS,
                              AFECTAAGENDA AS ES_AFECTA_PROTOCOL,
                              DECISIOID AS ES_DECISIO,
                              (SELECT ID FROM A1_ELEMENT_PRINCIPAL EP WHERE EP.ASPECTE_ID = ASPECTE_ID AND ROWNUM=1) AS ELEMENT_PRINCIPAL_ID,
                              DECISIOID AS DECISIO_AGENDA_ID,
                              (SELECT ID FROM A1_DM_TIPUS_AGENDA TIP_AG WHERE TIP_AG.DESCRIPCIO = 'CONCRETA' AND AMBIT_ID=1) AS TIPUS_AGENDA_ID,
                              LLOCID AS LLOC_ID,
                              (SELECT ID FROM A1_DM_TIPUS_DATA TIP_DAT WHERE TIP_DAT.DESCRIPCIO = 'CONCRETA' AND AMBIT_ID=1) AS TIPUS_DATA_ID,
                              DISTRICTEID AS DISTRICTE_ID,
                              NULL AS BARRI_ID,
                              FITXAAGENDAID AS ID_ORIGINAL,
                              'RISPLUS' AS ESQUEMA_ORIGINAL,
                              'FITXESAGENDES' AS TABLA_ORIGINAL,
                              ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM Z_T_RP_FITXESAGENDES NUEVOS
                        WHERE INSTALACIOID = ConstInstalacioAlcaldia
                         AND NOT EXISTS (SELECT 1
                                            FROM A1_ENTRADA_AGENDA ANTIGUOS
                                           WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.FITXAAGENDAID
                                         );

                                        


COMMIT;
END;

PROCEDURE SE190_AGENDA_DELEGACIO IS
BEGIN

        INSERT INTO A1_AGENDA_DELEGACIO (ID, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, DESTI_DELEGACIO_ID, ENTRADA_AGENDA_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID) 
                       SELECT A1_SEQ_AGENDA_DELEGACIO.NEXTVAL AS ID, 
                      		  SYSDATE AS DATA_CREACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                              FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                              FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                              FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                              FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                              DELEGACIOID AS DESTI_DELEGACIO_ID,
                              AGENDA.ID AS ENTRADA_AGENDA_ID,
                              FITXAAGENDAID AS ID_ORIGINAL,
                              'RISPLUS' AS ESQUEMA_ORIGINAL,
                              'FITXESAGENDES'  AS TABLA_ORIGINAL,
                              ConstInstalacioAlcaldia AS INSTALACIOID
                        FROM Z_T_RP_FITXESAGENDES NUEVOS,
                             A1_ENTRADA_AGENDA AGENDA
                        WHERE DELEGACIOID IS NOT NULL
                        AND AGENDA.ID_ORIGINAL = NUEVOS.FITXAAGENDAID
                        AND NOT EXISTS (SELECT 1
                                            FROM A1_AGENDA_DELEGACIO ANTIGUOS
                                           WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.FITXAAGENDAID
                                             AND NVL(ANTIGUOS.DESTI_DELEGACIO_ID,1) = NVL(NUEVOS.DELEGACIOID,1)
                                         );

                                        


COMMIT;
END;


PROCEDURE SE200_CLASSIFICACIO_ARXIU IS
BEGIN

        INSERT INTO A1_CLASSIFICACIO_ARXIU (ID, DESCRIPTORS_TEMATICS, DATA_TRANSFERENCIA, DATA_ARXIU, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, SERIE_ID, ESPECIFIC_ID, ASPECTE_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID)
                SELECT A1_SEQ_CLASSIFICACIO_ARXIU.NEXTVAL AS ID,
                       DESCRIPTORSTEMATICS AS DESCRIPTORS_TEMATICS,
                       DATATRANSFERENCIA AS DATA_TRANSFERENCIA,
                       DATAARXIU AS DATA_ARXIU,
                       SYSDATE AS DATA_CREACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                       FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
--                       SERIEID AS SERIE_ID,
                       (SELECT ID FROM A1_DM_SERIE WHERE ID_ORIGINAL=SERIEID) AS SERIE_ID,
--                       ESPECIFICID AS ESPECIFIC_ID,
                       ESPECIFICID AS ESPECIFIC_ID,
                       ASP.ID AS ASPECTE_ID,
                       ARXIUID AS ID_ORIGINAL,
                       'RISPLUS' AS ESQUEMA_ORIGINAL,
                       'ARXIUS' AS TABLA_ORIGINAL,
                       ConstInstalacioAlcaldia AS INSTALACIOID
                  FROM Z_T_RP_ARXIUS NUEVOS,
                       A1_ASPECTE ASP
                 WHERE ASP.ID_ORIGINAL = NUEVOS.ASPECTEID
                  AND NOT EXISTS (SELECT 1
                          FROM A1_CLASSIFICACIO_ARXIU ANTIGUOS
                         WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ARXIUID
                       );  
                       


COMMIT;
END;

PROCEDURE SE210_ELEMENTS_RELACIONATS IS
BEGIN

    INSERT INTO A1_ELEMENTS_RELACIONATS (ID, ELEMENT_PRINCIPAL1, ELEMENT_PRINCIPAL2, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
            SELECT A1_SEQ_ELEMENTS_RELACIONATS.NEXTVAL AS ID,
               (SELECT ID FROM A1_ELEMENT_PRINCIPAL WHERE ID_ORIGINAL=RELAC.ELEMENTMESTRE) AS ELEMENT_PRINCIPAL1,
               (SELECT ID FROM A1_ELEMENT_PRINCIPAL WHERE ID_ORIGINAL=RELAC.ELEMENTRELACIONAT) AS ELEMENT_PRINCIPAL2,
               RELACIOELEMENTPRINCIPALID AS ID_ORIGINAL,
               'RISPLUS' AS TABLA_ORIGINAL,
               'RELACIONSELEMENTSPRINCI' AS TABLA_ORIGINAL
          FROM Z_T_RP_RELACIONSELEMENTSPRINCI RELAC          
        WHERE  NOT EXISTS (SELECT 1 
                             FROM A1_ELEMENTS_RELACIONATS ANTIGUOS
                            WHERE ANTIGUOS.ID_ORIGINAL = RELAC.RELACIOELEMENTPRINCIPALID
                          );  


COMMIT;
END;

PROCEDURE SE220_TITULAR_FORA IS
BEGIN
/*
      INSERT INTO A1_TITULAR_FORA (ID, TRACTAMENT, NOM, COGNOM1, COGNOM2, TIPUS_CONTACTE, ENTITAT, DEPARTAMENT, CARREC, DATA_VIGENCIA_CARREC, NOM_CARRER, CODI_CARRER, NUMERO_INICI, LLETRA_INICI, NUMERO_FI, LLETRA_FI, PIS, PORTA, ESCALA, BLOC, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, ASPECTE_ID, CONTACTE_ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_TIPUS_VIA, CODI_BARRI, BARRI, DISTRICTE, CODI_DISTRICTE, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, TRACTAMENT_ID)
                      SELECT A1_SEQ_TITULAR_FORA.NEXTVAL AS ID,
                       SUBJ.NOM AS NOM,
                       SUBJ.COGNOM1 AS COGNOM1,
                       SUBJ.COGNOM2 AS COGNOM2,
                       CONTACTE_SINTAGMA.TIPUS_CONTACTE_ID AS TIPUS_CONTACTE,
                       CONTACTE_RISPLUS.EMPRESA AS ENTITAT,
                       CONTACTE_RISPLUS.DEPARTAMENT AS DEPARTAMENT,
                       CONTACTE_RISPLUS.CARREC AS CARREC,
                       FUNC_FECHA_NULA(NULL) AS DATA_VIGENCIA_CARREC,
                       CONTACTE_RISPLUS.ADRECA AS NOM_CARRER, 
                       FUNC_NULOS_NUMERIC() AS CODI_CARRER, 
                       FUNC_NULOS_NUMERIC() AS NUMERO_INICI, 
                       FUNC_NULOS_STRING() AS LLETRA_INICI, 
                       FUNC_NULOS_NUMERIC() AS NUMERO_FI, 
                       FUNC_NULOS_STRING() AS LLETRA_FI, 
                       FUNC_NULOS_NUMERIC() AS PIS, 
                       FUNC_NULOS_STRING() AS PORTA, 
                       FUNC_NULOS_NUMERIC() AS ESCALA, 
                       FUNC_NULOS_NUMERIC() AS BLOC, 
                       CONTACTE_RISPLUS.CODIPOSTAL AS CODI_POSTAL, 
                       FUNC_NULOS_NUMERIC() AS COORDENADA_X, 
                       FUNC_NULOS_NUMERIC() AS COORDENADA_Y, 
                       FUNC_NULOS_STRING() AS SECCIO_CENSAL, 
                       FUNC_NULOS_NUMERIC() AS ANY_CONST, 
                       FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                       FUNC_FECHA_NULA() AS DATA_MODIFICACIO, 
                       FUNC_FECHA_NULA() AS DATA_ESBORRAT, 
                       FUNC_USUARI(NULL) AS USUARI_CREACIO, 
                       FUNC_USUARI(NULL) AS USUARI_MODIFICACIO, 
                       FUNC_USUARI(NULL) AS USUARI_ESBORRAT, 
                       EL.ASPECTEID AS ASPECTE_ID, 
                       CONTACTE_SINTAGMA.ID AS CONTACTE_ID, 
                       FUNC_NULOS_NUMERIC() AS CODI_MUNICIPI, 
                       CONTACTE_RISPLUS.MUNICIPI AS MUNICIPI, 
                       FUNC_NULOS_NUMERIC() AS CODI_PROVINCIA, 
                       CONTACTE_RISPLUS.PROVINCIA AS  PROVINCIA, 
                       FUNC_NULOS_NUMERIC() AS CODI_PAIS, 
                       CONTACTE_RISPLUS.PAIS AS PAIS, 
                       FUNC_NULOS_NUMERIC() AS CODI_TIPUS_VIA, 
                       FUNC_NULOS_NUMERIC() AS CODI_BARRI, 
                       FUNC_NULOS_STRING()  AS  BARRI, 
                       FUNC_NULOS_STRING() AS DISTRICTE, 
                       FUNC_NULOS_NUMERIC() AS CODI_DISTRICTE, 
                       CONTACTE_RISPLUS.CONTACTEID AS ID_ORIGINAL, 
                       'RISPLUS' AS ESQUEMA_ORIGINAL, 
                       'CONATCTES' AS TABLA_ORIGINAL, 
                       SUBJ.TRACTAMENT_ID AS TRACTAMENT_ID
                FROM Z_T_RP_CONTACTES CONTACTE_RISPLUS,
                     Z_T_RP_ELEMENTS EL,
                     A1_SUBJECTE SUBJ,
                     A1_CONTACTE CONTACTE_SINTAGMA
                WHERE EL.TITULARFORAID = CONTACTE_RISPLUS.CONTACTEID
                  AND (SUBJ.ID_ORIGINAL= CONTACTE_RISPLUS.CONTACTEID  AND SUBJ.ESQUEMA_ORIGINAL='RISPLUS')
                  AND (CONTACTE_SINTAGMA.ID_ORIGINAL = CONTACTE_RISPLUS.CONTACTEID  AND CONTACTE_SINTAGMA.ESQUEMA_ORIGINAL='RISPLUS');

*/
COMMIT;
END;



PROCEDURE RESETEATOR_TABLAS IS 
BEGIN
   DELETE FROM A1_TITULAR_FORA;
   
   DELETE FROM A1_ELEMENTS_RELACIONATS;
   
   DELETE FROM A1_CLASSIFICACIO_ARXIU;
   
   DELETE FROM A1_AGENDA_DELEGACIO;
   
   DELETE FROM A1_ENTRADA_AGENDA; 
   
   DELETE FROM A1_DOSSIER;

-- ANULADA   DELETE FROM A1_ACCIO_FINAL;
   DELETE FROM Z_SE164_ACCIONS_PART4;    --ACCIONES CON USUARIS NULL
   DELETE FROM Z_SE163_ACCIONS_PART3;    --ACCIONES CON USUARIS RELLENADOS
   DELETE FROM Z_SE162_ACCIONS_PART2;
   DELETE FROM Z_SE161_ACCIONS_PART1;
   DELETE FROM Z_SE160_ACCION_ELEMENTS_PPAL;

   DELETE FROM Z_SE151_RELAC_ELEMENT_PPAL_SEC; 
   DELETE FROM Z_SE150_ELEMENTS_SEC_ACCION;
   
   DELETE FROM A1_ELEMENT_PRINCIPAL;
   DELETE FROM Z_SE999_ELEMENT_PRINCIPAL;
   DELETE FROM Z_SE140_ELEMENT_PRINCIPAL;

   DELETE FROM A1_TITULAR_DINS;   
   DELETE FROM Z_SE130_TITULARDINS;
   
   
   
   DELETE FROM A1_DOSSIER;
   DELETE FROM Z_SE999_DOSSIER;
   
   DELETE FROM A1_ASPECTE;
   DELETE FROM Z_SE999_ASPECTE;
   DELETE FROM Z_SE113_ASPECTES_DOSSIER;
   DELETE FROM Z_SE112_ASPECTES_ELEMENT_SEC;
   DELETE FROM Z_SE111_ASPECTES_ELEMENT_PPAL;
   DELETE FROM Z_SE110_ASPECTE_ACCIO;
   
   --CATÁLOGOS 
   DELETE FROM A1_DM_TIPUS_DATA;
   DELETE FROM Z_SE999_DM_TIPUS_DATA;
   DELETE FROM Z_SE100_TIPUS_DATA;

   DELETE FROM A1_DM_TIPUS_ARG;
   DELETE FROM Z_SE999_DM_TIPUS_ARG;   
--   DELETE FROM Z_SE090_TIPUS_ARG;

--   DELETE FROM A1_DM_ORIGEN_ELEMENT;
   DELETE FROM Z_SE999_DM_ORIGEN_ELEMENT;   
   DELETE FROM Z_SE080_ORIGEN_ELEMENT;
    
   DELETE FROM A1_DM_TIPUS_AGENDA;   
   DELETE FROM Z_SE999_DM_TIPUS_AGENDA;
   DELETE FROM Z_SE070_TIPUS_AGENDA;
   
--   DELETE FROM A1_DM_PAS_ACCIO;
--   DELETE FROM Z_SE061_DM_PAS_ACCIO;
--   DELETE FROM Z_SE060_PAS_ACCIO;

   

   
--   DELETE FROM A1_DM_ESTAT_ELEMENT;
   DELETE FROM Z_SE999_DM_ESTAT_ELEMENT;               
   DELETE FROM Z_SE050_ESTAT_ELEMENT;

   DELETE FROM A1_DM_PREFIX; 
   DELETE FROM Z_SE043_DM_PREFIX;
   DELETE FROM A1_DM_CATALEG_DOCUMENT;
   DELETE FROM Z_SE042_DM_CATALEG_DOCUMENT;
   DELETE FROM A1_DM_SERIE;
   DELETE FROM Z_SE040_SERIES_SUBSERIES;

    DELETE FROM A1_DM_TIPUS_SUPORT;
    DELETE FROM Z_SE999_DM_TIPUS_SUPORT;

    DELETE FROM A1_DM_PREFIX_ANY;
    DELETE FROM Z_SE999_DM_PREFIX_ANY;

    DELETE FROM A1_DM_PRIORITAT_ELEMENT;
    DELETE FROM Z_SE999_DM_PRIORITAT_ELEMENT;

    DELETE FROM A1_DM_DECISIO_AGENDA;
    DELETE FROM Z_SE999_DM_DECISIO_AGENDA;

    DELETE FROM A1_DM_TIPUS_ELEMENT;
    DELETE FROM Z_SE999_DM_TIPUS_ELEMENT;
    
    DELETE FROM A1_DM_DESTI_DELEGACIO;
    DELETE FROM Z_SE999_DM_DESTI_DELEGACIO;

    DELETE FROM A1_TRANSICIO_TRAMITACIO;

    DELETE FROM A1_DM_PAS_ACCIO;

    DELETE FROM A1_DM_SUBTIPUS_ACCIO;
    DELETE FROM Z_SE999_DM_SUBTIPUS_ACCIO;
    DELETE FROM Z_SE025_DM_SUBTIPUSACCIO;    

    
    DELETE FROM A1_DM_TIPUS_ACCIO;
    DELETE FROM Z_SE999_DM_TIPUS_ACCIO;
    DELETE FROM Z_SE020_TIPUSACCIO_DMTIPUSACCI;
    
    DELETE FROM A1_DM_ESPECIFIC;
    
    DELETE FROM A1_DM_TIPUS_TEMA;
    DELETE FROM Z_SE999_DM_TIPUS_TEMA;
    
    DELETE FROM A1_DM_DISTRICTE;
    DELETE FROM Z_SE999_DM_DISTRICTE;
    
    DELETE FROM A1_DM_LLOC;
    DELETE FROM Z_SE999_DM_LLOC;

    DELETE FROM Z_SE003_AMBITS;
    DELETE FROM Z_SE002_INSTALACIO_AMBIT_PART;
    DELETE FROM Z_SE001_PARTICIONES;
    
    
--    DELETE FROM Z_F010_DM_LLOCS;


COMMIT;
END;


  PROCEDURE RESETEATOR_SECUENCIAS IS         
            TYPE V_Sequence IS VARRAY(1) OF VARCHAR2(100);
            Secuencia V_Sequence;
            total integer;  
    
    BEGIN
    
            
        Secuencia := V_Sequence('A1_SEQ_DM_TIPUS_ACCIO'
                 );
        
                     
                
        total := Secuencia.count; 


        
        FOR i in 1 .. total LOOP
                execute immediate 'DROP SEQUENCE ' || Secuencia(i);  
                execute immediate 'CREATE SEQUENCE ' || Secuencia(i) || ' MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE';            
        END LOOP;
    END;
  
/*

DROP SEQUENCE A1_SEQ_DM_TIPUS_ACCIO;
CREATE SEQUENCE A1_SEQ_DM_TIPUS_ACCIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  A1_SEQ_DM_TIPUS_ELEMENT;
CREATE SEQUENCE A1_SEQ_DM_TIPUS_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  A1_SEQ_SERIE_SUBSERIE;
CREATE SEQUENCE A1_SEQ_SERIE_SUBSERIE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE A1_SEQ_DM_ESTAT_ELEMENT;
CREATE SEQUENCE A1_SEQ_DM_ESTAT_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE A1_SEQ_DM_ORIGEN_ELEMENT;
CREATE SEQUENCE A1_SEQ_DM_ORIGEN_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE A1_SEQ_DM_PAS_ACCIO;
CREATE SEQUENCE A1_SEQ_DM_PAS_ACCIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE A1_SEQ_DM_PRIORITAT_ELEMENT;
CREATE SEQUENCE A1_SEQ_DM_PRIORITAT_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE A1_SEQ_DM_TIPUS_AGENDA;
CREATE SEQUENCE A1_SEQ_DM_TIPUS_AGENDA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

--DROP SEQUENCE A1_SEQ_DM_TIPUS_ARG;
--CREATE SEQUENCE A1_SEQ_DM_TIPUS_ARG MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE A1_SEQ_DM_TIPUS_DATA;
CREATE SEQUENCE A1_SEQ_DM_TIPUS_DATA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  A1_SEQ_TITULAR_DINS;
CREATE SEQUENCE A1_SEQ_TITULAR_DINS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  A1_SEQ_DOSSIER;
CREATE SEQUENCE A1_SEQ_DOSSIER MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  A1_SEQ_AGENDA_DELEGACIO;
CREATE SEQUENCE A1_SEQ_AGENDA_DELEGACIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;


*/

END S_05_TEMAS_RISPLUS;

/
