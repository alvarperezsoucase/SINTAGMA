--------------------------------------------------------
--  DDL for Package Body SINTAGMA_01_CONTACTES_VIPS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."SINTAGMA_01_CONTACTES_VIPS" AS

 
  
     -- CONTACTOS CON CLASIFICACIONES ACTIVAS
    PROCEDURE SB01_CONTACTOS_ACTIVOS IS
    BEGIN              
        
        /* ANULADO. AHORA SE NORMALIZA FUNC_NORMALITZAR(CLVIP.CARREC || CLVIP.ENTITAT || CLVIP.ADRECA || CLVIP.MUNICIPI) AS Contacte_Normalizado 
        INSERT INTO Z_SB001_CONTACTOS_ACTIVOS (ID_CONTACTE, N_VIP, CARREC, ENTITAT, ADRECA, MUNICIPI)
        SELECT SEQ_CONTACTE.NEXTVAL AS ID_CONTACTE, 
                   N_VIP, 
                   NVL(T.CARREC,'NULL') AS CARREC,  
                   NVL(T.ENTITAT,'NULL') AS ENTITAT,  
                   NVL(T.ADRECA,'NULL') AS ADRECA, 
                   NVL( T.MUNICIPI,'NULL') AS MUNICIPI 
            FROM (
                    SELECT  N_VIP, 
                            TRIM(CARREC) AS CARREC, 
                            TRIM(ENTITAT) AS ENTITAT, 
                            TRIM(REPLACE(FUNC_NORMALITZAR(ADRECA),'.','')) AS ADRECA, 
                            TRIM(REPLACE(MUNICIPI,'.','')) AS MUNICIPI

                    FROM Z_TMP_VIPS_U_CLASSIF_VIP , 
                         TMP_CLASSIF_ACTIVES act
                    WHERE CLASSIF = act.codi
                    GROUP BY N_VIP, 
                             TRIM(CARREC), 
                             TRIM(ENTITAT), 
                             TRIM(REPLACE(FUNC_NORMALITZAR(ADRECA),'.','')), 
                             TRIM(REPLACE(MUNICIPI,'.','')) 
                ) T
            WHERE NOT EXISTS (SELECT 1 
                              FROM Z_SB001_CONTACTOS_ACTIVOS NUEVOS
                              WHERE NUEVOS.N_VIP = T.N_VIP
                                AND NVL(NUEVOS.CARREC,'NULL') = NVL(T.CARREC,'NULL')
                                AND NVL(NUEVOS.ENTITAT,'NULL') = NVL(T.ENTITAT,'NULL')
                                AND NVL(NUEVOS.ADRECA,'NULL') = NVL(T.ADRECA,'NULL')
                                AND NVL(NUEVOS.MUNICIPI,'NULL') = NVL(T.MUNICIPI,'NULL')
                              );      
          */
            INSERT INTO Z_SB001_CONTACTOS_ACTIVOS (ID_CONTACTE, N_VIP, Contacte_Normalizado, CARREC, ENTITAT, ADRECA, MUNICIPI)
                        SELECT SEQ_CONTACTE.NEXTVAL AS ID_CONTACTE,
                               N_VIP AS N_VIP,
                               Contacte_Normalizado AS Contacte_Normalizado,
                               CARREC AS CARREC,
                               ENTITAT AS ENTITAT,                               
                               ADRECA AS ADRECA,
                               MUNICIPI AS MUNICIPI
                        FROM (       
                                    SELECT N_VIP AS N_VIP,
                                           MAX(Contacte_Normalizado) AS Contacte_Normalizado,
                                           MAX(CARREC) AS CARREC,
                                           MAX(ENTITAT) AS ENTITAT,
                                           MAX(MUNICIPI) AS MUNICIPI,
                                           MAX(ADRECA) AS ADRECA
                                    FROM (       
                                            SELECT AGRUPADO.n_vip AS N_VIP,
                                                   AGRUPADO.Contacte_Normalizado AS Contacte_Normalizado,
                                                   FUNC_NULOS_ASTERICO(CLASSVIP.CARREC) AS CARREC,
                                                   FUNC_NULOS_ASTERICO(CLASSVIP.ENTITAT) AS ENTITAT,
                                                   FUNC_NULOS_ASTERICO(CLASSVIP.MUNICIPI) AS MUNICIPI,
                                                   FUNC_NULOS_ASTERICO(CLASSVIP.ADRECA) AS ADRECA,
                                                   ROW_NUMBER ()  OVER (PARTITION BY AGRUPADO.Contacte_Normalizado ORDER BY AGRUPADO.Contacte_Normalizado ASC ) AS COLNUM
                                            FROM (       
                                                        SELECT   N_VIP,             
                                                                 FUNC_NORMALITZAR(CLVIP.CARREC || CLVIP.ENTITAT || CLVIP.ADRECA || CLVIP.MUNICIPI) AS Contacte_Normalizado  
                                                                 
                                                        FROM Z_TMP_VIPS_U_CLASSIF_VIP CLVIP , 
                                                                                 TMP_CLASSIF_ACTIVES act
                                                                                 
                                                                            WHERE CLASSIF = act.codi
                                                        GROUP BY N_VIP, FUNC_NORMALITZAR(CLVIP.CARREC || CLVIP.ENTITAT || CLVIP.ADRECA || CLVIP.MUNICIPI)
                                            ) AGRUPADO,
                                              Z_TMP_VIPS_U_CLASSIF_VIP CLASSVIP
                                            WHERE CLASSVIP.N_VIP = AGRUPADO.N_VIP
                                    ) TFINAL 
                                    WHERE TFINAL.COLNUM=1 
                                    GROUP BY N_VIP
                        ) CONTACTES_AGRUPADOS
                        WHERE NOT EXISTS (SELECT 1
                                            FROM Z_SB001_CONTACTOS_ACTIVOS ANTIGUOS
                                           WHERE ANTIGUOS.Contacte_Normalizado = CONTACTES_AGRUPADOS.Contacte_Normalizado
                                          ); 
        
      
    COMMIT;
    END;
    
   -- SUJETOS RELACIONADOS CON CONTACTOS.
    PROCEDURE SB02_CONTACTOS_VIPS IS
    BEGIN
      
       INSERT INTO Z_SB002_CONTACTOS_VIPS (ID_CONTACTE, N_VIP, ADRECA_P, MUNICIPI_P, TELEFON_P)      
        SELECT SEQ_CONTACTE.NEXTVAL AS ID_CONTACTE, 
               N_VIP, 
               NVL((ADRECA_P),'NULL') AS adreca_p, 
               NVL(MUNICIPI_P,'NULL') AS municipi_p,  
               NVL(TELEFON_P,'NULL') AS TELEFON_P 
        FROM (
                SELECT N_VIP, 
                       ADRECA_P, 
                       MUNICIPI_P, 
                       TELEFON_P 
                FROM Z_TMP_VIPS_U_VIPS T 
                WHERE (TRIM(REPLACE(T.ADRECA_P,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.municipi_p,'.','')) IS NOT NULL 
                       )
                  AND NOT EXISTS(SELECT 1 
                                 FROM Z_SB001_CONTACTOS_ACTIVOS DIF 
                                 WHERE TRIM(REPLACE(FUNC_NORMALITZAR(T.Adreca_p),'.',''))= DIF.ADRECA 
                                   AND TRIM(REPLACE(T.municipi_p,'.','')) = DIF.municipi 
                                   AND TRIM(T.N_VIP) = DIF.N_VIP 
                                )
                GROUP BY N_VIP, (ADRECA_P), MUNICIPI_P, TELEFON_P
              ) T
         WHERE NOT EXISTS (SELECT 1 
                              FROM Z_SB002_CONTACTOS_VIPS NUEVOS
                              WHERE NUEVOS.N_VIP = T.N_VIP
                                AND NVL(NUEVOS.ADRECA_P,'NULL') = NVL(T.ADRECA_P,'NULL')
                                AND NVL(NUEVOS.MUNICIPI_P,'NULL') = NVL(T.MUNICIPI_P,'NULL')
                                AND NVL(NUEVOS.TELEFON_P,'NULL') = NVL(T.TELEFON_P,'NULL')
                              );
      
       /* ANULADO 26/07/2018. Se quita cp y provincia
        -- SOLO TENER EN CUENTA LOS QUE TENGAN DATOS INFORMADOS      
        INSERT INTO Z_SB02_DIF_CONT_PART_VIPS (ID_CONTACTE,	N_VIP,	ADRECA_P,	MUNICIPI_P,	PROVINCIA_P, CP_P,	TELEFON_P)      
        SELECT Z_SEQ_CONTACTE.NEXTVAL AS ID_CONTACTE, 
               N_VIP, 
               NVL((ADRECA_P),'NULL') AS adreca_p, 
               NVL(MUNICIPI_P,'NULL') AS municipi_p,  
               NVL(PROVINCIA_P,'NULL') AS provincia_p, 
               NVL(CP_P,'NULL') AS CP_P, 
               NVL(TELEFON_P,'NULL') AS TELEFON_P 
        FROM (
                SELECT N_VIP, 
                       ADRECA_P, 
                       MUNICIPI_P, 
                       PROVINCIA_P, 
                       CP_P, 
                       TELEFON_P 
                FROM Z_TMP_VIPS_U_VIPS T 
                WHERE (TRIM(REPLACE(T.ADRECA_P,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.municipi_p,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.CP_p,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.PROVINCIA_P,'.','')) IS NOT NULL
                       )
                  AND NOT EXISTS(SELECT * 
                                 FROM Z_SB01_DIF_CONT_VIPS DIF 
                                 WHERE TRIM(REPLACE(FUNC_NORMALITZAR(T.Adreca_p),'.',''))= DIF.ADRECA 
                                   AND TRIM(REPLACE(T.municipi_p,'.','')) = DIF.municipi 
                                   AND TRIM(REPLACE(T.CP_p,'.','')) = DIF.Cp 
                                   AND TRIM(REPLACE(T.PROVINCIA_P,'.','')) = DIF.PROVINCIA 
                                   AND TRIM(T.N_VIP) = DIF.N_VIP 
                                )
                GROUP BY N_VIP, (ADRECA_P), MUNICIPI_P, PROVINCIA_P, CP_P , TELEFON_P
              );
            */
        COMMIT;
    END;
    
    
    PROCEDURE SB03_CONTACTES_ID IS
    BEGIN
             
            INSERT INTO Z_SB003_CONTACTES_ID --DADES_DIF_IDCONT_CLASS_VIPS
                SELECT DIF.Id_Contacte,
                       CV.* 
                FROM Z_SB001_CONTACTOS_ACTIVOS DIF, 
                     Z_TMP_VIPS_U_CLASSIF_VIP CV,     
                      TMP_CLASSIF_ACTIVES act
                WHERE FUNC_NORMALITZAR(CV.CARREC || CV.ENTITAT || CV.ADRECA || CV.MUNICIPI) = DIF.Contacte_Normalizado
