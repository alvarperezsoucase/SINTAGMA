--------------------------------------------------------
--  DDL for Package Body Z_PRE_CONVIDATS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."Z_PRE_CONVIDATS" AS


  

/*
  PROCEDURE D001_TIPOLOGIA_OBSEQUI
  BEGIN
    
        INSERT INTO Z_D001_TIPOLOGIA_OBSEQUI
            SELECT ID AS ID,
                   PROVEIDOR AS DESCRIPCIO
                   SYSDATE AS DATA_CREACIO,
                   FUNC_NULOS_DATE(NULL) AS DATA_MODIFICACIO,
                   FUNC_NULOS_DATE(NULL) AS DATA_ESBORRAT,
                   'MIGRACIO' AS USUARI_CREACIO,
                   FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                   FUNC_NULOS_STRING() AS USUARI_ESBORRAT
            FROM Z_T       
                    
            
  
  COMMIT;
  END;
  */
  
  --BUSCAMOS LAS CLASFICACIONES QUE YA EXISTEN COMPARANDO POR NORMALIZACIÓN DE DESCRIPCIÓN.
  PROCEDURE G001_YA_EXISTS_CLASIFFICACIO IS
  BEGIN
  
     INSERT INTO Z_G001_YA_EXISTS_CLASIFFICACIO (ID_SINTAGMA, ID_SIAP, DM_CODI, DM_DESCRIPCIO,  SIAP_CODI, SIAP_CLASSIFICACIO)
      SELECT ID_SINTAGMA,
             ID_SIAP as ID_SIAP,
             DM_CODI,
             DM_DESCRIPCIO,             
             SIAP_CODI,
             SIAP_CLASSIFICACIO
        FROM (     
               SELECT CL.ID AS ID_SINTAGMA, 
                      CL.CODI AS DM_CODI,
                      CL.DESCRIPCIO AS DM_DESCRIPCIO, 
                      SIAP.id AS ID_SIAP, 
                      SIAP.CODI AS SIAP_CODI, 
                      SIAP.CLASSIFICACIO AS SIAP_CLASSIFICACIO
                 FROM PRE_DM_CLASSIFICACIO CL,
                      Z_T_SIAP_CLASSIFICACIONS SIAP		 
                WHERE CL.DESCRIPCIO = SIAP.CLASSIFICACIO
                   OR CL.CODI = SIAP.CODI
             ) CLASSIFICACIO_EXISTEN        
         WHERE NOT EXISTS (SELECT 1
                           FROM Z_G001_YA_EXISTS_CLASIFFICACIO ANTIGUOS
                           WHERE ANTIGUOS.DM_DESCRIPCIO = CLASSIFICACIO_EXISTEN.SIAP_CLASSIFICACIO 
                              OR ANTIGUOS.DM_CODI = CLASSIFICACIO_EXISTEN.SIAP_CODI
                          );
  
  
  COMMIT;
  END;
  
  
  PROCEDURE G002_NUEVOS_CLASSIFICACIO IS
  BEGIN
  
              INSERT INTO Z_G002_NUEVOS_CLASIFFICACIO (ID_SINTAGMA, ID_SIAP, SIAP_CODI, SIAP_CLASSIFICACIO, SIAP_OBSOLET)
                        SELECT (SEQ_PRE_DM_CLASSIFICACIO.NEXTVAL) AS ID_SINTAGMA,
                               NUEVOS.ID_SIAP AS ID_SIAP, 
                               NUEVOS.SIAP_CODI AS SIAP_CODI, 
                               NUEVOS.SIAP_CLASSIFICACIO AS SIAP_CLASSIFICACIO, 
                               NUEVOS.SIAP_OBSOLET AS SIAP_OBSOLET
                        FROM (	   
                                SELECT ID AS ID_SIAP,
                                       CODI AS SIAP_CODI,
                                       CLASSIFICACIO AS SIAP_CLASSIFICACIO, 
                                       OBSOLET AS SIAP_OBSOLET
                                  FROM Z_T_SIAP_CLASSIFICACIONS
                                 WHERE ID NOT IN ( SELECT SIAP.ID 
                                                     FROM Z_T_SIAP_CLASSIFICACIONS SIAP
                                                    WHERE SIAP.CODI IN (SELECT CODI 
                                                                          FROM Z_PRE_DM_CLASSIFICACIO
                                                                       )
					
				                                 )	
                                   AND CLASSIFICACIO IS NOT NULL                        
                            ) NUEVOS 
                            WHERE NOT EXISTS (SELECT 1
                                                FROM Z_G002_NUEVOS_CLASIFFICACIO ANTIGUOS
                                               WHERE ANTIGUOS.ID_SIAP = NUEVOS.ID_SIAP
                                              ); 

  
  
  COMMIT;
  END;
  
  --TABLA QUE RELACIONA SINTAGMA_ID CON SIAP_ID (POSTERIORMENTE SE INSERTARÁ EN EL CATÁLOGO, PERO ÉSTA NOS SIRVE PARA RELACIONAR SÓLO LAS DE SIAP)
  PROCEDURE G003_CLASSIF_SIAP_SINTAGMA IS
  BEGIN
  
    --a) SE GENERA TABLA DE RELACION
    INSERT INTO Z_G003_CLASSIF_SIAP_SINTAGMA (ID_SINTAGMA, ID_SIAP, SIAP_CODI, SIAP_CLASSIFICACIO)
            SELECT TODOS.ID_SINTAGMA, 
                   TODOS.ID_SIAP, 
                   TODOS.SIAP_CODI, 
                   TODOS.SIAP_CLASSIFICACIO
            FROM (       
					SELECT ID_SINTAGMA AS ID_SINTAGMA,
					       ID_SIAP AS ID_SIAP,
					       SIAP_CODI,
					       SIAP_CLASSIFICACIO
					FROM Z_G001_YA_EXISTS_CLASIFFICACIO
					  UNION ALL 
					SELECT ID_SINTAGMA AS ID_SINTAGMA,
					       ID_SIAP AS ID_SIAP,
					       SIAP_CODI,
					       SIAP_CLASSIFICACIO
					FROM Z_G002_NUEVOS_CLASIFFICACIO  
  			) TODOS
       WHERE NOT EXISTS (SELECT 1 
       					   FROM Z_G003_CLASSIF_SIAP_SINTAGMA ANTIGUOS
       					  WHERE ANTIGUOS.ID_SIAP =TODOS.ID_SIAP
       					 );  
    
    COMMIT;
    
      --SE INSERTAN LOS NUEVOS EN CATALOGI
             INSERT INTO PRE_DM_CLASSIFICACIO (ID, DESCRIPCIO, CODI, PRELACIO, DATA_INICI_REVISO, DATA_FI_REVISIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPOLOGIA_ID, AMBIT_ID)
                       SELECT SIAP.ID_SINTAGMA AS ID, 
                              SIAP.SIAP_CLASSIFICACIO AS DESCRIPCIO, 
                              SIAP.SIAP_CODI AS CODI, 
                              0 AS PRELACIO, 
                              NULL AS DATA_INICI_REVISO, 
                              NULL AS DATA_FI_REVISIO, 
                              SYSDATE AS DATA_CREACIO, 
                              NULL AS DATA_ESBORRAT, 
                              NULL AS DATA_MODIFICACIO, 
                              'MIGRACIO' AS USUARI_CREACIO, 
                              NULL AS USUARI_ESBORRAT, 
                              NULL AS USUARI_MODIFICACIO, 
                              1 AS TIPOLOGIA_ID, 
                              2 AS AMBIT_ID
                        FROM Z_G002_NUEVOS_CLASIFFICACIO SIAP
                       WHERE NOT EXISTS (SELECT 1   
                                           FROM PRE_DM_CLASSIFICACIO ANTIGUOS
                                          WHERE ANTIGUOS.ID = SIAP.ID_SINTAGMA
                                         ); 

  
  COMMIT;
  END;
  
  /* se ha metido en a_00_inserts
  PROCEDURE G010_ESTAT_CONFIRMACIO IS
  BEGIN
  
        INSERT INTO DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                    VALUES(1, 'PENDENT', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL);
    
        INSERT INTO DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                    VALUES(2, 'CONFIRMAT', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL);
                    
        INSERT INTO DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                    VALUES(3, 'DELEGAT', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL);
                    
        INSERT INTO DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                    VALUES(4, 'REBUTJAT', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL);                    
                    
  
  
  COMMIT;
  END;
  */
  /*
  PROCEDURE G011_TIPUS_VIA_INVITACIO IS
  BEGIN
  
    INSERT INTO DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(1, 'INVITACIÓ TIPUS 1', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);

    INSERT INTO DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(2, 'INVITACIÓ TIPUS 2', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);


    INSERT INTO DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(3, 'INVITACIÓ TIPUS 3', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);
  
    INSERT INTO DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(4, 'INVITACIÓ TIPUS 4', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);

  
  COMMIT;
  END;
  */
  /*
  PROCEDURE G012_INICIATIVA_RESPOSTA IS
  BEGIN
  
        INSERT INTO DM_INICIATIVA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                    VALUES(1, 'CONVIDAT', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);

        INSERT INTO DM_INICIATIVA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                    VALUES(2, 'ALCALDIA', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);


  COMMIT;
  END;
  */
  
  
  /*
  PROCEDURE G013_TIPUS_VIA_RESPOSTA IS
  BEGIN
  
      INSERT INTO DM_TIPUS_VIA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(1, 'VIA RESPOSTA 1', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);


      INSERT INTO DM_TIPUS_VIA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(2, 'VIA RESPOSTA 2', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);
  
      INSERT INTO DM_TIPUS_VIA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(3, 'VIA RESPOSTA 3', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);
  
  COMMIT;
  END;
*/
  PROCEDURE G020_TIPUS_ACTE_SIAP IS
  BEGIN
  
           INSERT INTO Z_G020_TIPUS_ACTE_SIAP (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                         SELECT ID,
                                ID AS CODI,
                                TIPUS_ACTE AS DESCRIPCIO,
                                SYSDATE AS DATA_CREACIO,
                                FUNC_NULOS_INSERT() AS  DATA_ESBORRAT, 
                                FUNC_NULOS_INSERT() AS DATA_MODIFICACIO, 
                                'MIGRACIO' AS USUARI_CREACIO, 
                                FUNC_NULOS_INSERT() AS USUARI_ESBORRAT, 
                                FUNC_NULOS_INSERT() AS USUARI_MODIFICACIO
                         FROM Z_T_SIAP_TIPUS_ACTE NUEVOS
                         WHERE NOT EXISTS (SELECT 1 
                                             FROM Z_G020_TIPUS_ACTE_SIAP ANTIGUOS
                                            WHERE ANTIGUOS.ID = NUEVOS.ID
                                           );
                                           
    
  
  COMMIT;
  END;
  

  PROCEDURE G021_TIPUS_ACTE_VIPS IS
     max_ID_SIAP number;
  BEGIN
  
   SELECT MAX(ID) INTO max_ID_SIAP 
              FROM Z_G020_TIPUS_ACTE_SIAP;
       
       
            max_ID_SIAP := max_ID_SIAP +1;
            
            SET_SEQ('SEQ_PRE_DM_TIPUS_ACTE',max_ID_SIAP);
       
        INSERT INTO Z_G021_TIPUS_ACTE_VIPS (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                 SELECT ( max_ID_SIAP + SEQ_PRE_DM_TIPUS_ACTE.NEXTVAL) AS ID,
                        CODI AS CODI,
                        DESCRIPCIO AS DESCRIPCIO,
                        SYSDATE AS DATA_CREACIO,
                        FUNC_NULOS_INSERT() AS  DATA_ESBORRAT, 
                        FUNC_NULOS_INSERT() AS DATA_MODIFICACIO, 
                        'MIGRACIO' AS USUARI_CREACIO, 
                        FUNC_NULOS_INSERT() AS USUARI_ESBORRAT, 
                        FUNC_NULOS_INSERT() AS USUARI_MODIFICACIO
                 FROM Z_TMP_VIPS_U_T_ACTES NUEVOS
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_G021_TIPUS_ACTE_VIPS ANTIGUOS
                                    WHERE ANTIGUOS.CODI = NUEVOS.CODI 
                                   );
    
  
  COMMIT;
  END;

  --BUSCAMOS LOS ACTOS QUE COINCIDEN POR DESCRIPCION. ASIGNAMOS EL CODI DE VIPS (QUE SÍ LO TIENEN)
  PROCEDURE G022_TIPUS_ACTE_SIAP_VIPS IS
  BEGIN

    INSERT INTO Z_G022_TIPUS_ACTE_SIAP_VIPS (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
         SELECT ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO
            FROM (
                SELECT SIAP.ID AS ID,
                       VIPS.CODI AS CODI,
                       SIAP.DESCRIPCIO AS DESCRIPCIO,
                       SIAP.DATA_CREACIO,
                       SIAP.DATA_ESBORRAT, 
                       SIAP.DATA_MODIFICACIO, 
                       SIAP.USUARI_CREACIO, 
                       SIAP.USUARI_ESBORRAT, 
                       SIAP.USUARI_MODIFICACIO
                    FROM Z_G020_TIPUS_ACTE_SIAP SIAP,
                         Z_G021_TIPUS_ACTE_VIPS VIPS
                   WHERE SIAP.DESCRIPCIO = VIPS.DESCRIPCIO
                  ) SIAP_VIPS
                  WHERE NOT EXISTS (SELECT 1
                                     FROM  Z_G022_TIPUS_ACTE_SIAP_VIPS ANTIGUOS
                                    WHERE ANTIGUOS.CODI = SIAP_VIPS.CODI
                                   );
                                    


  COMMIT;
  END;

  --BUSCAMOS LOS ACTOS QUE NO COINCIDEN POR DESCRIPCION Y ASIGANAMOS COMO CODI EL ID DE SIAP
  PROCEDURE G023_TIPUS_ACTE_RESTANTES IS
  BEGIN

    INSERT INTO Z_G023_TIPUS_ACTE_RESTANTES (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
         SELECT ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO
            FROM (
                    SELECT SIAP.ID AS ID,
                               SIAP.ID AS CODI,
                               SIAP.DESCRIPCIO AS DESCRIPCIO,
                               SIAP.DATA_CREACIO,
                               SIAP.DATA_ESBORRAT, 
                               SIAP.DATA_MODIFICACIO, 
                               SIAP.USUARI_CREACIO, 
                               SIAP.USUARI_ESBORRAT, 
                               SIAP.USUARI_MODIFICACIO
                        FROM Z_G020_TIPUS_ACTE_SIAP SIAP
                        LEFT OUTER JOIN 
                             Z_G021_TIPUS_ACTE_VIPS VIPS
                        ON   SIAP.DESCRIPCIO = VIPS.DESCRIPCIO  
                        WHERE VIPS.DESCRIPCIO IS NULL
                  ) SIAP_VIPS_RESTO
                  WHERE NOT EXISTS (SELECT 1
                                     FROM  Z_G023_TIPUS_ACTE_RESTANTES ANTIGUOS
                                    WHERE ANTIGUOS.DESCRIPCIO = SIAP_VIPS_RESTO.DESCRIPCIO
                                   );
                                    


  COMMIT;
  END;


  PROCEDURE G024_DM_TIPUS_ACTE IS
  BEGIN
  
        INSERT INTO Z_G024_DM_TIPUS_ACTE (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                      SELECT 
                            ID AS ID,
                            CODI AS CODI,
                            DESCRIPCIO AS DESCRIPCIO,
                            DATA_CREACIO,
                            DATA_ESBORRAT, 
                            DATA_MODIFICACIO, 
                            USUARI_CREACIO, 
                            USUARI_ESBORRAT, 
                            USUARI_MODIFICACIO
                    FROM         Z_G022_TIPUS_ACTE_SIAP_VIPS
                      UNION ALL 
                    SELECT 
                            ID AS ID,
                            CODI AS CODI,
                            DESCRIPCIO AS DESCRIPCIO,
                            DATA_CREACIO,
                            DATA_ESBORRAT, 
                            DATA_MODIFICACIO, 
                            USUARI_CREACIO, 
                            USUARI_ESBORRAT, 
                            USUARI_MODIFICACIO
                    FROM         Z_G023_TIPUS_ACTE_RESTANTES  
  
            COMMIT;
            
            INSERT INTO PRE_DM_TIPUS_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                SELECT ID, 
                       DESCRIPCIO, 
                       DATA_CREACIO, 
                       DATA_ESBORRAT, 
                       DATA_MODIFICACIO, 
                       USUARI_CREACIO, 
                       USUARI_ESBORRAT, 
                       USUARI_MODIFICACIO
                  FROM Z_G024_DM_TIPUS_ACTE NUEVOS
                 WHERE NOT EXISTS (SELECT 1 
                                    FROM PRE_DM_TIPUS_ACTE ANTIGUOS
                                   WHERE ANTIGUOS.ID = NUEVOS.ID
                                  ); 
                                    
            
            COMMIT;
            
  END;
  


  PROCEDURE G040_SECTORS IS
  BEGIN
  
        INSERT INTO PRE_DM_SECTOR (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
            SELECT ID,
                SUBSTR(SECTOR,1,50) AS DESCRIPCIO,
                SYSDATE AS DATA_CREACIO,
                NULL AS  DATA_ESBORRAT, 
                NULL AS DATA_MODIFICACIO, 
                'MIGRACIO' AS USUARI_CREACIO, 
                NULL AS USUARI_ESBORRAT, 
                NULL AS USUARI_MODIFICACIO
             FROM Z_T_SIAP_SECTORS NUEVOS
            WHERE NOT EXISTS (SELECT 1 
                                FROM PRE_DM_SECTOR ANTIGUOS
                               WHERE ANTIGUOS.ID = NUEVOS.ID
                             );
  
  
                
  
  COMMIT;
  END;


   PROCEDURE G041_CATEGORIAS IS
   BEGIN
   
    INSERT INTO PRE_DM_CATEGORIA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
             SELECT ID,
                    CATEGORIA AS DESCRIPCIO,
                    SYSDATE AS DATA_CREACIO,
                    NULL AS  DATA_ESBORRAT, 
                    NULL AS DATA_MODIFICACIO, 
                    'MIGRACIO' AS USUARI_CREACIO, 
                    NULL AS USUARI_ESBORRAT, 
                    NULL AS USUARI_MODIFICACIO
             FROM Z_T_SIAP_CATEGORIES NUEVOS
             WHERE NOT EXISTS (SELECT 1 
                                FROM PRE_DM_CATEGORIA ANTIGUOS
                               WHERE ANTIGUOS.ID = NUEVOS.ID
                             );
  
   
   COMMIT;
   END;

/*
  --METER LOS DE SIAP Y VIPS  
  PROCEDURE G042_TIPUS_ACTE_CODI IS
  
       max_ID_SIAP number;
   
  BEGIN
  
        --SIAP
        INSERT INTO Z_G042_TIPUS_ACTE_CODI (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                 SELECT ID,
                        ID AS CODI,
                        TIPUS_ACTE AS DESCRIPCIO,
                        SYSDATE AS DATA_CREACIO,
                        NULL AS  DATA_ESBORRAT, 
                        NULL AS DATA_MODIFICACIO, 
                        'MIGRACIO' AS USUARI_CREACIO, 
                        NULL AS USUARI_ESBORRAT, 
                        NULL AS USUARI_MODIFICACIO
                 FROM Z_T_SIAP_TIPUS_ACTE NUEVOS
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_G042_TIPUS_ACTE_CODI ANTIGUOS
                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                   );
        
       --VIPS (EN VIPS NO TIENEN ID, VAN POR CODI, ASÍ QUE SE EMPEZARÁ A METER COMO ID EL MAX(ID) + SEQUENCIA
       SELECT MAX(ID) INTO max_ID_SIAP 
              FROM Z_G042_TIPUS_ACTE_CODI;
       
        INSERT INTO Z_G043_TIPUS_ACTE_CODI_VIPS (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                 SELECT ( max_ID_SIAP + AUX_SEQ_DM_TIPUS_ACTE.NEXTVAL) AS ID,
                        CODI AS CODI,
                        DESCRIPCIO AS DESCRIPCIO,
                        SYSDATE AS DATA_CREACIO,
                        NULL AS  DATA_ESBORRAT, 
                        NULL AS DATA_MODIFICACIO, 
                        'MIGRACIO' AS USUARI_CREACIO, 
                        NULL AS USUARI_ESBORRAT, 
                        NULL AS USUARI_MODIFICACIO
                 FROM Z_TMP_VIPS_U_T_ACTES NUEVOS
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_G043_TIPUS_ACTE_CODI_VIPS ANTIGUOS
                                    WHERE ANTIGUOS.CODI = NUEVOS.CODI 
                                      OR ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                   );
       
       
       
  COMMIT;
  END;
*/

  PROCEDURE G043_PRESIDENT IS
  BEGIN
  
    INSERT INTO PRE_DM_PRESIDENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                 SELECT ID,
                        PRESIDENT AS DESCRIPCIO,
                        SYSDATE AS DATA_CREACIO,
                        NULL AS  DATA_ESBORRAT, 
                        NULL AS DATA_MODIFICACIO, 
                        'MIGRACIO' AS USUARI_CREACIO, 
                        NULL AS USUARI_ESBORRAT, 
                        NULL AS USUARI_MODIFICACIO
                 FROM Z_T_SIAP_PRESIDENTS NUEVOS
                 
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM PRE_DM_PRESIDENT ANTIGUOS
                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                   )
                   AND ID<>104;--REPETIDO Y PARCHE                
  
  COMMIT;
  END;
  
  
  PROCEDURE G044_PETICIONARI IS
  BEGIN
  
     INSERT INTO PRE_DM_PETICIONARI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                 SELECT ID,
                        SUBSTR(PETICIONARI,1,50) AS DESCRIPCIO,
                        SYSDATE AS DATA_CREACIO,
                        NULL AS  DATA_ESBORRAT, 
                        NULL AS DATA_MODIFICACIO, 
                        'MIGRACIO' AS USUARI_CREACIO, 
                        NULL AS USUARI_ESBORRAT, 
                        NULL AS USUARI_MODIFICACIO
                 FROM Z_T_SIAP_PETICIONARIS NUEVOS
                 WHERE NOT EXISTS (SELECT 1 
                                     FROM PRE_DM_PETICIONARI ANTIGUOS
                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                   )
                  AND OBSOLET IS NOT NULL;
  
  COMMIT;
  END;
  
  
  --ÁUX CATÁLOGO Y SE RELLENA DM
  PROCEDURE G045_ESTAT_ACTE IS
  BEGIN
            
            --SE SACA UNA AGRUPACIÓN DE LOS DISTINTOS ESTADOS Y SE ASIGNA UNA SECUENCIA
            INSERT INTO Z_G045_ESTAT_ACTE (ID,DESCRIPCIO)
                        SELECT SEQ_PRE_DM_ESTAT_ACTE.NEXTVAL AS ID,
                               ESTATS.ESTAT AS DESCRIPCIO	   
                        FROM ( 
                                SELECT ESTAT AS ESTAT
                                  FROM Z_T_SIAP_ACTES 
                                 GROUP BY ESTAT
                             ) ESTATS
                         WHERE NOT EXISTS (SELECT 1
                                  FROM Z_G045_ESTAT_ACTE ANTIGUOS 
                                 WHERE ANTIGUOS.DESCRIPCIO = ESTATS.ESTAT
                                );
              COMMIT;
                 
        INSERT INTO PRE_DM_ESTAT_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)         
                 SELECT ID AS ID, 
                        DESCRIPCIO AS DESCRIPCIO, 
                        SYSDATE AS DATA_CREACIO, 
                        NULL AS DATA_ESBORRAT, 
                        NULL AS DATA_MODIFICACIO, 
                        'MIGRACIO' AS USUARI_CREACIO, 
                        NULL AS USUARI_ESBORRAT, 
                        NULL AS USUARI_MODIFICACIO
                   FROM Z_G045_ESTAT_ACTE NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM PRE_DM_ESTAT_ACTE ANTIGUOS
                                    WHERE  ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                  );  

                             
                             
  
  COMMIT;
  END;
/* SE HA MOVIDO A A_00_INSERTS
    --GESTIÓN DE ESTADO DE LA INVITACION
    --OJO, LOS DATOS DEL CATÁLOGO SE PODRÍAN SACAR DE VIPS_ACTES (CAMPO ASSITIR)
   PROCEDURE G046_GESTIO_INVITACIO IS
   BEGIN
   
   
        INSERT INTO DM_ESTAT_GESTIO_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI)
                VALUES(1, 'ASSISTIR', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL,'E1');


      INSERT INTO DM_ESTAT_GESTIO_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI)
                VALUES(2, 'NO ASSISTIR', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL,'E2');
  
      INSERT INTO DM_ESTAT_GESTIO_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI)                  
                VALUES(3, 'PENDENT 3', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL,'E3');
        
   
   COMMIT;
   END;
*/
    --GESTIÓN DE ESTADO DEL ESPACIO    
/*    
   PROCEDURE G047_GESTIO_ESPAIS IS
   BEGIN
   
   
      INSERT INTO DM_ESTAT_GESTIO_ESPAIS (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(1, 'PLE', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);


      INSERT INTO DM_ESTAT_GESTIO_ESPAIS (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(2, 'ESPAI DISPONIBLE', SYSDATE,  NULL, NULL, 'MIGRACIO', NULL, NULL);        
   
   COMMIT;
   END;
*/
    PROCEDURE G90_ELEMENT_PRINCIPALS IS
    BEGIN
            --OJO AUXELEMENT_PRINCIPAL ES PORQUE SE NECESITA ELEMT_PRINIPAL SIN RELACION
            INSERT INTO PRE_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                SELECT SEQ_PRE_ELEMENT_PRINCIPAL.NEXTVAL AS ID,
                       SEQ_PRE_ELEMENT_PRINCIPAL.CURRVAL AS NUMERO_REGISTRE, 
                       NULL AS ES_RELACIO_ENTRADA, 
                       NULL AS DATA_RELACIO_ENTRADA, 
                       NULL AS ES_VALIDAT_RE, 
                       NULL AS DATA_REGISTRE_GENERAL, 
                       NULL AS DATA_INICI_SEGUIMENT, 
                       NULL AS DATA_FI_SEGUIMENT, 
                       NULL AS NOM_USUARI_RESPONSABLE, 
                       NULL AS MATRICULA_USUARI_RESPONSABLE, 
                       NULL AS DATA_DOCUMENT,
                       NULL AS DATA_TERMINI, 
                       NULL AS DATA_RESPOSTA, 
                       NULL AS DATA_RESOLUCIO, 
                       ACTE.DESCRIPCIO AS NOM_ACTE, 
                       FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                       FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO, 
                       FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT, 
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO, 
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT, 
                       NULL AS AFECTA_AGENDA_ID, 
                       NULL AS ORIGEN_ID, 
                       NULL AS PRIORITAT_ID, 
                       NULL AS TIPUS_ELEMENT_ID, 
                       NULL AS ASPECTE_ID, 
                       NULL AS DOSSIER_ID, 
                       NULL AS ESTAT_ELEMENT_PRINCIPAL_ID, 
                       NULL AS TIPUS_SUPORT_ID, 
                       NULL AS TIPUS_AMBIT_ID, 
                       NULL AS TIPUS_ARG_ID, 
                       NULL AS PREFIX_ID, 
                       NULL AS NUMERO_REGISTRE_GENERAL_ID, 
                       NULL AS ELEMENT_PRINCIPAL_ORIGEN_ID, 
                       ACTE.ID AS ID_ORIGINAL, 
                       'SIAP' AS ESQUEMA_ORIGINAL, 
                       'ACTES' AS TABLA_ORIGINAL, 
                       30 AS INSTALACIOID
                  FROM Z_T_SIAP_ACTES ACTE 
                  WHERE NOT EXISTS (SELECT 1 
                                    FROM PRE_ELEMENT_PRINCIPAL ANTIGUOS
                                    WHERE ANTIGUOS.ID_ORIGINAL = ACTE.ID
                                   ); 
       COMMIT;                            
                INSERT INTO PRE_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                SELECT SEQ_PRE_ELEMENT_PRINCIPAL.NEXTVAL AS ID,
                       SEQ_PRE_ELEMENT_PRINCIPAL.CURRVAL AS NUMERO_REGISTRE, 
                       NULL AS ES_RELACIO_ENTRADA, 
                       NULL AS DATA_RELACIO_ENTRADA, 
                       NULL AS ES_VALIDAT_RE, 
                       NULL AS DATA_REGISTRE_GENERAL, 
                       NULL AS DATA_INICI_SEGUIMENT, 
                       NULL AS DATA_FI_SEGUIMENT, 
                       NULL AS NOM_USUARI_RESPONSABLE, 
                       NULL AS MATRICULA_USUARI_RESPONSABLE, 
                       NULL AS DATA_DOCUMENT, 
                       NULL AS DATA_TERMINI, 
                       NULL AS DATA_RESPOSTA, 
                       NULL AS DATA_RESOLUCIO, 
                       NVL(SUBSTR(DESCRIPCIO,1,100),'*') AS NOM_ACTE, 
                       FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                       FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO, 
                       FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT, 
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO, 
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT, 
                       NULL AS AFECTA_AGENDA_ID, 
                       NULL AS ORIGEN_ID, 
                       NULL AS PRIORITAT_ID, 
                       NULL AS TIPUS_ELEMENT_ID, 
                       NULL AS ASPECTE_ID, 
                       NULL AS DOSSIER_ID, 
                       NULL AS ESTAT_ELEMENT_PRINCIPAL_ID, 
                       NULL AS TIPUS_SUPORT_ID, 
                       NULL AS TIPUS_AMBIT_ID, 
                       NULL AS TIPUS_ARG_ID, 
                       NULL AS PREFIX_ID, 
                       NULL AS NUMERO_REGISTRE_GENERAL_ID, 
                       NULL AS ELEMENT_PRINCIPAL_ORIGEN_ID, 
                       ACTE1 AS ID_ORIGINAL, 
                       'ORGA' AS ESQUEMA_ORIGINAL, 
                       'LLISTA ACTE' AS TABLA_ORIGINAL, 
                       30 AS INSTALACIOID
                  FROM Z_TMP_VIPS_U_ORGA_LLISTA ACTE 
                  WHERE NOT EXISTS (SELECT 1 
                                    FROM PRE_ELEMENT_PRINCIPAL ANTIGUOS
                                    WHERE ANTIGUOS.ID_ORIGINAL = ACTE1
                                   ); 
    
    COMMIT;
    
     INSERT INTO PRE_ELEMENT_PRINCIPAL (ID, NUMERO_REGISTRE, ES_RELACIO_ENTRADA, DATA_RELACIO_ENTRADA, ES_VALIDAT_RE, DATA_REGISTRE_GENERAL, DATA_INICI_SEGUIMENT, DATA_FI_SEGUIMENT, NOM_USUARI_RESPONSABLE, MATRICULA_USUARI_RESPONSABLE, DATA_DOCUMENT, DATA_TERMINI, DATA_RESPOSTA, DATA_RESOLUCIO, NOM_ACTE, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AFECTA_AGENDA_ID, ORIGEN_ID, PRIORITAT_ID, TIPUS_ELEMENT_ID, ASPECTE_ID, DOSSIER_ID, ESTAT_ELEMENT_PRINCIPAL_ID, TIPUS_SUPORT_ID, TIPUS_AMBIT_ID, TIPUS_ARG_ID, PREFIX_ID, NUMERO_REGISTRE_GENERAL_ID, ELEMENT_PRINCIPAL_ORIGEN_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID)
                SELECT SEQ_PRE_ELEMENT_PRINCIPAL.NEXTVAL AS ID,
                       SEQ_PRE_ELEMENT_PRINCIPAL.CURRVAL AS NUMERO_REGISTRE, 
                       NULL AS ES_RELACIO_ENTRADA, 
                       NULL AS DATA_RELACIO_ENTRADA, 
                       NULL AS ES_VALIDAT_RE, 
                       NULL AS DATA_REGISTRE_GENERAL, 
                       NULL AS DATA_INICI_SEGUIMENT, 
                       NULL AS DATA_FI_SEGUIMENT, 
                       NULL AS NOM_USUARI_RESPONSABLE, 
                       NULL AS MATRICULA_USUARI_RESPONSABLE, 
                       NULL AS DATA_DOCUMENT,
                       NULL AS DATA_TERMINI, 
                       NULL AS DATA_RESPOSTA, 
                       NULL AS DATA_RESOLUCIO, 
                       NVL(SUBSTR(DESCRIPCIO,1,100),'*') AS NOM_ACTE, 
                       FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                       FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO, 
                       FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT, 
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO, 
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT, 
                       NULL AS AFECTA_AGENDA_ID, 
                       NULL AS ORIGEN_ID, 
                       NULL AS PRIORITAT_ID, 
                       NULL AS TIPUS_ELEMENT_ID, 
                       NULL AS ASPECTE_ID, 
                       NULL AS DOSSIER_ID, 
                       NULL AS ESTAT_ELEMENT_PRINCIPAL_ID, 
                       NULL AS TIPUS_SUPORT_ID, 
                       NULL AS TIPUS_AMBIT_ID, 
                       NULL AS TIPUS_ARG_ID, 
                       NULL AS PREFIX_ID, 
                       NULL AS NUMERO_REGISTRE_GENERAL_ID, 
                       NULL AS ELEMENT_PRINCIPAL_ORIGEN_ID, 
                       ACTE2 AS ID_ORIGINAL, 
                       'ORGA' AS ESQUEMA_ORIGINAL, 
                       'LLISTA ACTE' AS TABLA_ORIGINAL, 
                       30 AS INSTALACIOID
                   FROM Z_TMP_VIPS_U_ORGA_LLISTA NUEVOS 
                  WHERE ACTE2 IS NOT NULL   
                    AND NOT EXISTS (SELECT 1 
                                    FROM PRE_ELEMENT_PRINCIPAL ANTIGUOS
                                    WHERE ANTIGUOS.ID_ORIGINAL = ACTE2
                                   ); 

    
    COMMIT;
    END;

   PROCEDURE G100_ACTES_SIAP IS   
   
   BEGIN
        /* ANULADO. BORRAR
            INSERT INTO AUX_ACTE (ID, TITOL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, DATA_ENTRADA, COMENTARIS_VALORACIO, ELEMENT_PRINCIPAL_ID, TIPUS_ACTE_ID, CATEGORIA_ID, SECTOR_ID, PRESIDENT_ID, PETICIONARI_ID, ESTAT_ACTE_ID, ESTAT_GESTIO_INVITACIO_ID, ESTAT_GESTIO_ESPAIS_ID)
                             SELECT ID AS ID,
                                       DESCRIPCIO AS TITOL,
                                       SYSDATE AS DATA_CREACIO,
                                       NULL AS  DATA_ESBORRAT, 
                                       NULL AS DATA_MODIFICACIO, 
                                       'MIGRACIO' AS USUARI_CREACIO, 
                                       NULL AS USUARI_ESBORRAT, 
                                       NULL AS USUARI_MODIFICACIO,
                                       DATA_INICI AS DATA_ENTRADA,
                                       OBSERVACIONS AS COMENTARIS_VALORACIO,
                                       1 AS ELEMENT_PRINCIPAL_ID,
                                       IDTIPUS_ACTE AS TIPUS_ACTE_ID,
                                       FUNC_NULOS(IDCATEGORIA) AS CATEGORIA_ID, --OJO TEMPORAL. NO PERMITE NULOS
                                       IDSECTOR AS SECTOR_ID,
                                       IDPRESIDENT AS PRESIDENT_ID,
                                       IDPETICIONARI AS PETICIONARI_ID,
                                       1 AS ESTAT_ACTE_ID,
                                       1 AS ESTAT_GESTIO_ID,
                                       1 AS ESTAT_GESTIO_ESPAIS_ID       
                                FROM Z_T_SIAP_ACTES NUEVOS
                               WHERE NOT EXISTS (SELECT 1
                                                   FROM AUX_ACTE ANTIGUOS
                                                  WHERE ANTIGUOS.ID = NUEVOS.ID
                                                 );
                                                 
        */
        --DESDE SIAP 
        
        /*
        ACTE.ID AS ID_ORIGINAL, 
                       'SIAP' AS ESQUEMA_ORIGINAL, 
                       'ACTES' AS TABLA_ORIGINAL, 
        */                       
        
        INSERT INTO PRE_ACTE (ID, TITOL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, DATA_ENTRADA, COMENTARIS_VALORACIO, ELEMENT_PRINCIPAL_ID, TIPUS_ACTE_ID, CATEGORIA_ID, SECTOR_ID, PRESIDENT_ID, PETICIONARI_ID, ESTAT_ACTE_ID, ESTAT_GESTIO_INVITACIO_ID, ESTAT_GESTIO_ESPAIS_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                                SELECT SEQ_PRE_ACTE.NEXTVAL AS ID,
                                       NVL(SUBSTR(DESCRIPCIO,1,100),'*') AS TITOL,
                                       SYSDATE AS DATA_CREACIO,
                                       NULL AS  DATA_ESBORRAT, 
                                       NULL AS DATA_MODIFICACIO, 
                                       'MIGRACIO' AS USUARI_CREACIO, 
                                       NULL AS USUARI_ESBORRAT, 
                                       NULL AS USUARI_MODIFICACIO,
                                       FUNC_FECHA_NULA(DATA_INICI) AS DATA_ENTRADA,
                                       OBSERVACIONS AS COMENTARIS_VALORACIO,
                                       (SELECT ID FROM PRE_ELEMENT_PRINCIPAL EP WHERE EP.ID_ORIGINAL = NUEVOS.ID AND TABLA_ORIGINAL='ACTES') AS ELEMENT_PRINCIPAL_ID,
                                       IDTIPUS_ACTE AS TIPUS_ACTE_ID,
                                       IDCATEGORIA  AS CATEGORIA_ID, --OJO TEMPORAL. NO PERMITE NULOS
                                       IDSECTOR AS SECTOR_ID,
                                       IDPRESIDENT AS PRESIDENT_ID,
                                       IDPETICIONARI AS PETICIONARI_ID,
                                       (SELECT ID FROM PRE_DM_ESTAT_ACTE WHERE DESCRIPCIO = NUEVOS.ESTAT) AS ESTAT_ACTE_ID,
                                       2 AS ESTAT_GESTIO_INVITACIO_ID, --convocatoria
                                       2 AS ESTAT_GESTIO_ESPAIS_ID,
                                       ID AS ID_ORIGINAL, 
                                       'SIAP' AS ESQUEMA_ORIGINAL, 
                                       'ACTES' AS TABLA_ORIGINAL
                                FROM Z_T_SIAP_ACTES NUEVOS 
                                WHERE IDTIPUS_ACTE IS NOT NULL   
                                 AND NOT EXISTS (SELECT 1 
                                                   FROM PRE_ACTE ANTIGUOS
                                                  WHERE ANTIGUOS.ID = NUEVOS.ID
                                                 ) 
                                AND IDTIPUS_ACTE IS NOT NULL
                                AND CATEGORIA IS NOT NULL                                
--                                AND IDSECTOR IS NOT NULL
--                                AND IDPRESIDENT IS NOT NULL
--                                AND IDPETICIONARI IS NOT NULL
                                AND NUEVOS.ESTAT IS NOT NULL
                                AND DATA_INICI IS NOT NULL
                                AND (SELECT ID FROM PRE_DM_CATEGORIA WHERE DESCRIPCIO = NUEVOS.CATEGORIA) IS NOT NULL
                                AND (SELECT ID FROM PRE_DM_PETICIONARI WHERE ID = NUEVOS.IDPETICIONARI) IS NOT NULL
                                AND (SELECT ID FROM PRE_DM_SECTOR WHERE ID = NUEVOS.IDSECTOR) IS NOT NULL
                                AND (SELECT ID FROM PRE_DM_PRESIDENT WHERE ID = NUEVOS.IDPRESIDENT) IS NOT NULL;
                                             
    COMMIT;
    END;
    
    

    
    PROCEDURE G110_ACTES_ORGA IS
    BEGIN
        ----INSERTAMOS LOS SUPERACTOS 
        INSERT INTO PRE_ACTE (ID, TITOL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, DATA_ENTRADA, COMENTARIS_VALORACIO, ELEMENT_PRINCIPAL_ID, TIPUS_ACTE_ID, CATEGORIA_ID, SECTOR_ID, PRESIDENT_ID, PETICIONARI_ID, ESTAT_ACTE_ID, ESTAT_GESTIO_INVITACIO_ID, ESTAT_GESTIO_ESPAIS_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                                SELECT SEQ_PRE_ACTE.NEXTVAL AS ID,
                                       NVL(SUBSTR(DESCRIPCIO,1,100),'*') AS TITOL,
                                       FUNC_FECHA_NULA(DAT_ACT_LLI) AS DATA_CREACIO,
                                       NULL AS  DATA_ESBORRAT, 
                                       NULL AS DATA_MODIFICACIO, 
                                       USU_ACT_LLI AS USUARI_CREACIO, 
                                       NULL AS USUARI_ESBORRAT, 
                                       NULL AS USUARI_MODIFICACIO,
                                       FUNC_FECHA_NULA(DAT_ACT_LLI) AS DATA_ENTRADA,
                                       LITER1 AS COMENTARIS_VALORACIO,
                                       (SELECT ID FROM PRE_ELEMENT_PRINCIPAL EP WHERE EP.ID_ORIGINAL =ACTE1 AND EP.TABLA_ORIGINAL='LLISTA ACTE' ) AS ELEMENT_PRINCIPAL_ID,
                                       2 AS TIPUS_ACTE_ID, --SIN DETERMINAR
                                       32  AS CATEGORIA_ID, --VARIOS
                                       NULL AS SECTOR_ID,
                                       NULL AS PRESIDENT_ID,
                                       NULL AS PETICIONARI_ID,
                                       (SELECT ID FROM  PRE_DM_ESTAT_ACTE WHERE lower(DESCRIPCIO) ='tancat')  AS ESTAT_ACTE_ID, --TANCAT
                                       1 AS ESTAT_GESTIO_ID,
                                       1 AS ESTAT_GESTIO_ESPAIS_ID,
                                       ACTE1 AS ID_ORIGINAL, 
                                       'ORGA' AS ESQUEMA_ORIGINAL, 
                                       'ORGA_LLISTA' AS TABLA_ORIGINAL       
                                FROM Z_TMP_VIPS_U_ORGA_LLISTA NUEVOS 
--                                WHERE IDTIPUS_ACTE IS NOT NULL   
                                 WHERE NOT EXISTS (SELECT 1 
                                                   FROM PRE_ACTE ANTIGUOS
                                                  WHERE ANTIGUOS.ID = NUEVOS.ACTE1
                                                 ) ;
   
   --INSERTAMOS LOS ACTOS DE RECEPCIÓN (SUBACTOS)
    INSERT INTO PRE_ACTE (ID, TITOL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, DATA_ENTRADA, COMENTARIS_VALORACIO, ELEMENT_PRINCIPAL_ID, TIPUS_ACTE_ID, CATEGORIA_ID, SECTOR_ID, PRESIDENT_ID, PETICIONARI_ID, ESTAT_ACTE_ID, ESTAT_GESTIO_INVITACIO_ID, ESTAT_GESTIO_ESPAIS_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                                SELECT SEQ_PRE_ACTE.NEXTVAL AS ID,
                                       NVL(SUBSTR(DESCRIPCIO,1,100),'*') AS TITOL,
                                       FUNC_FECHA_NULA(DAT_ACT_LLI) AS DATA_CREACIO,
                                       NULL AS  DATA_ESBORRAT, 
                                       NULL AS DATA_MODIFICACIO, 
                                       USU_ACT_LLI AS USUARI_CREACIO, 
                                       NULL AS USUARI_ESBORRAT, 
                                       NULL AS USUARI_MODIFICACIO,
                                       FUNC_FECHA_NULA(DAT_ACT_LLI) AS DATA_ENTRADA,
                                       LITER2 AS COMENTARIS_VALORACIO,
                                       (SELECT ID FROM PRE_ELEMENT_PRINCIPAL EP WHERE EP.ID_ORIGINAL =ACTE2 AND EP.TABLA_ORIGINAL='LLISTA ACTE' ) AS ELEMENT_PRINCIPAL_ID,
                                       2 AS TIPUS_ACTE_ID, --SIN DETERMINAR
                                       32  AS CATEGORIA_ID, --VARIOS
                                       NULL AS SECTOR_ID,
                                       NULL AS PRESIDENT_ID,
                                       NULL AS PETICIONARI_ID,
                                       (SELECT ID FROM  PRE_DM_ESTAT_ACTE WHERE lower(DESCRIPCIO) ='tancat')  AS ESTAT_ACTE_ID, --TANCAT
                                       1 AS ESTAT_GESTIO_ID,
                                       1 AS ESTAT_GESTIO_ESPAIS_ID,
                                        ACTE2 AS ID_ORIGINAL, 
                                       'ORGA' AS ESQUEMA_ORIGINAL, 
                                       'ORGA_LLISTA' AS TABLA_ORIGINAL       
                                FROM Z_TMP_VIPS_U_ORGA_LLISTA NUEVOS 
                                WHERE ACTE2 IS NOT NULL   
                                 AND NOT EXISTS (SELECT 1 
                                                   FROM PRE_ACTE ANTIGUOS
                                                  WHERE ANTIGUOS.ID = NUEVOS.ACTE2
                                                 ) ;
    
        
   
   COMMIT;
   END;

   PROCEDURE G115_CONVIDAT_ORGA IS
   BEGIN
   --QUE EMPIECE EN LA 300
              INSERT INTO PRE_CONVIDAT  (ID, TRACTAMENT, NOM, COGNOM1, COGNOM2, TIPUS_CONTACTE, ENTITAT, DEPARTAMENT, CARREC, NOM_CARRER, CODI_CARRER, PIS, PORTA, LLETRA_INICI, LLETRA_FI, ESCALA, BLOC, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_ENVIAMENT_INVITACIO, ES_CONFIRMA_RECEPCIO_INVITACIO, CODI_ACUS_REBUT, DATA_ACUS_REBUT, DATA_CONFIRMACIO, NOM_PERSONA_DELEGA, CARREC_PERSONA_DELEGA, ENTITAT_PERSONA_DELEGA, OBSERVACIONS, DATA_ACTUALITZACIO_ASSISTENCIA, CODI_CLASSIFICACIO, NOM_CLASSIFICACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, ACTE_ID, ESTAT_CONFIRMACIO_ID, TIPUS_VIA_INVITACIO_ID, INICIATIVA_RESPOSTA_ID, TIPUS_VIA_RESPOSTA_ID, PRIORITAT, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DECISIO_ASSISTENCIA_ID)
               SELECT SEQ_PRE_CONVIDAT.NEXTVAL AS ID, 
--                   VIP.N_VIP AS SUBJECTE_ID,
                   SUBSTR(ORGA.TRACTAMENT,1,20) AS TRACTAMENT, 
                   ORGA.NOM AS NOM,
                   (CASE WHEN(length(ORGA.COGNOMS) - length(replace(ORGA.COGNOMS, ' ', '')) + 1) = 2 THEN 
                                    trim(SUBSTR(ORGA.COGNOMS,1,INSTR(ORGA.COGNOMS,' ')-1))
                            WHEN trim(SUBSTR(ORGA.COGNOMS,1, INSTR(LOWER(ORGA.COGNOMS),' i ')-1)) IS NULL THEN 
                                    ORGA.COGNOMS 
                   ELSE  
                            trim(SUBSTR(ORGA.COGNOMS,1, INSTR(LOWER(ORGA.COGNOMS),' i ')-1))
                   END)  AS COGNOM1, 
                  (CASE WHEN trim(SUBSTR(ORGA.COGNOMS,1, INSTR(LOWER(ORGA.COGNOMS),' i ')-1)) IS NOT NULL THEN 
                                 trim(SUBSTR(ORGA.COGNOMS,INSTR(LOWER(ORGA.COGNOMS),' i ')))
                            WHEN (length(ORGA.COGNOMS) - length(replace(ORGA.COGNOMS, ' ', '')) + 1) = 2 THEN  
                                 trim(SUBSTR(ORGA.COGNOMS, INSTR(ORGA.COGNOMS,' ')))
                   ELSE 
                            NULL 
                   END) AS COGNOM2, 
                   CONTACTE.TIPUS_CONTACTE_ID AS TIPUS_CONTACTE,
                   ORGA.ENTITAT AS ENTITAT,
                   ORGA.DEPART AS DEPARTAMENT,
                   ORGA.CARREC AS CARREC,
                   NVL(ORGA.ADRECA,'*') AS NOM_CARRER,
                   NULL AS CODI_CARRER,
                   NULL AS PIS,
                   NULL AS PORTA,
                   NULL AS LLETRA_INICI,
                   NULL AS LLETRA_FI,
                   NULL AS ESCALA,
                   NULL AS BLOC,
                   ORGA.CP AS CODI_POSTAL,
                   NULL AS COORDENADA_X,
                   NULL AS COORDENADA_Y,
                   NULL AS SECCIO_CENSAL,
                   NULL AS ANY_CONS,
                   NULL AS NUMERO_INICI,
                   NULL AS NUMERO_FI,
                   ORGA.DAT_CONVOCA AS DATA_ENVIAMENT_INVITACIO,
                    (CASE WHEN ORGA.INC_CONF='S' THEN
                           1
                    ELSE
                           0
                   END) AS ES_CONFIRMA_RECEPCIO_INVITACIO,
                   NULL AS CODI_ACUS_REBUT,
                   NULL AS DATA_ACUS_REBUT,
                   ORGA.DAT_CONF AS DATA_CONFIRMACIO,
                   NULL AS NOM_PERSONA_DELEGA,
                   NULL AS CARREC_PERSONA_DELEGA,
                   NULL AS ENTITAT_PERSONA_DELEGA,
                   ORGA.COMENTARI AS OBSERVACIONS,  
                   ORGA.DAT_CONF2 AS DATA_ACTUALITZACIO_ASSISTENCIA,
                   ORGA.CLASSIF AS CODI_CLASSIFICACIO,
                   (SELECT DESCRIPCIO FROM PRE_DM_CLASSIFICACIO WHERE CODI = ORGA.CLASSIF AND ROWNUM=1) AS NOM_CLASSIFICACIO,
                   ORGA.DAT_CONVOCA AS DATA_CREACIO,
                   NULL AS DATA_ESBORRAT,
                   NULL AS DATA_MODIFICACIO,
                   USU_CONVOCA AS USUARI_CREACIO,
                   NULL AS USUARI_ESBORRAT,
                   NULL AS USUARI_MODIFICACIO,
                   CONTACTE.ID AS CONTACTE_ID,
                   (SELECT ID FROM PRE_ACTE ACTE WHERE ACTE.ID_ORIGINAL = ORGA.ACTE) AS ACTE_ID,
                   2 AS ESTAT_CONFIRMACIO,
                   1 AS TIPUS_VIA_INVITACIO_ID,
                   1 AS INCIATIVA_RESPOSTA_ID,
                   1 AS TIPUS_VIA_RESPOSTA_ID,
                   CONVITAT.PRIORITAT_ID AS PRIORITAT, --ojo si es 0 hay que poner NULL
                   NULL AS CODI_MUNICIPI, 
                   ORGA.MUNICIPI AS MUNICIPI, 
                   NULL AS CODI_PROVINCIA, 
                   ORGA.PROVINCIA AS PROVINCIA, 
                   NULL AS CODI_PAIS, 
                   ORGA.PAIS AS PAIS, 
                   NULL AS CODI_TIPUS_VIA, 
                   NULL AS CODI_BARRI, 
                   NULL AS BARRI, 
                   NULL AS CODI_DISTRICTE, 
                   NULL AS  DISTRICTE,
                   CONVITAT.ID AS ID_ORIGINAL, 
                   'SIAP' ESQUEMA_ORIGINAL, 
                   'VIPS_ACTES' TABLA_ORIGINAL,
                   (CASE WHEN ORGA.USU_ASS='S' THEN
                           2
                    ELSE
                           1
                   END) AS DECISIO_ASSISTENCIA_ID -- <--- ojo
            FROM Z_PRE_CONTACTE CONTACTE,
                 Z_TMP_VIPS_U_ORGA_ACTE ORGA,
                 Z_PRE_SUBJECTE CONVITAT
            WHERE CONVITAT.ID = ORGA.N_VIP
              AND CONTACTE.SUBJECTE_ID = CONVITAT.ID
--             AND  ORGA.N_VIP = CONVITAT.ID
             AND ORGA.ACTE IS NOT NULL;
   
   
   
   
   COMMIT;
   
   
   
   
   
   
           --SE NSERTAN LOS ACTOS DE RECEPCION
           INSERT INTO PRE_CONVIDAT  (ID, TRACTAMENT, NOM, COGNOM1, COGNOM2, TIPUS_CONTACTE, ENTITAT, DEPARTAMENT, CARREC, NOM_CARRER, CODI_CARRER, PIS, PORTA, LLETRA_INICI, LLETRA_FI, ESCALA, BLOC, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_ENVIAMENT_INVITACIO, ES_CONFIRMA_RECEPCIO_INVITACIO, CODI_ACUS_REBUT, DATA_ACUS_REBUT, DATA_CONFIRMACIO, NOM_PERSONA_DELEGA, CARREC_PERSONA_DELEGA, ENTITAT_PERSONA_DELEGA, OBSERVACIONS, DATA_ACTUALITZACIO_ASSISTENCIA, CODI_CLASSIFICACIO, NOM_CLASSIFICACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, ACTE_ID, ESTAT_CONFIRMACIO_ID, TIPUS_VIA_INVITACIO_ID, INICIATIVA_RESPOSTA_ID, TIPUS_VIA_RESPOSTA_ID, PRIORITAT, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DECISIO_ASSISTENCIA_ID)
               SELECT SEQ_PRE_CONVIDAT.NEXTVAL AS ID, 
--                   VIP.N_VIP AS SUBJECTE_ID,
                   SUBSTR(ORGA.TRACTAMENT,1,20) AS TRACTAMENT, 
                   FUNC_NULOS_ASTERICO(ORGA.NOM) AS NOM,
                   (CASE WHEN(length(ORGA.COGNOMS) - length(replace(ORGA.COGNOMS, ' ', '')) + 1) = 2 THEN 
                                    trim(SUBSTR(ORGA.COGNOMS,1,INSTR(ORGA.COGNOMS,' ')-1))
                            WHEN trim(SUBSTR(ORGA.COGNOMS,1, INSTR(LOWER(ORGA.COGNOMS),' i ')-1)) IS NULL THEN 
                                    ORGA.COGNOMS 
                   ELSE  
                            trim(SUBSTR(ORGA.COGNOMS,1, INSTR(LOWER(ORGA.COGNOMS),' i ')-1))
                   END)  AS COGNOM1, 
                  (CASE WHEN trim(SUBSTR(ORGA.COGNOMS,1, INSTR(LOWER(ORGA.COGNOMS),' i ')-1)) IS NOT NULL THEN 
                                 trim(SUBSTR(ORGA.COGNOMS,INSTR(LOWER(ORGA.COGNOMS),' i ')))
                            WHEN (length(ORGA.COGNOMS) - length(replace(ORGA.COGNOMS, ' ', '')) + 1) = 2 THEN  
                                 trim(SUBSTR(ORGA.COGNOMS, INSTR(ORGA.COGNOMS,' ')))
                   ELSE 
                            NULL 
                   END) AS COGNOM2, 
                   CONTACTE.TIPUS_CONTACTE_ID AS TIPUS_CONTACTE,
                   ORGA.ENTITAT AS ENTITAT,
                   ORGA.DEPART AS DEPARTAMENT,
                   ORGA.CARREC AS CARREC,
                   NVL(ORGA.ADRECA,'*') AS NOM_CARRER,
                   NULL AS CODI_CARRER,
                   NULL AS PIS,
                   NULL AS PORTA,
                   NULL AS LLETRA_INICI,
                   NULL AS LLETRA_FI,
                   NULL AS ESCALA,
                   NULL AS BLOC,
                   ORGA.CP AS CODI_POSTAL,
                   NULL AS COORDENADA_X,
                   NULL AS COORDENADA_Y,
                   NULL AS SECCIO_CENSAL,
                   NULL AS ANY_CONS,
                   NULL AS NUMERO_INICI,
                   NULL AS NUMERO_FI,
                   ORGA.DAT_CONVOCA AS DATA_ENVIAMENT_INVITACIO,
                      (CASE WHEN ORGA.INC_CONF='S' THEN
                           1
                    ELSE
                           0
                   END) AS ES_CONFIRMA_RECEPCIO_INVITACIO,

                   NULL AS CODI_ACUS_REBUT,
                   NULL AS DATA_ACUS_REBUT,
                   ORGA.DAT_CONF AS DATA_CONFIRMACIO,
                   NULL AS NOM_PERSONA_DELEGA,
                   NULL AS CARREC_PERSONA_DELEGA,
                   NULL AS ENTITAT_PERSONA_DELEGA,
                   ORGA.COMENTARI AS OBSERVACIONS,
                   ORGA.DAT_CONF2 AS DATA_ACTUALITZACIO_ASSISTENCIA,
                   ORGA.CLASSIF AS CODI_CLASSIFICACIO,
                   (SELECT DESCRIPCIO FROM PRE_DM_CLASSIFICACIO WHERE CODI = ORGA.CLASSIF AND ROWNUM=1) AS NOM_CLASSIFICACIO,
                   ORGA.DAT_CONVOCA AS DATA_CREACIO,
                   NULL AS DATA_ESBORRAT,
                   NULL AS DATA_MODIFICACIO,
                   USU_CONVOCA AS USUARI_CREACIO,
                   NULL AS USUARI_ESBORRAT,
                   NULL AS USUARI_MODIFICACIO,
                   CONTACTE.ID AS CONTACTE_ID,
                   (SELECT ID FROM PRE_ACTE ACTE WHERE ACTE.ID_ORIGINAL = ORGA.AC2E) AS ACTE_ID,
                   2 AS ESTAT_CONFIRMACIO,
                   1 AS TIPUS_VIA_INVITACIO_ID,
                   1 AS INCIATIVA_RESPOSTA_ID,
                   1 AS TIPUS_VIA_RESPOSTA_ID,
                   CONVITAT.PRIORITAT_ID AS PRIORITAT,  --¡ojo si es 0 hay que poner NULL!
                   NULL AS CODI_MUNICIPI, 
                   ORGA.MUNICIPI AS MUNICIPI, 
                   NULL AS CODI_PROVINCIA, 
                   ORGA.PROVINCIA AS PROVINCIA, 
                   NULL AS CODI_PAIS, 
                   ORGA.PAIS AS PAIS, 
                   NULL AS CODI_TIPUS_VIA, 
                   NULL AS CODI_BARRI, 
                   NULL AS BARRI, 
                   NULL AS CODI_DISTRICTE, 
                   NULL AS  DISTRICTE,
                   CONVITAT.ID AS ID_ORIGINAL, 
                   'SIAP' ESQUEMA_ORIGINAL, 
                   'VIPS_ACTES' TABLA_ORIGINAL,
                    (CASE WHEN ORGA.USU_ASS='S' THEN
                           2
                    ELSE
                           1
                   END) AS DECISIO_ASSISTENCIA_ID -- <--- ojo
            FROM Z_PRE_CONTACTE CONTACTE,
                 Z_TMP_VIPS_U_ORGA_ACTE ORGA,
                 Z_PRE_SUBJECTE CONVITAT
             WHERE CONVITAT.ID = ORGA.N_VIP
              AND CONTACTE.SUBJECTE_ID = CONVITAT.ID
             AND ORGA.ACTE IS NULL;
   
   


   
   COMMIT;
   END;


  PROCEDURE G120_ACTES_VIPS IS
  BEGIN
   /*
    INSERT INTO A1_ACTE (ID, TITOL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, DATA_ENTRADA, COMENTARIS_VALORACIO, ELEMENT_PRINCIPAL_ID, TIPUS_ACTE_ID, CATEGORIA_ID, SECTOR_ID, PRESIDENT_ID, PETICIONARI_ID, ESTAT_ACTE_ID, ESTAT_GESTIO_INVITACIO_ID, ESTAT_GESTIO_ESPAIS_ID)
                                SELECT ID AS ID,
                                       NVL(SUBSTR(DESCRIPCIO,1,100),'*') AS TITOL,
                                       SYSDATE AS DATA_CREACIO,
                                       NULL AS  DATA_ESBORRAT, 
                                       NULL AS DATA_MODIFICACIO, 
                                       'MIGRACIO' AS USUARI_CREACIO, 
                                       NULL AS USUARI_ESBORRAT, 
                                       NULL AS USUARI_MODIFICACIO,
                                       FUNC_FECHA_NULA(DATA_INICI) AS DATA_ENTRADA,
                                       OBSERVACIONS AS COMENTARIS_VALORACIO,
                                       249979 AS ELEMENT_PRINCIPAL_ID,
                                       IDTIPUS_ACTE AS TIPUS_ACTE_ID,
                                       (SELECT ID FROM DM_CATEGORIA WHERE DESCRIPCIO = NUEVOS.CATEGORIA)  AS CATEGORIA_ID, --OJO TEMPORAL. NO PERMITE NULOS
                                       IDSECTOR AS SECTOR_ID,
                                       IDPRESIDENT AS PRESIDENT_ID,
                                       IDPETICIONARI AS PETICIONARI_ID,
                                       (SELECT ID FROM DM_ESTAT_ACTE WHERE DESCRIPCIO = NUEVOS.ESTAT) AS ESTAT_ACTE_ID,
                                       Const_SI_ASISTIR AS ESTAT_GESTIO_ID,
                                       Const_LLENO AS ESTAT_GESTIO_ESPAIS_ID       
                                FROM Z_T_SIAP_ACTES NUEVOS 
                                WHERE IDTIPUS_ACTE IS NOT NULL   
                                 AND NOT EXISTS (SELECT 1 
                                                   FROM ACTE ANTIGUOS
                                                  WHERE ANTIGUOS.ID = NUEVOS.ID
                                                 ) 
                                AND IDTIPUS_ACTE IS NOT NULL
                                AND CATEGORIA IS NOT NULL                                
                                AND IDSECTOR IS NOT NULL
                                AND IDPRESIDENT IS NOT NULL
                                AND IDPETICIONARI IS NOT NULL
                                AND NUEVOS.ESTAT IS NOT NULL
                                AND (SELECT ID FROM DM_CATEGORIA WHERE DESCRIPCIO = NUEVOS.CATEGORIA) IS NOT NULL
                                AND (SELECT ID FROM DM_PETICIONARI WHERE ID = NUEVOS.IDPETICIONARI) IS NOT NULL
                                AND (SELECT ID FROM DM_SECTOR WHERE ID = NUEVOS.IDSECTOR) IS NOT NULL
                                AND (SELECT ID FROM DM_PRESIDENT WHERE ID = NUEVOS.IDPRESIDENT) IS NOT NULL;
  
  */
  COMMIT;
  END;


/*
 PROCEDURE G130_CORREUS_CONVITAT IS
    BEGIN
    
            
    
    
         INSERT INTO Z_G130_CORREUS_CONVITAT (IDVIP, INTERNET)
              		 SELECT aux.IDVIP, 
                            aux.INTERNET 
            		 FROM(                                                                         
              			   SELECT DISTINCT t.IDVIP,
              			  				   trim(regexp_substr(t.INTERNET, '[^;]+', 1, levels.column_value))  as INTERNET
              			   FROM ( 
                			      SELECT IDVIP, 
                			             INTERNET 
                			      FROM Z_T_SIAP_VIPS_ADRECES 
                			      WHERE INTERNET IS NOT NULL 
                			        AND INTERNET LIKE '%@%' 
                			        AND EXISTS (SELECT * 
                			       	 		    FROM SUBJECTE s 
                			       			    WHERE s.ID = IDVIP)  
                			     ) t,
                			     table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(t.INTERNET, '[^;]+'))  + 1) as sys.OdciNumberList)) levels
              					 order by IDVIP
            			) aux
            		WHERE TRIM(aux.internet) is not null 
            	      AND NOT EXISTS (SELECT 1
            	     				  FROM Z_G130_CORREUS_CONVITAT con 
            	     				  WHERE con.IDVIP = aux.IDVIP 
            	     				    AND con.internet = aux.internet
            	     				  );                                                                     

            COMMIT;   
            
          END;  
          
    PROCEDURE G131_CORREUS_PRINCIPALS IS
      
        ID_VIP_ANT number;
    BEGIN
          
        ID_VIP_ANT:=0;
        
         FOR c IN (
               SELECT * 
               FROM  Z_G130_CORREUS_CONVITAT  NUEVOS
               WHERE NOT EXISTS (SELECT * 
                                 FROM Z_G131_CORREUS_PRINCIPALS ANTIGUOS
                                 WHERE  NUEVOS.IDVIP = ANTIGUOS.IDVIP
                                   AND NUEVOS.internet = ANTIGUOS.CORREU
                                 )              
               ORDER BY IDVIP,INTERNET
           )
           
         LOOP                        
            IF c.IDVIP <> ID_VIP_ANT THEN
                  ID_VIP_ANT:= c.IDVIP;
                  INSERT INTO Z_G131_CORREUS_PRINCIPALS VALUES (c.IDVIP, c.internet, 1);
            ELSE                  
                    INSERT INTO Z_G131_CORREUS_PRINCIPALS VALUES (c.IDVIP, c.internet, 0);                           
            END IF;

          END LOOP;
        
        COMMIT;        
        END;
                
        
        PROCEDURE G132_CORREUS_CONVITAT IS   
        
        BEGIN
         
            INSERT INTO CONVIDAT_CORREU(ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, CONVIDAT_ID)
                    SELECT SEQ_CONVIDAT_CORREU.NEXTVAL AS ID, 
                           cc.correu AS CORREU_ELECTRONIC, 
                           cc.principal AS ES_PRINCIPAL, 
                           sysdate AS DATA_CREACIO, 
                           'MIGRACIO' AS USUARI_CREACIO, 
                           cc.IDVIP AS CONVIDAT_ID
                     FROM Z_G131_CORREUS_PRINCIPALS cc
                     WHERE NOT EXISTS(SELECT 1 
                                      FROM CONVIDAT_CORREU 
                                      WHERE CONVIDAT_ID = cc.IDVIP
                                        AND CORREU_ELECTRONIC = CC.CORREU)
                     and exists (select 1 from CONVIDAT where Id = cc.IDVIP);                                        
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN DANI_TB_AUX_CORREUS_PRINCIPALS
        
    END;  


     PROCEDURE G140_TELEFONS_NUMERICS is 
        BEGIN           
            
             INSERT INTO Z_G140_TELEFONS_NUMERICS (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON)
               SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON
                FROM (	   
                         SELECT DISTINCT ID,
                                IDVIP,
                                (CASE WHEN SUBSTR(TRIM(TELEFON1),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFON1,' ','')))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix 
                                END) AS TIPUS_TELEFON,
                                FUNC_NORMALITZAR_SIGNES(TELEFON1) AS TELEFON
                         FROM Z_T_SIAP_VIPS_ADRECES C
                         WHERE TRIM(TELEFON1) IS NOT NULL 
                           AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFON1)) IS NULL 
                           AND TRIM(TELEFON1) <> '.' 
                           AND FUNC_NORMALITZAR_SIGNES(TELEFON1) IS NOT NULL 
         			       AND EXISTS (SELECT * 
                			       	 		    FROM SUBJECTE s 
                			       			    WHERE s.ID = N_VIP)  
                       ) NUEVOS
                   WHERE NOT EXISTS (SELECT * 
                                     FROM Z_B110_TELEFONS_NUMERICS ANTIGUOS  
                                     WHERE NUEVOS.ID_CONTACTE = ANTIGUOS.ID_CONTACTE 
                                       AND NUEVOS.N_VIP = ANTIGUOS.N_VIP
                                       AND NUEVOS.TIPUS_TELEFON = ANTIGUOS.TIPUS_TELEFON
                                       AND NUEVOS.TELEFON = ANTIGUOS.TELEFON
                                     );
            COMMIT; 
            
            INSERT INTO Z_B110_TELEFONS_NUMERICS (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON)
                SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON
                FROM (	   
                       SELECT DISTINCT ID_CONTACTE,
                              N_VIP,
                              (CASE WHEN SUBSTR(TRIM(TELEFON2),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_SIGNES(TELEFON2))= 9 THEN 
                                   ConstTelefonMobil
                              ELSE 
                                   ConstTelefonFix 
                              END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_SIGNES(TELEFON2)  AS TELEFON
                       FROM Z_B03_CONTACTES_ID C
                       WHERE TRIM(TELEFON2) IS NOT NULL 
                         AND LENGTH(FUNC_NORMALITZAR_SIGNES(TELEFON2)) IS NULL 
                         AND TRIM(TELEFON2) <> '.'
                         AND FUNC_NORMALITZAR_SIGNES(TELEFON2) IS NOT NULL 
                         AND EXISTS (SELECT * 
                				     FROM SUBJECTE s 
                			       	 WHERE s.ID = N_VIP
                                    )  
                     ) NUEVOS
                   WHERE NOT EXISTS (SELECT * 
                                     FROM Z_B110_TELEFONS_NUMERICS ANTIGUOS  
                                     WHERE NUEVOS.ID_CONTACTE = ANTIGUOS.ID_CONTACTE 
                                       AND NUEVOS.N_VIP = ANTIGUOS.N_VIP
                                       AND NUEVOS.TIPUS_TELEFON = ANTIGUOS.TIPUS_TELEFON
                                       AND NUEVOS.TELEFON = ANTIGUOS.TELEFON
                                     );
            
            INSERT INTO Z_B110_TELEFONS_NUMERICS (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON)
                SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON
                FROM (	   
                           SELECT DISTINCT ID_CONTACTE,
                                  N_VIP,
                                  (CASE WHEN SUBSTR(TRIM(TELEFON_MOBIL),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_SIGNES(TELEFON_MOBIL))= 9 THEN 
                                        ConstTelefonMobil
                                   ELSE 
                                        ConstTelefonFix
                                   END) AS TIPUS_TELEFON,
                                   FUNC_NORMALITZAR_SIGNES(TELEFON_MOBIL) AS TELEFON
                            FROM Z_B03_CONTACTES_ID C
                            WHERE TRIM(TELEFON_MOBIL) IS NOT NULL 
                              AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFON_MOBIL)) IS NULL 
                              AND TRIM(TELEFON_MOBIL) <> '.'
                              AND FUNC_NORMALITZAR_SIGNES(TELEFON_MOBIL) IS NOT NULL 
                              AND EXISTS (SELECT * 
                     		 		      FROM SUBJECTE s 
                                          WHERE s.ID = N_VIP
                                         )  


                     ) NUEVOS
                   WHERE NOT EXISTS (SELECT * 
                                     FROM Z_B110_TELEFONS_NUMERICS ANTIGUOS  
                                     WHERE NUEVOS.ID_CONTACTE = ANTIGUOS.ID_CONTACTE 
                                       AND NUEVOS.N_VIP = ANTIGUOS.N_VIP
                                       AND NUEVOS.TIPUS_TELEFON = ANTIGUOS.TIPUS_TELEFON
                                       AND NUEVOS.TELEFON = ANTIGUOS.TELEFON
                                     );
                              
                              
                              
            INSERT INTO Z_B110_TELEFONS_NUMERICS (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON)
                SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON
                FROM (	   
                             SELECT DISTINCT ID_CONTACTE,
                                    N_VIP,
                                    ConstTelefonFax AS TIPUS_TELEFON,
                                    FUNC_NORMALITZAR_SIGNES(FAX)  AS TELEFON
                             FROM Z_B03_CONTACTES_ID C
                             WHERE TRIM(FAX) IS NOT NULL 
                               AND LENGTH(FUNC_NORMALITZAR_NUMERICS(FAX)) IS NULL 
                               AND TRIM(FAX) <> '.'
                               AND FUNC_NORMALITZAR_SIGNES(FAX) IS NOT NULL 
                               AND EXISTS (SELECT * 
                                           FROM SUBJECTE s 
                                           WHERE s.ID = N_VIP
                                          )  
                               
                     ) NUEVOS
                   WHERE NOT EXISTS (SELECT * 
                                     FROM Z_B110_TELEFONS_NUMERICS ANTIGUOS  
                                     WHERE NUEVOS.ID_CONTACTE = ANTIGUOS.ID_CONTACTE 
                                       AND NUEVOS.N_VIP = ANTIGUOS.N_VIP
                                       AND NUEVOS.TIPUS_TELEFON = ANTIGUOS.TIPUS_TELEFON
                                       AND NUEVOS.TELEFON = ANTIGUOS.TELEFON
                                     );
                               
                                      
           INSERT INTO Z_B110_TELEFONS_NUMERICS (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON)
           SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON
                FROM (	   
                           SELECT B4.ID_CONTACTE, 
                                  B4.N_VIP,
                                  (CASE WHEN SUBSTR(TRIM(B4.TELEFON_P),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(B4.TELEFON_P,'.',''),' ','')))= 9 THEN 
                                         ConstTelefonMobil
                                    ELSE 
                                         ConstTelefonFix 
                                   END) AS TIPUS_TELEFON,
                                   FUNC_NORMALITZAR_SIGNES(B4.TELEFON_P) AS TELEFON
                           FROM Z_B03_CONTACTES_ID B3,
                                Z_B04_SUBJECTES_ID B4                           
                           WHERE TRIM(B4.TELEFON_P) IS NOT NULL 
                             AND B3.ID_CONTACTE = B4.ID_CONTACTE
                             AND LENGTH(FUNC_NORMALITZAR_NUMERICS(B4.TELEFON_P)) IS NULL 
                             AND TRIM(B4.TELEFON_P) <> '.'
                             AND FUNC_NORMALITZAR_SIGNES(B4.TELEFON_P) IS NOT NULL 
                             AND EXISTS (SELECT * 
                                	     FROM SUBJECTE s 
                                       	 WHERE s.ID = B3.N_VIP
                                        )  

                     ) NUEVOS
                   WHERE NOT EXISTS (SELECT * 
                                     FROM Z_B110_TELEFONS_NUMERICS ANTIGUOS  
                                     WHERE NUEVOS.ID_CONTACTE = ANTIGUOS.ID_CONTACTE 
                                       AND NUEVOS.N_VIP = ANTIGUOS.N_VIP
                                       AND NUEVOS.TIPUS_TELEFON = ANTIGUOS.TIPUS_TELEFON
                                       AND NUEVOS.TELEFON = ANTIGUOS.TELEFON
                                     );
                    
            
           COMMIT;
           
          END;


      PROCEDURE B111_TELEFON_PRINCIPAL IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT * 
            FROM  Z_B110_TELEFONS_NUMERICS NUEVOS
            WHERE NOT EXISTS (SELECT * 
                               FROM Z_B111_TEL_PRINCIPALS ANTIGUOS
                               WHERE NUEVOS.id_contacte = ANTIGUOS.id_contacte
                                 AND NUEVOS.telefon = ANTIGUOS.telefon
                                 AND NUEVOS.tipus_telefon = ANTIGUOS.tipus_telefon
                              )                                 
            ORDER BY ID_CONTACTE,tipus_telefon,TELEFON
        )
        
        LOOP
            
            IF c.id_contacte <> id_contacte_ant THEN
              id_contacte_ant:= c.id_contacte;
              INSERT INTO Z_B111_TEL_PRINCIPALS VALUES (c.id_contacte, c.tipus_telefon,c.telefon, 1);
            ELSE
              INSERT INTO Z_B111_TEL_PRINCIPALS VALUES (c.id_contacte, c.tipus_telefon,c.telefon, 0);           
            END IF;

        END LOOP;
        
        COMMIT;       
      
      END;


      PROCEDURE B112_CONTACTE_TELEFON is 
           
      BEGIN
        
           INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, CONTACTE_ID, TIPUS_TELEFON_ID)
                    SELECT SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           NUEVOS.telefon AS NUMERO, 
                           NUEVOS.principal AS ES_PRINCIPAL, 
                           sysdate, 
                           'MIGRACIO', 
                           NUEVOS.id_contacte AS CONTACTE_ID, 
                           NUEVOS.tipus_telefon AS TIPUS_TELEFON_ID
                     FROM Z_B111_TEL_PRINCIPALS NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     )
                      and exists (select 1 from contacte where Id = NUEVOS.id_contacte);                                     
                                     
           COMMIT;

      END;
*/


  PROCEDURE RESETEATOR_TABLAS IS
  BEGIN
  
    DELETE FROM Z_G131_CORREUS_PRINCIPALS;
    DELETE FROM Z_G130_CORREUS_CONVITAT;
  
    DELETE FROM PRE_CONVIDAT;
    DELETE FROM PRE_ACTE;
    
    
    
    
  --CATÁLOGO DE SIAP  
--    DELETE FROM A1_DM_ESTAT_GESTIO_ESPAIS;
--    DELETE FROM A1_DM_ESTAT_GESTIO_INVITACIO;
--    DELETE FROM DM_TIPUS_ACTE_2; --TEMPORAL Y COMO AYUDA DE DUPLICADOS
--    DELETE FROM AUX_DM_ESTAT_ACTE;    

    DELETE FROM Z_G045_ESTAT_ACTE;

    DELETE FROM PRE_ELEMENT_PRINCIPAL;
    
    DELETE FROM Z_G043_TIPUS_ACTE_CODI_VIPS;
    DELETE FROM Z_G042_TIPUS_ACTE_CODI;    

    DELETE FROM PRE_DM_PETICIONARI;
    DELETE FROM PRE_DM_PRESIDENT;

    DELETE FROM PRE_DM_CATEGORIA;    
    DELETE FROM PRE_DM_SECTOR;

    DELETE FROM PRE_DM_TIPUS_ACTE;
    DELETE FROM Z_G024_DM_TIPUS_ACTE;
    DELETE FROM Z_G023_TIPUS_ACTE_RESTANTES;
    DELETE FROM Z_G022_TIPUS_ACTE_SIAP_VIPS;
    DELETE FROM Z_G021_TIPUS_ACTE_VIPS;
    DELETE FROM Z_G020_TIPUS_ACTE_SIAP;  
  
--    DELETE FROM A1_DM_TIPUS_VIA_RESPOSTA;
--    DELETE FROM A1_DM_INICIATIVA_RESPOSTA;
    --CATÁLOGO FIJO  
--    DELETE FROM A1_DM_TIPUS_VIA_INVITACIO;
    --CATÁLOGO FIJO
--    DELETE FROM A1_DM_ESTAT_CONFIRMACIO; 
    
--    DELETE FROM DM_TIPUS_VIA_RESPOSTA;
--    DELETE FROM DM_TIPUS_VIA_INVITACIO;
--    DELETE FROM DM_ESTAT_CONFIRMACIO; 
  
    DELETE FROM Z_G003_CLASSIF_SIAP_SINTAGMA;
    DELETE FROM Z_G002_NUEVOS_CLASIFFICACIO;  
    DELETE FROM Z_G001_YA_EXISTS_CLASIFFICACIO;
  
  COMMIT;  
  END RESETEATOR_TABLAS;



/*
DROP SEQUENCE AUX_SEQ_SIAP_CLASSIFICACIO;
CREATE SEQUENCE AUX_SEQ_SIAP_CLASSIFICACIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;


DROP SEQUENCE AUX_SEQ_SIAP_DM_ESTAT_ACTE;
CREATE SEQUENCE AUX_SEQ_SIAP_DM_ESTAT_ACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_TIPUS_ACTE;
CREATE SEQUENCE AUX_SEQ_DM_TIPUS_ACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_CONVITAT;
CREATE SEQUENCE AUX_SEQ_CONVITAT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_CONVIDAT_CORREU;
CREATE SEQUENCE AUX_SEQ_CONVIDAT_CORREU MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;


*/

END Z_PRE_CONVIDATS;

/
