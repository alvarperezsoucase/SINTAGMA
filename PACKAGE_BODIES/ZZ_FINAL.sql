--------------------------------------------------------
--  DDL for Package Body ZZ_FINAL
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."ZZ_FINAL" AS


 -- SEPARA LOS CONTACTOS
    PROCEDURE B01_DIF_CONT_VIPS IS
    BEGIN              
        INSERT INTO Z_B01_DIF_CONT_VIPS (ID_CONTACTE, N_VIP, CARREC, ENTITAT, ADRECA, MUNICIPI)
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
                            TRIM(REPLACE(LIMPIARCHARS(ADRECA),'.','')) AS ADRECA, 
                            TRIM(REPLACE(MUNICIPI,'.','')) AS MUNICIPI

                    FROM Z_TMP_VIPS_U_CLASSIF_VIP , 
                         TMP_CLASSIF_ACTIVES act
                    WHERE CLASSIF = act.codi
                    GROUP BY N_VIP, 
                             TRIM(CARREC), 
                             TRIM(ENTITAT), 
                             TRIM(REPLACE(LIMPIARCHARS(ADRECA),'.','')), 
                             TRIM(REPLACE(MUNICIPI,'.','')) 
                ) T
            WHERE NOT EXISTS (SELECT 1 
                              FROM Z_B01_DIF_CONT_VIPS NUEVOS
                              WHERE NUEVOS.N_VIP = T.N_VIP
                                AND NVL(NUEVOS.CARREC,'NULL') = NVL(T.CARREC,'NULL')
                                AND NVL(NUEVOS.ENTITAT,'NULL') = NVL(T.ENTITAT,'NULL')
                                AND NVL(NUEVOS.ADRECA,'NULL') = NVL(T.ADRECA,'NULL')
                                AND NVL(NUEVOS.MUNICIPI,'NULL') = NVL(T.MUNICIPI,'NULL')
                              );
                
        
        /* ANULADO 26/07/2018. Se quita cp y provincia
            SELECT Z_SEQ_CONTACTE.NEXTVAL AS ID_CONTACTE, 
                   N_VIP, 
                   NVL(T.CARREC,'NULL') AS CARREC, 
                   NVL(T.ENTITAT,'NULL') AS ENTITAT, 
                   NVL(T.ADRECA,'NULL') AS ADRECA, 
                   NVL(T.MUNICIPI,'NULL') AS MUNICIPI, 
                   NVL(T.CP,'NULL') AS CP, 
                   NVL(T.PROVINCIA,'NULL') AS PROVINCIA 
            FROM (
                    SELECT  N_VIP, 
                            TRIM(CARREC) AS CARREC, 
                            TRIM(ENTITAT) AS ENTITAT, 
                            TRIM(REPLACE(LIMPIARCHARS(ADRECA),'.','')) AS ADRECA, 
                            TRIM(REPLACE(MUNICIPI,'.','')) AS MUNICIPI, 
                            TRIM(REPLACE(CP,'.','')) AS CP, 
                            TRIM(REPLACE(PROVINCIA,'.','')) AS PROVINCIA
                    FROM SINTAGMA_U.Z_TMP_VIPS_U_CLASSIF_VIP , DANI_TB_CLASSIF_ACTIVES act
                    WHERE CLASSIF = act.codi
                    GROUP BY N_VIP, 
                             TRIM(CARREC), 
                             TRIM(ENTITAT), 
                             TRIM(REPLACE(LIMPIARCHARS(ADRECA),'.','')), 
                             TRIM(REPLACE(MUNICIPI,'.','')), 
                             TRIM(REPLACE(CP,'.','')), 
                             TRIM(REPLACE(PROVINCIA,'.',''))
                ) T;
            */
        COMMIT;
    END;
    
   -- CARGA LOS QUE NO ESTÉN 
    PROCEDURE B02_DIF_CONT_PART_VIPS IS
    BEGIN
      
          INSERT INTO Z_B02_DIF_CONT_PART_VIPS (ID_CONTACTE, N_VIP, ADRECA_P, MUNICIPI_P, TELEFON_P)      
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
                FROM SINTAGMA_U.Z_TMP_VIPS_U_VIPS T 
                WHERE (TRIM(REPLACE(T.ADRECA_P,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.municipi_p,'.','')) IS NOT NULL 
                       )
                  AND NOT EXISTS(SELECT 1 
                                 FROM Z_B01_DIF_CONT_VIPS DIF 
                                 WHERE TRIM(REPLACE(LIMPIARCHARS(T.Adreca_p),'.',''))= DIF.ADRECA 
                                   AND TRIM(REPLACE(T.municipi_p,'.','')) = DIF.municipi 
                                   AND TRIM(T.N_VIP) = DIF.N_VIP 
                                )
                GROUP BY N_VIP, (ADRECA_P), MUNICIPI_P, TELEFON_P
              ) T
         WHERE NOT EXISTS (SELECT 1 
                              FROM Z_B02_DIF_CONT_PART_VIPS NUEVOS
                              WHERE NUEVOS.N_VIP = T.N_VIP
                                AND NVL(NUEVOS.ADRECA_P,'NULL') = NVL(T.ADRECA_P,'NULL')
                                AND NVL(NUEVOS.MUNICIPI_P,'NULL') = NVL(T.MUNICIPI_P,'NULL')
                                AND NVL(NUEVOS.TELEFON_P,'NULL') = NVL(T.TELEFON_P,'NULL')
                              );
      
       /* ANULADO 26/07/2018. Se quita cp y provincia
        -- SOLO TENER EN CUENTA LOS QUE TENGAN DATOS INFORMADOS      
        INSERT INTO Z_B2_DIF_CONT_PART_VIPS (ID_CONTACTE,	N_VIP,	ADRECA_P,	MUNICIPI_P,	PROVINCIA_P, CP_P,	TELEFON_P)      
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
                FROM SINTAGMA_U.Z_TMP_VIPS_U_VIPS T 
                WHERE (TRIM(REPLACE(T.ADRECA_P,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.municipi_p,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.CP_p,'.','')) IS NOT NULL 
                       OR TRIM(REPLACE(T.PROVINCIA_P,'.','')) IS NOT NULL
                       )
                  AND NOT EXISTS(SELECT * 
                                 FROM Z_B1_DIF_CONT_VIPS DIF 
                                 WHERE TRIM(REPLACE(LIMPIARCHARS(T.Adreca_p),'.',''))= DIF.ADRECA 
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
    
    
    PROCEDURE B03_CONTACTES_ID IS
    BEGIN
             
            INSERT INTO Z_B03_CONTACTES_ID --DADES_DIF_IDCONT_CLASS_VIPS
                SELECT DIF.Id_Contacte,
                       CV.* 
                FROM Z_B01_DIF_CONT_VIPS DIF, 
                     Z_TMP_VIPS_U_CLASSIF_VIP CV, 
                     TMP_CLASSIF_ACTIVES act
                WHERE DIF.CARREC = NVL(TRIM(CV.CARREC),'NULL') 
                  AND DIF.ENTITAT = NVL(TRIM(CV.ENTITAT),'NULL')  
                  AND DIF.ADRECA = NVL(TRIM(LIMPIARCHARS(CV.ADRECA)),'NULL')  
                  AND DIF.MUNICIPI = NVL(TRIM(CV.MUNICIPI),'NULL')  
                  AND DIF.N_VIP = CV.N_VIP
                  AND CV.CLASSIF = act.codi
                  AND NOT exists (SELECT 1 
                                    FROM Z_B03_CONTACTES_ID nuevos
                                    WHERE nuevos.Id_Contacte = DIF.Id_Contacte);

    
      COMMIT;
    
    END;  
    
        /* REVISAR */
    PROCEDURE B04_CONTACTES_PART_ID IS
    BEGIN
             
    INSERT INTO Z_B04_CONTACTES_PART_ID --DADES_IDCONTACTES_CLASS_VIPS
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
      FROM Z_B02_DIF_CONT_PART_VIPS DIF, 
           Z_TMP_VIPS_U_VIPS VIPS
      WHERE DIF.N_VIP = VIPS.N_VIP
        AND DIF.ADRECA_P = NVL(VIPS.ADRECA_P,'NULL')  
        AND DIF.MUNICIPI_P = NVL(VIPS.MUNICIPI_P,'NULL')  
        AND DIF.TELEFON_P =  NVL(VIPS.TELEFON_P,'NULL') 
        AND NOT EXISTS (SELECT 1
                        FROM Z_B04_CONTACTES_PART_ID NUEVOS
                        WHERE NUEVOS.Id_Contacte = DIF.Id_Contacte);
      
      COMMIT;
    
    END;  
      
   
   PROCEDURE B05_CONTACTES_SIN_GENER IS
   BEGIN
   
           INSERT INTO Z_B05_CONTACTES_SIN_GENER
            SELECT CONTACTES_TODOS.*
            FROM Z_B03_CONTACTES_ID CONTACTES_TODOS
                 LEFT OUTER JOIN 
                    (SELECT * 
					 FROM Z_B03_CONTACTES_ID
					 WHERE CLASSIF='GENER'                   
                     ) CONTACTES_SIN_GENER
                 ON   CONTACTES_TODOS.ID_CONTACTE = CONTACTES_SIN_GENER.ID_CONTACTE 
            WHERE CONTACTES_SIN_GENER.ID_CONTACTE IS NULL
             AND NOT EXISTS ( SELECT 1 
                                FROM Z_B05_CONTACTES_SIN_GENER ANTIGUOS                                
                               WHERE  ID_CONTACTE = ANTIGUOS.ID_CONTACTE
                             );
   
   COMMIT;
   END;
          
  
          
          
   PROCEDURE B30_TRACTAMENTS IS 
            
            max_seq number;
             
            BEGIN
            
            INSERT INTO Z_B30_TRACTAMENT (ID, CODI, DESCRIPCIO, ABREUJADA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_BAIXA)                                                                       
                        SELECT t.CODI, 
                               t.CODI, 
                               NVL(t.descripcio,t.codi) AS DESCRIPCIO, 
                               t.abreujada, 
                               sysdate AS DATA_CREACIO, 
                               NULL AS DATA_MODIFICACIO, 
                               NULL AS DATA_ESBORRAT, 
                               'MIGRACIO' AS USUARI_CREACIO, 
                               NULL AS USUARI_MODIFICACIO, 
                               NULL AS USUARI_BAIXA 
                        FROM Z_TMP_VIPS_U_TRACTAMENTS t
                        WHERE LENGTH(TRIM(TRANSLATE(t.CODI, ' +-.0123456789', ' '))) IS NULL 
                          AND NOT EXISTS (SELECT * 
                                          FROM Z_B30_TRACTAMENT 
                                          WHERE CODI=t.CODI); 
            
                SELECT MAX(ID) INTO max_seq
                FROM DM_TRACTAMENT;
            
                max_seq := max_seq +1;
            
            SET_SEQ('SEQ_DM_TRACTAMENT',max_seq);
            
            INSERT INTO Z_B30_TRACTAMENT (ID, CODI, DESCRIPCIO, ABREUJADA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_BAIXA)                                                                      
                         SELECT SEQ_DM_TRACTAMENT.NEXTVAL, 
                                t.CODI, 
                                NVL(t.descripcio,t.codi), 
                                t.abreujada, 
                                sysdate, 
                                NULL, 
                                NULL, 
                                'MIGRACIO', 
                                NULL, 
                                NULL 
                         FROM Z_TMP_VIPS_U_TRACTAMENTS t
                         WHERE LENGTH(TRIM(TRANSLATE(t.CODI, ' +-.0123456789', ' '))) IS NOT NULL
                           AND NOT EXISTS (SELECT * 
                                           FROM Z_B30_TRACTAMENT 
                                           WHERE CODI=t.CODI 
                                              OR DESCRIPCIO = t.descripcio
                                           ); 
            COMMIT;
                        
            -- BUSCAR MAPEO PARA DESCRIPCIONES IGUALES, MAPEAR AL MISMO TRACTAMENT (ejecutado cambiando valor duplicado H. Sr. 2,74 en auxiliar) 
            
            INSERT INTO DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO,USUARI_CREACIO)
                        SELECT NUEVOS.id, 
                               NUEVOS.descripcio, 
                               NUEVOS.data_creacio, 
                               NUEVOS.usuari_creacio
                        FROM Z_B30_TRACTAMENT NUEVOS
                        WHERE NOT EXISTS (SELECT * 
                                          FROM DM_TRACTAMENT ANTIGUOS
                                          WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO);
            COMMIT;
            
                      
          END; 
          
    
          -- CREAR ENFOQUE LIMPIANDO CLASSIFICACIONES QUE NO TENGAN PERSONAS ASSIGNADAS
                  
          /*
           PROCEDURE DANI_CLASSIFICACIONS IS 
            BEGIN
            
            INSERT INTO XXXXXX
            
            SELECT * FROM Z_TMP_VIPS_U_CLASSIFICACIONS CL, Z_TMP_VIPS_U_CLASSIF_VIP CV
            WHERE CV.CLASSIF = CL.CODI                                                                        
                          
            -- CLASSIFICACIONS SENSE PERSONES ASSIGNADES
            SELECT CL.* FROM Z_TMP_VIPS_U_CLASSIFICACIONS CL
            WHERE NOT EXISTS (SELECT * FROM Z_TMP_VIPS_U_CLASSIF_VIP CV WHERE CV.CLASSIF = CL.CODI) 
                        
            -- CLASSIFICACIONS AMB PERSONES ASSIGNADES
            SELECT CL.* FROM Z_TMP_VIPS_U_CLASSIFICACIONS CL
            WHERE EXISTS (SELECT * FROM Z_TMP_VIPS_U_CLASSIF_VIP CV WHERE CV.CLASSIF = CL.CODI) 
                        
            -- CONTACTES CON CLASSIFICACIONES ACTIVAS
            SELECT * FROM Z_B3_CONTACTES_ID cv
            WHERE EXISTS (SELECT * FROM DANI_CLASSIFICACIONS_ACTIVES ac WHERE ac.CODI =  cv.CLASSIF)

            -- CONTACTES SIN CLASSIFICACIONES ACTIVAS
            SELECT * FROM Z_B3_CONTACTES_ID cv
            WHERE NOT EXISTS (SELECT * FROM DANI_CLASSIFICACIONS_ACTIVES ac WHERE ac.CODI =  cv.CLASSIF)
                                                                                     
            COMMIT;                                                                   
                   
          END;  
                   
          */
    
    
        


     -- FALTA MIGRAR LOS TELEFONOS NO NUMERICOS (SEPARANDO PARTE NUMERICA de la no NUMERICA)    
    /*
    PROCEDURE DANI_TELEFONS_NO_NUMERICS is 
      
            BEGIN           
            
             INSERT INTO DANI_TB_TELEFONS_NO_NUMERICS 
             SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   CASE WHEN SUBSTR(TRIM(TELEFON1),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFON1,' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON1),'-',''),' ',''),'.','') 
            FROM Z_B3_CONTACTES_ID WHERE TRIM(TELEFON1) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON1, ' +-.0123456789', ' '))) IS NOT NULL AND TRIM(TELEFON1) <> '.';
                        
            INSERT INTO DANI_TB_TELEFONS_NO_NUMERICS 
            SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   CASE WHEN SUBSTR(TRIM(TELEFON2),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON2,'.',''),' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON2),'-',''),' ',''),'.','') 
            FROM Z_B3_CONTACTES_ID WHERE TRIM(TELEFON2) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON2, ' +-.0123456789', ' '))) IS NOT NULL AND TRIM(TELEFON2) <> '.';

            INSERT INTO DANI_TB_TELEFONS_NO_NUMERICS             
            SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   CASE WHEN SUBSTR(TRIM(TELEFON_MOBIL),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON_MOBIL,'.',''),' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON_MOBIL),'-',''),' ',''),'.','') 
            FROM Z_B3_CONTACTES_ID WHERE TRIM(TELEFON_MOBIL) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON_MOBIL, ' +-.0123456789', ' '))) IS NOT NULL AND TRIM(TELEFON_MOBIL) <> '.';

            INSERT INTO DANI_TB_TELEFONS_NO_NUMERICS 
            SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   3 AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(FAX),'-',''),' ',''),'.','') 
            FROM Z_B3_CONTACTES_ID WHERE TRIM(FAX) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(FAX, ' +-.0123456789', ' '))) IS NOT NULL AND TRIM(FAX) <> '.';
                    
            
           INSERT INTO DANI_TB_TELEFONS_NO_NUMERICS
           SELECT ID_CONTACTE, 
                  N_VIP,
                  CASE WHEN SUBSTR(TRIM(TELEFON_P),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON_P,'.',''),' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON_P),'-',''),' ',''),'.','') AS TELEFON
           FROM Z_B4_CONTACTES_PART_ID C
           WHERE TRIM(TELEFON_P) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON_P, ' +-.0123456789', ' '))) IS NOT NULL AND TRIM(TELEFON_P) <> '.'
                  AND NOT EXISTS (SELECT * FROM DANI_TB_TELEFONS_NUMERICS AUX  WHERE C.ID_CONTACTE = AUX.ID_CONTACTE AND C.N_VIP = AUX.N_VIP AND REPLACE(REPLACE(REPLACE(TRIM(C.TELEFON_P),'-',''),' ',''),'.','') = AUX.TELEFON);
            
           COMMIT;	
          END;
    */
        
        
    PROCEDURE B50_CARRECS IS
      
    BEGIN
    
            INSERT INTO Z_B50_CARRECS
                   SELECT SEQ_DM_CARREC.NEXTVAL AS ID_CARREC, 
                          T.CARREC_NORM
                   FROM ( 
                           SELECT LIMPIARCHARS(CARREC) AS CARREC_NORM
                           FROM Z_B03_CONTACTES_ID 
                           WHERE TRIM(LIMPIARCHARS(CARREC)) IS NOT NULL
                           GROUP BY LIMPIARCHARS(CARREC)
                        )T
                   WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_B50_CARRECS ANTIGUOS 
                                     WHERE T.CARREC_NORM = ANTIGUOS.CARREC_NORM
                                    );
            COMMIT;
            
           
                
    END;    
        
    PROCEDURE B51_CARRECS_CONTACTES IS      
    BEGIN
    
             INSERT INTO Z_B51_CARRECS_CONTACTES
                     SELECT c.ID_CONTACTE, 
                            norm.ID_CARREC
                    FROM Z_B03_CONTACTES_ID c, 
                         Z_B50_CARRECS norm
                    WHERE TRIM(LIMPIARCHARS(c.CARREC)) IS NOT NULL 
                      AND LIMPIARCHARS(c.CARREC) = norm.CARREC_NORM
                      AND NOT EXISTS ( SELECT 1 
                      				   FROM Z_B51_CARRECS_CONTACTES ANTIGUOS
                      				   WHERE ANTIGUOS.ID_CONTACTE = c.ID_CONTACTE
                      				     AND ANTIGUOS.ID_CARREC = norm.ID_CARREC) 
                    GROUP BY c.ID_CONTACTE, norm.ID_CARREC;
                    
                    
                    

            COMMIT;
                    

            COMMIT;
    
    END;
    
    PROCEDURE B52_DM_CARREC IS      
    BEGIN
                INSERT INTO DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, USUARI_CREACIO)
                    SELECT norm.ID_CARREC, 
                           MAX(c.CARREC) AS DESCRIPCIO, 
                           MAX(SYSDATE) AS DATA_CREACIO, 
                           MAX('MIGRACIO') AS USUARI_CREACIO
                     FROM Z_B50_CARRECS norm, 
                          Z_B03_CONTACTES_ID c
                     WHERE LIMPIARCHARS(c.CARREC) = norm.CARREC_NORM 
                       AND NOT EXISTS(SELECT 1 
                                        FROM DM_CARREC aux 
                                       WHERE LIMPIARCHARS(aux.DESCRIPCIO) = norm.CARREC_NORM
                                      )
                     GROUP BY norm.ID_CARREC;
            COMMIT;
    
    COMMIT;
    END;
    
    
    
    PROCEDURE B60_ENTITATS IS 
      
    BEGIN
        
            -- VALORS UTILTIZATS DEL CATALEG
            INSERT INTO Z_B60_ENTITAT (ID, CODI, ENTITAT, ENTITAT_NORM)
                 SELECT SEQ_DM_ENTITAT.NEXTVAL AS ID, 
                        CODI, 
                        ENTITAT, 
                        ENTITAT_NORM
                   FROM (
                           SELECT  MAX(CODI) AS CODI, 
                                   MAX(NVL(ent.ENTITAT,ent.CODI)) AS ENTITAT, 
                                   LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.','')) AS ENTITAT_NORM
                           FROM Z_TMP_VIPS_U_ENTITAT ent, 
                                Z_B03_CONTACTES_ID c
                           WHERE c.codi_entitat = ent.codi 
                             AND TRIM(ent.ENTITAT) IS NOT NULL
                           GROUP BY LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.',''))
                        ) T
                  WHERE NOT EXISTS (SELECT 1
                                    FROM Z_B60_ENTITAT 
                                    WHERE CODI = t.CODI) 
                    AND
                        NOT EXISTS (SELECT 1 
                                    FROM DM_ENTITAT 
                                    where LIMPIARCHARS(REPLACE(REPLACE(t.entitat,' de ',''), 'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE(DESCRIPCIO,' de ',''), 'S.A.',''))); 
            COMMIT;
            
            
            -- VALORS EN FORMAT TEXT QUE COINCIDEIXEN AMB CATÀLEG
            INSERT INTO Z_B60_ENTITAT (ID, CODI, ENTITAT, ENTITAT_NORM)
                    SELECT SEQ_DM_ENTITAT.NEXTVAL AS ID, 
                           CODI, 
                           ENTITAT, 
                           ENTITAT_NORM
                    FROM (
                            SELECT  MAX(CODI) AS CODI, 
                                    MAX(NVL(ent.ENTITAT,ent.CODI)) AS ENTITAT, 
                                    LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.','')) AS ENTITAT_NORM
                            FROM Z_B03_CONTACTES_ID c, 
                                 Z_TMP_VIPS_U_ENTITAT ent 
                            WHERE LIMPIARCHARS(REPLACE(REPLACE(c.entitat,' de ',''), 'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE(ent.entitat,' de ',''),'S.A.',''))
                            GROUP BY LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.',''))
                         ) T
                    WHERE NOT EXISTS (SELECT 1 
                                        FROM Z_B60_ENTITAT 
                                        WHERE CODI = t.CODI) 
                      AND NOT EXISTS (SELECT 1 
                                        FROM DM_ENTITAT 
                                        where LIMPIARCHARS(REPLACE(REPLACE(t.entitat,' de ',''), 'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE(DESCRIPCIO,' de ',''), 'S.A.','')));
             COMMIT;
             
            -- ALTA CATALOGO DE LITERALES QUE NO ESTAN EN EL CATALOGO
            INSERT INTO Z_B61_ENTITAT_NORMALIZADA
                    SELECT SEQ_DM_ENTITAT.NEXTVAL AS ID, 
                           aec.entitat AS ENTITAT, 
                           aec.ENTITAT_NORM AS ENTITAT_NORMALITZADA 
                    FROM  (
                            SELECT LIMPIARCHARS(REPLACE(REPLACE(ENTITAT,' de ',''), 'S.A.','')) AS ENTITAT_NORM, 
                                   MAX(ENTITAT) AS ENTITAT
                            FROM Z_B03_CONTACTES_ID
                            WHERE LIMPIARCHARS(REPLACE(REPLACE(ENTITAT,' de ',''), 'S.A.','')) IS NOT NULL 
                              AND CODI_ENTITAT IS NULL
                            GROUP BY LIMPIARCHARS(REPLACE(REPLACE(ENTITAT,' de ',''),'S.A.',''))
                          ) aec
                    WHERE NOT EXISTS(SELECT 1 
                                      FROM Z_B60_ENTITAT aux 
                                      where aux.entitat_norm = aec.ENTITAT_NORM) 
                      AND NOT EXISTS(SELECT 1 
                                     FROM Z_B61_ENTITAT_NORMALIZADA aux2 
                                     WHERE aec.ENTITAT_NORM = aux2.entitat_normalitzada)    
                      AND NOT EXISTS(SELECT 1 
                                     FROM DM_ENTITAT a1 
                                     where LIMPIARCHARS(REPLACE(REPLACE(a1.descripcio,' de ',''), 'S.A.','')) = aec.ENTITAT_NORM);
            COMMIT;
            
            
            -- INSERTA LOS QUE VIENEN DE CATALAOGO (y las que coinciden por descripcion con alguna del catàlogo)
            INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, USUARI_CREACIO)
                    SELECT aux.id, 
                           aux.codi, 
                           aux.entitat, 
                           SYSDATE, 
                           'MIGRACIO'
            FROM Z_B60_ENTITAT aux
            WHERE NOT EXISTS (SELECT 1 
                                FROM DM_ENTITAT e 
                                WHERE e.codi = aux.codi);
           
           COMMIT;
            -- INSERTA LAS 
            INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, USUARI_CREACIO)
                    SELECT aux.id, 
                           aux.id, 
                           aux.entitat, 
                           SYSDATE, 
                           'MIGRACIO'
                    FROM Z_B61_ENTITAT_NORMALIZADA aux
                    WHERE NOT EXISTS (SELECT 1 
                                        FROM DM_ENTITAT e 
                                        WHERE LIMPIARCHARS(REPLACE(REPLACE(e.descripcio,' de ',''), 'S.A.',''))= aux.entitat_normalitzada);
                                        
            COMMIT;            
    END;
    
    
    PROCEDURE B62_ENTITATS_CONTACTES IS    
    BEGIN    
    
            INSERT INTO Z_B62_ENTITATS_CONTACTES (ID, ID_CONTACTE)
                 SELECT ent.id AS ID, 
                        c.id_contacte
                 FROM DM_ENTITAT ent, 
                      Z_B03_CONTACTES_ID c
                WHERE LIMPIARCHARS(REPLACE(REPLACE(ent.descripcio,' de ',''),'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE( c.entitat,' de ',''),'S.A.','')) 
                  AND TRIM(REPLACE(REPLACE(c.entitat,'.',''),'-','')) IS NOT NULL 
                  AND  NOT EXISTS(SELECT 1 
                                  FROM Z_B62_ENTITATS_CONTACTES ec 
                                  WHERE ec.id_contacte = c.id_contacte and ec.id = ent.id)
                GROUP BY ent.id, c.id_contacte;
                
            COMMIT;
            
            INSERT INTO Z_B62_ENTITATS_CONTACTES (ID, ID_CONTACTE)
                        SELECT ent.id AS ID, 
                               c.id_contacte
                        FROM DM_ENTITAT ent, 
                             Z_B03_CONTACTES_ID c
                        WHERE LIMPIARCHARS(REPLACE(REPLACE(ent.descripcio,' de ',''),'S.A.','')) =  LIMPIARCHARS(REPLACE(REPLACE( c.entitat,' de ',''),'S.A.','')) 
                          AND TRIM(REPLACE(REPLACE(c.entitat,'.',''),'-','')) IS NOT NULL
                          AND NOT EXISTS(SELECT 1 
                                         FROM Z_B62_ENTITATS_CONTACTES ec 
                                         WHERE ec.id_contacte = c.id_contacte and ec.id = ent.id)
                        GROUP BY ent.id, c.id_contacte;
            COMMIT;
            
    END;
    
------------------------------------------------------------------------------    
-- SUBJECTES -----------------------------------------------------------------    
------------------------------------------------------------------------------    
    
    PROCEDURE B70_SUBJECTES_DIFUNTS IS                 
    BEGIN
   
       INSERT INTO Z_B70_SUBJECTES_DIFUNTS
            SELECT N_VIP, 
                   NVL2(DATA_ALTA,TRUNC(DATA_ALTA),TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_DEFUNCIO
            FROM Z_B03_CONTACTES_ID 
            WHERE CLASSIF = 'DEFU'
            AND NOT EXISTS (SELECT 1
                            FROM Z_B70_SUBJECTES_DIFUNTS ANTIGUOS
                            WHERE ANTIGUOS.N_VIP = N_VIP);
            
       COMMIT;
    END;
    
    
    PROCEDURE B71_SUBJECTES_AMB_PRIORITAT IS
      
    BEGIN
           INSERT INTO Z_B71_SUBJECTES_AMB_PRIORITAT    
                SELECT N_VIP, 
                       REPLACE(TRIM(FAX), '91-SC','1-SC') 
                FROM Z_B03_CONTACTES_ID 
                WHERE TRIM(FAX) IN ('1-SC','91-SC')        
                  AND NOT EXISTS(SELECT 1
                            FROM Z_B71_SUBJECTES_AMB_PRIORITAT ANTIGUOS
                            WHERE ANTIGUOS.N_VIP = N_VIP)
                GROUP BY N_VIP, REPLACE(TRIM(FAX),'91-SC','1-SC') ;
                
           COMMIT;
    END;
    
        
    PROCEDURE B72_SUBJECTES is                 
    BEGIN

      INSERT INTO SUBJECTE (ID, NOM,COGNOM1,COGNOM2,ALIES,DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,	USUARI_ESBORRAT,	USUARI_MODIFICACIO,	TRACTAMENT_ID,	PRIORITAT_ID,	TIPUS_SUBJECTE_ID,	AMBIT_ID,	IDIOMA_ID)
            SELECT N_VIP, 
                   MAX(NOM), 
                   MAX(COGNOM1), 
                   MAX(COGNOM2), 
                   MAX(ALIES), 
                   MAX(DATA_DEFUNCIO), 
                   MAX(MOTIU_BAIXA), 
                   MAX(DATA_ALTA), 
                   MAX(DATA_BAIXA), 
                   MAX(DATA_MODIF),
                   MAX(USU_ALTA), 
                   MAX(USU_MODIF), 
                   MAX(USU_BAIXA), 
                   MAX(TRACTAMENT), 
                   MAX(PRIORITAT), 
                   MAX(TIPUS_SUBJECTE_ID), 
                   MAX(AMBIT_ID), 
                   MAX(IDIOMA_ID)
      FROM (
              SELECT  c.N_VIP,
                      NVL(c.NOM,'.') AS NOM,
                      c.COGNOM1,
                      c.COGNOM2,
                      NULL AS ALIES,
                      dif.DATA_DEFUNCIO,
                      NULL AS MOTIU_BAIXA,
                      NVL2(DATA_ALTA, DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA,
                      DATA_MODIF, 
                      DATA_BAIXA,
                      NVL(USU_ALTA, 'NO_INFO') AS USU_ALTA,   
                      NVL2(USU_MODIF, USU_MODIF, NVL2(DATA_MODIF, 'NO_INFO', NULL)) AS USU_MODIF,
                      NVL2(DATA_BAIXA, 'NO_INFO', NULL) AS USU_BAIXA, 
                      (SELECT admt.ID FROM DM_TRACTAMENT admt WHERE admt.ID = c.Tractament) AS TRACTAMENT,
                      (SELECT dmp.ID FROM DM_PRIORITAT dmp WHERE dmp.DESCRIPCIO = pr.prioritat) AS PRIORITAT,
                      ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                      ConstAMBIT_PROTOCOL AS AMBIT_ID,
                      NULL AS IDIOMA_ID         
              FROM Z_B04_CONTACTES_PART_ID c, 
                   Z_B70_SUBJECTES_DIFUNTS dif, 
                   Z_B71_SUBJECTES_AMB_PRIORITAT PR
              WHERE c.N_VIP = dif.N_VIP (+) 
                AND c.n_Vip = PR.N_VIP (+)
                AND NOT EXISTS (SELECT 1 
                                FROM SUBJECTE s 
                                WHERE s.ID = c.N_VIP)
           ) T
      GROUP BY N_VIP;
      COMMIT;
      
      -- NUEVO
      INSERT INTO SUBJECTE (ID, NOM,COGNOM1,COGNOM2,ALIES,DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,	USUARI_ESBORRAT,	USUARI_MODIFICACIO,	TRACTAMENT_ID,	PRIORITAT_ID,	TIPUS_SUBJECTE_ID,	AMBIT_ID,	IDIOMA_ID)
                SELECT N_VIP, 
                       MAX(NOM), 
                       MAX(COGNOM1), 
                       MAX(COGNOM2), 
                       MAX(ALIES), 
                       MAX(DATA_DEFUNCIO), 
                       MAX(MOTIU_BAIXA), 
                       MAX(DATA_ALTA), 
                       MAX(DATA_BAIXA),
                       MAX(DATA_MODI), 
                       MAX(USU_ALTA), 
                       MAX(USU_MODIF), 
                       MAX(USU_BAIXA), 
                       MAX(TRACTAMENT), 
                       MAX(PRIORITAT), 
                       MAX(TIPUS_SUBJECTE_ID), 
                       MAX(AMBIT_ID), 
                       MAX(IDIOMA_ID)
                FROM (
                          SELECT  c.N_VIP,
                                  NVL(CV.NOM,'.') AS NOM,
                                  (CASE WHEN(length(CV.COGNOMS) - length(replace(CV.COGNOMS, ' ', '')) + 1) = 2 THEN 
                                                trim(SUBSTR(CV.COGNOMS,1,INSTR(CV.COGNOMS,' ')-1))
                                        WHEN trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1)) IS NULL THEN 
                                                CV.COGNOMS 
                                  ELSE  
                                        trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1))
                                  END)  AS COGNOM1, 
                                  (CASE WHEN trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1)) IS NOT NULL THEN 
                                             trim(SUBSTR(CV.COGNOMS,INSTR(LOWER(CV.COGNOMS),' i ')))
                                        WHEN (length(CV.COGNOMS) - length(replace(CV.COGNOMS, ' ', '')) + 1) = 2 THEN  
                                             trim(SUBSTR(CV.COGNOMS, INSTR(CV.COGNOMS,' ')))
                                  ELSE 
                                        NULL 
                                  END) AS COGNOM2, 
                                  (case when SUBSTR(nom,instr(nom,'(')+1,instr(nom,')') - (instr(nom,'(')+1)) IS NOT NULL then
                                             SUBSTR(nom,instr(nom,'(')+1,instr(nom,')') - (instr(nom,'(')+1))
                                        when SUBSTR(COGNOMS,instr(COGNOMS,'(') +1 ,instr(COGNOMS,')') - (instr(COGNOMS,'(') +1)) is not null then
                                             SUBSTR(COGNOMS,instr(COGNOMS,'(') +1 ,instr(COGNOMS,')') - (instr(COGNOMS,'(') +1))
                                   else
                                    null
                                  end)  AS ALIES,
                                  dif.DATA_DEFUNCIO,
                                  NULL AS MOTIU_BAIXA,
                                  NVL2(c.DATA_ALTA, c.DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA,
                                  DATA_MODI, 
                                  CV.Data_Baixa AS DATA_BAIXA,
                                  NVL(c.USU_ALTA, 'NO_INFO') AS USU_ALTA,   
                                  NVL2(c.USU_MODI, c.USU_MODI, NVL2(c.DATA_MODI, 'NO_INFO', NULL)) AS USU_MODIF,
                                  NVL2(CV.Data_Baixa,'NO_INFO',NULL) AS USU_BAIXA, 
                                  (SELECT admt.ID FROM DM_TRACTAMENT admt WHERE admt.ID = CV.TRACTAMENT ) AS TRACTAMENT, 
                                  (SELECT dmp.ID FROM DM_PRIORITAT dmp WHERE dmp.DESCRIPCIO = pr.prioritat) AS PRIORITAT,
                                  ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                                  ConstAMBIT_PROTOCOL AS AMBIT_ID,
                                  NULL AS IDIOMA_ID 
                          FROM Z_B03_CONTACTES_ID c, 
                               Z_B70_SUBJECTES_DIFUNTS dif, 
                               Z_B71_SUBJECTES_AMB_PRIORITAT PR, 
                               Z_TMP_VIPS_U_VIPS CV
                          WHERE c.N_VIP = dif.N_VIP (+) 
                            AND c.N_VIP = CV.N_VIP 
                            AND c.n_Vip = PR.N_VIP
                   ) T
              WHERE NOT EXISTS (SELECT 1 
                                FROM SUBJECTE s 
                                WHERE s.ID = T.N_VIP) 
              GROUP BY N_VIP;
      
      COMMIT;
    
    END;
    
    -----------------------------------------------------------------------------------
    -- ADRECA ----------------------------------------------------------------------
    -----------------------------------------------------------------------------------        
     
      PROCEDURE B80_ADRECA_CONTACTE IS      
      BEGIN
              INSERT INTO Z_B80_ADRECA_CONTACTE
                    SELECT SEQ_ADRECA.NEXTVAL, 
                           ID_CONTACTE, 
                           ADRECA, 
                           MUNICIPI, 
                           CP, 
                           PROVINCIA, 
                           PAIS, 
                           USU_ALTA,
                           DATA_ALTA, 
                           USU_MODI, 
                           DATA_MODI
                   FROM (
                           SELECT c.ID_CONTACTE, 
                               MAX(c.ADRECA) AS ADRECA, 
                               MAX(c.MUNICIPI) AS MUNICIPI, 
                               MAX(c.CP) AS CP, 
                               MAX(c.PROVINCIA) AS PROVINCIA, 
                               MAX(t.PAIS) AS PAIS, 
                               MAX(NVL(c.USU_ALTA,'NO_INFO')) AS USU_ALTA, 
                               MAX(NVL(c.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy'))) AS DATA_ALTA, 
                               MAX(c.USU_MODI) AS USU_MODI, MAX(c.DATA_MODI) AS DATA_MODI
                           FROM Z_B03_CONTACTES_ID c, (              
                                                          SELECT ID_CONTACTE, 
                                                                 REPLACE(REPLACE(PAIS,'(',''),')','') AS PAIS
                                                            FROM Z_B03_CONTACTES_ID
                                                           WHERE LENGTH(TRIM(TRANSLATE(PAIS, ' +-.0123456789', ' '))) IS NOT NULL 
                                                             AND LENGTH(TRIM(TRANSLATE(SUBSTR(PAIS,1,1), ' +-.0123456789', ' '))) IS NOT NULL 
                                                             AND PAIS NOT IN ('PP','CIU') AND SUBSTR(PAIS,1,3) <> 'AUT'
                                                       )T
                           WHERE c.ID_CONTACTE = T.ID_CONTACTE (+)
                           GROUP BY c.ID_CONTACTE
                        ) a
                    WHERE NOT EXISTS (SELECT 1
                        			  FROM Z_B80_ADRECA_CONTACTE ANTIGUOS
              						  WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
              
              -- CREAR PARA PARTICULARES B4 (CON DATOS DE DIRECCION INFORMADO)
              INSERT INTO Z_B80_ADRECA_CONTACTE (ID_ADRECA,ID_CONTACTE,ADRECA,MUNICIPI,CP,PROVINCIA,PAIS,USU_ALTA,DATA_ALTA,USU_MODI,DATA_MODI)
                    SELECT SEQ_ADRECA.NEXTVAL AS ID_ADRECA, 
                           c.ID_CONTACTE AS ID_CONTACTE, 
                           c.ADRECA_P AS ADRECA, 
                           c.MUNICIPI_P AS MUNICIPI, 
                           c.CP_P AS CP, 
                           c.PROVINCIA_P AS PROVINCIA, 
                           c.PAIS_P AS PAIS, 
                           NVL(c.USU_ALTA,'NO_INFO') AS USU_ALTA, 
                           NVL(c.DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, 
                           c.USU_MODIF AS USU_MODI, 
                           c.DATA_MODIF AS DATA_MODI
                  FROM Z_B04_CONTACTES_PART_ID c
                 WHERE (TRIM(c.ADRECA_P) IS NOT NULL 
                    OR TRIM(c.MUNICIPI_P) IS NOT NULL 
                    OR TRIM(c.PROVINCIA_P) IS NOT NULL 
                    OR TRIM(c.PAIS_P) IS NOT NULL 
                    OR TRIM(c.CP_P) IS NOT NULL)
                   AND NOT EXISTS (SELECT 1 
                   					 FROM Z_B80_ADRECA_CONTACTE ANTIGUOS 
                   					 WHERE ANTIGUOS.ID_CONTACTE = c.ID_CONTACTE
                   				  ); 
                             
              COMMIT;
        
              -- FALTAN DIRECCIONES PARTICULARES
                 
              INSERT INTO ADRECA (ID, MUNICIPI, NOM_CARRER, PROVINCIA, PAIS, USUARI_CREACIO, DATA_CREACIO, USUARI_MODIFICACIO,DATA_MODIFICACIO)
                    SELECT ac.ID_ADRECA , 
                           ac.municipi, 
                           nvl(ac.adreca,'.'), 
                           ac.provincia, 
                           ac.pais,  
                           ac.usu_alta, 
                           ac.data_alta, 
                           ac.usu_modi, 
                           ac.data_modi
              FROM Z_B80_ADRECA_CONTACTE ac
              WHERE NOT EXISTS (SELECT 1 
                                FROM ADRECA ANTIGUOS
                                WHERE ANTIGUOS.ID =  ac.ID_ADRECA);
              
              COMMIT;
                     
    END;
        
        
    -----------------------------------------------------------------------------------
    -- CONTACTES ----------------------------------------------------------------------
    -----------------------------------------------------------------------------------    
    
    PROCEDURE B90_CONTACTES_PRINCIPALS IS
   
    BEGIN
              INSERT INTO Z_B90_CONTACTES_PRINCIPALS
                    SELECT ID_CONTACTE 
                      FROM Z_B03_CONTACTES_ID
                     WHERE CLASSIF = 'GENER'
                      AND NOT EXISTS (SELECT 1 
                                       FROM Z_B90_CONTACTES_PRINCIPALS ANTIGUOS
                                      WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
                     
              COMMIT;
              
    END;
    
    PROCEDURE B91_DATA_ACT_CONTACTE IS      
    BEGIN
    
           INSERT INTO Z_B91_DATA_ACT_CONTACTE
                SELECT ID_CONTACTE,
                       (CASE WHEN LENGTH(PAIS) =5 THEN 
                                    TO_DATE(PAIS||'-2018','dd-mm-yyyy') 
                            WHEN LENGTH(PAIS) = 7 AND SUBSTR(PAIS, 3, 1) = '-' THEN 
                                    TO_DATE(SUBSTR(PAIS, 1,3)||'0'||SUBSTR(PAIS, 4,7), 'dd-mm-yy')
                            WHEN LENGTH(PAIS) = 7 THEN 
                                    TO_DATE(PAIS, 'ddmm-yy')
                            WHEN LENGTH(PAIS) = 8 THEN 
                                    TO_DATE(PAIS, 'dd-mm-yy')
                            WHEN LENGTH(PAIS) = 10 THEN 
                                    TO_DATE(PAIS, 'dd-mm-yyyy')
                        ELSE TO_DATE('01-01-1970','dd-mm-yyyy')
                    END) AS DATA_ACTUALITZACIO
               FROM  Z_B03_CONTACTES_ID 
              WHERE PAIS IS NOT NULL 
                AND LENGTH(TRIM(TRANSLATE(SUBSTR(PAIS,1,5), ' +-.0123456789', ' '))) IS NULL 
                AND TO_NUMBER(SUBSTR(PAIS,1,1)) IN (0,1,2,3) AND TRIM(PAIS)<>'.'
                AND NOT EXISTS (SELECT 1
                                 FROM Z_B91_DATA_ACT_CONTACTE ANTIGUOS
                                WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
            COMMIT;
            
    END;

    
    
    
    
    
    
    PROCEDURE B92_TIPUS_CONTACTES IS

    BEGIN   
      
            INSERT INTO Z_B92_TIPUS_CONTACTES   
                    SELECT NUEVOS.ID_CONTACTE, NUEVOS.TIPUS
                    FROM (
                            SELECT ID_CONTACTE, 
                                   MAX(1) AS TIPUS
                            FROM  Z_B04_CONTACTES_PART_ID part
                            GROUP BY(ID_CONTACTE)
                          UNION
                            SELECT ID_CONTACTE, 
                                   MAX(2) AS TIPUS
                              FROM Z_B03_CONTACTES_ID t 
                          GROUP BY(ID_CONTACTE)
                         ) NUEVOS
                   WHERE NOT EXISTS (SELECT 1
                                     FROM Z_B92_TIPUS_CONTACTES ANTIGUOS
                                     WHERE NUEVOS.ID_CONTACTE =  ANTIGUOS.ID_CONTACTE 
              					       AND NUEVOS.TIPUS = ANTIGUOS.TIPUS_CONTACTE
              		                );
            
            COMMIT;

    END;
    
    
   
    
    
    PROCEDURE B93_CONTACTES is       
         
    BEGIN

        INSERT INTO CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID)
        SELECT ID_CONTACTE, MAX(PRINCIPAL), MAX(ID_CARREC), MAX(DEPART), MAX(QUALITAT), MAX(DATA_ACTUALITZACIO), MIN(DATA_ALTA), MAX(DATA_MODI), MAX(DATA_BAIXA), MAX(USU_ALTA), MAX(USU_MODI), MAX(USU_BAIXA), MAX(TIPUS_CONTACTE_ID), MAX(N_VIP), MAX(ID_ADRECA), MAX(ENTITAT_ID), MAX(VISIBILITAT_ID), MAX(AMBIT_ID) 
        FROM (
                SELECT co1.ID_CONTACTE, NVL2(cp.ID_CONTACTE, '1','0') AS PRINCIPAL, 
                       car.id_carrec, co1.DEPART, 
                       1 AS QUALITAT, 
                       ddm.DATA_ACTUALITZACIO, 
                       NVL(co1.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, 
                       co1.DATA_MODI,s.data_esborrat AS DATA_BAIXA, 
                       NVL(co1.USU_ALTA,'NO_INFO') AS USU_ALTA, 
                       co1.USU_MODI, 
                       s.usuari_esborrat AS USU_BAIXA, 
                       ConstContacteProfesional AS TIPUS_CONTACTE_ID, 
                       co1.N_VIP, ad.ID_ADRECA, 
                       ec.ID AS ENTITAT_ID , 
                       ConstVISIBILITAT_ALCALDIA AS VISIBILITAT_ID ,
                       ConstAMBIT_PROTOCOL AS AMBIT_ID
                FROM  Z_B80_ADRECA_CONTACTE ad, 
                      Z_B90_CONTACTES_PRINCIPALS cp, 
                      Z_B91_DATA_ACT_CONTACTE ddm, 
                      Z_B51_CARRECS_CONTACTES car, 
                      Z_B62_ENTITATS_CONTACTES ec, 
                      SUBJECTE s, 
                     (
                        SELECT ID_CONTACTE, 
                               MAX(DEPART) AS DEPART, 
                               MIN(DATA_ALTA) AS DATA_ALTA,
                               MAX(DATA_MODI) AS DATA_MODI, 
                               MAX(USU_ALTA) AS USU_ALTA , 
                               MAX(USU_MODI) AS USU_MODI, 
                               MAX(N_VIP) AS N_VIP
                        FROM Z_B03_CONTACTES_ID 
                        GROUP BY ID_CONTACTE
                    ) co1
            WHERE co1.n_vip = s.id 
              AND co1.ID_CONTACTE = ad.ID_CONTACTE (+) 
              AND co1.ID_CONTACTE = cp.ID_CONTACTE (+) 
              AND co1.ID_CONTACTE = ddm.ID_CONTACTE (+) 
              AND co1.Id_Contacte = car.id_contacte (+) 
              AND co1.ID_CONTACTE = ec.ID_CONTACTE (+)  
              AND NOT EXISTS (SELECT 1 
                              FROM CONTACTE c1 
                              WHERE c1.id = co1.id_contacte)
    ) T
        GROUP BY T.ID_CONTACTE;
        
        
        -- PARTICULARES QUE TENIAN DIRECCION INFORMADA
        INSERT INTO CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID)
            SELECT ID_CONTACTE, 
                   MAX(PRINCIPAL), 
                   MAX(ID_CARREC), 
                   MAX(DEPART), 
                   MAX(QUALITAT), 
                   MAX(DATA_ACTUALITZACIO), 
                   MIN(DATA_ALTA), 
                   MAX(DATA_MODIF), 
                   MAX(DATA_BAIXA), 
                   MAX(USU_ALTA),  
                   MAX(USU_MODIF), 
                   MAX(USU_BAIXA), 
                   MAX(TIPUS_CONTACTE_ID), 
                   MAX(N_VIP), 
                   MAX(ID_ADRECA), 
                   MAX(ENTITAT_ID), 
                   MAX(VISIBILITAT_ID), 
                   MAX(AMBIT_ID) 
          FROM (
                    SELECT co1.ID_CONTACTE, 
                           NVL2(cp.ID_CONTACTE, '1','0') AS PRINCIPAL, 
                           car.id_carrec, 
                           '' AS DEPART, 
                           1 AS QUALITAT, 
                           ddm.DATA_ACTUALITZACIO, 
                           NVL(co1.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, 
                           co1.DATA_MODIF, s.data_esborrat AS DATA_BAIXA, 
                           NVL(co1.USU_ALTA,'NO_INFO') AS USU_ALTA, 
                           co1.USU_MODIF, 
                           s.usuari_esborrat AS USU_BAIXA, 
                           ConstContactePersonal AS TIPUS_CONTACTE_ID, 
                           co1.N_VIP, 
                           ad.ID_ADRECA, 
                           ec.ID AS ENTITAT_ID , 
                           ConstVISIBILITAT_ALCALDIA AS VISIBILITAT_ID  ,
                           ConstAMBIT_PROTOCOL AS AMBIT_ID
                    FROM Z_B04_CONTACTES_PART_ID co1, 
                         Z_B80_ADRECA_CONTACTE ad, 
                         Z_B90_CONTACTES_PRINCIPALS cp, 
                         Z_B91_DATA_ACT_CONTACTE ddm, 
                         Z_B51_CARRECS_CONTACTES car, 
                         Z_B62_ENTITATS_CONTACTES ec, 
                         SUBJECTE s
                    WHERE co1.n_vip = s.id 
                      AND co1.ID_CONTACTE = ad.ID_CONTACTE 
                      AND co1.ID_CONTACTE = cp.ID_CONTACTE (+) 
                      AND co1.ID_CONTACTE = ddm.ID_CONTACTE (+) 
                      AND co1.Id_Contacte = car.id_contacte (+) 
                      AND co1.ID_CONTACTE = ec.ID_CONTACTE (+)  
                      AND NOT EXISTS (SELECT 1 
                                        FROM CONTACTE c1 
                                       WHERE c1.id = co1.id_contacte)
        ) T
        GROUP BY T.ID_CONTACTE;
       
        COMMIT;               
    END;
    
  
    
    
    ----------------------------------------------------------------------
    -- CORREUS_CONTACTES
    ----------------------------------------------------------------------
    
     PROCEDURE B100_CORREUS_CONTACTES IS
    BEGIN
         INSERT INTO Z_B100_CORREUS_CONTACTES (ID_CONTACTE, INTERNET)
              		 SELECT aux.ID_CONTACTE, 
                            aux.INTERNET 
            		 FROM(                                                                         
              			   SELECT DISTINCT t.ID_CONTACTE,
              			  				   trim(regexp_substr(t.INTERNET, '[^;]+', 1, levels.column_value))  as INTERNET
              			   FROM ( 
                			      SELECT ID_CONTACTE, 
                			             INTERNET 
                			      FROM Z_B03_CONTACTES_ID 
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
            	     				  FROM Z_B100_CORREUS_CONTACTES con 
            	     				  WHERE con.ID_CONTACTE = aux.ID_CONTACTE 
            	     				    AND con.internet = aux.internet
            	     				  );                                                                 

            COMMIT;   
            
          END;  
          
    PROCEDURE B101_CORREUS_PRINCIPALS IS
      
        id_contacte_ant number;
    BEGIN
          
        id_contacte_ant:=0;
        
         FOR c IN (
               SELECT * 
               FROM  Z_B100_CORREUS_CONTACTES  NUEVOS
               WHERE NOT EXISTS (SELECT * 
                                 FROM Z_B101_CORREUS_PRINCIPALS ANTIGUOS
                                 WHERE  NUEVOS.id_contacte = ANTIGUOS.id_contacte
                                   AND NUEVOS.internet = ANTIGUOS.CORREU
                                 )              
               ORDER BY ID_CONTACTE,INTERNET
           )
           
         LOOP                        
            IF c.id_contacte <> id_contacte_ant THEN
                  id_contacte_ant:= c.id_contacte;
                  INSERT INTO Z_B101_CORREUS_PRINCIPALS VALUES (c.id_contacte, c.internet, 1);
            ELSE                  
                    INSERT INTO Z_B101_CORREUS_PRINCIPALS VALUES (c.id_contacte, c.internet, 0);                           
            END IF;

          END LOOP;
        
        COMMIT;        
        END;
                
        
        PROCEDURE B102_CORREUS_CONTACTES IS   
        
        BEGIN
         
            INSERT INTO CONTACTE_CORREU(ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, Contacte_Id)
                    SELECT SEQ_CONTACTE_CORREU.NEXTVAL AS ID, 
                           cc.correu AS CORREU_ELECTRONIC, 
                           cc.principal AS ES_PRINCIPAL, 
                           sysdate AS DATA_CREACIO, 
                           'MIGRACIO' AS USUARI_CREACIO, 
                           cc.id_contacte AS Contacte_Id
                     FROM Z_B101_CORREUS_PRINCIPALS cc
                     WHERE NOT EXISTS(SELECT 1 
                                      FROM CONTACTE_CORREU 
                                      WHERE Contacte_Id = cc.id_contacte
                                        AND CORREU_ELECTRONIC = CC.CORREU);
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN DANI_TB_CORREUS_PRINCIPALS
        
    END;  
    
    ----------------------------------------------------------------------
    -- TELEFONS
    ----------------------------------------------------------------------
    
    PROCEDURE B110_TELEFONS_NUMERICS is 
        BEGIN           
            
             INSERT INTO Z_B110_TELEFONS_NUMERICS (ID_CONTACTE, N_VIP, TIPUS_TELEFON, TELEFON)
               SELECT NUEVOS.ID_CONTACTE, 
                	   NUEVOS.N_VIP, 
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON
                FROM (	   
                         SELECT DISTINCT ID_CONTACTE,
                                N_VIP,
                                (CASE WHEN SUBSTR(TRIM(TELEFON1),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFON1,' ','')))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix 
                                END) AS TIPUS_TELEFON,
                                REPLACE(REPLACE(REPLACE(TRIM(TELEFON1),'-',''),' ',''),'.','') AS TELEFON
                         FROM Z_B03_CONTACTES_ID C
                         WHERE TRIM(TELEFON1) IS NOT NULL 
                           AND LENGTH(TRIM(TRANSLATE(TELEFON1, ' +-.,/0123456789', ' '))) IS NULL 
                           AND TRIM(TELEFON1) <> '.' 
                           AND REPLACE(REPLACE(REPLACE(TRIM(TELEFON1),'-',''),' ',''),'.','') IS NOT NULL 
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
                              (CASE WHEN SUBSTR(TRIM(TELEFON2),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON2,'.',''),' ','')))= 9 THEN 
                                   ConstTelefonMobil
                              ELSE 
                                   ConstTelefonFix 
                              END) AS TIPUS_TELEFON,
                              REPLACE(REPLACE(REPLACE(TRIM(TELEFON2),'-',''),' ',''),'.','')  AS TELEFON
                       FROM Z_B03_CONTACTES_ID C
                       WHERE TRIM(TELEFON2) IS NOT NULL 
                         AND LENGTH(TRIM(TRANSLATE(TELEFON2, ' +-.,/0123456789', ' '))) IS NULL 
                         AND TRIM(TELEFON2) <> '.'
                         AND REPLACE(REPLACE(REPLACE(TRIM(TELEFON2),'-',''),' ',''),'.','') IS NOT NULL 
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
                                  (CASE WHEN SUBSTR(TRIM(TELEFON_MOBIL),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON_MOBIL,'.',''),' ','')))= 9 THEN 
                                        ConstTelefonMobil
                                   ELSE 
                                        ConstTelefonFix
                                   END) AS TIPUS_TELEFON,
                                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON_MOBIL),'-',''),' ',''),'.','') AS TELEFON
                            FROM Z_B03_CONTACTES_ID C
                            WHERE TRIM(TELEFON_MOBIL) IS NOT NULL 
                              AND LENGTH(TRIM(TRANSLATE(TELEFON_MOBIL, ' +-.,/0123456789', ' '))) IS NULL 
                              AND TRIM(TELEFON_MOBIL) <> '.'
                              AND REPLACE(REPLACE(REPLACE(TRIM(TELEFON_MOBIL),'-',''),' ',''),'.','') IS NOT NULL 
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
                                    REPLACE(REPLACE(REPLACE(TRIM(FAX),'-',''),' ',''),'.','')  AS TELEFON
                             FROM Z_B03_CONTACTES_ID C
                             WHERE TRIM(FAX) IS NOT NULL 
                               AND LENGTH(TRIM(TRANSLATE(FAX, ' +-.,/0123456789', ' '))) IS NULL 
                               AND TRIM(FAX) <> '.'
                               AND REPLACE(REPLACE(REPLACE(TRIM(FAX),'-',''),' ',''),'.','') IS NOT NULL 
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
                                   REPLACE(REPLACE(REPLACE(TRIM(B4.TELEFON_P),'-',''),' ',''),'.','') AS TELEFON
                           FROM Z_B03_CONTACTES_ID B3,
                                Z_B04_CONTACTES_PART_ID B4                           
                           WHERE TRIM(B4.TELEFON_P) IS NOT NULL 
                             AND B3.ID_CONTACTE = B4.ID_CONTACTE
                             AND LENGTH(TRIM(TRANSLATE(B4.TELEFON_P, ' +-.,/0123456789', ' '))) IS NULL 
                             AND TRIM(B4.TELEFON_P) <> '.'
                             AND REPLACE(REPLACE(REPLACE(TRIM(B4.TELEFON_P),'-',''),' ',''),'.','') IS NOT NULL 
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
                                     );    
           COMMIT;

      END;
    
    ----------------------------------------------------------------------
    -- clasificaciones
    ----------------------------------------------------------------------
    
    PROCEDURE B120_CLASSIFICACIO IS      
    BEGIN
          -- AFEGIR ORDRE DE PRELACIO ENTRE CLASSIFICACIONS I ASSIGNAR IDENTIFICADOR INTERN   
          INSERT INTO Z_B120_CLASSIFICACIONS 
                SELECT SEQ_DM_CLASSIFICACIO.NEXTVAL,
                       cl.CODI, 
                       cl.DESCRIPCIO, 
                       p.orden
               FROM Z_TMP_VIPS_U_CLASSIFICACIONS cl, 
                    Z_TMP_VIPS_U_PRELA_LLISTA p, 
                    TMP_CLASSIF_ACTIVES act
               WHERE cl.codi = p.classif 
                 AND cl.codi = act.codi 
                 AND NOT EXISTS (SELECT 1 
                                 FROM Z_B120_CLASSIFICACIONS 
                                 WHERE Z_B120_CLASSIFICACIONS.CODI = cl.codi
                                );
          COMMIT;    
          --OUTER METERLE FECHA DE MODIF LAS QUE NO ESTÉN. LAS QUE TENGAN ACT A NULO ---> SE PONE FECHA DE DATA_ESBORRAT Y LAS QUE EXISTAN 
          
          
          --OJO COGER DATA_ESBORRAT DE DANI_TB
          INSERT INTO DM_CLASSIFICACIO (ID,  CODI, DESCRIPCIO, PRELACIO,TIPOLOGIA_ID,AMBIT_ID, DATA_CREACIO, Usuari_Creacio)
                SELECT cl.id ,
                       cl.CODI, 
                       NVL(cl.DESCRIPCIO,'.'), cl.ORDEN, 
                       1, 
                       ConstAMBIT_PROTOCOL ,
                       SYSDATE, 
                       'MIGRACIO' 
          FROM Z_B120_CLASSIFICACIONS cl
          WHERE NOT EXISTS (SELECT 1 
                            FROM DM_CLASSIFICACIO 
                            WHERE CODI = cl.codi
                           );
          COMMIT;          
    
    END;
    
            
    -- CRUZAR CON CLASIFICACIONES ACTIVAS
    
    PROCEDURE B121_CLASSIF_CONTACTE IS
    
    BEGIN
    
      INSERT INTO Z_B121_CLASSIF_CONTACTE
              SELECT ID_CONTACTE, 
                     CLASSIF, 
                     N_PRELACIO, 
                     CL.ID AS ID_CLASSIFICACIO, 
                     NVL(USU_ALTA,'NO_INFO'), 
                     NVL(DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')), 
                     USU_MODI, 
                     DATA_MODI 
              FROM Z_B03_CONTACTES_ID C, 
                   DM_CLASSIFICACIO CL
              WHERE CLASSIF <> 'GENER' 
                AND CL.CODI = C.CLASSIF             
                AND EXISTS (SELECT * 
                            FROM SUBJECTE s 
                            WHERE s.ID = N_VIP
                           )  

                AND NOT EXISTS(SELECT 1   
                                 FROM Z_B121_CLASSIF_CONTACTE cc 
                                 WHERE cc.id_contacte = c.id_contacte 
                                   AND cc.classif = c.CLASSIF 
                              );    
              COMMIT;
      
      INSERT INTO CONTACTE_CLASSIFICACIO (ID, PRELACIO, CLASSIFICACIO_ID, CONTACTE_ID, DATA_CREACIO, USUARI_CREACIO , USUARI_MODIFICACIO, DATA_MODIFICACIO)
              SELECT SEQ_CONTACTE_CLASSIFICACIO.NEXTVAL, 
                     NUEVOS.n_prelacio, 
                     NUEVOS.id_classificacio, 
                     NUEVOS.id_contacte, 
                     NUEVOS.data_alta,
                     NUEVOS.usu_alta, 
                     NUEVOS.usu_modi, 
                     NUEVOS.data_modi  
              FROM Z_B121_CLASSIF_CONTACTE NUEVOS
              WHERE NOT EXISTS(SELECT 1 
                             FROM CONTACTE_CLASSIFICACIO ANTIGUOS 
                            WHERE ANTIGUOS.contacte_id = NUEVOS.id_contacte
                             AND  ANTIGUOS.classificacio_ID = NUEVOS.id_classificacio
                          );
      COMMIT;
      
    END;
        
    
    
        PROCEDURE B130_ACOMPANYANTS IS 
        BEGIN
               INSERT INTO Z_B130_ACOMPANYANTS                                                                           
                       SELECT N_VIP, 
                              TRACTAMENT_A, 
                              NOM_A, 
                             (CASE WHEN(length(COGNOMS_A) - length(replace(COGNOMS_A, ' ', '')) + 1) = 2 THEN 
                                        trim(SUBSTR(COGNOMS_A,1,INSTR(COGNOMS_A,' ')-1))
                                   WHEN trim(SUBSTR(COGNOMS_A,1, INSTR(LOWER(COGNOMS_A),' i ')-1)) IS NULL THEN 
                                        COGNOMS_A 
                              ELSE  
                                  trim(SUBSTR(COGNOMS_A,1, INSTR(LOWER(COGNOMS_A),' i ')-1))
                              END)  AS COGNOM_A_1, 
                             (CASE WHEN trim(SUBSTR(COGNOMS_A,1, INSTR(LOWER(COGNOMS_A),' i ')-1)) IS NOT NULL THEN 
                                       trim(SUBSTR(COGNOMS_A,INSTR(LOWER(COGNOMS_A),' i ')))
                                    WHEN (length(COGNOMS_A) - length(replace(COGNOMS_A, ' ', '')) + 1) = 2 THEN  
                                     trim(SUBSTR(COGNOMS_A, INSTR(COGNOMS_A,' ')))
                              ELSE 
                                  NULL 
                              END) AS COGNOM_A_2,
                              VIPS.Data_Alta,
                              VIPS.Data_Modif,
                              VIPS.DATA_BAIXA,
                              VIPS.Usu_Alta,
                              VIPS.Usu_Modif
                        FROM Z_TMP_VIPS_U_VIPS VIPS
                        WHERE TRIM(NOM_A) IS NOT NULL 
                          AND TRIM(COGNOMS_A) IS NOT NULL
                          AND NOT EXISTS (SELECT 1 
                                          FROM Z_B130_ACOMPANYANTS ANTIGUOS
                                          WHERE ANTIGUOS.N_VIP = N_VIP);                                                       
           COMMIT;                                                                   
           
           INSERT INTO ACOMPANYANT (ID, NOM, COGNOM1, COGNOM2, CONTACTE_ID,DATA_CREACIO, DATA_MODIFICACIO, Data_Esborrat, USUARI_CREACIO, USUARI_MODIFICACIO,TRACTAMENT_ID)
                       SELECT SEQ_ACOMPANYANT.NEXTVAL AS ID, 
                              NVL(ase.nom_a,'.'), 
                              NVL(ase.cognom_a_1,'.'), 
                              ase.cognom_a_2, 
                              B3.id_contacte, 
                              NVL(ase.data_alta,TO_DATE('01/01/1970','dd/mm/yyyy')), 
                              ase.data_modif, 
                              ase.data_baixa, 
                              NVL(ase.usu_modif,'NO_INFO'), 
                              NULL, ase.tractament_a
                        FROM Z_B130_ACOMPANYANTS ase, 
                             Z_B03_CONTACTES_ID B3
                        WHERE ase.n_vip = B3.n_vip 
                          AND EXISTS (SELECT * 
                		 		      FROM SUBJECTE s 
                			       	  WHERE s.ID = B3.N_VIP
                                     )  

                          AND NOT EXISTS (SELECT 1 
                                          FROM ACOMPANYANT ANTIGUOS 
                                          WHERE ANTIGUOS.contacte_ID = B3.id_contacte
                                         );
           COMMIT;
                   
          END;  
   
    
    
    
        
    
    -- CREACION DE CATALOGO DE CÀRRECS
    
       
    
    
       
     
 

     
     
    PROCEDURE BORRAR_TODOS_DATOS IS
    BEGIN
    
    
  		 DELETE FROM ACOMPANYANT; 
		 DELETE FROM Z_B130_ACOMPANYANTS;

    
         DELETE FROM CONTACTE_CLASSIFICACIO;
         DELETE FROM DM_CLASSIFICACIO;
         DELETE FROM Z_B121_CLASSIF_CONTACTE;
         DELETE FROM Z_B120_CLASSIFICACIONS;
         
         DELETE FROM Z_B111_TEL_PRINCIPALS;
         DELETE FROM Z_B110_TELEFONS_NUMERICS;   

	     DELETE FROM CONTACTE_TELEFON;
    
    	 DELETE FROM CONTACTE_CORREU;
		 DELETE FROM Z_B101_CORREUS_PRINCIPALS;
	     DELETE FROM Z_B100_CORREUS_CONTACTES;
    
         DELETE FROM CONTACTE;
         DELETE FROM Z_B92_TIPUS_CONTACTES;
         DELETE FROM Z_B91_DATA_ACT_CONTACTE;
         DELETE FROM Z_B90_CONTACTES_PRINCIPALS;
    
         DELETE FROM ADRECA;
         DELETE FROM Z_B80_ADRECA_CONTACTE;
    
         DELETE FROM SUBJECTE;    
         DELETE FROM Z_B71_SUBJECTES_AMB_PRIORITAT;
         DELETE FROM Z_B70_SUBJECTES_DIFUNTS;
    
         DELETE FROM DM_ENTITAT;
         DELETE FROM Z_B62_ENTITATS_CONTACTES;    
         DELETE FROM Z_B61_ENTITAT_NORMALIZADA;  
         DELETE FROM Z_B60_ENTITAT;
         
         DELETE FROM DM_CARREC;
         DELETE FROM Z_B51_CARRECS_CONTACTES;
		 DELETE FROM Z_B50_CARRECS;
         
--	     DELETE FROM DM_TRACTAMENT;
		 DELETE FROM Z_B30_TRACTAMENT;
		 
         DELETE FROM Z_B05_CONTACTES_SIN_GENER;
         DELETE FROM Z_B04_CONTACTES_PART_ID;
         DELETE FROM Z_B03_CONTACTES_ID;
         DELETE FROM Z_B02_DIF_CONT_PART_VIPS;   
         DELETE FROM Z_B01_DIF_CONT_VIPS;
    
    
    COMMIT;
    END;
    
    
    
     PROCEDURE RESETEATOR_SECUENCIAS IS         
            TYPE V_Sequence IS VARRAY(11) OF VARCHAR2(100);
            Secuencia V_Sequence;
            total 						integer;  
    
    BEGIN
    
            
        Secuencia := V_Sequence('SEQ_CONTACTE',
                                'SEQ_CONTACTE_CORREU',
                                'SEQ_ACOMPANYANT',
                                'SEQ_DM_TRACTAMENT',
                                'SEQ_CONTACTE_TELEFON',
                                'SEQ_DM_CARREC',
                                'SEQ_DM_ENTITAT',
                                'SEQ_ADRECA',
                                'SEQ_DM_CLASSIFICACIO',
                                'SEQ_CONTACTE_CLASSIFICACIO');
        
                     
                
        total := Secuencia.count; 


        
        FOR i in 1 .. total LOOP
                DBMS_OUTPUT.PUT_LINE('jjsjsjsjs');
                execute immediate 'DROP SEQUENCE ' || Secuencia(i);  
                DBMS_OUTPUT.PUT_LINE('jjsjsjsjs1');
                execute immediate 'CREATE SEQUENCE ' || Secuencia(i) || ' MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE';            
        DBMS_OUTPUT.PUT_LINE('jjsjsjsjs2');
  
        END LOOP;
    
     /*
     DROP SEQUENCE SEQ_CONTACTE;
CREATE SEQUENCE SEQ_CONTACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_CONTACTE_CORREU;
CREATE SEQUENCE SEQ_CONTACTE_CORREU MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;


DROP SEQUENCE SEQ_ACOMPANYANT;
CREATE SEQUENCE SEQ_ACOMPANYANT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_TRACTAMENT;
CREATE SEQUENCE SEQ_DM_TRACTAMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE  SEQ_CONTACTE_TELEFON;
CREATE SEQUENCE SEQ_CONTACTE_TELEFON MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_CARREC;
CREATE SEQUENCE SEQ_DM_CARREC MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_ENTITAT;
CREATE SEQUENCE SEQ_DM_ENTITAT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_ADRECA;
CREATE SEQUENCE SEQ_ADRECA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_CLASSIFICACIO;
CREATE SEQUENCE SEQ_DM_CLASSIFICACIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_CONTACTE_CLASSIFICACIO;
CREATE SEQUENCE SEQ_CONTACTE_CLASSIFICACIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;
*/
    
    
    END;
 
 /*
    PROCEDURE NYAPA_CLASSIFICACIONS IS      
    BEGIN
      
      INSERT INTO DM_CLASSIFICACIO (ID,DESCRIPCIO,CODI,PRELACIO,DATA_CREACIO,USUARI_CREACIO, TIPOLOGIA_ID, AMBIT_ID) VALUES (99999, '1905 - GENERIC - Classificació genèrica', 'GENER',99,SYSDATE,'MIGRACIO',1,2);         
    
      INSERT INTO CONTACTE_CLASSIFICACIO (ID, PRELACIO, CLASSIFICACIO_ID, CONTACTE_ID, DATA_CREACIO, USUARI_CREACIO)
                SELECT SEQ_CONTACTE_CLASSIFICACIO.NEXTVAL, 
                       99, 
                       (SELECT ID FROM DM_CLASSIFICACIO WHERE CODI = 'GENER'), 
                       co.id, 
                       SYSDATE, 
                       'MIGRACIO'
                FROM CONTACTE_CLASSIFICACIO cc, 
                     CONTACTE co
                WHERE co.id = cc.contacte_id (+) 
                  AND cc.id IS NULL;
   COMMIT;    
   END;
*/
END ZZ_FINAL;

/