--                DIF.CARREC = NVL(TRIM(CV.CARREC),'NULL') 
--                  AND DIF.ENTITAT = NVL(TRIM(CV.ENTITAT),'NULL')  
--                  AND DIF.ADRECA = NVL(TRIM(FUNC_NORMALITZAR(CV.ADRECA)),'NULL')  
--                  AND DIF.MUNICIPI = NVL(TRIM(CV.MUNICIPI),'NULL')  
                  AND DIF.N_VIP = CV.N_VIP
                  AND CV.CLASSIF = act.codi
                  AND NOT exists (SELECT 1 
                                    FROM Z_SB003_CONTACTES_ID nuevos
                                    WHERE nuevos.Id_Contacte = DIF.Id_Contacte);

    
      COMMIT;
    
    END;  
    
        /* REVISAR */
    PROCEDURE SB04_SUBJECTES_ID IS
    BEGIN
             
    INSERT INTO Z_SB004_SUBJECTES_ID --DADES_IDCONTACTES_CLASS_VIPS
      SELECT DIF.Id_Contacte,
             (CASE WHEN(length(VIPS.COGNOMS) - length(replace(VIPS.COGNOMS, ' ', '')) + 1) = 2 THEN 
                        trim(SUBSTR(VIPS.COGNOMS,1,INSTR(VIPS.COGNOMS,' ')-1))
                   WHEN trim(SUBSTR(VIPS.COGNOMS,1, INSTR(LOWER(VIPS.COGNOMS),' i ')-1)) IS NULL THEN 
                        VIPS.COGNOMS 
              ELSE  
                  trim(SUBSTR(VIPS.COGNOMS,1, INSTR(LOWER(VIPS.COGNOMS),' i ')-1))
              END)  AS COGNOM1, 
              (CASE WHEN trim(SUBSTR(VIPS.COGNOMS,1, INSTR(LOWER(VIPS.COGNOMS),' i ')-1)) IS NOT NULL THEN 
                        trim(SUBSTR(VIPS.COGNOMS,INSTR(LOWER(VIPS.COGNOMS),' i ')))
                    WHEN (length(VIPS.COGNOMS) - length(replace(VIPS.COGNOMS, ' ', '')) + 1) = 2 THEN  
                        trim(SUBSTR(VIPS.COGNOMS, INSTR(VIPS.COGNOMS,' ')))
              ELSE 
                    NULL 
              END) AS COGNOM2,                 
              (case when SUBSTR(nom,instr(nom,'(')+1,instr(nom,')') - (instr(nom,'(')+1)) IS NOT NULL then
                        SUBSTR(nom,instr(nom,'(')+1,instr(nom,')') - (instr(nom,'(')+1))
                    when SUBSTR(COGNOMS,instr(COGNOMS,'(') +1 ,instr(COGNOMS,')') - (instr(COGNOMS,'(') +1)) is not null then
                        SUBSTR(COGNOMS,instr(COGNOMS,'(') +1 ,instr(COGNOMS,')') - (instr(COGNOMS,'(') +1))
              else
                null
              end) as Alies_Vips,            
              VIPS.* 
      FROM Z_SB002_CONTACTOS_VIPS DIF, 
           Z_TMP_VIPS_U_VIPS VIPS
      WHERE DIF.N_VIP = VIPS.N_VIP
        AND DIF.ADRECA_P = NVL(VIPS.ADRECA_P,'NULL')  
        AND DIF.MUNICIPI_P = NVL(VIPS.MUNICIPI_P,'NULL')  
        AND DIF.TELEFON_P =  NVL(VIPS.TELEFON_P,'NULL') 
        AND NOT EXISTS (SELECT 1
                        FROM Z_SB004_SUBJECTES_ID NUEVOS
                        WHERE NUEVOS.Id_Contacte = DIF.Id_Contacte);
      
      COMMIT;
    
    END;  
      
   
   PROCEDURE SB05_CONTACTES_SIN_GENER IS
   BEGIN
   
           INSERT INTO Z_SB005_CONTACTES_SIN_GENER
            SELECT CONTACTES_TODOS.*
            FROM Z_SB003_CONTACTES_ID CONTACTES_TODOS
                 LEFT OUTER JOIN 
                    (SELECT * 
					 FROM Z_SB003_CONTACTES_ID
					 WHERE CLASSIF='GENER'                   
                     ) CONTACTES_SIN_GENER
                 ON   CONTACTES_TODOS.ID_CONTACTE = CONTACTES_SIN_GENER.ID_CONTACTE 
            WHERE CONTACTES_SIN_GENER.ID_CONTACTE IS NULL
             AND NOT EXISTS ( SELECT 1 
                                FROM Z_SB005_CONTACTES_SIN_GENER ANTIGUOS                                
                               WHERE  ID_CONTACTE = ANTIGUOS.ID_CONTACTE
                             );
   
   
    
   COMMIT;
   END;
          
  
          
          
   PROCEDURE SB30_TRACTAMENTS IS 
            
            max_seq number;
             
            BEGIN
            
           INSERT INTO Z_SB030_TRACTAMENT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,ABREUJADA,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
                    SELECT  SEQ_DM_TRACTAMENT.NEXTVAL AS ID , 
                            TRACTAMENTS_UNICOS.CODI, 
                            TRACTAMENTS_UNICOS.descripcio AS DESCRIPCIO,        
                            FUNC_FECHA_1970(NULL) AS DATA_CREACIO, 
                            FUNC_NULOS_INSERT() AS DATA_MODIFICACIO, 
                            FUNC_NULOS_INSERT() AS DATA_ESBORRAT, 
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                            FUNC_NULOS_INSERT() AS USUARI_ESBORRAT,
                            FUNC_NULOS_INSERT() AS USUARI_MODIFICACIO, 
                            TRACTAMENTS_UNICOS.abreujada AS ABREUJADA, 
                            TRACTAMENTS_UNICOS.CODI AS ID_ORIGINAL, 
                            'VIPS_U' AS ESQUEMA_ORIGINAL, 
                            'TRACTAMENTS' AS TABLA_ORIGINAL
                    FROM (
                            SELECT CODI,
                                   DESCRIPCIO,
                                   ABREUJADA
                            FROM Z_TMP_VIPS_U_TRACTAMENTS
                            WHERE FUNC_NORMALITZAR(descripcio) IN (
                                                                    SELECT FUNC_NORMALITZAR(descripcio)
                                                                    FROM Z_TMP_VIPS_U_TRACTAMENTS
                                                                    WHERE FUNC_NORMALITZAR(descripcio) IS NOT NULL
                                                                    GROUP BY FUNC_NORMALITZAR(descripcio)
                                                                   )
                         ) TRACTAMENTS_UNICOS
                    WHERE NOT EXISTS (SELECT 1 
                                        FROM Z_SB030_TRACTAMENT NUEVOS
                                       WHERE FUNC_NORMALITZAR(TRACTAMENTS_UNICOS.DESCRIPCIO) = FUNC_NORMALITZAR(NUEVOS.DESCRIPCIO)
                                      );
            
--         max_seq := max_seq +1;
--         SET_SEQ('SEQ_DM_TRACTAMENT',max_seq);
            
            INSERT INTO Z_SB030_TRACTAMENT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO,USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
                         SELECT SEQ_DM_TRACTAMENT.NEXTVAL AS ID , 
                                TRACTAMENTS_VIPS.TRACTAMENT AS CODI, 
                                TRACTAMENTS_VIPS.TRACTAMENT AS DESCRIPCIO,        
                                FUNC_FECHA_1970(NULL) AS DATA_CREACIO, 
                                FUNC_NULOS_INSERT() AS DATA_MODIFICACIO, 
                                FUNC_NULOS_INSERT() AS DATA_ESBORRAT, 
                                FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                                FUNC_NULOS_INSERT() AS USUARI_ESBORRAT,
                                FUNC_NULOS_INSERT() AS USUARI_MODIFICACIO,
                                FUNC_NULOS_INSERT() AS ABREUJADA, 
                                TRACTAMENTS_VIPS.TRACTAMENT AS ID_ORIGINAL, 
                                'VIPS_U' AS ESQUEMA_ORIGINAL, 
                                'VIPS' AS TABLA_ORIGINAL
                        FROM (	
                                SELECT TRACTAMENT AS TRACTAMENT
                                  FROM Z_TMP_VIPS_U_VIPS
                                 WHERE FUNC_NORMALITZAR(TRACTAMENT) NOT IN ( SELECT FUNC_NORMALITZAR(CODI)
                                                                               FROM Z_SB030_TRACTAMENT											
                                                                           )	
                                 GROUP BY TRACTAMENT
                        ) TRACTAMENTS_VIPS		 
                        WHERE NOT EXISTS (SELECT 1
                                           FROM Z_SB030_TRACTAMENT NUEVOS
                                           WHERE TRACTAMENTS_VIPS.TRACTAMENT=NUEVOS.CODI 
                                             AND TRACTAMENTS_VIPS.TRACTAMENT = NUEVOS.DESCRIPCIO
                                           ); 
            COMMIT;
                        
            -- BUSCAR MAPEO PARA DESCRIPCIONES IGUALES, MAPEAR AL MISMO TRACTAMENT (ejecutado cambiando valor duplicado H. Sr. 2,74 en auxiliar) 
            
--            INSERT INTO DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO,USUARI_CREACIO)
--                        SELECT NUEVOS.id, 
--                               NUEVOS.descripcio, 
--                               NUEVOS.data_creacio, 
--                               NUEVOS.usuari_creacio
--                        FROM Z_SB030_TRACTAMENT NUEVOS
--                        WHERE NOT EXISTS (SELECT * 
--                                          FROM DM_TRACTAMENT ANTIGUOS
--                                          WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO);
            COMMIT;
            
                      
          END; 
          
    
          -- CREAR ENFOQUE LIMPIANDO CLASSIFICACIONES QUE NO TENGAN PERSONAS ASSIGNADAS
           
    PROCEDURE SB31_DM_TRACTAMENT IS 
    BEGIN
    
    
                INSERT INTO Z_SB999_DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
                     SELECT ID, 
                     		DESCRIPCIO, 
                     		DATA_CREACIO, 
                     		DATA_MODIFICACIO, 
                     		DATA_ESBORRAT, 
                     		USUARI_CREACIO, 
                     		USUARI_ESBORRAT, 
                     		USUARI_MODIFICACIO, 
                     		ABREUJADA,
                     		ID_ORIGINAL,
                     		ESQUEMA_ORIGINAL,
                     		TABLA_ORIGINAL
                       FROM Z_SB030_TRACTAMENT NUEVOS
                      WHERE NOT EXISTS (SELECT 1
                                          FROM Z_SB999_DM_TRACTAMENT ANTIGUOS
                                         WHERE FUNC_NORMALITZAR(NUEVOS.DESCRIPCIO) = FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO)
                                        );
            
    
    
    COMMIT;
                INSERT INTO DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
                     SELECT ID, 
                     		DESCRIPCIO, 
                     		DATA_CREACIO, 
                     		DATA_MODIFICACIO, 
                     		DATA_ESBORRAT, 
                     		USUARI_CREACIO, 
                     		USUARI_ESBORRAT, 
                     		USUARI_MODIFICACIO, 
                     		ABREUJADA,
                     		ID_ORIGINAL,
                     		ESQUEMA_ORIGINAL,
                     		TABLA_ORIGINAL
                       FROM Z_SB999_DM_TRACTAMENT NUEVOS
                      WHERE NOT EXISTS (SELECT 1
                                          FROM DM_TRACTAMENT ANTIGUOS
                                         WHERE FUNC_NORMALITZAR(NUEVOS.DESCRIPCIO) = FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO)
                                        );
            
    
    COMMIT;
    END;
        
        
    PROCEDURE SB50_CARRECS IS      
    BEGIN
    
            INSERT INTO Z_SB050_CARRECS (ID_CARREC,CARREC_NORM,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL)
                   SELECT SEQ_DM_CARREC.NEXTVAL AS ID_CARREC, 
                          T.CARREC_NORM AS CARREC_NORM,
                          FUNC_NULOS_INSERT() AS ID_ORIGINAL,
                          'VIPS_U' AS ESQUEMA_ORIGINAL,
                          'CLASSIF_VIP' AS TABLA_ORIGINAL
                   FROM ( 
                           SELECT FUNC_NORMALITZAR(CARREC) AS CARREC_NORM
                           FROM Z_SB003_CONTACTES_ID 
                           WHERE TRIM(FUNC_NORMALITZAR(CARREC)) IS NOT NULL
                           GROUP BY FUNC_NORMALITZAR(CARREC)
                        )T
                   WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_SB050_CARRECS ANTIGUOS 
                                     WHERE T.CARREC_NORM = ANTIGUOS.CARREC_NORM
                                    );
            COMMIT;
            
           
                
    END;    
        
    PROCEDURE SB51_CARRECS_CONTACTES_REL IS      
    BEGIN
    
             INSERT INTO Z_SB051_CARRECS_CONTACTES_REL (ID_CONTACTE, ID_CARREC)
                     SELECT Contactes.ID_CONTACTE, 
                            Z_B50.ID_CARREC
                    FROM Z_SB003_CONTACTES_ID Contactes, 
                         Z_SB050_CARRECS Z_B50
                    WHERE TRIM(FUNC_NORMALITZAR(Contactes.CARREC)) IS NOT NULL 
                      AND FUNC_NORMALITZAR(Contactes.CARREC) = Z_B50.CARREC_NORM
                      AND NOT EXISTS ( SELECT 1 
                      				   FROM Z_SB051_CARRECS_CONTACTES_REL ANTIGUOS
                      				   WHERE ANTIGUOS.ID_CONTACTE = Contactes.ID_CONTACTE
                      				     AND ANTIGUOS.ID_CARREC = Z_B50.ID_CARREC) 
                    GROUP BY Contactes.ID_CONTACTE, Z_B50.ID_CARREC;
                    
                    
                    

            COMMIT;
                    

            COMMIT;
        END;
    
    PROCEDURE SB52_CARRECS_CONTACTES_NULL IS      
    BEGIN
        INSERT INTO Z_SB052_CARRECS_CONTACTES_NULL (ID_CONTACTE, ID_CARREC)
                     SELECT Contacte.ID_CONTACTE AS ID_CONTACTE,
                            FUNC_NULOS_INSERT() AS ID_CARREC
                    FROM Z_SB003_CONTACTES_ID Contacte
                    WHERE TRIM(FUNC_NORMALITZAR(Contacte.CARREC)) IS NULL                      
                      AND NOT EXISTS ( SELECT 1 
                      				   FROM Z_SB052_CARRECS_CONTACTES_NULL ANTIGUOS
                      				   WHERE ANTIGUOS.ID_CONTACTE = Contacte.ID_CONTACTE
                      				  ) 
                    GROUP BY Contacte.ID_CONTACTE;
    
    COMMIT;
    END;
    
    PROCEDURE SB53_CARRECS_CONTACTES IS
    BEGIN
    
        INSERT INTO Z_SB053_CARRECS_CONTACTES (ID_CONTACTE,ID_CARREC,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL)
                    SELECT ID_CONTACTE,
                           ID_CARREC,
                           ID_ORIGINAL,
                           ESQUEMA_ORIGINAL,
                           TABLA_ORIGINAL
                    FROM (       
                            SELECT ID_CONTACTE, 
                                   ID_CARREC,
                                    'SECUENCIA' AS ID_ORIGINAL,
                                    'VIPS_U' AS ESQUEMA_ORIGINAL,
                                    'CLASSIF_VIP' AS TABLA_ORIGINAL
                            FROM Z_SB051_CARRECS_CONTACTES_REL
                                UNION ALL
                            SELECT ID_CONTACTE, 
                                   FUNC_NULOS_NUMERIC() AS ID_CARREC,
                                   'SIN CARGO' AS ID_ORIGINAL,
                                   'VIPS_U' AS ESQUEMA_ORIGINAL,
                                  'CLASSIF_VIP' AS TABLA_ORIGINAL
                            FROM Z_SB052_CARRECS_CONTACTES_NULL
                         ) CARRECS_CONTACTES	
                    WHERE NOT EXISTS (SELECT 1 
                                      FROM Z_SB053_CARRECS_CONTACTES ANTIGUOS
                                      WHERE CARRECS_CONTACTES.ID_CONTACTE =ANTIGUOS.ID_CONTACTE
                                        AND FUNC_NULOS(CARRECS_CONTACTES.ID_CARREC) = FUNC_NULOS(ANTIGUOS.ID_CARREC) 
                                     );
    
    COMMIT;
    END;
    
        
    PROCEDURE SB55_DM_CARREC IS
    BEGIN
    
        INSERT INTO Z_SB999_DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT Z_B50.ID_CARREC AS ID, 
                           MAX(Z_B03.CARREC) AS DESCRIPCIO, 
                           MAX(FUNC_FECHA_1970(NULL)) AS DATA_CREACIO, 
                           MAX(FUNC_NULOS_INSERT()) AS DATA_ESBORRAT,
                           MAX(FUNC_NULOS_INSERT()) AS DATA_MODIFICACIO,
                           MAX(FUNC_USU_CREACIO(NULL)) AS USUARI_CREACIO,
                           MAX(FUNC_NULOS_INSERT()) AS USUARI_ESBORRAT,
                           MAX(FUNC_NULOS_INSERT()) AS USUARI_MODIFICACIO,
                           MAX(Z_B50.ID_ORIGINAL) AS ID_ORIGINAL,
                           MAX(Z_B50.ESQUEMA_ORIGINAL) AS ESQUEMA_ORIGINAL,
                           MAX(Z_B50.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SB050_CARRECS Z_B50, 
                          Z_SB003_CONTACTES_ID Z_B03
                     WHERE FUNC_NORMALITZAR(Z_B03.CARREC) = Z_B50.CARREC_NORM 
                       AND NOT EXISTS(SELECT 1 
                                        FROM Z_SB999_DM_CARREC ANTIGUOS
                                       WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = Z_B50.CARREC_NORM
                                      )
                     GROUP BY Z_B50.ID_CARREC;
    
     COMMIT;
     
        INSERT INTO DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT ID, 
                           trim(DESCRIPCIO), 
                           DATA_CREACIO, 
                           DATA_ESBORRAT, 
                           DATA_MODIFICACIO, 
                           USUARI_CREACIO, 
                           USUARI_ESBORRAT, 
                           USUARI_MODIFICACIO, 
                           ID_ORIGINAL, 
                           ESQUEMA_ORIGINAL, 
                           TABLA_ORIGINAL
                     FROM Z_SB999_DM_CARREC NUEVOS
                     WHERE NOT EXISTS(SELECT 1 
                                        FROM DM_CARREC ANTIGUOS
                                       WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR(NUEVOS.DESCRIPCIO)
                                      );

            COMMIT;
    
    COMMIT;
    END;
    
    
    
    PROCEDURE SB60_ENTITATS IS 
      
    BEGIN
      
            -- VALORS UTILTIZATS DEL CATALEG
            INSERT INTO Z_SB060_ENTITAT_CATALOG (ID, CODI, ENTITAT, ENTITAT_NORM, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT SEQ_DM_ENTITAT.NEXTVAL AS ID, 
                        CODI, 
                        ENTITAT, 
                        ENTITAT_NORM,
                        CODI AS ID_ORIGINAL, 
                        'VIPS_U' AS ESQUEMA_ORIGINAL, 
                        'ENTITAT' AS TABLA_ORIGINAL
                   FROM (
                           SELECT  MAX(CODI) AS CODI, 
                                   MAX(NVL(ent.ENTITAT,ent.CODI)) AS ENTITAT, 
                                   FUNC_NORMALITZAR_ENTITAT(ent.ENTITAT) AS ENTITAT_NORM
                           FROM Z_TMP_VIPS_U_ENTITAT ent, 
                                Z_SB003_CONTACTES_ID c
                           WHERE c.codi_entitat = ent.codi 
                             or  FUNC_NORMALITZAR_ENTITAT(c.entitat) = FUNC_NORMALITZAR_ENTITAT(ent.entitat)
                             AND TRIM(ent.ENTITAT) IS NOT NULL
                           GROUP BY FUNC_NORMALITZAR_ENTITAT(ent.ENTITAT)
                        ) T
                  WHERE NOT EXISTS (SELECT 1
                                    FROM Z_SB060_ENTITAT_CATALOG 
                                    WHERE CODI = t.CODI
                                   ) ;
--                    AND
--                        NOT EXISTS (SELECT 1 
--                                    FROM DM_ENTITAT 
--                                    where FUNC_NORMALITZAR_ENTITAT(t.entitat) = FUNC_NORMALITZAR_ENTITAT(DESCRIPCIO)
--                                   ); 
            COMMIT;
        END;
        
        
        
        PROCEDURE SB61_ENTITATS_CODI_NULL IS 
        BEGIN
                INSERT INTO Z_SB061_ENTITATS_CODI_NULL (ID, CODI, ENTITAT, ENTITAT_NORM, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                              SELECT SEQ_DM_ENTITAT.NEXTVAL AS ID, 
                                     FUNC_NULOS_INSERT() AS CODI,
                                     aec.entitat AS ENTITAT, 
                                     aec.ENTITAT_NORM AS ENTITAT_NORM,
                                     FUNC_NULOS_INSERT() AS ID_ORIGINAL, 
                                     'VIPS_U' AS ESQUEMA_ORIGINAL, 
                                     'CLASSIF_VIP' AS TABLA_ORIGINAL
                              FROM  (
                                      SELECT FUNC_NORMALITZAR_ENTITAT(ENTITAT) AS ENTITAT_NORM, 
                                             MAX(ENTITAT) AS ENTITAT
                                      FROM Z_SB003_CONTACTES_ID
                                      WHERE FUNC_NORMALITZAR_ENTITAT(ENTITAT) IS NOT NULL 
                                        AND CODI_ENTITAT IS NULL
                                        AND FUNC_NORMALITZAR_ENTITAT(ENTITAT) NOT IN ( SELECT FUNC_NORMALITZAR_ENTITAT(ENTITAT) 
                                                                                         FROM Z_SB060_ENTITAT_CATALOG
                                                                                     ) 
                                    GROUP BY FUNC_NORMALITZAR_ENTITAT(ENTITAT)
                                  ) aec
                            WHERE NOT EXISTS(SELECT 1 
                                              FROM Z_SB061_ENTITATS_CODI_NULL ANTIGUOS
                                              where ANTIGUOS.ENTITAT_NORM = aec.ENTITAT_NORM
                                             );
            COMMIT;
        
        
        COMMIT;
        END;
        

        PROCEDURE SB65_DM_ENTITATS IS
        BEGIN
        
                    INSERT INTO Z_SB999_DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                        SELECT ID, 
                               CODI, 
                               DESCRIPCIO, 
                               DATA_CREACIO, 
                               DATA_ESBORRAT, 
                               DATA_MODIFICACIO, 
                               USUARI_CREACIO, 
                               USUARI_ESBORRAT, 
                               USUARI_MODIFICACIO, 
                               ID_ORIGINAL, 
                               ESQUEMA_ORIGINAL, 
                               TABLA_ORIGINAL
                        FROM (	   
                                SELECT ID AS ID, 
                                       TO_CHAR(CODI) AS CODI, 
                                       entitat AS DESCRIPCIO, 
                                       FUNC_FECHA_1970(NULL) AS DATA_CREACIO, 
                                       FUNC_NULOS_INSERT() AS DATA_ESBORRAT,
                                       FUNC_NULOS_INSERT() AS DATA_MODIFICACIO,
                                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                       FUNC_NULOS_INSERT() AS USUARI_ESBORRAT,
                                       FUNC_NULOS_INSERT() AS USUARI_MODIFICACIO, 
                                       ID_ORIGINAL, 
                                       ESQUEMA_ORIGINAL, 
                                       TABLA_ORIGINAL
                                FROM Z_SB060_ENTITAT_CATALOG
                                    UNION ALL
                                SELECT ID AS ID, 
                                       TO_CHAR(ID) AS CODI, 
                                       entitat AS DESCRIPCIO, 
                                       FUNC_FECHA_1970(NULL) AS DATA_CREACIO, 
                                       FUNC_NULOS_INSERT() AS DATA_ESBORRAT,
                                       FUNC_NULOS_INSERT() AS DATA_MODIFICACIO,
                                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                       FUNC_NULOS_INSERT() AS USUARI_ESBORRAT,
                                       FUNC_NULOS_INSERT() AS USUARI_MODIFICACIO, 
                                       ID_ORIGINAL, 
                                       ESQUEMA_ORIGINAL, 
                                       TABLA_ORIGINAL
                                FROM Z_SB061_ENTITATS_CODI_NULL
                        ) UNION_ENTITATS
                        WHERE NOT EXISTS (SELECT 1
                                           FROM Z_SB999_DM_ENTITAT ANTIGUOS
                                          WHERE FUNC_NORMALITZAR_ENTITAT(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR_ENTITAT(UNION_ENTITATS.DESCRIPCIO)
                                         ); 
        
        
        
        COMMIT;
        
        
        
            INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                        SELECT ID, 
                               CODI, 
                               DESCRIPCIO, 
                               DATA_CREACIO, 
                               DATA_ESBORRAT, 
                               DATA_MODIFICACIO, 
                               USUARI_CREACIO, 
                               USUARI_ESBORRAT, 
                               USUARI_MODIFICACIO, 
                               ID_ORIGINAL, 
                               ESQUEMA_ORIGINAL, 
                               TABLA_ORIGINAL
                        FROM Z_SB999_DM_ENTITAT NUEVOS
                        WHERE NOT EXISTS (SELECT 1
                                           FROM DM_ENTITAT ANTIGUOS
                                          WHERE FUNC_NORMALITZAR_ENTITAT(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR_ENTITAT(NUEVOS.DESCRIPCIO)
                                         ); 
        
        
        COMMIT;
        END;
           
            
            
            
            
           
    
    
    PROCEDURE SB66_ENTITATS_CONTACTES IS    
    BEGIN    
    
            INSERT INTO Z_SB066_ENTITATS_CONTACTES (ID, ID_CONTACTE)
                 SELECT ent.id AS ID, 
                        c.id_contacte
                 FROM DM_ENTITAT ent, 
                      Z_SB003_CONTACTES_ID c
                WHERE FUNC_NORMALITZAR_ENTITAT(ent.descripcio) = FUNC_NORMALITZAR_ENTITAT(c.entitat) 
                  AND TRIM(REPLACE(REPLACE(c.entitat,'.',''),'-','')) IS NOT NULL 
                  AND  NOT EXISTS(SELECT 1 
                                  FROM Z_SB066_ENTITATS_CONTACTES ec 
                                  WHERE ec.id_contacte = c.id_contacte and ec.id = ent.id)
                GROUP BY ent.id, c.id_contacte;
           
 
            COMMIT;
            
    END;
    
------------------------------------------------------------------------------    
-- SUBJECTES -----------------------------------------------------------------    
------------------------------------------------------------------------------    
    
    PROCEDURE SB70_SUBJECTES_DIFUNTS IS                 
    BEGIN
   
       INSERT INTO Z_SB070_SUBJECTES_DIFUNTS
            SELECT N_VIP, 
                   NVL2(DATA_ALTA,TRUNC(DATA_ALTA),TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_DEFUNCIO
            FROM Z_SB003_CONTACTES_ID 
            WHERE CLASSIF = 'DEFU'
            AND NOT EXISTS (SELECT 1
                            FROM Z_SB070_SUBJECTES_DIFUNTS ANTIGUOS
                            WHERE ANTIGUOS.N_VIP = N_VIP);
            
       COMMIT;
    END;
    
    
    PROCEDURE SB71_SUBJECTES_AMB_PRIORITAT IS
      
    BEGIN
           INSERT INTO Z_SB071_SUBJECTES_AMB_PRIORITA (N_VIP, PRIORITAT)
                SELECT N_VIP, 
                       ConstPRIORIDAD_SC AS PRIORITAT
                FROM Z_SB003_CONTACTES_ID 
                WHERE TRIM(FAX) IN ('1-SC','91-SC')        
                  AND NOT EXISTS(SELECT 1
                            FROM Z_SB071_SUBJECTES_AMB_PRIORITA ANTIGUOS
                            WHERE ANTIGUOS.N_VIP = N_VIP)
                GROUP BY N_VIP, ConstPRIORIDAD_SC ;
                
           COMMIT;
    END;
    
    
    PROCEDURE SB72_SUBJECTES_VIPS IS
    BEGIN
    
                INSERT INTO Z_SB072_SUBJECTES_VIPS (ID, NOM,COGNOM1,COGNOM2,ALIES,NOM_NORMALITZAT, DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT,	TRACTAMENT_ID,	PRIORITAT_ID,	TIPUS_SUBJECTE_ID,	AMBIT_ID,	IDIOMA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                        SELECT ID AS ID, 
                               MAX(NOM) AS NOM, 
                               MAX(COGNOM1) AS COGNOM1, 
                               MAX(COGNOM2) AS COGNOM2, 
                               MAX(ALIES) AS ALIES, 
                               MAX(NOM_NORMALITZAT) AS NOM_NORMALITZAT,
                               MAX(DATA_DEFUNCIO) AS DATA_DEFUNCIO, 
                               MAX(MOTIU_BAIXA) AS MOTIU_BAIXA, 
                               MAX(DATA_CREACIO) AS DATA_CREACIO, 
                               MAX(DATA_ESBORRAT) AS DATA_ESBORRAT, 
                               MAX(DATA_MODIFICACIO) AS DATA_MODIFICACIO,
                               MAX(USUARI_CREACIO) AS USUARI_CREACIO, 
                               MAX(USUARI_MODIFICACIO) AS USUARI_MODIFICACIO, 
                               MAX(USUARI_ESBORRAT) AS USUARI_ESBORRAT, 
                               MAX(TRACTAMENT_ID) AS TRACTAMENT_ID, 
                               MAX(PRIORITAT_ID) AS PRIORITAT_ID, 
                               MAX(TIPUS_SUBJECTE_ID) AS TIPUS_SUBJECTE_ID, 
                               MAX(AMBIT_ID) AS AMBIT_ID, 
                               MAX(IDIOMA_ID) AS IDIOMA_ID, 
                               ID AS ID_ORIGINAL, 
                               'VIPS_U' AS ESQUEMA_ORIGINAL, 
                               'VIPS' AS TABLA_ORIGINAL
                  FROM (
                          SELECT  Subjecte.N_VIP AS ID,
                                  FUNC_NULOS_ASTERICO(Subjecte.NOM) AS NOM,
                                  Subjecte.COGNOM1 AS COGNOM1,
                                  Subjecte.COGNOM2 AS COGNOM2,
                                  Subjecte.ALIES_VIPS AS ALIES,
                                  FUNC_NORMALITZAR(Subjecte.NOM||Subjecte.COGNOM1||Subjecte.COGNOM2) as NOM_NORMALITZAT,
                                  SubjecteDifunto.DATA_DEFUNCIO AS DATA_DEFUNCIO,
                                  FUNC_NULOS_INSERT() AS MOTIU_BAIXA,
                                  NVL2(DATA_ALTA, DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_CREACIO,                      
                                  DATA_BAIXA AS DATA_ESBORRAT,
                                  DATA_MODIF AS DATA_MODIFICACIO, 
                                  FUNC_USU_CREACIO(USU_ALTA) AS USUARI_CREACIO,   
                                  NVL2(USU_MODIF, USU_MODIF, NVL2(DATA_MODIF, 'MIGRACIO', NULL)) AS USUARI_MODIFICACIO,
                                  NVL2(DATA_BAIXA, 'MIGRACIO', NULL) AS USUARI_ESBORRAT, 
                                  (SELECT tractament.ID FROM DM_TRACTAMENT tractament WHERE tractament.ID_ORIGINAL = Subjecte.Tractament) AS TRACTAMENT_ID,
--                                  (SELECT prioritat.ID FROM DM_PRIORITAT prioritat WHERE prioritat.DESCRIPCIO = SubjectePR.prioritat) AS PRIORITAT_ID,
                                  (SELECT 1 FROM Z_SB071_SUBJECTES_AMB_PRIORITA WHERE n_vip = Subjecte.N_VIP) AS PRIORITAT_ID,
                                  ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                                  ConstAMBIT_PROTOCOL AS AMBIT_ID,
                                  FUNC_NULOS_INSERT() AS IDIOMA_ID         
                          FROM Z_SB004_SUBJECTES_ID Subjecte, 
                               Z_SB070_SUBJECTES_DIFUNTS SubjecteDifunto
                          WHERE Subjecte.N_VIP = SubjecteDifunto.N_VIP (+) 
                            AND NOT EXISTS (SELECT 1 
                                            FROM Z_SB072_SUBJECTES_VIPS ANTIGUOS
                                            WHERE ANTIGUOS.ID = Subjecte.N_VIP)
                       ) T
                  GROUP BY ID;
                  COMMIT;
    
    COMMIT;
    END;
    
    PROCEDURE SB73_SUBJECTE_CONTACTE IS
    BEGIN
    
    INSERT INTO Z_SB073_SUBJECTE_CONTACTE (ID, NOM,COGNOM1,COGNOM2,ALIES,NOM_NORMALITZAT,DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TRACTAMENT_ID,	PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT ID as ID, 
                       MAX(NOM) AS NOM, 
                       MAX(COGNOM1) AS COGNOM1, 
                       MAX(COGNOM2) AS COGNOM2, 
                       MAX(ALIES) AS ALIES, 
                       MAX(NOM_NORMALITZAT) as NOM_NORMALITZAT,
                       MAX(DATA_DEFUNCIO) AS DATA_DEFUNCIO, 
                       MAX(MOTIU_BAIXA) AS MOTIU_BAIXA, 
                       MAX(DATA_ALTA) AS DATA_CREACIO, 
                       MAX(DATA_BAIXA) AS DATA_ESBORRAT,
                       MAX(DATA_MODIFICACIO) AS DATA_MODIFICACIO, 
                       MAX(USUARI_CREACIO) AS USUARI_CREACIO, 
                       MAX(USUARI_MODIFICACIO) AS USUARI_MODIFICACIO, 
                       MAX(USUARI_ESBORRAT) AS USUARI_ESBORRAT, 
                       MAX(TRACTAMENT_ID) AS TRACTAMENT_ID, 
                       MAX(PRIORITAT_ID) AS PRIORITAT_ID, 
                       MAX(TIPUS_SUBJECTE_ID) AS TIPUS_SUBJECTE_ID, 
                       MAX(AMBIT_ID) AS AMBIT_ID, 
                       MAX(IDIOMA_ID) AS IDIOMA_ID,
                       ID AS ID_ORIGINAL, 
                       'VIPS_U' AS ESQUEMA_ORIGINAL, 
                       'CLASSIF_VIPS' AS TABLA_ORIGINAL
                FROM (
                          SELECT  Contactes.N_VIP AS ID,
                                  FUNC_NULOS_ASTERICO(VIPS.NOM) AS NOM,
                                  (CASE WHEN(length(VIPS.COGNOMS) - length(replace(VIPS.COGNOMS, ' ', '')) + 1) = 2 THEN 
                                                trim(SUBSTR(VIPS.COGNOMS,1,INSTR(VIPS.COGNOMS,' ')-1))
                                        WHEN trim(SUBSTR(VIPS.COGNOMS,1, INSTR(LOWER(VIPS.COGNOMS),' i ')-1)) IS NULL THEN 
                                                VIPS.COGNOMS 
                                  ELSE  
                                        trim(SUBSTR(VIPS.COGNOMS,1, INSTR(LOWER(VIPS.COGNOMS),' i ')-1))
                                  END)  AS COGNOM1, 
                                  (CASE WHEN trim(SUBSTR(VIPS.COGNOMS,1, INSTR(LOWER(VIPS.COGNOMS),' i ')-1)) IS NOT NULL THEN 
                                             trim(SUBSTR(VIPS.COGNOMS,INSTR(LOWER(VIPS.COGNOMS),' i ')))
                                        WHEN (length(VIPS.COGNOMS) - length(replace(VIPS.COGNOMS, ' ', '')) + 1) = 2 THEN  
                                             trim(SUBSTR(VIPS.COGNOMS, INSTR(VIPS.COGNOMS,' ')))
                                  ELSE 
                                        NULL 
                                  END) AS COGNOM2, 
                                  (case when SUBSTR(VIPS.nom,instr(VIPS.nom,'(')+1,instr(VIPS.nom,')') - (instr(VIPS.nom,'(')+1)) IS NOT NULL then
                                             SUBSTR(VIPS.nom,instr(VIPS.nom,'(')+1,instr(VIPS.nom,')') - (instr(VIPS.nom,'(')+1))
                                        when SUBSTR(VIPS.COGNOMS,instr(VIPS.COGNOMS,'(') +1 ,instr(VIPS.COGNOMS,')') - (instr(VIPS.COGNOMS,'(') +1)) is not null then
                                             SUBSTR(VIPS.COGNOMS,instr(VIPS.COGNOMS,'(') +1 ,instr(VIPS.COGNOMS,')') - (instr(VIPS.COGNOMS,'(') +1))
                                   else
                                    null
                                  end)  AS ALIES,
                                  FUNC_NORMALITZAR(VIPS.NOM||VIPS.COGNOMS) as NOM_NORMALITZAT,
                                  SubjecteDifunt.DATA_DEFUNCIO AS DATA_DEFUNCIO,
                                  FUNC_NULOS_INSERT() AS MOTIU_BAIXA,
                                  NVL2(Contactes.DATA_ALTA, Contactes.DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA,
                                  DATA_MODI AS DATA_MODIFICACIO, 
                                  VIPS.Data_Baixa AS DATA_BAIXA,
                                  FUNC_USU_CREACIO(Contactes.USU_ALTA) AS USUARI_CREACIO,   
                                  NVL2(Contactes.USU_MODI, Contactes.USU_MODI, NVL2(Contactes.DATA_MODI, 'MIGRACIO', NULL)) AS USUARI_MODIFICACIO,
                                  NVL2(VIPS.Data_Baixa,'MIGRACIO',NULL) AS USUARI_ESBORRAT, 
                                  (SELECT Tractament.ID FROM DM_TRACTAMENT Tractament WHERE Tractament.ID_ORIGINAL = VIPS.TRACTAMENT ) AS TRACTAMENT_ID, 
--                                  (SELECT Prioritat.ID FROM DM_PRIORITAT Prioritat WHERE Prioritat.DESCRIPCIO = SubjectePR.prioritat) AS PRIORITAT_ID,
                                  (SELECT 1 FROM Z_SB071_SUBJECTES_AMB_PRIORITA WHERE n_vip = SubjectePR.N_VIP) AS PRIORITAT_ID,
                                  ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                                  ConstAMBIT_PROTOCOL AS AMBIT_ID,
                                  FUNC_NULOS_INSERT() AS IDIOMA_ID 
                          FROM Z_SB003_CONTACTES_ID Contactes, 
                               Z_SB070_SUBJECTES_DIFUNTS SubjecteDifunt, 
                               Z_SB071_SUBJECTES_AMB_PRIORITA SubjectePR, 
                               Z_TMP_VIPS_U_VIPS VIPS
                          WHERE Contactes.N_VIP = SubjecteDifunt.N_VIP (+) 
                            AND Contactes.N_VIP = VIPS.N_VIP 
                            AND Contactes.n_Vip = SubjectePR.N_VIP (+)
                   ) SUBJECTES_CONTACTES
              WHERE NOT EXISTS (SELECT 1 
                                FROM Z_SB073_SUBJECTE_CONTACTE ANTIGUOS 
                                WHERE ANTIGUOS.ID = SUBJECTES_CONTACTES.ID) 
              GROUP BY ID;
    
    COMMIT;
    END;
    
    
        
    PROCEDURE SB78_SUBJECTES is                 
    BEGIN

      INSERT INTO Z_SB999_SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)      
                 SELECT SEQ_SUBJECTE.NEXTVAL AS ID,
                        NOM AS NOM,
                        COGNOM1 AS COGNOM1,
                        COGNOM2 AS COGNOM2,
                        ALIES AS ALIES,
                        DATA_DEFUNCIO AS DATA_DEFUNCIO,
                        NOM_NORMALITZAT AS NOM_NORMALITZAT,
                        MOTIU_BAIXA AS MOTIU_BAIXA,
                        DATA_CREACIO AS DATA_CREACIO,
                        DATA_ESBORRAT AS DATA_ESBORRAT,
                        DATA_MODIFICACIO AS DATA_MODIFICACIO,
                        USUARI_CREACIO AS USUARI_CREACIO,
                        USUARI_ESBORRAT AS USUARI_ESBORRAT,
                        USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                        TRACTAMENT_ID AS TRACTAMENT_ID,
                        PRIORITAT_ID AS PRIORITAT_ID,
                        TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID,
                        AMBIT_ID AS AMBIT_ID,
                        IDIOMA_ID AS IDIOMA_ID,
                        ID AS ID_ORIGINAL,
                        ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                        TABLA_ORIGINAL AS TABLA_ORIGINAL
                 FROM (
                        SELECT  ID AS ID,
                                NOM AS NOM,
                                COGNOM1 AS COGNOM1,
                                COGNOM2 AS COGNOM2,
                                ALIES AS ALIES,
                                DATA_DEFUNCIO AS DATA_DEFUNCIO,
                                NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                MOTIU_BAIXA AS MOTIU_BAIXA,
                                DATA_CREACIO AS DATA_CREACIO,
                                DATA_ESBORRAT AS DATA_ESBORRAT,
                                DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                USUARI_CREACIO AS USUARI_CREACIO,
                                USUARI_ESBORRAT AS USUARI_ESBORRAT,
                                USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                TRACTAMENT_ID AS TRACTAMENT_ID,
                                PRIORITAT_ID AS PRIORITAT_ID,
                                TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID,
                                AMBIT_ID AS AMBIT_ID,
                                IDIOMA_ID AS IDIOMA_ID,
                                ID AS ID_ORIGINAL,
                                ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                                TABLA_ORIGINAL AS TABLA_ORIGINAL
                        FROM Z_SB072_SUBJECTES_VIPS                                 
                                        UNION ALL                                        
                        SELECT  ID AS ID,
                                NOM AS NOM,
                                COGNOM1 AS COGNOM1,
                                COGNOM2 AS COGNOM2,
                                ALIES AS ALIES,
                                DATA_DEFUNCIO AS DATA_DEFUNCIO,
                                NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                MOTIU_BAIXA AS MOTIU_BAIXA,
                                DATA_CREACIO AS DATA_CREACIO,
                                DATA_ESBORRAT AS DATA_ESBORRAT,
                                DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                USUARI_CREACIO AS USUARI_CREACIO,
                                USUARI_ESBORRAT AS USUARI_ESBORRAT,
                                USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                TRACTAMENT_ID AS TRACTAMENT_ID,
                                PRIORITAT_ID AS PRIORITAT_ID,
                                TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID,
                                AMBIT_ID AS AMBIT_ID,
                                IDIOMA_ID AS IDIOMA_ID,
                                ID AS ID_ORIGINAL,
                                ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                                TABLA_ORIGINAL AS TABLA_ORIGINAL                                        
                        FROM Z_SB073_SUBJECTE_CONTACTE 
                ) SUBJECTES_NUEVOS                
                WHERE NOT EXISTS (SELECT 1
                                   FROM Z_SB999_SUBJECTE ANTIGUOS
                                  WHERE  ANTIGUOS.ID_ORIGINAL = SUBJECTES_NUEVOS.ID_ORIGINAL
                                 );
       COMMIT;                                 
                
                
        INSERT INTO SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                SELECT  ID AS ID,
                        NOM AS NOM,
                        COGNOM1 AS COGNOM1,
                        COGNOM2 AS COGNOM2,
                        ALIES AS ALIES,
                        DATA_DEFUNCIO AS DATA_DEFUNCIO,
                        NOM_NORMALITZAT AS NOM_NORMALITZAT,
                        MOTIU_BAIXA AS MOTIU_BAIXA,
                        DATA_CREACIO AS DATA_CREACIO,
                        DATA_ESBORRAT AS DATA_ESBORRAT,
                        DATA_MODIFICACIO AS DATA_MODIFICACIO,
                        USUARI_CREACIO AS USUARI_CREACIO,
                        USUARI_ESBORRAT AS USUARI_ESBORRAT,
                        USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                        TRACTAMENT_ID AS TRACTAMENT_ID,
                        PRIORITAT_ID AS PRIORITAT_ID,
                        TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID,
                        AMBIT_ID AS AMBIT_ID,
                        IDIOMA_ID AS IDIOMA_ID,
                        ID_ORIGINAL AS ID_ORIGINAL,
                        ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                        TABLA_ORIGINAL AS TABLA_ORIGINAL
                FROM Z_SB999_SUBJECTE NUEVOS
                WHERE NOT EXISTS (SELECT 1
                                   FROM SUBJECTE ANTIGUOS
                                  WHERE  ANTIGUOS.ID = NUEVOS.ID
                                 );     
    COMMIT;    
    END;
    
    -----------------------------------------------------------------------------------
    -- ADRECA ----------------------------------------------------------------------
    -----------------------------------------------------------------------------------        
     
      PROCEDURE SB80_ADRECA_CONTACTE IS      
      BEGIN
              INSERT INTO Z_SB080_ADRECA_CONTACTE (ID_ADRECA,ID_CONTACTE,ADRECA,MUNICIPI,CP,PROVINCIA,PAIS,USU_ALTA,DATA_ALTA,USU_MODI,DATA_MODI,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                    SELECT SEQ_ADRECA.NEXTVAL AS ID_ADRECA, 
                           ID_CONTACTE AS ID_CONTACTE, 
                           ADRECA AS ADRECA, 
                           MUNICIPI AS MUNICIPI, 
                           CP AS CP, 
                           PROVINCIA AS PROVINCIA, 
                           PAIS AS PAIS, 
                           USU_ALTA AS USU_ALTA,
                           DATA_ALTA AS DATA_ALTA, 
                           USU_MODI AS USU_MODI, 
                           DATA_MODI AS DATA_MODI,
                           'SECUENCIA' AS ID_ORIGINAL, 
                           'VIPS_U' AS ESQUEMA_ORIGINAL , 
                           'CLASSIF_VIP' AS TABLA_ORIGINAL
                   FROM (
                           SELECT Contactes.ID_CONTACTE, 
                               MAX(Contactes.ADRECA) AS ADRECA, 
                               MAX(Contactes.MUNICIPI) AS MUNICIPI, 
                               MAX(Contactes.CP) AS CP, 
                               MAX(Contactes.PROVINCIA) AS PROVINCIA, 
                               MAX(t.PAIS) AS PAIS, 
                               MAX(FUNC_USU_CREACIO(Contactes.USU_ALTA)) AS USU_ALTA, 
                               MAX(FUNC_FECHA_1970(Contactes.DATA_ALTA)) AS DATA_ALTA, 
                               MAX(Contactes.USU_MODI) AS USU_MODI, 
                               MAX(Contactes.DATA_MODI) AS DATA_MODI
                           FROM Z_SB003_CONTACTES_ID Contactes, 
                                (SELECT ID_CONTACTE, 
                                        REPLACE(REPLACE(PAIS,'(',''),')','') AS PAIS
                                   FROM Z_SB003_CONTACTES_ID
                                  WHERE LENGTH(FUNC_NORMALITZAR_NUMERICS(PAIS)) IS NOT NULL 
                                    AND LENGTH(FUNC_NORMALITZAR_NUMERICS(SUBSTR(PAIS,1,1))) IS NOT NULL 
                                    AND PAIS NOT IN ('PP','CIU') AND SUBSTR(PAIS,1,3) <> 'AUT'
                                )T
                           WHERE Contactes.ID_CONTACTE = T.ID_CONTACTE (+)
                           GROUP BY Contactes.ID_CONTACTE
                        ) a
                    WHERE NOT EXISTS (SELECT 1
                        			  FROM Z_SB080_ADRECA_CONTACTE ANTIGUOS
              						  WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
    COMMIT;
    END;
    
    
    
    
    
    PROCEDURE SB81_ADRECA_SUBJECTE IS     
    BEGIN
              -- CREAR PARA PARTICULARES B4 (CON DATOS DE DIRECCION INFORMADO)
              INSERT INTO Z_SB081_ADRECA_SUBJECTE (ID_ADRECA,ID_CONTACTE,ADRECA,MUNICIPI,CP,PROVINCIA,PAIS,USU_ALTA,DATA_ALTA,USU_MODIF,DATA_MODIF,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                    SELECT SEQ_ADRECA.NEXTVAL AS ID_ADRECA, 
                           Subjecte.ID_CONTACTE, 
                           Subjecte.ADRECA_P AS ADRECA, 
                           Subjecte.MUNICIPI_P AS MUNICIPI, 
                           Subjecte.CP_P AS CP , 
                           Subjecte.PROVINCIA_P AS PROVINCIA, 
                           Subjecte.PAIS_P AS PAIS, 
                           FUNC_USU_CREACIO(Subjecte.USU_ALTA) AS USU_ALTA, 
                           FUNC_FECHA_1970(Subjecte.DATA_ALTA) AS DATA_ALTA, 
                           Subjecte.USU_MODIF, 
                           Subjecte.DATA_MODIF,
                           'SECUENCIA' AS ID_ORIGINAL, 
                           'VIPS_U' AS ESQUEMA_ORIGINAL , 
                           'VIPS' AS TABLA_ORIGINAL
                  FROM Z_SB004_SUBJECTES_ID Subjecte
                 WHERE (TRIM(Subjecte.ADRECA_P) IS NOT NULL 
                    OR TRIM(Subjecte.MUNICIPI_P) IS NOT NULL 
                    OR TRIM(Subjecte.PROVINCIA_P) IS NOT NULL 
                    OR TRIM(Subjecte.PAIS_P) IS NOT NULL 
                    OR TRIM(Subjecte.CP_P) IS NOT NULL)
                   AND NOT EXISTS (SELECT 1 
                   					 FROM Z_SB081_ADRECA_SUBJECTE ANTIGUOS 
                   					 WHERE ANTIGUOS.ID_CONTACTE = Subjecte.ID_CONTACTE
                   				  ); 
                             
     COMMIT;
     END;   
     
     
     
              -- FALTAN DIRECCIONES PARTICULARES
     PROCEDURE SB82_DM_ADRECA IS
     BEGIN
     
     
              INSERT INTO Z_SB999_ADRECA (ID, NOM_CARRER, MUNICIPI, PROVINCIA, CODI_POSTAL, PAIS, USUARI_CREACIO, DATA_CREACIO, USUARI_MODIFICACIO,DATA_MODIFICACIO,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                 SELECT ID, NOM_CARRER, MUNICIPI, PROVINCIA, CODI_POSTAL, PAIS, USUARI_CREACIO, DATA_CREACIO, USUARI_MODIFICACIO,DATA_MODIFICACIO,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL
                   FROM (
                             SELECT ID_ADRECA AS ID,
                                    FUNC_NULOS(ADRECA) AS NOM_CARRER,
                                    MUNICIPI AS MUNICIPI,
                                    PROVINCIA AS PROVINCIA,
                                    CP AS CODI_POSTAL,                                    
                                    PAIS AS PAIS,
                                    USU_ALTA AS USUARI_CREACIO,
                                    DATA_ALTA AS DATA_CREACIO,
                                    USU_MODI AS USUARI_MODIFICACIO,
                                    DATA_MODI AS DATA_MODIFICACIO,
                                    ID_ORIGINAL AS ID_ORIGINAL, 
                                    ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL , 
                                    TABLA_ORIGINAL AS TABLA_ORIGINAL
                              FROM Z_SB080_ADRECA_CONTACTE 
                                    UNION ALL
                             SELECT ID_ADRECA AS ID,
                                    FUNC_NULOS(ADRECA) AS NOM_CARRER,
                                    MUNICIPI AS MUNICIPI,
                                    PROVINCIA AS PROVINCIA,
                                    CP AS CODI_POSTAL,                                    
                                    PAIS AS PAIS,
                                    USU_ALTA AS USUARI_CREACIO,
                                    DATA_ALTA AS DATA_CREACIO,
                                    USU_MODIF AS USUARI_MODIFICACIO,
                                    DATA_MODIF AS DATA_MODIFICACIO,
                                    ID_ORIGINAL AS ID_ORIGINAL, 
                                    ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL , 
                                    TABLA_ORIGINAL AS TABLA_ORIGINAL
                              FROM Z_SB081_ADRECA_SUBJECTE
                      ) ADRECA
              WHERE NOT EXISTS (SELECT 1 
                                FROM Z_SB999_ADRECA ANTIGUOS
                                WHERE ANTIGUOS.ID =  ADRECA.ID
                               );
     
     
     COMMIT;
              INSERT INTO ADRECA (ID, NOM_CARRER, MUNICIPI, PROVINCIA, CODI_POSTAL, PAIS, USUARI_CREACIO, DATA_CREACIO, USUARI_MODIFICACIO,DATA_MODIFICACIO,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                 SELECT ID, 
                        NOM_CARRER, 
                        MUNICIPI, 
                        PROVINCIA, 
                        CODI_POSTAL, 
                        PAIS, 
                        USUARI_CREACIO, 
                        DATA_CREACIO, 
                        USUARI_MODIFICACIO,
                        DATA_MODIFICACIO,
                        ID_ORIGINAL, 
                        ESQUEMA_ORIGINAL , 
                        TABLA_ORIGINAL
                   FROM Z_SB999_ADRECA ADRECA
              WHERE NOT EXISTS (SELECT 1 
                                FROM ADRECA ANTIGUOS
                                WHERE ANTIGUOS.ID =  ADRECA.ID
                               );
              
              COMMIT;
                     
    END;
        
        
    -----------------------------------------------------------------------------------
    -- CONTACTES ----------------------------------------------------------------------
    -----------------------------------------------------------------------------------    
    
    PROCEDURE SB90_CONTACTES_PRINCIPALS IS
   
    BEGIN
              INSERT INTO Z_SB090_CONTACTES_PRINCIPALS
                    SELECT ID_CONTACTE 
                      FROM Z_SB003_CONTACTES_ID
                     WHERE CLASSIF = 'GENER'
                      AND NOT EXISTS (SELECT 1 
                                       FROM Z_SB090_CONTACTES_PRINCIPALS ANTIGUOS
                                      WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
                     
              COMMIT;
              
    END;
    
    PROCEDURE SB91_DATA_ACT_CONTACTE IS      
    BEGIN
    
           INSERT INTO Z_SB091_DATA_ACT_CONTACTE
                SELECT ID_CONTACTE,
                       ( CASE WHEN LENGTH(PAIS) =5 AND FUNC_ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(PAIS||'-2018','dd-mm-yyyy') 
                             WHEN LENGTH(PAIS) = 7 AND SUBSTR(PAIS, 3, 1) = '-' AND FUNC_ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(SUBSTR(PAIS, 1,3)||'0'||SUBSTR(PAIS, 4,7), 'dd-mm-yy')
                             WHEN LENGTH(PAIS) = 7 AND FUNC_ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(PAIS, 'ddmm-yy')
                            WHEN LENGTH(PAIS) = 8 AND FUNC_ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(PAIS, 'dd-mm-yy')
                             WHEN LENGTH(PAIS) = 10 AND FUNC_ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 AND SUBSTR(PAIS, 3, 1) = '-' THEN 
                                    TO_DATE(PAIS, 'dd-mm-yyyy')
                        ELSE 
                                    TO_DATE('01-01-1970','dd-mm-yyyy')
                        END) AS DATA_ACTUALITZACIO
               FROM  Z_SB003_CONTACTES_ID 
              WHERE PAIS IS NOT NULL 
                AND LENGTH(FUNC_NORMALITZAR_NUMERICS(substr(PAIS,1,5))) IS NULL 
--                AND TO_NUMBER(SUBSTR(PAIS,1,1)) IN (0,1,2,3) AND TRIM(PAIS)<>'.'
                AND TRIM(PAIS)<>'.'
                AND NOT EXISTS (SELECT 1
                                 FROM Z_SB091_DATA_ACT_CONTACTE ANTIGUOS
                                WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
            COMMIT;
            
    END;

    
    
    
    
    
    
    PROCEDURE SB92_TIPUS_CONTACTES IS

    BEGIN   
      
            INSERT INTO Z_SB092_TIPUS_CONTACTES   
                    SELECT NUEVOS.ID_CONTACTE, NUEVOS.TIPUS
                    FROM (
                            SELECT ID_CONTACTE, 
                                   MAX(ConstContactePersonal) AS TIPUS
                            FROM  Z_SB004_SUBJECTES_ID part
                            GROUP BY(ID_CONTACTE)
                          UNION
                            SELECT ID_CONTACTE, 
                                   MAX(ConstContacteProfesional) AS TIPUS
                              FROM Z_SB003_CONTACTES_ID t 
                          GROUP BY(ID_CONTACTE)
                         ) NUEVOS
                   WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SB092_TIPUS_CONTACTES ANTIGUOS
                                     WHERE NUEVOS.ID_CONTACTE =  ANTIGUOS.ID_CONTACTE 
              					       AND NUEVOS.TIPUS = ANTIGUOS.TIPUS
              		                );
            
            COMMIT;

    END;
    
    
   
    
    --CONTACTE_PROFESIONAL
    PROCEDURE SB93_CONTACTES_CONTACTES is             
    BEGIN
                                                 
        INSERT INTO Z_SB093_CONTACTES_CONTACTES (ID, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, DATA_FI_VIGENCIA_CARREC)
                   SELECT ID_CONTACTE AS ID,
                        MAX(PRINCIPAL) AS ES_PRINCIPAL, 
                        MAX(DEPART) AS DEPARTAMENT, 
                        MAX(QUALITAT) AS DADES_QUALITAT, 
                        MAX(DATA_ACTUALITZACIO) AS DATA_DARRERA_ACTUALITZACIO, 
                        MIN(DATA_ALTA) AS DATA_CREACIO, 
                        MAX(DATA_BAIXA) AS DATA_ESBORRAT, 
                        MAX(DATA_MODI) AS DATA_MODIFICACIO, 
                        MAX(USU_ALTA) AS USUARI_CREACIO, 
                        MAX(USU_BAIXA) AS USUARI_ESBORRAT, 
                        MAX(USU_MODI) AS USUARI_MODIFICACIO, 
                        MAX(TIPUS_CONTACTE_ID) AS TIPUS_CONTACTE_ID, 
                        MAX(SUBJECTE_ID) AS SUBJECTE_ID,  --- OJO ES N_VIP. SUBJECTE AHORA VA POR SECUENCIA
                        MAX(ID_ADRECA) AS ADRECA_ID, 
                        MAX(ENTITAT_ID) AS ENTITAT_ID,  
                        MAX(FUNC_NULOS_STRING()) AS  CONTACTE_ORIGEN_ID,
                        MAX(VISIBILITAT_ID) AS VISIBILITAT_ID, 
                        MAX(AMBIT_ID)  AS AMBIT_ID,                        
                        MAX(ID_CARREC) AS CARREC_ID, 
                        MAX(NVIP_ID_ORIGINAL) AS ID_ORIGINAL,
                        MAX('VIPS_U') AS ESQUEMA_ORIGINAL, 
                        MAX('CLASSIF_VIP') AS TABLA_ORIGINAL,
                        MAX(FUNC_NULOS_STRING()) AS DATA_FI_VIGENCIA_CARREC
                FROM (
                        SELECT Contacto.ID_CONTACTE, 
                               NVL2(Contate_Principals.ID_CONTACTE, '1','0') AS PRINCIPAL, 
                               Contacto.DEPART, 
                               1 AS QUALITAT, 
                               Contacte_act.DATA_ACTUALITZACIO, 
                               NVL(Contacto.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, 
                               Subjecte.data_esborrat AS DATA_BAIXA, 
                               Contacto.DATA_MODI,
                                NVL(Contacto.USU_ALTA,'NO_INFO') AS USU_ALTA, 
                                Subjecte.usuari_esborrat AS USU_BAIXA, 
                               Contacto.USU_MODI, 
                               ConstContacteProfesional AS TIPUS_CONTACTE_ID, 
                               SUBJECTE.ID AS SUBJECTE_ID, 
                               Adreca.ID_ADRECA, 
                               Entitats.ID AS ENTITAT_ID , 
                               ConstVISIBILITAT_ALCALDIA AS VISIBILITAT_ID ,
                               ConstAMBIT_PROTOCOL AS AMBIT_ID,                             
                               Carrecs.id_carrec,
                               SUBJECTE.ID_ORIGINAL AS NVIP_ID_ORIGINAL
                        FROM  Z_SB080_ADRECA_CONTACTE Adreca, 
                              Z_SB090_CONTACTES_PRINCIPALS Contate_Principals, 
                              Z_SB091_DATA_ACT_CONTACTE Contacte_act, 
                              Z_SB053_CARRECS_CONTACTES Carrecs, 
                              Z_SB066_ENTITATS_CONTACTES Entitats, 
                              SUBJECTE Subjecte, 
                             (
                                SELECT ID_CONTACTE, 
                                       MAX(DEPART) AS DEPART, 
                                       MIN(DATA_ALTA) AS DATA_ALTA,
                                       MAX(DATA_MODI) AS DATA_MODI, 
                                       MAX(USU_ALTA) AS USU_ALTA , 
                                       MAX(USU_MODI) AS USU_MODI, 
                                       MAX(N_VIP) AS N_VIP
                                FROM Z_SB003_CONTACTES_ID 
                                GROUP BY ID_CONTACTE
                            ) Contacto
                        WHERE Contacto.n_vip = Subjecte.ID_ORIGINAL 
                          AND Contacto.ID_CONTACTE = Adreca.ID_CONTACTE (+) 
                          AND Contacto.ID_CONTACTE = Contate_Principals.ID_CONTACTE (+) 
                          AND Contacto.ID_CONTACTE = Contacte_act.ID_CONTACTE (+) 
                          AND Contacto.Id_Contacte = Carrecs.id_contacte (+) 
                          AND Contacto.ID_CONTACTE = Entitats.ID_CONTACTE (+)  
                          AND NOT EXISTS (SELECT 1 
                                          FROM Z_SB093_CONTACTES_CONTACTES nuevos 
                                          WHERE nuevos.id = Contacto.id_contacte
                                         )
                ) CONTACTE_PROFESIONAL                
                WHERE NOT EXISTS (SELECT 1
                                    FROM Z_SB093_CONTACTES_CONTACTES ANTIGUOS
                                   WHERE CONTACTE_PROFESIONAL.ID_CONTACTE = ANTIGUOS.ID
                                  )
                GROUP BY CONTACTE_PROFESIONAL.ID_CONTACTE;                  
        COMMIT;
        END;
        
       -- CONTACTES_PERSONAL 
       PROCEDURE SB94_CONTACTES_SUBJECTES is             
       BEGIN 
        -- PARTICULARES QUE TENIAN DIRECCION INFORMADA -> CONTACTES_PERSONAL
        INSERT INTO Z_SB094_CONTACTES_SUBJECTES (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
            SELECT ID_CONTACTE AS ID,
                        MAX(PRINCIPAL) AS ES_PRINCIPAL, 
                        MAX(ID_CARREC) AS CARREC_ID, 
                        MAX(DEPART) AS DEPARTAMENT, 
                        MAX(QUALITAT) AS DADES_QUALITAT, 
                        MAX(DATA_ACTUALITZACIO) AS DATA_DARRERA_ACTUALITZACIO, 
                        MIN(DATA_ALTA) AS DATA_CREACIO, 
                        MAX(DATA_MODI) AS DATA_MODIFICACIO, 
                        MAX(DATA_BAIXA) AS DATA_ESBORRAT, 
                        MAX(USU_ALTA) AS USUARI_CREACIO, 
                        MAX(USU_MODI) AS USUARI_MODIFICACIO, 
                        MAX(USU_BAIXA) AS USUARI_ESBORRAT, 
                        MAX(TIPUS_CONTACTE_ID) AS TIPUS_CONTACTE_ID, 
                        MAX(SUBJECTE_ID) AS SUBJECTE_ID, 
                        MAX(ID_ADRECA) AS ADRECA_ID, 
                        MAX(ENTITAT_ID) AS ENTITAT_ID, 
                        MAX(VISIBILITAT_ID) AS VISIBILITAT_ID, 
                        MAX(AMBIT_ID)  AS AMBIT_ID,
                        MAX(N_VIP_ID) AS ID_ORIGINAL, 
                        MAX('VIPS') AS ESQUEMA_ORIGINAL, 
                        MAX('VIPS_U') AS TABLA_ORIGINAL 
          FROM (
                    SELECT B004.ID_CONTACTE, 
                           NVL2(Contate_Principals.ID_CONTACTE, '1','0') AS PRINCIPAL, 
                           Carrecs.id_carrec, 
                           '' AS DEPART, 
                           1 AS QUALITAT, 
                           Contacte_act.DATA_ACTUALITZACIO, 
                           NVL(B004.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, 
                           B004.DATA_MODIF AS DATA_MODI, 
                           Subjecte.data_esborrat AS DATA_BAIXA, 
                           NVL(B004.USU_ALTA,'NO_INFO') AS USU_ALTA, 
                           B004.USU_MODIF AS USU_MODI, 
                           Subjecte.usuari_esborrat AS USU_BAIXA, 
                           ConstContactePersonal AS TIPUS_CONTACTE_ID, 
                           Subjecte.ID AS SUBJECTE_ID,  --OJO AHORA VA POR SECUENCIA
                           Adreca.ID_ADRECA, 
                           Entitats.ID AS ENTITAT_ID , 
                           ConstVISIBILITAT_ALCALDIA AS VISIBILITAT_ID  ,
                           ConstAMBIT_PROTOCOL AS AMBIT_ID,
                           Subjecte.ID_ORIGINAL AS N_VIP_ID  --ESTE ES EL N_VIP
                    FROM Z_SB004_SUBJECTES_ID B004, 
                         Z_SB081_ADRECA_SUBJECTE Adreca, 
                         Z_SB090_CONTACTES_PRINCIPALS Contate_Principals, 
                         Z_SB091_DATA_ACT_CONTACTE Contacte_act, 
                         Z_SB053_CARRECS_CONTACTES Carrecs, 
                         Z_SB066_ENTITATS_CONTACTES Entitats, 
                         SUBJECTE Subjecte
                    WHERE B004.n_vip = Subjecte.id 
                      AND B004.ID_CONTACTE = Adreca.ID_CONTACTE 
                      AND B004.ID_CONTACTE = Contate_Principals.ID_CONTACTE (+) 
                      AND B004.ID_CONTACTE = Contacte_act.ID_CONTACTE (+) 
                      AND B004.Id_Contacte = Carrecs.id_contacte (+) 
                      AND B004.ID_CONTACTE = Entitats.ID_CONTACTE (+)                        
        ) CONTACTES_PERSONAL
        WHERE NOT EXISTS (SELECT 1
        				    FROM Z_SB094_CONTACTES_SUBJECTES NUEVOS 
        				   WHERE CONTACTES_PERSONAL.ID_CONTACTE = NUEVOS.id
        				  )
       GROUP BY CONTACTES_PERSONAL.ID_CONTACTE;
       
        COMMIT;               
    END;
    
    PROCEDURE SB95_CONTACTES IS
    BEGIN
       
       INSERT INTO CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL) 
          SELECT ID AS ID, 
                 ES_PRINCIPAL, 
                 CARREC_ID, 
                 DEPARTAMENT, 
                 DADES_QUALITAT, 
                 DATA_DARRERA_ACTUALITZACIO, 
                 DATA_CREACIO, 
                 DATA_MODIFICACIO, 
                 DATA_ESBORRAT, 
                 USUARI_CREACIO, 
                 USUARI_MODIFICACIO, 
                 USUARI_ESBORRAT, 
                 TIPUS_CONTACTE_ID, 
                 SUBJECTE_ID, 
                 ADRECA_ID, 
                 ENTITAT_ID,
                 VISIBILITAT_ID, 
                 AMBIT_ID,
                 ID_ORIGINAL, 
                 ESQUEMA_ORIGINAL, 
                 TABLA_ORIGINAL
          FROM (       
                 SELECT ID AS ID,
                        ES_PRINCIPAL AS ES_PRINCIPAL,
                        CARREC_ID AS CARREC_ID,
                        DEPARTAMENT AS DEPARTAMENT,
                        DADES_QUALITAT AS DADES_QUALITAT,
                        DATA_DARRERA_ACTUALITZACIO AS DATA_DARRERA_ACTUALITZACIO,
                        DATA_CREACIO AS DATA_CREACIO,
                        DATA_MODIFICACIO AS DATA_MODIFICACIO,
                        DATA_ESBORRAT AS DATA_ESBORRAT,
                        USUARI_CREACIO AS USUARI_CREACIO,
                        USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                        USUARI_ESBORRAT AS USUARI_ESBORRAT,
                        TIPUS_CONTACTE_ID AS TIPUS_CONTACTE_ID,
                        SUBJECTE_ID AS SUBJECTE_ID,
                        ADRECA_ID AS ADRECA_ID,
                        ENTITAT_ID AS ENTITAT_ID,
                        VISIBILITAT_ID AS VISIBILITAT_ID,
                        AMBIT_ID AS AMBIT_ID,
                        ID_ORIGINAL AS ID_ORIGINAL, 
                        ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL, 
                        TABLA_ORIGINAL AS TABLA_ORIGINAL 
                FROM Z_SB093_CONTACTES_CONTACTES 
                ) NUEVOS
            WHERE NOT EXISTS (SELECT 1
                                FROM CONTACTE ANTIGUOS
                               WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                              ); 
               
           INSERT INTO CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL) 
              SELECT ID AS ID, 
                     ES_PRINCIPAL, CARREC_ID, 
                     DEPARTAMENT, 
                     DADES_QUALITAT, 
                     DATA_DARRERA_ACTUALITZACIO, 
                     DATA_CREACIO, 
                     DATA_MODIFICACIO, 
                     DATA_ESBORRAT, 
                     USUARI_CREACIO, 
                     USUARI_MODIFICACIO, 
                     USUARI_ESBORRAT, 
                     TIPUS_CONTACTE_ID, 
                     SUBJECTE_ID, 
                     ADRECA_ID, 
                     ENTITAT_ID,
                     VISIBILITAT_ID, 
                     AMBIT_ID,
                     ID_ORIGINAL, 
                     ESQUEMA_ORIGINAL, 
                     TABLA_ORIGINAL
              FROM (
                         SELECT ID AS ID,
                                ES_PRINCIPAL AS ES_PRINCIPAL,
                                CARREC_ID AS CARREC_ID,
                                DEPARTAMENT AS DEPARTAMENT,
                                DADES_QUALITAT AS DADES_QUALITAT,
                                DATA_DARRERA_ACTUALITZACIO AS DATA_DARRERA_ACTUALITZACIO,
                                DATA_CREACIO AS DATA_CREACIO,
                                DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                DATA_ESBORRAT AS DATA_ESBORRAT,
                                USUARI_CREACIO AS USUARI_CREACIO,
                                USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                USUARI_ESBORRAT AS USUARI_ESBORRAT,
                                TIPUS_CONTACTE_ID AS TIPUS_CONTACTE_ID,
                                SUBJECTE_ID AS SUBJECTE_ID,
                                ADRECA_ID AS ADRECA_ID,
                                ENTITAT_ID AS ENTITAT_ID,
                                VISIBILITAT_ID AS VISIBILITAT_ID,
                                AMBIT_ID AS AMBIT_ID,
                                ID_ORIGINAL AS ID_ORIGINAL, 
                                ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL, 
                                TABLA_ORIGINAL AS TABLA_ORIGINAL 
                        FROM Z_SB094_CONTACTES_SUBJECTES 
                     ) NUEVOS   
                 WHERE NOT EXISTS (SELECT 1
                                     FROM CONTACTE ANTIGUOS
                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                   ); 
                   
    COMMIT;
    END;
    
    
    ----------------------------------------------------------------------
    -- CORREUS_CONTACTES
    ----------------------------------------------------------------------
    
     PROCEDURE SB100_CORREUS_CONTACTES IS
    BEGIN
         INSERT INTO Z_SB100_CORREUS_CONTACTES (ID_CONTACTE, INTERNET)
              		 SELECT aux.ID_CONTACTE, 
                            aux.INTERNET 
            		 FROM(                                                                         
              			   SELECT DISTINCT t.ID_CONTACTE,
              			  				   trim(regexp_substr(t.INTERNET, '[^;]+', 1, levels.column_value))  as INTERNET
              			   FROM ( 
                			      SELECT ID_CONTACTE, 
                			             INTERNET 
                			      FROM Z_SB003_CONTACTES_ID 
                			      WHERE INTERNET IS NOT NULL 
                			        AND INTERNET LIKE '%@%' 
                			        AND EXISTS (SELECT * 
                			       	 		    FROM SUBJECTE s 
                			       			    WHERE s.ID = N_VIP)  
                			     ) t,
                			     table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(t.INTERNET, '[^;]+'))  + 1) as sys.OdciNumberList)) levels
              					 order by ID_CONTACTE
            			) aux
            		WHERE TRIM(aux.internet) is not null 
            	      AND NOT EXISTS (SELECT 1
            	     				  FROM Z_SB100_CORREUS_CONTACTES con 
            	     				  WHERE con.ID_CONTACTE = aux.ID_CONTACTE 
            	     				    AND con.internet = aux.internet
            	     				  );                                                                 

            COMMIT;   
            
          END;  
          
    PROCEDURE SB101_CORREUS_PRINCIPALS IS
      
        id_contacte_ant number;
    BEGIN
          
        id_contacte_ant:=0;
        
        DELETE FROM Z_SB101_CORREUS_PRINCIPALS;
        
         FOR c IN (
               SELECT * 
               FROM  Z_SB100_CORREUS_CONTACTES  NUEVOS
               WHERE NOT EXISTS (SELECT * 
                                 FROM Z_SB101_CORREUS_PRINCIPALS ANTIGUOS
                                 WHERE  NUEVOS.id_contacte = ANTIGUOS.id_contacte
                                   AND NUEVOS.internet = ANTIGUOS.CORREU
                                 )              
               ORDER BY ID_CONTACTE,INTERNET
           )
           
         LOOP                        
            IF c.id_contacte <> id_contacte_ant THEN
                  id_contacte_ant:= c.id_contacte;
                  INSERT INTO Z_SB101_CORREUS_PRINCIPALS VALUES (c.id_contacte, c.internet, 1);
            ELSE                  
                  INSERT INTO Z_SB101_CORREUS_PRINCIPALS VALUES (c.id_contacte, c.internet, 0);                           
            END IF;

          END LOOP;
        
        COMMIT;        
        END;
                
        
        PROCEDURE SB102_CORREUS_CONTACTES IS   
        
        BEGIN
         
            INSERT INTO CONTACTE_CORREU(ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, Contacte_Id,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT SEQ_CONTACTE_CORREU.NEXTVAL AS ID, 
                           cc.correu AS CORREU_ELECTRONIC, 
                           cc.principal AS ES_PRINCIPAL, 
                           sysdate AS DATA_CREACIO, 
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                           cc.id_contacte AS Contacte_Id,
                           cc.id_contacte AS ID_ORIGINAL, 
                           'VIPS_U' AS ESQUEMA_ORIGINAL, 
                           'CLASSIF_VIP' AS TABLA_ORIGINAL
                     FROM Z_SB101_CORREUS_PRINCIPALS cc
                     WHERE NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_CORREU 
                                      WHERE Contacte_Id = cc.id_contacte
                                        AND CORREU_ELECTRONIC = CC.CORREU);
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN DANI_TB_AUX_CORREUS_PRINCIPALS
        
    END;  
    
    ----------------------------------------------------------------------
    -- TELEFONS
    ----------------------------------------------------------------------
    
    PROCEDURE SB110_TELEFONS_TELEFON1 IS
    BEGIN
    
        INSERT INTO Z_SB110_TELEFON (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstSI as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.N_VIP as ID_ORIGINAL,
                       'VIPS_U' AS ESQUEMA_ORIGINAL,
                       'CLASSIF_VIP //TELEFON1        ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT DISTINCT ID_CONTACTE As ID_CONTACTE,
                              N_VIP AS N_VIP,
                             (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TELEFON1),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TELEFON1))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TELEFON1) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TELEFON1) AS CONCEPTE                              
                       FROM Z_SB003_CONTACTES_ID B03,
                            CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TELEFON1))=1
                         AND CONTACTE.ID = ID_CONTACTE
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SB110_TELEFON ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.N_VIP = NUEVOS.N_VIP
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           NUEVOS.TELEFON AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.ID_CONTACTE AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           NUEVOS.TABLA_ORIGINAL AS TABLA_ORIGINAL
                     FROM Z_SB110_TELEFON NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     );  
                                        
    
    COMMIT;
    END;
    
    PROCEDURE SB111_TELEFONS_TELEFON2 IS
    BEGIN
    
        INSERT INTO Z_SB110_TELEFON (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.N_VIP as ID_ORIGINAL,
                       'VIPS_U' AS ESQUEMA_ORIGINAL,
                       'CLASSIF_VIP //TELEFON2        ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT DISTINCT ID_CONTACTE As ID_CONTACTE,
                              N_VIP AS N_VIP,
                              (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TELEFON2),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TELEFON2))= 9 THEN                               
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TELEFON2) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TELEFON2) AS CONCEPTE                              
                       FROM Z_SB003_CONTACTES_ID B03,
                            CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TELEFON2))=1
                         AND CONTACTE.ID = B03.ID_CONTACTE
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SB110_TELEFON ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.N_VIP = NUEVOS.N_VIP
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON
                                   );

    COMMIT;
    
     INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           NUEVOS.TELEFON AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.ID_CONTACTE AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           NUEVOS.TABLA_ORIGINAL AS TABLA_ORIGINAL
                     FROM Z_SB110_TELEFON NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     );    
    
    COMMIT;
    END;
    
   PROCEDURE SB112_TELEFONS_MOBIL IS
   BEGIN
   
            INSERT INTO Z_SB110_TELEFON (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.N_VIP as ID_ORIGINAL,
                       'VIPS_U' AS ESQUEMA_ORIGINAL,
                       'CLASSIF_VIP //TELEFON_MOBIL   ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT DISTINCT ID_CONTACTE As ID_CONTACTE,
                              N_VIP AS N_VIP,
                              (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TELEFON_MOBIL),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TELEFON_MOBIL))= 9 THEN    
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TELEFON_MOBIL) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TELEFON_MOBIL) AS CONCEPTE                              
                       FROM Z_SB003_CONTACTES_ID B03,
                            CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TELEFON_MOBIL))=1
                         AND CONTACTE.ID = B03.ID_CONTACTE
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SB110_TELEFON ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.N_VIP = NUEVOS.N_VIP
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON
                                   );
   
    COMMIT;
    
     INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           NUEVOS.TELEFON AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.ID_CONTACTE AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           NUEVOS.TABLA_ORIGINAL AS TABLA_ORIGINAL
                     FROM Z_SB110_TELEFON NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     );    
   
   COMMIT;
   END;
    
   PROCEDURE SB113_TELEFONS_FAX IS
   BEGIN
   
             INSERT INTO Z_SB110_TELEFON (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.N_VIP as ID_ORIGINAL,
                       'VIPS_U' AS ESQUEMA_ORIGINAL,
                       'CLASSIF_VIP //FAX   ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT DISTINCT ID_CONTACTE As ID_CONTACTE,
                              N_VIP AS N_VIP,
                               (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(FAX),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(FAX))= 9 THEN    
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFax
                                END) AS TIPUS_TELEFON,                               
                              FUNC_NORMALITZAR_TFN(FAX) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(FAX) AS CONCEPTE                              
                       FROM Z_SB003_CONTACTES_ID B03,
                            CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(FAX))=1
                         AND CONTACTE.ID = B03.ID_CONTACTE
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SB110_TELEFON ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.N_VIP = NUEVOS.N_VIP
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON
                                   );
   
    COMMIT;
    
     INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           NUEVOS.TELEFON AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.ID_CONTACTE AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           NUEVOS.TABLA_ORIGINAL AS TABLA_ORIGINAL
                     FROM Z_SB110_TELEFON NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     );    
   
   COMMIT;
   END;
    
    
   PROCEDURE SB114_TELEFONS_TELEFON_P IS
   BEGIN
          
           INSERT INTO Z_SB110_TELEFON (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
        
                        SELECT NUEVOS.ID_CONTACTE, 
                               NUEVOS.N_VIP, 
                               NUEVOS.TIPUS_TELEFON,
                               NUEVOS.TELEFON,
                               ConstNO as ES_PRINCIPAL,
                               CONCEPTE AS CONCEPTE,
                               ConstSI AS ES_PARTICULAR,
                               NUEVOS.N_VIP as ID_ORIGINAL,
                               'VIPS_U' AS ESQUEMA_ORIGINAL,
                               'VIPS //TELEFON_P   ' as TABLA_ORIGINAL
                        FROM (	   
                               SELECT DISTINCT B04.ID_CONTACTE As ID_CONTACTE,
                                      B04.N_VIP AS N_VIP,
                                       (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(B04.TELEFON_P),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(B04.TELEFON_P))= 9 THEN    
                                                  ConstTelefonMobil
                                        ELSE 
                                                  ConstTelefonFix
                                        END) AS TIPUS_TELEFON,                               
                                      FUNC_NORMALITZAR_TFN(B04.TELEFON_P) AS TELEFON,
                                      FUNC_NORMALITZAR_CONCEPTE(B04.TELEFON_P) AS CONCEPTE                              
                               FROM Z_SB003_CONTACTES_ID B03,
                                    Z_SB004_SUBJECTES_ID B04,
                                    CONTACTE  CONTACTE
                               WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(B04.TELEFON_P))=1
                                 AND B03.N_VIP = B04.N_VIP
                                 AND CONTACTE.ID = B04.ID_CONTACTE
                             ) NUEVOS
                         WHERE NOT EXISTS (SELECT 1
                                             FROM Z_SB110_TELEFON ANTIGUOS
                                            WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                              AND ANTIGUOS.N_VIP = NUEVOS.N_VIP
                                              AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                              AND ANTIGUOS.TELEFON = NUEVOS.TELEFON
                                           );
   
   
    COMMIT;
    
     INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           NUEVOS.TELEFON AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.ID_CONTACTE AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           NUEVOS.TABLA_ORIGINAL AS TABLA_ORIGINAL
                     FROM Z_SB110_TELEFON NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     );    
   
   COMMIT;
   END;
    
    
   
/*

      PROCEDURE SB115_CONTACTE_TELEFON is 
           
      BEGIN
        
           INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           NUEVOS.TELEFON AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.ID_CONTACTE AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           NUEVOS.TABLA_ORIGINAL AS TABLA_ORIGINAL
                     FROM Z_SB110_TELEFON NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     );    
           COMMIT;

      END;
*/    
    ----------------------------------------------------------------------
    -- clasificaciones
    ----------------------------------------------------------------------
    
    PROCEDURE SB120_CLASSIFICACIO IS      
    BEGIN
          -- AFEGIR ORDRE DE PRELACIO ENTRE CLASSIFICACIONS I ASSIGNAR IDENTIFICADOR INTERN   
          INSERT INTO Z_SB120_CLASSIFICACIONS (ID, CODI, DESCRIPCIO, ORDEN, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT SEQ_DM_CLASSIFICACIO.NEXTVAL AS ID,
                       CLASSIF.CODI, 
                       CLASSIF.DESCRIPCIO, 
                       LISTA.orden,
                       CLASSIF.CODI AS ID_ORIGINAL, 
                       'VIPS_U' AS ESQUEMA_ORIGINAL, 
                       'CLASSIFICACIONS' AS TABLA_ORIGINAL
               FROM Z_TMP_VIPS_U_CLASSIFICACIONS CLASSIF, 
                    Z_TMP_VIPS_U_PRELA_LLISTA LISTA, 
                    TMP_CLASSIF_ACTIVES ACTIVES
               WHERE CLASSIF.codi = LISTA.classif (+)
                 AND CLASSIF.codi = ACTIVES.codi 
                 AND NOT EXISTS (SELECT 1 
                                 FROM Z_SB120_CLASSIFICACIONS 
                                WHERE Z_SB120_CLASSIFICACIONS.CODI = CLASSIF.codi
                                );
          COMMIT;    
          --OUTER METERLE FECHA DE MODIF LAS QUE NO ESTÉN. LAS QUE TENGAN ACT A NULO ---> SE PONE FECHA DE DATA_ESBORRAT Y LAS QUE EXISTAN 
          
          
         
          COMMIT;          
    
    END;
    
    
    PROCEDURE SB121_DM_CLASSIFICACIO IS
    BEGIN
    
          --OJO COGER DATA_ESBORRAT DE DANI_TB
          INSERT INTO DM_CLASSIFICACIO (ID, DESCRIPCIO, CODI, PRELACIO, DATA_INICI_REVISO, DATA_FI_REVISIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPOLOGIA_ID, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT B120.ID AS ID,
                       FUNC_NULOS(B120.DESCRIPCIO) AS DESCRIPCIO, 
                       B120.CODI AS CODI, 
                       nvl(B120.ORDEN,0) AS PRELACIO,
                       NULL AS DATA_INICI_REVICIO,
                       NULL AS DATA_FI_REVICIO,                       
                       FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                       NULL AS DATA_ESBORRAT,
                       NULL AS DATA_MODIFICACIO,
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                       NULL AS USUARI_ESBORRAT,
                       NULL AS USUARI_MODIFICACIO,
                       ConstTipologia AS TIPOLOGIA_ID, 
                       ConstAMBIT_PROTOCOL AS AMBIT_ID, 
                       B120.ID_ORIGINAL AS ID_ORIGINAL, 
                       B120.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL, 
                       B120.TABLA_ORIGINAL AS TABLA_ORIGINAL                       
          FROM Z_SB120_CLASSIFICACIONS B120
          WHERE NOT EXISTS (SELECT 1 
                            FROM DM_CLASSIFICACIO ANTIGUOS
                            WHERE ANTIGUOS.CODI = B120.CODI
                           );
    
    COMMIT;
    END;
            
    -- CRUZAR CON CLASIFICACIONES ACTIVAS
    
    PROCEDURE SB130_CLASSIF_CONTACTE IS
    
    BEGIN
    
      INSERT INTO Z_SB130_CLASSIF_CONTACTE (CONTACTE_ID, CLASSIFICACIO_CODI, PRELACIO, ID_CLASSIFICACIO, DATA_CREACIO, USUARI_CREACIO, USUARI_MODIFICACIO, DATA_MODIFICACIO,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT ID_CONTACTE AS CONTACTE_ID, 
                     CLASSIF AS CLASSIFICACIO_CODI, 
                     N_PRELACIO AS PRELACIO, 
                     CLASSIF.ID AS ID_CLASSIFICACIO,
                     FUNC_FECHA_CREACIO(DATA_ALTA) AS DATA_CREACIO,
                     FUNC_USU_CREACIO(USU_ALTA) AS USUARI_CREACIO,                      
                     USU_MODI AS USUARI_MODIFICACIO, 
                     DATA_MODI AS DATA_MODIFICACIO,
                     CONTACTES.N_VIP AS ID_ORIGINAL, 
                     'VIPS_U' AS ESQUEMA_ORIGINAL, 
                     'CLASSIF_VIPS' AS TABLA_ORIGINAL                     
              FROM Z_SB003_CONTACTES_ID CONTACTES, 
                   DM_CLASSIFICACIO CLASSIF
              WHERE CLASSIF.CODI = CONTACTES.CLASSIF             
                AND EXISTS (SELECT 1 
                            FROM CONTACTE CONTACTE
                            WHERE CONTACTE.ID = ID_CONTACTE
                           )  

                AND NOT EXISTS(SELECT 1   
                                 FROM Z_SB130_CLASSIF_CONTACTE ANTIGUOS 
                                 WHERE ANTIGUOS.CONTACTE_ID = CONTACTES.id_contacte 
                                   AND ANTIGUOS.CLASSIFICACIO_CODI = CONTACTES.CLASSIF 
                              );    
        
      
      
    COMMIT;      
    END;
   
    PROCEDURE SB131_CONTACTE_CLASSIFICACIO IS
    BEGIN
    
        INSERT INTO CONTACTE_CLASSIFICACIO (ID, PRELACIO, DATA_FI_VIGENCIA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CLASSIFICACIO_ID, CONTACTE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
              SELECT SEQ_CONTACTE_CLASSIFICACIO.NEXTVAL AS ID, 
                     NVL(NUEVOS.PRELACIO,0), 
                     NULL AS DATA_FI_VIGENCIA,
                     DATA_CREACIO AS DATA_CREACIO,
                     NULL AS DATA_ESBORRAT,
                     DATA_MODIFICACIO AS DATA_MODIFICACIO,
                     USUARI_CREACIO AS USUARI_CREACIO,
                     NULL AS USUARI_ESBORRAT,
                     USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                     ID_CLASSIFICACIO AS CLASSIFICACIO_ID,
                     CONTACTE_ID AS CONTACTE_ID,
                     ID_ORIGINAL AS ID_ORIGINAL, 
                     ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL, 
                     TABLA_ORIGINAL AS TABLA_ORIGINAL
              FROM Z_SB130_CLASSIF_CONTACTE NUEVOS
              WHERE NOT EXISTS(SELECT 1 
                             FROM CONTACTE_CLASSIFICACIO ANTIGUOS 
                            WHERE ANTIGUOS.CONTACTE_ID = NUEVOS.CONTACTE_ID
                             AND  ANTIGUOS.classificacio_ID = NUEVOS.id_classificacio
                          );
    
    
    COMMIT;
    END;
   
    
    PROCEDURE SB140_ACOMPANYANTS_VIPS IS
    BEGIN
    
        INSERT INTO Z_SB140_ACOMPANYANTS_VIPS (SUBJECTE_ID, NOM, COGNOM1, COGNOM2, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, CONTACTE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
            
                       SELECT SUBJECTE.ID AS SUBJECTE_ID,
                              VIPS.NOM_A AS NOM, 
                             (CASE WHEN(length(VIPS.COGNOMS_A) - length(replace(VIPS.COGNOMS_A, ' ', '')) + 1) = 2 THEN 
                                        trim(SUBSTR(VIPS.COGNOMS_A,1,INSTR(VIPS.COGNOMS_A,' ')-1))
                                   WHEN TRIM(VIPS.COGNOMS_A) IS NULL THEN
                                        ' '
                                   WHEN trim(SUBSTR(VIPS.COGNOMS_A,1, INSTR(LOWER(VIPS.COGNOMS_A),' i ')-1)) IS NULL THEN 
                                        VIPS.COGNOMS_A 
                                        
                              ELSE  
                                  trim(SUBSTR(VIPS.COGNOMS_A,1, INSTR(LOWER(VIPS.COGNOMS_A),' i ')-1))
                              END)  
                                AS COGNOM1, 
                             (CASE WHEN trim(SUBSTR(VIPS.COGNOMS_A,1, INSTR(LOWER(VIPS.COGNOMS_A),' i ')-1)) IS NOT NULL THEN 
                                       trim(SUBSTR(VIPS.COGNOMS_A,INSTR(LOWER(VIPS.COGNOMS_A),' i ')))
                                    WHEN (length(VIPS.COGNOMS_A) - length(replace(VIPS.COGNOMS_A, ' ', '')) + 1) = 2 THEN  
                                     trim(SUBSTR(VIPS.COGNOMS_A, INSTR(VIPS.COGNOMS_A,' ')))
                              ELSE 
                                  NULL 
                              END) AS COGNOM2,
                              FUNC_FECHA_CREACIO(VIPS.Data_Alta) AS DATA_CREACIO,
                              VIPS.DATA_BAIXA AS DATA_ESBORRAT,
                              VIPS.Data_Modif AS DATA_MODIFICACIO,                              
                              FUNC_USU_CREACIO(VIPS.Usu_Alta) AS USUARI_CREACIO,
                              FUNC_NULOS_STRING() AS USUARI_ESBORRAT,                              
                              VIPS.Usu_Modif AS USUARI_MODIFICACIO,
                              (SELECT Tractament.ID FROM DM_TRACTAMENT Tractament WHERE Tractament.ID_ORIGINAL = VIPS.TRACTAMENT_A ) AS TRACTAMENT_ID, 
                              Contacte.ID as CONTACTE_ID,
                              VIPS.N_VIP AS ID_ORIGINAL, 
                              'VIPS_U' AS ESQUEMA_ORIGINAL, 
                              'VIPS' AS TABLA_ORIGINAL                              
                        FROM Z_TMP_VIPS_U_VIPS VIPS,
                             SUBJECTE SUBJECTE,
                             CONTACTE CONTACTE
                        WHERE SUBJECTE.ID_ORIGINAL = VIPS.N_VIP
                          AND Contacte.Subjecte_ID = Subjecte.ID
                          AND TRIM(NOM_A) IS NOT NULL 
                          AND TRIM(COGNOMS_A) IS NOT NULL
                          AND NOT EXISTS (SELECT 1 
                                          FROM Z_SB140_ACOMPANYANTS_VIPS ANTIGUOS
                                          WHERE ANTIGUOS.ID_ORIGINAL = VIPS.N_VIP);   
    
    COMMIT;
    END;
        
    
    PROCEDURE SB141_ACOMPANYANTS IS
    BEGIN
    
          INSERT INTO ACOMPANYANT (ID, NOM, COGNOM1, COGNOM2, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, CONTACTE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
              SELECT SEQ_ACOMPANYANT.NEXTVAL AS ID, 
                     NOM, 
                     NVL(COGNOM1,' ') AS COGNOM1, 
                     COGNOM2, 
                     DATA_CREACIO, 
                     DATA_ESBORRAT, 
                     DATA_MODIFICACIO, 
                     USUARI_CREACIO, 
                     USUARI_ESBORRAT, 
                     USUARI_MODIFICACIO, 
                     TRACTAMENT_ID, 
                     CONTACTE_ID, 
                     ID_ORIGINAL, 
                     ESQUEMA_ORIGINAL, 
                     TABLA_ORIGINAL
                FROM Z_SB140_ACOMPANYANTS_VIPS NUEVOS
               WHERE NOT EXISTS (SELECT 1
                                   FROM ACOMPANYANT ANTIGUOS
                                  WHERE ANTIGUOS.CONTACTE_ID = NUEVOS.CONTACTE_ID
                                    AND ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                                );
    COMMIT;
    END;
    


     
     
    PROCEDURE RESETEATOR_TABLAS_AUX IS
    BEGIN    
       
       DELETE FROM Z_SB001_CONTACTOS_ACTIVOS;
       DELETE FROM Z_SB002_CONTACTOS_VIPS;
       DELETE FROM Z_SB003_CONTACTES_ID;
       DELETE FROM Z_SB004_SUBJECTES_ID;
       DELETE FROM Z_SB005_CONTACTES_SIN_GENER;

       DELETE FROM Z_SB030_TRACTAMENT;
	   
	   DELETE FROM Z_SB050_CARRECS;
	   DELETE FROM Z_SB051_CARRECS_CONTACTES_REL;
       DELETE FROM Z_SB052_CARRECS_CONTACTES_NULL;
       DELETE FROM Z_SB053_CARRECS_CONTACTES;	   
	   
	   DELETE FROM Z_SB060_ENTITAT_CATALOG;
	   DELETE FROM Z_SB061_ENTITATS_CODI_NULL;
	   
	   DELETE FROM Z_SB066_ENTITATS_CONTACTES;
	   DELETE FROM Z_SB070_SUBJECTES_DIFUNTS;
	   DELETE FROM Z_SB071_SUBJECTES_AMB_PRIORITA;
	   DELETE FROM Z_SB072_SUBJECTES_VIPS;
	   DELETE FROM Z_SB073_SUBJECTE_CONTACTE;
	   DELETE FROM Z_SB080_ADRECA_CONTACTE;
	   DELETE FROM Z_SB081_ADRECA_SUBJECTE;
	   DELETE FROM Z_SB090_CONTACTES_PRINCIPALS;
	   DELETE FROM Z_SB091_DATA_ACT_CONTACTE;
	   DELETE FROM Z_SB092_TIPUS_CONTACTES;
	   DELETE FROM Z_SB093_CONTACTES_CONTACTES;
	   DELETE FROM Z_SB094_CONTACTES_SUBJECTES;
	   
	   DELETE FROM Z_SB100_CORREUS_CONTACTES;
	   DELETE FROM Z_SB101_CORREUS_PRINCIPALS;
	   DELETE FROM Z_SB110_TELEFON;
	   
	   DELETE FROM Z_SB120_CLASSIFICACIONS;
	   
	   DELETE FROM Z_SB130_CLASSIF_CONTACTE;
	   
	   DELETE FROM Z_SB140_ACOMPANYANTS_VIPS;
    
	   DELETE FROM Z_SB999_DM_TRACTAMENT;
       DELETE FROM Z_SB999_DM_CARREC;       
	   DELETE FROM Z_SB999_DM_ENTITAT;
	   DELETE FROM Z_SB999_SUBJECTE;
	   DELETE FROM Z_SB999_ADRECA;
    
    COMMIT;
    END;

    PROCEDURE RESETEATOR_TABLAS_SINTAGMA IS
    BEGIN    
      
      DELETE FROM ACOMPANYANT;
      DELETE FROM CONTACTE_CLASSIFICACIO;
      DELETE FROM DM_CLASSIFICACIO;
      DELETE FROM CONTACTE_TELEFON;
      DELETE FROM CONTACTE_CORREU;
      DELETE FROM CONTACTE;
      DELETE FROM ADRECA;
      DELETE FROM SUBJECTE;
      DELETE FROM DM_ENTITAT;
      DELETE FROM DM_CARREC;
      DELETE FROM DM_TRACTAMENT;	  
    
    COMMIT;
    END;


    PROCEDURE RESETEATOR_SECUENCIAS IS
         TYPE V_Sequence IS VARRAY(11) OF VARCHAR2(100);
            Secuencia V_Sequence;
            total 						integer;      
            prefijo varchar2(3);
    BEGIN
    
        prefijo :='';
        Secuencia := V_Sequence('SEQ_CONTACTE',
                                'SEQ_DM_TRACTAMENT',
								'SEQ_DM_CARREC',
								'SEQ_DM_ENTITAT',
								'SEQ_SUBJECTE',
								'SEQ_ADRECA',
								'SEQ_CONTACTE_CORREU',
								'SEQ_CONTACTE_TELEFON',
								'SEQ_DM_CLASSIFICACIO',
								'SEQ_CONTACTE_CLASSIFICACIO',
								'SEQ_ACOMPANYANT'
                              );
                              
        total := Secuencia.count;
    
        DBMS_OUTPUT.PUT_LINE('jjsjsjsjs');
        
        --ojo se ha de resetear a 0, ya que le suma 1 al value.
        --si se proceduce algún casque, puede ser debido a que se intenta resetear por debajo del star with (o min value)
        --yo lo solventé metiendo a pelo esta sentencia por cada secuencia:
        --DROP SEQUENCE SEQ_xxx;
        --CREATE SEQUENCE SEQ_xxx MINVALUE 10000 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 10000 NOCACHE NOORDER NOCYCLE;
        FOR i in 1 .. total LOOP
            -- NOMBRE : SEQ_DM_XXX        Nímero al cuál resetear
            SET_SEQ(prefijo || Secuencia(i),0);
            
        END LOOP;     
        
    COMMIT;    
    END;

END SINTAGMA_01_CONTACTES_VIPS;

/
