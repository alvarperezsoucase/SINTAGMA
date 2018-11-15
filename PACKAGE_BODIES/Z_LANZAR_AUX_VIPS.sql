--------------------------------------------------------
--  DDL for Package Body Z_LANZAR_AUX_VIPS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."Z_LANZAR_AUX_VIPS" AS

   -- CONTACTOS CON CLASIFICACIONES ACTIVAS
    PROCEDURE B01_CONTACTOS_ACTIVOS IS
    BEGIN              
        INSERT INTO Z_B001_CONTACTOS_ACTIVOS (ID_CONTACTE, N_VIP, CARREC, ENTITAT, ADRECA, MUNICIPI)
        SELECT AUX_SEQ_CONTACTE_VIPS.NEXTVAL AS ID_CONTACTE, 
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
                              FROM Z_B001_CONTACTOS_ACTIVOS NUEVOS
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
                            TRIM(REPLACE(FUNC_NORMALITZAR(ADRECA),'.','')) AS ADRECA, 
                            TRIM(REPLACE(MUNICIPI,'.','')) AS MUNICIPI, 
                            TRIM(REPLACE(CP,'.','')) AS CP, 
                            TRIM(REPLACE(PROVINCIA,'.','')) AS PROVINCIA
                    FROM Z_TMP_VIPS_U_CLASSIF_VIP , DANI_TB_CLASSIF_ACTIVES act
                    WHERE CLASSIF = act.codi
                    GROUP BY N_VIP, 
                             TRIM(CARREC), 
                             TRIM(ENTITAT), 
                             TRIM(REPLACE(FUNC_NORMALITZAR(ADRECA),'.','')), 
                             TRIM(REPLACE(MUNICIPI,'.','')), 
                             TRIM(REPLACE(CP,'.','')), 
                             TRIM(REPLACE(PROVINCIA,'.',''))
                ) T;
            */
        COMMIT;
    END;
    
   -- SUJETOS RELACIONADOS CON CONTACTOS.
    PROCEDURE B02_CONTACTOS_VIPS IS
    BEGIN
      
       INSERT INTO Z_B002_CONTACTOS_VIPS (ID_CONTACTE, N_VIP, ADRECA_P, MUNICIPI_P, TELEFON_P)      
        SELECT AUX_SEQ_CONTACTE_VIPS.NEXTVAL AS ID_CONTACTE, 
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
                                 FROM Z_B001_CONTACTOS_ACTIVOS DIF 
                                 WHERE TRIM(REPLACE(FUNC_NORMALITZAR(T.Adreca_p),'.',''))= DIF.ADRECA 
                                   AND TRIM(REPLACE(T.municipi_p,'.','')) = DIF.municipi 
                                   AND TRIM(T.N_VIP) = DIF.N_VIP 
                                )
                GROUP BY N_VIP, (ADRECA_P), MUNICIPI_P, TELEFON_P
              ) T
         WHERE NOT EXISTS (SELECT 1 
                              FROM Z_B002_CONTACTOS_VIPS NUEVOS
                              WHERE NUEVOS.N_VIP = T.N_VIP
                                AND NVL(NUEVOS.ADRECA_P,'NULL') = NVL(T.ADRECA_P,'NULL')
                                AND NVL(NUEVOS.MUNICIPI_P,'NULL') = NVL(T.MUNICIPI_P,'NULL')
                                AND NVL(NUEVOS.TELEFON_P,'NULL') = NVL(T.TELEFON_P,'NULL')
                              );
      
       /* ANULADO 26/07/2018. Se quita cp y provincia
        -- SOLO TENER EN CUENTA LOS QUE TENGAN DATOS INFORMADOS      
        INSERT INTO Z_B02_DIF_CONT_PART_VIPS (ID_CONTACTE,	N_VIP,	ADRECA_P,	MUNICIPI_P,	PROVINCIA_P, CP_P,	TELEFON_P)      
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
                                 FROM Z_B01_DIF_CONT_VIPS DIF 
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
    
    
    PROCEDURE B03_CONTACTES_ID IS
    BEGIN
             
            INSERT INTO Z_B003_CONTACTES_ID --DADES_DIF_IDCONT_CLASS_VIPS
                SELECT DIF.Id_Contacte,
                       CV.* 
                FROM Z_B001_CONTACTOS_ACTIVOS DIF, 
                     Z_TMP_VIPS_U_CLASSIF_VIP CV                     
                WHERE DIF.CARREC = NVL(TRIM(CV.CARREC),'NULL') 
                  AND DIF.ENTITAT = NVL(TRIM(CV.ENTITAT),'NULL')  
                  AND DIF.ADRECA = NVL(TRIM(FUNC_NORMALITZAR(CV.ADRECA)),'NULL')  
                  AND DIF.MUNICIPI = NVL(TRIM(CV.MUNICIPI),'NULL')  
                  AND DIF.N_VIP = CV.N_VIP                 
                  AND NOT exists (SELECT 1 
                                    FROM Z_B003_CONTACTES_ID nuevos
                                    WHERE nuevos.Id_Contacte = DIF.Id_Contacte);

    
      COMMIT;
    
    END;  
    
        /* REVISAR */
    PROCEDURE B04_SUBJECTES_ID IS
    BEGIN
             
    INSERT INTO Z_B004_SUBJECTES_ID --DADES_IDCONTACTES_CLASS_VIPS
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
      FROM Z_B002_CONTACTOS_VIPS DIF, 
           Z_TMP_VIPS_U_VIPS VIPS
      WHERE DIF.N_VIP = VIPS.N_VIP
        AND DIF.ADRECA_P = NVL(VIPS.ADRECA_P,'NULL')  
        AND DIF.MUNICIPI_P = NVL(VIPS.MUNICIPI_P,'NULL')  
        AND DIF.TELEFON_P =  NVL(VIPS.TELEFON_P,'NULL') 
        AND NOT EXISTS (SELECT 1
                        FROM Z_B004_SUBJECTES_ID NUEVOS
                        WHERE NUEVOS.Id_Contacte = DIF.Id_Contacte);
      
      COMMIT;
    
    END;  
      
   
   PROCEDURE B05_CONTACTES_SIN_GENER IS
   BEGIN
   
           INSERT INTO Z_B005_CONTACTES_SIN_GENER
            SELECT CONTACTES_TODOS.*
            FROM Z_B003_CONTACTES_ID CONTACTES_TODOS
                 LEFT OUTER JOIN 
                    (SELECT * 
					 FROM Z_B003_CONTACTES_ID
					 WHERE CLASSIF='GENER'                   
                     ) CONTACTES_SIN_GENER
                 ON   CONTACTES_TODOS.ID_CONTACTE = CONTACTES_SIN_GENER.ID_CONTACTE 
            WHERE CONTACTES_SIN_GENER.ID_CONTACTE IS NULL
             AND NOT EXISTS ( SELECT 1 
                                FROM Z_B005_CONTACTES_SIN_GENER ANTIGUOS                                
                               WHERE  ID_CONTACTE = ANTIGUOS.ID_CONTACTE
                             );
   
   
    
   COMMIT;
   END;
          
  
          
          
   PROCEDURE B30_TRACTAMENTS IS 
            
            max_seq number;
             
            BEGIN
            
            INSERT INTO Z_B030_TRACTAMENT (ID, CODI, DESCRIPCIO, ABREUJADA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_BAIXA)                                                                       
                        SELECT t.CODI, 
                               t.CODI, 
                               NVL(t.descripcio,t.codi) AS DESCRIPCIO, 
                               t.abreujada, 
                               FUNC_FECHA_1970(NULL) AS DATA_CREACIO, 
                               NULL AS DATA_MODIFICACIO, 
                               NULL AS DATA_ESBORRAT, 
                               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                               NULL AS USUARI_MODIFICACIO, 
                               NULL AS USUARI_BAIXA 
                        FROM Z_TMP_VIPS_U_TRACTAMENTS t
                        WHERE LENGTH(FUNC_NORMALITZAR_NUMERICS(t.CODI)) IS NULL 
                          AND NOT EXISTS (SELECT * 
                                          FROM Z_B030_TRACTAMENT 
                                          WHERE CODI=t.CODI); 
            
                SELECT MAX(ID) INTO max_seq
                FROM Z_B030_TRACTAMENT;
            
                max_seq := max_seq +1;
            
            SET_SEQ('AUX_SEQ_DM_TRACTAMENT_VIPS',max_seq);
            
            INSERT INTO Z_B030_TRACTAMENT (ID, CODI, DESCRIPCIO, ABREUJADA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_BAIXA)                                                                      
                         SELECT AUX_SEQ_DM_TRACTAMENT_VIPS.NEXTVAL, 
                                t.CODI, 
                                NVL(t.descripcio,t.codi), 
                                t.abreujada, 
                                FUNC_FECHA_1970(NULL), 
                                NULL, 
                                NULL, 
                                FUNC_USU_CREACIO(NULL), 
                                NULL, 
                                NULL 
                         FROM Z_TMP_VIPS_U_TRACTAMENTS t
                         WHERE LENGTH(LENGTH(FUNC_NORMALITZAR_NUMERICS(t.CODI))) IS NOT NULL
                           AND NOT EXISTS (SELECT * 
                                           FROM Z_B030_TRACTAMENT 
                                           WHERE CODI=t.CODI 
                                              OR DESCRIPCIO = t.descripcio
                                           ); 
            COMMIT;
                        
            -- BUSCAR MAPEO PARA DESCRIPCIONES IGUALES, MAPEAR AL MISMO TRACTAMENT (ejecutado cambiando valor duplicado H. Sr. 2,74 en auxiliar) 
            
            INSERT INTO A0_DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO,USUARI_CREACIO)
                        SELECT NUEVOS.id, 
                               NUEVOS.descripcio, 
                               NUEVOS.data_creacio, 
                               NUEVOS.usuari_creacio
                        FROM Z_B030_TRACTAMENT NUEVOS
                        WHERE NOT EXISTS (SELECT * 
                                          FROM A0_DM_TRACTAMENT ANTIGUOS
                                          WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO);
            COMMIT;
            
                      
          END; 
          
    
          -- CREAR ENFOQUE LIMPIANDO CLASSIFICACIONES QUE NO TENGAN PERSONAS ASSIGNADAS
           
  
        
        
    PROCEDURE B50_CARRECS IS
      
    BEGIN
    
            INSERT INTO Z_B050_CARRECS (ID_CARREC, CARREC_NORM)
                   SELECT AUX_SEQ_DM_CARREC_VIPS.NEXTVAL AS ID_CARREC, 
                          T.CARREC_NORM
                   FROM ( 
                           SELECT FUNC_NORMALITZAR(CARREC) AS CARREC_NORM
                           FROM Z_B003_CONTACTES_ID 
                           WHERE TRIM(FUNC_NORMALITZAR(CARREC)) IS NOT NULL
                           GROUP BY FUNC_NORMALITZAR(CARREC)
                        )T
                   WHERE NOT EXISTS (SELECT 1 
                                     FROM Z_B050_CARRECS ANTIGUOS 
                                     WHERE T.CARREC_NORM = ANTIGUOS.CARREC_NORM
                                    );
            COMMIT;
            
           
                
    END;    
        
    PROCEDURE B51_CARRECS_CONTACTES_REL IS      
    BEGIN
    
             INSERT INTO Z_B051_CARRECS_CONTACTES_REL (ID_CONTACTE, ID_CARREC)
                     SELECT c.ID_CONTACTE, 
                            norm.ID_CARREC
                    FROM Z_B003_CONTACTES_ID c, 
                         Z_B050_CARRECS norm
                    WHERE TRIM(FUNC_NORMALITZAR(c.CARREC)) IS NOT NULL 
                      AND FUNC_NORMALITZAR(c.CARREC) = norm.CARREC_NORM
                      AND NOT EXISTS ( SELECT 1 
                      				   FROM Z_B051_CARRECS_CONTACTES_REL ANTIGUOS
                      				   WHERE ANTIGUOS.ID_CONTACTE = c.ID_CONTACTE
                      				     AND ANTIGUOS.ID_CARREC = norm.ID_CARREC) 
                    GROUP BY c.ID_CONTACTE, norm.ID_CARREC;
                    
                    
                    

            COMMIT;
                    

            COMMIT;
        END;
    
    PROCEDURE B52_CARRECS_CONTACTES_NULL IS      
    BEGIN
        INSERT INTO Z_B052_CARRECS_CONTACTES_NULL (ID_CONTACTE, ID_CARREC)
                     SELECT Contacte.ID_CONTACTE AS ID_CONTACTE,
                            NULL AS ID_CARREC
                    FROM Z_B003_CONTACTES_ID Contacte
                    WHERE TRIM(FUNC_NORMALITZAR(Contacte.CARREC)) IS NULL                      
                      AND NOT EXISTS ( SELECT 1 
                      				   FROM Z_B052_CARRECS_CONTACTES_NULL ANTIGUOS
                      				   WHERE ANTIGUOS.ID_CONTACTE = Contacte.ID_CONTACTE
                      				  ) 
                    GROUP BY Contacte.ID_CONTACTE;
    
    COMMIT;
    END;
    
    PROCEDURE B53_CARRECS_CONTACTES IS
    BEGIN
    
        INSERT INTO Z_B053_CARRECS_CONTACTES (ID_CONTACTE,ID_CARREC)
                    SELECT ID_CONTACTE,
                           ID_CARREC
                    FROM (       
                            SELECT ID_CONTACTE, ID_CARREC
                            FROM Z_B051_CARRECS_CONTACTES_REL
                                UNION ALL
                            SELECT ID_CONTACTE, NULL
                            FROM Z_B052_CARRECS_CONTACTES_NULL
                         ) CARRECS_CONTACTES	
                    WHERE NOT EXISTS (SELECT 1 
                                      FROM Z_B053_CARRECS_CONTACTES ANTIGUOS
                                      WHERE CARRECS_CONTACTES.ID_CONTACTE =ANTIGUOS.ID_CONTACTE
                                     );
    
    COMMIT;
    END;
    
    
    PROCEDURE B55_DM_CARREC IS      
    BEGIN
                INSERT INTO A0_DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, USUARI_CREACIO)
                    SELECT norm.ID_CARREC, 
                           MAX(c.CARREC) AS DESCRIPCIO, 
                           MAX(FUNC_FECHA_1970(NULL)) AS DATA_CREACIO, 
                           MAX(FUNC_USU_CREACIO(NULL)) AS USUARI_CREACIO
                     FROM Z_B050_CARRECS norm, 
                          Z_B003_CONTACTES_ID c
                     WHERE FUNC_NORMALITZAR(c.CARREC) = norm.CARREC_NORM 
                       AND NOT EXISTS(SELECT 1 
                                        FROM A0_DM_CARREC aux 
                                       WHERE FUNC_NORMALITZAR(aux.DESCRIPCIO) = norm.CARREC_NORM
                                      )
                     GROUP BY norm.ID_CARREC;
            COMMIT;
    
    COMMIT;
    END;
    
    
    
    PROCEDURE B60_ENTITATS IS 
      
    BEGIN
      
            -- VALORS UTILTIZATS DEL CATALEG
            INSERT INTO Z_B060_ENTITAT_CATALOG (ID, CODI, ENTITAT, ENTITAT_NORM)
                 SELECT AUX_SEQ_DM_ENTITAT_VIPS.NEXTVAL, 
                        CODI, 
                        ENTITAT, 
                        ENTITAT_NORM
                   FROM (
                           SELECT  MAX(CODI) AS CODI, 
                                   MAX(NVL(ent.ENTITAT,ent.CODI)) AS ENTITAT, 
                                   FUNC_NORMALITZAR_ENTITAT(ent.ENTITAT) AS ENTITAT_NORM
                           FROM Z_TMP_VIPS_U_ENTITAT ent, 
                                Z_B003_CONTACTES_ID c
                           WHERE c.codi_entitat = ent.codi 
                             or  FUNC_NORMALITZAR_ENTITAT(c.entitat) = FUNC_NORMALITZAR_ENTITAT(ent.entitat)
                             AND TRIM(ent.ENTITAT) IS NOT NULL
                           GROUP BY FUNC_NORMALITZAR_ENTITAT(ent.ENTITAT)
                        ) T
                  WHERE NOT EXISTS (SELECT 1
                                    FROM Z_B060_ENTITAT_CATALOG 
                                    WHERE CODI = t.CODI
                                   ) ;
--                    AND
--                        NOT EXISTS (SELECT 1 
--                                    FROM A0_DM_ENTITAT 
--                                    where FUNC_NORMALITZAR_ENTITAT(t.entitat) = FUNC_NORMALITZAR_ENTITAT(DESCRIPCIO)
--                                   ); 
            COMMIT;
        END;
        
        
        
        PROCEDURE B61_ENTITATS_CODI_NULL IS 
        BEGIN
                INSERT INTO Z_B061_ENTITATS_CODI_NULL
                              SELECT AUX_SEQ_DM_ENTITAT_VIPS.NEXTVAL AS ID, 
                              
                                     aec.entitat AS ENTITAT, 
                                     aec.ENTITAT_NORM AS ENTITAT_NORM 
                              FROM  (
                                      SELECT FUNC_NORMALITZAR_ENTITAT(ENTITAT) AS ENTITAT_NORM, 
                                             MAX(ENTITAT) AS ENTITAT
                                      FROM Z_B003_CONTACTES_ID
                                      WHERE FUNC_NORMALITZAR_ENTITAT(ENTITAT) IS NOT NULL 
                                        AND CODI_ENTITAT IS NULL
                                        AND FUNC_NORMALITZAR_ENTITAT(ENTITAT) NOT IN ( SELECT FUNC_NORMALITZAR_ENTITAT(ENTITAT) 
                                                                                         FROM Z_B060_ENTITAT_CATALOG
                                                                                     ) 
                                    GROUP BY FUNC_NORMALITZAR_ENTITAT(ENTITAT)
                                  ) aec
                            WHERE NOT EXISTS(SELECT 1 
                                              FROM Z_B061_ENTITATS_CODI_NULL ANTIGUOS
                                              where ANTIGUOS.ENTITAT_NORM = aec.ENTITAT_NORM
                                             );
            COMMIT;
        
        
        COMMIT;
        END;
        

        PROCEDURE B65_DM_ENTITATS IS
        BEGIN
            INSERT INTO A0_DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                        SELECT ID, 
                               CODI, 
                               DESCRIPCIO, 
                               DATA_CREACIO, 
                               DATA_ESBORRAT, 
                               DATA_MODIFICACIO, 
                               USUARI_CREACIO, 
                               USUARI_ESBORRAT, 
                               USUARI_MODIFICACIO
                        FROM (	   
                                SELECT ID AS ID, 
                                       TO_CHAR(CODI) AS CODI, 
                                       entitat AS DESCRIPCIO, 
                                       FUNC_FECHA_1970(NULL) AS DATA_CREACIO, 
                                       NULL AS DATA_ESBORRAT,
                                       NULL AS DATA_MODIFICACIO,
                                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                       NULL AS USUARI_ESBORRAT,
                                       NULL AS USUARI_MODIFICACIO
                                FROM Z_B060_ENTITAT_CATALOG
                                    UNION ALL
                                SELECT ID AS ID, 
                                       TO_CHAR(ID) AS CODI, 
                                       entitat AS DESCRIPCIO, 
                                       FUNC_FECHA_1970(NULL) AS DATA_CREACIO, 
                                       NULL AS DATA_ESBORRAT,
                                       NULL AS DATA_MODIFICACIO,
                                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                       NULL AS USUARI_ESBORRAT,
                                       NULL AS USUARI_MODIFICACIO
                                FROM Z_B061_ENTITATS_CODI_NULL
                        ) UNION_ENTITATS
                        WHERE NOT EXISTS (SELECT 1
                                           FROM A0_DM_ENTITAT ANTIGUOS
                                          WHERE FUNC_NORMALITZAR_ENTITAT(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR_ENTITAT(UNION_ENTITATS.DESCRIPCIO)
                                         ); 
        
        
        COMMIT;
        END;
           
            
            
            
            
           
    
    
    PROCEDURE B66_ENTITATS_CONTACTES IS    
    BEGIN    
    
            INSERT INTO Z_B066_ENTITATS_CONTACTES (ID, ID_CONTACTE)
                 SELECT ent.id AS ID, 
                        c.id_contacte
                 FROM A0_DM_ENTITAT ent, 
                      Z_B003_CONTACTES_ID c
                WHERE FUNC_NORMALITZAR_ENTITAT(ent.descripcio) = FUNC_NORMALITZAR_ENTITAT(c.entitat) 
                  AND TRIM(REPLACE(REPLACE(c.entitat,'.',''),'-','')) IS NOT NULL 
                  AND  NOT EXISTS(SELECT 1 
                                  FROM Z_B066_ENTITATS_CONTACTES ec 
                                  WHERE ec.id_contacte = c.id_contacte and ec.id = ent.id)
                GROUP BY ent.id, c.id_contacte;
           
 
            COMMIT;
            
    END;
    
------------------------------------------------------------------------------    
-- SUBJECTES -----------------------------------------------------------------    
------------------------------------------------------------------------------    
    
    PROCEDURE B70_SUBJECTES_DIFUNTS IS                 
    BEGIN
   
       INSERT INTO Z_B070_SUBJECTES_DIFUNTS
            SELECT N_VIP, 
                   NVL2(DATA_ALTA,TRUNC(DATA_ALTA),TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_DEFUNCIO
            FROM Z_B003_CONTACTES_ID 
            WHERE CLASSIF = 'DEFU'
            AND NOT EXISTS (SELECT 1
                            FROM Z_B070_SUBJECTES_DIFUNTS ANTIGUOS
                            WHERE ANTIGUOS.N_VIP = N_VIP);
            
       COMMIT;
    END;
    
    
    PROCEDURE B71_SUBJECTES_AMB_PRIORITAT IS
      
    BEGIN
           INSERT INTO Z_B071_SUBJECTES_AMB_PRIORITAT    (N_VIP, PRIORITAT)
                SELECT N_VIP, 
                       REPLACE(TRIM(FAX), '91-SC','1-SC') AS PRIORITAT
                FROM Z_B003_CONTACTES_ID 
                WHERE TRIM(FAX) IN ('1-SC','91-SC')        
                  AND NOT EXISTS(SELECT 1
                            FROM Z_B071_SUBJECTES_AMB_PRIORITAT ANTIGUOS
                            WHERE ANTIGUOS.N_VIP = N_VIP)
                GROUP BY N_VIP, REPLACE(TRIM(FAX),'91-SC','1-SC') ;
                
           COMMIT;
    END;
    
    
    PROCEDURE B72_SUBJECTES_VIPS IS
    BEGIN
    
                INSERT INTO Z_B072_SUBJECTES_VIPS (ID, NOM,COGNOM1,COGNOM2,ALIES,NOM_NORMALITZAT, DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT,	TRACTAMENT_ID,	PRIORITAT_ID,	TIPUS_SUBJECTE_ID,	AMBIT_ID,	IDIOMA_ID)
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
                               MAX(IDIOMA_ID) AS IDIOMA_ID
                  FROM (
                          SELECT  Subjecte.N_VIP AS ID,
                                  NVL(Subjecte.NOM,'.') AS NOM,
                                  Subjecte.COGNOM1 AS COGNOM1,
                                  Subjecte.COGNOM2 AS COGNOM2,
                                  Subjecte.ALIES_VIPS AS ALIES,
                                  FUNC_NORMALITZAR(Subjecte.NOM||Subjecte.COGNOM1||Subjecte.COGNOM2) as NOM_NORMALITZAT,
                                  SubjecteDifunto.DATA_DEFUNCIO AS DATA_DEFUNCIO,
                                  NULL AS MOTIU_BAIXA,
                                  NVL2(DATA_ALTA, DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_CREACIO,                      
                                  DATA_BAIXA AS DATA_ESBORRAT,
                                  DATA_MODIF AS DATA_MODIFICACIO, 
                                  FUNC_USU_CREACIO(USU_ALTA) AS USUARI_CREACIO,   
                                  NVL2(USU_MODIF, USU_MODIF, NVL2(DATA_MODIF, 'MIGRACIO', NULL)) AS USUARI_MODIFICACIO,
                                  NVL2(DATA_BAIXA, 'MIGRACIO', NULL) AS USUARI_ESBORRAT, 
                                  (SELECT tractament.ID FROM A0_DM_TRACTAMENT tractament WHERE tractament.ID = Subjecte.Tractament) AS TRACTAMENT_ID,
                                  (SELECT prioritat.ID FROM A0_DM_PRIORITAT prioritat WHERE prioritat.DESCRIPCIO = SubjectePR.prioritat) AS PRIORITAT_ID,
                                  ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                                  ConstAMBIT_PROTOCOL AS AMBIT_ID,
                                  NULL AS IDIOMA_ID         
                          FROM Z_B004_SUBJECTES_ID Subjecte, 
                               Z_B070_SUBJECTES_DIFUNTS SubjecteDifunto, 
                               Z_B071_SUBJECTES_AMB_PRIORITAT SubjectePR
                          WHERE Subjecte.N_VIP = SubjecteDifunto.N_VIP (+) 
                            AND Subjecte.n_Vip = SubjectePR.N_VIP (+)
                            AND NOT EXISTS (SELECT 1 
                                            FROM A0_SUBJECTE ANTIGUOS
                                            WHERE ANTIGUOS.ID = Subjecte.N_VIP)
                       ) T
                  GROUP BY ID;
                  COMMIT;
    
    COMMIT;
    END;
    
    PROCEDURE B73_SUBJECTE_CONTACTE IS
    BEGIN
    
    INSERT INTO Z_B073_SUBJECTE_CONTACTE (ID, NOM,COGNOM1,COGNOM2,ALIES,NOM_NORMALITZAT,DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TRACTAMENT_ID,	PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID)
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
                       MAX(IDIOMA_ID) AS IDIOMA_ID
                FROM (
                          SELECT  Contactes.N_VIP AS ID,
                                  NVL(VIPS.NOM,'.') AS NOM,
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
                                  NULL AS MOTIU_BAIXA,
                                  NVL2(Contactes.DATA_ALTA, Contactes.DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA,
                                  DATA_MODI AS DATA_MODIFICACIO, 
                                  VIPS.Data_Baixa AS DATA_BAIXA,
                                  FUNC_USU_CREACIO(Contactes.USU_ALTA) AS USUARI_CREACIO,   
                                  NVL2(Contactes.USU_MODI, Contactes.USU_MODI, NVL2(Contactes.DATA_MODI, 'MIGRACIO', NULL)) AS USUARI_MODIFICACIO,
                                  NVL2(VIPS.Data_Baixa,'MIGRACIO',NULL) AS USUARI_ESBORRAT, 
                                  (SELECT Tractament.ID FROM A0_DM_TRACTAMENT Tractament WHERE Tractament.ID = VIPS.TRACTAMENT ) AS TRACTAMENT_ID, 
                                  (SELECT Prioritat.ID FROM A0_DM_PRIORITAT Prioritat WHERE Prioritat.DESCRIPCIO = SubjectePR.prioritat) AS PRIORITAT_ID,
                                  ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                                  ConstAMBIT_PROTOCOL AS AMBIT_ID,
                                  NULL AS IDIOMA_ID 
                          FROM Z_B003_CONTACTES_ID Contactes, 
                               Z_B070_SUBJECTES_DIFUNTS SubjecteDifunt, 
                               Z_B071_SUBJECTES_AMB_PRIORITAT SubjectePR, 
                               Z_TMP_VIPS_U_VIPS VIPS
                          WHERE Contactes.N_VIP = SubjecteDifunt.N_VIP (+) 
                            AND Contactes.N_VIP = VIPS.N_VIP 
                            AND Contactes.n_Vip = SubjectePR.N_VIP
                   ) SUBJECTES_CONTACTES
              WHERE NOT EXISTS (SELECT 1 
                                FROM A0_SUBJECTE ANTIGUOS 
                                WHERE ANTIGUOS.ID = SUBJECTES_CONTACTES.ID) 
              GROUP BY ID;
    
    COMMIT;
    END;
    
    
        
    PROCEDURE B78_SUBJECTES is                 
    BEGIN

      INSERT INTO A0_SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
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
                        NULL AS IDIOMA_ID,
                        ID AS ID_ORIGINAL,
                        'VIPS_U' AS ESQUEMA_ORIGINAL,
                        'VIPS' AS TABLA_ORIGINAL
                FROM Z_B072_SUBJECTES_VIPS NUEVOS
                WHERE NOT EXISTS (SELECT 1
                                   FROM A0_SUBJECTE ANTIGUOS
                                  WHERE  ANTIGUOS.ID = NUEVOS.ID
                                 );
       COMMIT;                                 
                
                
        INSERT INTO A0_SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
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
                        NULL AS IDIOMA_ID,
                        ID AS ID_ORIGINAL,
                        'VIPS_U' AS ESQUEMA_ORIGINAL,
                        'VIPS' AS TABLA_ORIGINAL
                FROM Z_B073_SUBJECTE_CONTACTE NUEVOS
                WHERE NOT EXISTS (SELECT 1
                                   FROM A0_SUBJECTE ANTIGUOS
                                  WHERE  ANTIGUOS.ID = NUEVOS.ID
                                 );     
    COMMIT;    
    END;
    
    -----------------------------------------------------------------------------------
    -- ADRECA ----------------------------------------------------------------------
    -----------------------------------------------------------------------------------        
     
      PROCEDURE B80_ADRECA_CONTACTE IS      
      BEGIN
              INSERT INTO Z_B080_ADRECA_CONTACTE (ID_ADRECA,ID_CONTACTE,ADRECA,MUNICIPI,CP,PROVINCIA,PAIS,USU_ALTA,DATA_ALTA,USU_MODI,DATA_MODI)
                    SELECT AUX_SEQ_ADRECA_VIPS.NEXTVAL AS ID_ADRECA, 
                           ID_CONTACTE AS ID_CONTACTE, 
                           ADRECA AS ADRECA, 
                           MUNICIPI AS MUNICIPI, 
                           CP AS CP, 
                           PROVINCIA AS PROVINCIA, 
                           PAIS AS PAIS, 
                           USU_ALTA AS USU_ALTA,
                           DATA_ALTA AS DATA_ALTA, 
                           USU_MODI AS USU_MODI, 
                           DATA_MODI AS DATA_MODI
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
                           FROM Z_B003_CONTACTES_ID Contactes, 
                                (SELECT ID_CONTACTE, 
                                        REPLACE(REPLACE(PAIS,'(',''),')','') AS PAIS
                                   FROM Z_B003_CONTACTES_ID
                                  WHERE LENGTH(FUNC_NORMALITZAR_NUMERICS(PAIS)) IS NOT NULL 
                                    AND LENGTH(FUNC_NORMALITZAR_NUMERICS(SUBSTR(PAIS,1,1))) IS NOT NULL 
                                    AND PAIS NOT IN ('PP','CIU') AND SUBSTR(PAIS,1,3) <> 'AUT'
                                )T
                           WHERE Contactes.ID_CONTACTE = T.ID_CONTACTE (+)
                           GROUP BY Contactes.ID_CONTACTE
                        ) a
                    WHERE NOT EXISTS (SELECT 1
                        			  FROM Z_B080_ADRECA_CONTACTE ANTIGUOS
              						  WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
    COMMIT;
    END;
    
    PROCEDURE B81_ADRECA_SUBJECTE IS     
    BEGIN
              -- CREAR PARA PARTICULARES B4 (CON DATOS DE DIRECCION INFORMADO)
              INSERT INTO Z_B081_ADRECA_SUBJECTE (ID_ADRECA,ID_CONTACTE,ADRECA,MUNICIPI,CP,PROVINCIA,PAIS,USU_ALTA,DATA_ALTA,USU_MODIF,DATA_MODIF)
                    SELECT AUX_SEQ_ADRECA_VIPS.NEXTVAL AS ID_ADRECA, 
                           Subjecte.ID_CONTACTE, 
                           Subjecte.ADRECA_P AS ADRECA, 
                           Subjecte.MUNICIPI_P AS MUNICIPI, 
                           Subjecte.CP_P AS CP , 
                           Subjecte.PROVINCIA_P AS PROVINCIA, 
                           Subjecte.PAIS_P AS PAIS, 
                           FUNC_USU_CREACIO(Subjecte.USU_ALTA) AS USU_ALTA, 
                           FUNC_FECHA_1970(Subjecte.DATA_ALTA) AS DATA_ALTA, 
                           Subjecte.USU_MODIF, 
                           Subjecte.DATA_MODIF
                  FROM Z_B004_SUBJECTES_ID Subjecte
                 WHERE (TRIM(Subjecte.ADRECA_P) IS NOT NULL 
                    OR TRIM(Subjecte.MUNICIPI_P) IS NOT NULL 
                    OR TRIM(Subjecte.PROVINCIA_P) IS NOT NULL 
                    OR TRIM(Subjecte.PAIS_P) IS NOT NULL 
                    OR TRIM(Subjecte.CP_P) IS NOT NULL)
                   AND NOT EXISTS (SELECT 1 
                   					 FROM Z_B080_ADRECA_CONTACTE ANTIGUOS 
                   					 WHERE ANTIGUOS.ID_CONTACTE = Subjecte.ID_CONTACTE
                   				  ); 
                             
     COMMIT;
     END;   
              -- FALTAN DIRECCIONES PARTICULARES
     PROCEDURE B82_DM_ADRECA IS
     BEGIN
              INSERT INTO A0_ADRECA (ID, NOM_CARRER, MUNICIPI, PROVINCIA, CODI_POSTAL, PAIS, USUARI_CREACIO, DATA_CREACIO, USUARI_MODIFICACIO,DATA_MODIFICACIO)
                 SELECT ID, NOM_CARRER, MUNICIPI, PROVINCIA, CODI_POSTAL, PAIS, USUARI_CREACIO, DATA_CREACIO, USUARI_MODIFICACIO,DATA_MODIFICACIO
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
                                    DATA_MODI AS DATA_MODIFICACIO
                              FROM Z_B080_ADRECA_CONTACTE 
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
                                    DATA_MODIF AS DATA_MODIFICACIO
                              FROM Z_B081_ADRECA_SUBJECTE
                      ) ADRECA
              WHERE NOT EXISTS (SELECT 1 
                                FROM A0_ADRECA ANTIGUOS
                                WHERE ANTIGUOS.ID =  ADRECA.ID
                               );
              
              COMMIT;
                     
    END;
        
        
    -----------------------------------------------------------------------------------
    -- CONTACTES ----------------------------------------------------------------------
    -----------------------------------------------------------------------------------    
    
    PROCEDURE B90_CONTACTES_PRINCIPALS IS
   
    BEGIN
              INSERT INTO Z_B090_CONTACTES_PRINCIPALS
                    SELECT ID_CONTACTE 
                      FROM Z_B003_CONTACTES_ID
                     WHERE CLASSIF = 'GENER'
                      AND NOT EXISTS (SELECT 1 
                                       FROM Z_B090_CONTACTES_PRINCIPALS ANTIGUOS
                                      WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
                     
              COMMIT;
              
    END;
    
    PROCEDURE B91_DATA_ACT_CONTACTE IS      
    BEGIN
    
           INSERT INTO Z_B091_DATA_ACT_CONTACTE
                SELECT ID_CONTACTE,
                       ( CASE WHEN LENGTH(PAIS) =5 AND ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(PAIS||'-2018','dd-mm-yyyy') 
                             WHEN LENGTH(PAIS) = 7 AND SUBSTR(PAIS, 3, 1) = '-' AND ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(SUBSTR(PAIS, 1,3)||'0'||SUBSTR(PAIS, 4,7), 'dd-mm-yy')
                             WHEN LENGTH(PAIS) = 7 AND ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(PAIS, 'ddmm-yy')
                            WHEN LENGTH(PAIS) = 8 AND ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 THEN 
                                    TO_DATE(PAIS, 'dd-mm-yy')
                             WHEN LENGTH(PAIS) = 10 AND ES_NUMERICO(FUNC_NORMALITZAR_SIGNES(PAIS))=1 AND SUBSTR(PAIS, 3, 1) = '-' THEN 
                                    TO_DATE(PAIS, 'dd-mm-yyyy')
                        ELSE 
                                    TO_DATE('01-01-1970','dd-mm-yyyy')
                        END) AS DATA_ACTUALITZACIO
               FROM  Z_B003_CONTACTES_ID 
              WHERE PAIS IS NOT NULL 
                AND LENGTH(FUNC_NORMALITZAR_NUMERICS(substr(PAIS,1,5))) IS NULL 
--                AND TO_NUMBER(SUBSTR(PAIS,1,1)) IN (0,1,2,3) AND TRIM(PAIS)<>'.'
                AND TRIM(PAIS)<>'.'
                AND NOT EXISTS (SELECT 1
                                 FROM Z_B091_DATA_ACT_CONTACTE ANTIGUOS
                                WHERE ANTIGUOS.ID_CONTACTE = ID_CONTACTE);
            COMMIT;
            
    END;

    
    
    
    
    
    
    PROCEDURE B92_TIPUS_CONTACTES IS

    BEGIN   
      
            INSERT INTO Z_B092_TIPUS_CONTACTES   
                    SELECT NUEVOS.ID_CONTACTE, NUEVOS.TIPUS
                    FROM (
                            SELECT ID_CONTACTE, 
                                   MAX(ConstContactePersonal) AS TIPUS
                            FROM  Z_B004_SUBJECTES_ID part
                            GROUP BY(ID_CONTACTE)
                          UNION
                            SELECT ID_CONTACTE, 
                                   MAX(ConstContacteProfesional) AS TIPUS
                              FROM Z_B003_CONTACTES_ID t 
                          GROUP BY(ID_CONTACTE)
                         ) NUEVOS
                   WHERE NOT EXISTS (SELECT 1
                                     FROM Z_B092_TIPUS_CONTACTES ANTIGUOS
                                     WHERE NUEVOS.ID_CONTACTE =  ANTIGUOS.ID_CONTACTE 
              					       AND NUEVOS.TIPUS = ANTIGUOS.TIPUS_CONTACTE
              		                );
            
            COMMIT;

    END;
    
    
   
    
    
    PROCEDURE B93_CONTACTES_CONTACTES is             
    BEGIN

        INSERT INTO Z_B093_CONTACTES_CONTACTES (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
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
                        MAX(N_VIP) AS SUBJECTE_ID, 
                        MAX(ID_ADRECA) AS ADRECA_ID, 
                        MAX(ENTITAT_ID) AS ENTITAT_ID, 
                        MAX(VISIBILITAT_ID) AS VISIBILITAT_ID, 
                        MAX(AMBIT_ID)  AS AMBIT_ID,
                        MAX(N_VIP) AS ID_ORIGINAL, 
                        MAX('VIPS') AS ESQUEMA_ORIGINAL, 
                        MAX('VIPS_U') AS TABLA_ORIGINAL 
                FROM (
                        SELECT Contacto.ID_CONTACTE, 
                               NVL2(Contate_Principals.ID_CONTACTE, '1','0') AS PRINCIPAL, 
                               Carrecs.id_carrec, 
                               Contacto.DEPART, 
                               1 AS QUALITAT, 
                               Contacte_act.DATA_ACTUALITZACIO, 
                               NVL(Contacto.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, 
                               Contacto.DATA_MODI,
                               Subjecte.data_esborrat AS DATA_BAIXA, 
                               NVL(Contacto.USU_ALTA,'NO_INFO') AS USU_ALTA, 
                               Contacto.USU_MODI, 
                               Subjecte.usuari_esborrat AS USU_BAIXA, 
                               ConstContacteProfesional AS TIPUS_CONTACTE_ID, 
                               Contacto.N_VIP, 
                               Adreca.ID_ADRECA, 
                               Entitats.ID AS ENTITAT_ID , 
                               ConstVISIBILITAT_ALCALDIA AS VISIBILITAT_ID ,
                               ConstAMBIT_PROTOCOL AS AMBIT_ID                               
                        FROM  Z_B080_ADRECA_CONTACTE Adreca, 
                              Z_B090_CONTACTES_PRINCIPALS Contate_Principals, 
                              Z_B091_DATA_ACT_CONTACTE Contacte_act, 
                              Z_B053_CARRECS_CONTACTES Carrecs, 
                              Z_B066_ENTITATS_CONTACTES Entitats, 
                              A0_SUBJECTE Subjecte, 
                             (
                                SELECT ID_CONTACTE, 
                                       MAX(DEPART) AS DEPART, 
                                       MIN(DATA_ALTA) AS DATA_ALTA,
                                       MAX(DATA_MODI) AS DATA_MODI, 
                                       MAX(USU_ALTA) AS USU_ALTA , 
                                       MAX(USU_MODI) AS USU_MODI, 
                                       MAX(N_VIP) AS N_VIP
                                FROM Z_B003_CONTACTES_ID 
                                GROUP BY ID_CONTACTE
                            ) Contacto
                        WHERE Contacto.n_vip = Subjecte.id 
                          AND Contacto.ID_CONTACTE = Adreca.ID_CONTACTE (+) 
                          AND Contacto.ID_CONTACTE = Contate_Principals.ID_CONTACTE (+) 
                          AND Contacto.ID_CONTACTE = Contacte_act.ID_CONTACTE (+) 
                          AND Contacto.Id_Contacte = Carrecs.id_contacte (+) 
                          AND Contacto.ID_CONTACTE = Entitats.ID_CONTACTE (+)  
                          AND NOT EXISTS (SELECT 1 
                                          FROM Z_B093_CONTACTES_CONTACTES nuevos 
                                          WHERE nuevos.id = Contacto.id_contacte
                                         )
                ) T
                GROUP BY T.ID_CONTACTE;
        COMMIT;
        END;
        
        
       PROCEDURE B94_CONTACTES_SUBJECTES is             
       BEGIN 
        -- PARTICULARES QUE TENIAN DIRECCION INFORMADA
        INSERT INTO Z_B094_CONTACTES_SUBJECTES (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
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
                        MAX(N_VIP) AS SUBJECTE_ID, 
                        MAX(ID_ADRECA) AS ADRECA_ID, 
                        MAX(ENTITAT_ID) AS ENTITAT_ID, 
                        MAX(VISIBILITAT_ID) AS VISIBILITAT_ID, 
                        MAX(AMBIT_ID)  AS AMBIT_ID,
                        MAX(N_VIP) AS ID_ORIGINAL, 
                        MAX('VIPS') AS ESQUEMA_ORIGINAL, 
                        MAX('VIPS_U') AS TABLA_ORIGINAL 
          FROM (
                    SELECT Subjecte.ID_CONTACTE, 
                           NVL2(Contate_Principals.ID_CONTACTE, '1','0') AS PRINCIPAL, 
                           Carrecs.id_carrec, 
                           '' AS DEPART, 
                           1 AS QUALITAT, 
                           Contacte_act.DATA_ACTUALITZACIO, 
                           NVL(Subjecte.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, 
                           Subjecte.DATA_MODIF AS DATA_MODI, 
                           s.data_esborrat AS DATA_BAIXA, 
                           NVL(Subjecte.USU_ALTA,'NO_INFO') AS USU_ALTA, 
                           Subjecte.USU_MODIF AS USU_MODI, 
                           s.usuari_esborrat AS USU_BAIXA, 
                           ConstContactePersonal AS TIPUS_CONTACTE_ID, 
                           Subjecte.N_VIP, 
                           Adreca.ID_ADRECA, 
                           Entitats.ID AS ENTITAT_ID , 
                           ConstVISIBILITAT_ALCALDIA AS VISIBILITAT_ID  ,
                           ConstAMBIT_PROTOCOL AS AMBIT_ID
                    FROM Z_B004_SUBJECTES_ID Subjecte, 
                         Z_B080_ADRECA_CONTACTE Adreca, 
                         Z_B090_CONTACTES_PRINCIPALS Contate_Principals, 
                         Z_B091_DATA_ACT_CONTACTE Contacte_act, 
                         Z_B053_CARRECS_CONTACTES Carrecs, 
                         Z_B066_ENTITATS_CONTACTES Entitats, 
                         A0_SUBJECTE s
                    WHERE Subjecte.n_vip = s.id 
                      AND Subjecte.ID_CONTACTE = Adreca.ID_CONTACTE 
                      AND Subjecte.ID_CONTACTE = Contate_Principals.ID_CONTACTE (+) 
                      AND Subjecte.ID_CONTACTE = Contacte_act.ID_CONTACTE (+) 
                      AND Subjecte.Id_Contacte = Carrecs.id_contacte (+) 
                      AND Subjecte.ID_CONTACTE = Entitats.ID_CONTACTE (+)  
                      AND NOT EXISTS (SELECT 1 
                                        FROM Z_B094_CONTACTES_SUBJECTES nuevos 
                                       WHERE nuevos.id = Subjecte.id_contacte)
        ) T
        GROUP BY T.ID_CONTACTE;
       
        COMMIT;               
    END;
    
    PROCEDURE B95_CONTACTES IS
    BEGIN
       
       INSERT INTO A0_CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL) 
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
                FROM Z_B093_CONTACTES_CONTACTES 
                ) NUEVOS
            WHERE NOT EXISTS (SELECT 1
                                FROM A0_CONTACTE ANTIGUOS
                               WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                              ); 
               
           INSERT INTO A0_CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL) 
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
                        FROM Z_B094_CONTACTES_SUBJECTES 
                     ) NUEVOS   
                 WHERE NOT EXISTS (SELECT 1
                                     FROM A0_CONTACTE ANTIGUOS
                                    WHERE ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                                   ); 
                   
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
                			      FROM Z_B003_CONTACTES_ID 
                			      WHERE INTERNET IS NOT NULL 
                			        AND INTERNET LIKE '%@%' 
                			        AND EXISTS (SELECT * 
                			       	 		    FROM A0_SUBJECTE s 
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
         
            INSERT INTO A0_CONTACTE_CORREU(ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, Contacte_Id)
                    SELECT AUX_SEQ_CONTACTE_CORREU_VIPS.NEXTVAL AS ID, 
                           cc.correu AS CORREU_ELECTRONIC, 
                           cc.principal AS ES_PRINCIPAL, 
                           sysdate AS DATA_CREACIO, 
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO, 
                           cc.id_contacte AS Contacte_Id
                     FROM Z_B101_CORREUS_PRINCIPALS cc
                     WHERE NOT EXISTS(SELECT 1 
                                      FROM A0_CONTACTE_CORREU 
                                      WHERE Contacte_Id = cc.id_contacte
                                        AND CORREU_ELECTRONIC = CC.CORREU);
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN DANI_TB_AUX_CORREUS_PRINCIPALS
        
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
                                FUNC_NORMALITZAR_SIGNES(TELEFON1) AS TELEFON
                         FROM Z_B003_CONTACTES_ID C
                         WHERE TRIM(TELEFON1) IS NOT NULL 
                           AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFON1)) IS NULL 
                           AND TRIM(TELEFON1) <> '.' 
                           AND FUNC_NORMALITZAR_SIGNES(TELEFON1) IS NOT NULL 
         			       AND EXISTS (SELECT * 
                			       	 		    FROM A0_SUBJECTE s 
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
                       FROM Z_B003_CONTACTES_ID C
                       WHERE TRIM(TELEFON2) IS NOT NULL 
                         AND LENGTH(FUNC_NORMALITZAR_SIGNES(TELEFON2)) IS NULL 
                         AND TRIM(TELEFON2) <> '.'
                         AND FUNC_NORMALITZAR_SIGNES(TELEFON2) IS NOT NULL 
                         AND EXISTS (SELECT * 
                				     FROM A0_SUBJECTE s 
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
                            FROM Z_B003_CONTACTES_ID C
                            WHERE TRIM(TELEFON_MOBIL) IS NOT NULL 
                              AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFON_MOBIL)) IS NULL 
                              AND TRIM(TELEFON_MOBIL) <> '.'
                              AND FUNC_NORMALITZAR_SIGNES(TELEFON_MOBIL) IS NOT NULL 
                              AND EXISTS (SELECT * 
                     		 		      FROM A0_SUBJECTE s 
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
                             FROM Z_B003_CONTACTES_ID C
                             WHERE TRIM(FAX) IS NOT NULL 
                               AND LENGTH(FUNC_NORMALITZAR_NUMERICS(FAX)) IS NULL 
                               AND TRIM(FAX) <> '.'
                               AND FUNC_NORMALITZAR_SIGNES(FAX) IS NOT NULL 
                               AND EXISTS (SELECT * 
                                           FROM A0_SUBJECTE s 
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
                           FROM Z_B003_CONTACTES_ID B3,
                                Z_B004_SUBJECTES_ID B4                           
                           WHERE TRIM(B4.TELEFON_P) IS NOT NULL 
                             AND B3.ID_CONTACTE = B4.ID_CONTACTE
                             AND LENGTH(FUNC_NORMALITZAR_NUMERICS(B4.TELEFON_P)) IS NULL 
                             AND TRIM(B4.TELEFON_P) <> '.'
                             AND FUNC_NORMALITZAR_SIGNES(B4.TELEFON_P) IS NOT NULL 
                             AND EXISTS (SELECT * 
                                	     FROM A0_SUBJECTE s 
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
        
           INSERT INTO A0_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, CONTACTE_ID, TIPUS_TELEFON_ID)
                    SELECT AUX_SEQ_CONTACTE_TELEFON_VIPS.NEXTVAL AS ID, 
                           NUEVOS.telefon AS NUMERO, 
                           NUEVOS.principal AS ES_PRINCIPAL, 
                           sysdate, 
                           FUNC_USU_CREACIO(NULL), 
                           NUEVOS.id_contacte AS CONTACTE_ID, 
                           NUEVOS.tipus_telefon AS TIPUS_TELEFON_ID
                     FROM Z_B111_TEL_PRINCIPALS NUEVOS 
                     WHERE NUEVOS.TELEFON IS NOT NULL                       
                       AND NOT EXISTS(SELECT 1 
                                      FROM A0_CONTACTE_TELEFON ANTIGUOS
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
                SELECT AUX_SEQ_DM_CLASSIFICACIO_VIPS.NEXTVAL,
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
          INSERT INTO A0_DM_CLASSIFICACIO (ID,  CODI, DESCRIPCIO, PRELACIO,TIPOLOGIA_ID,AMBIT_ID, DATA_CREACIO, Usuari_Creacio)
                SELECT cl.id ,
                       cl.CODI, 
                       FUNC_NULOS(cl.DESCRIPCIO), 
                       cl.ORDEN, 
                       ConstTipologia, 
                       ConstAMBIT_PROTOCOL ,
                       SYSDATE, 
                       FUNC_USU_CREACIO(NULL)
          FROM Z_B120_CLASSIFICACIONS cl
          WHERE NOT EXISTS (SELECT 1 
                            FROM A0_DM_CLASSIFICACIO 
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
                     FUNC_USU_CREACIO(USU_ALTA), 
                     FUNC_FECHA_1970(DATA_ALTA), 
                     USU_MODI, 
                     DATA_MODI 
              FROM Z_B003_CONTACTES_ID C, 
                   A0_DM_CLASSIFICACIO CL
              WHERE CLASSIF <> 'GENER' 
                AND CL.CODI = C.CLASSIF             
                AND EXISTS (SELECT * 
                            FROM A0_SUBJECTE s 
                            WHERE s.ID = N_VIP
                           )  

                AND NOT EXISTS(SELECT 1   
                                 FROM Z_B121_CLASSIF_CONTACTE cc 
                                 WHERE cc.id_contacte = c.id_contacte 
                                   AND cc.classif = c.CLASSIF 
                              );    
              COMMIT;
      
      INSERT INTO A0_CONTACTE_CLASSIFICACIO (ID, PRELACIO, CLASSIFICACIO_ID, CONTACTE_ID, DATA_CREACIO, USUARI_CREACIO , USUARI_MODIFICACIO, DATA_MODIFICACIO)
              SELECT AUX_SEQ_CONTACTE_CLASSIF_VIPS.NEXTVAL, 
                     NUEVOS.n_prelacio, 
                     NUEVOS.id_classificacio, 
                     NUEVOS.id_contacte, 
                     NUEVOS.data_alta,
                     NUEVOS.usu_alta, 
                     NUEVOS.usu_modi, 
                     NUEVOS.data_modi  
              FROM Z_B121_CLASSIF_CONTACTE NUEVOS
              WHERE NOT EXISTS(SELECT 1 
                             FROM A0_CONTACTE_CLASSIFICACIO ANTIGUOS 
                            WHERE ANTIGUOS.contacte_id = NUEVOS.id_contacte
                             AND  ANTIGUOS.classificacio_ID = NUEVOS.id_classificacio
                          );
      COMMIT;
      
    END;
        
    
    
        PROCEDURE B130_ACOMPANYANTS_VIPS IS 
        BEGIN
               INSERT INTO Z_B130_ACOMPANYANTS_VIPS                                                                           
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
                                          FROM Z_B130_ACOMPANYANTS_VIPS ANTIGUOS
                                          WHERE ANTIGUOS.N_VIP = N_VIP);                                                       
           COMMIT;                                                                   
           
           INSERT INTO A0_ACOMPANYANT (ID, NOM, COGNOM1, COGNOM2, CONTACTE_ID,DATA_CREACIO, DATA_MODIFICACIO, Data_Esborrat, USUARI_CREACIO, USUARI_MODIFICACIO,TRACTAMENT_ID)
                       SELECT AUX_SEQ_ACOMPANYANT_VIPS.NEXTVAL AS ID, 
                              NVL(ase.nom_a,'.'), 
                              NVL(ase.cognom_a_1,'.'), 
                              ase.cognom_a_2, 
                              B3.id_contacte, 
                              FUNC_FECHA_1970(ase.data_alta), 
                              ase.data_modif, 
                              ase.data_baixa, 
                              FUNC_USU_CREACIO(ase.usu_modif), 
                              NULL, 
                              ase.tractament_a
                        FROM Z_B130_ACOMPANYANTS_VIPS ase, 
                             Z_B003_CONTACTES_ID B3
                        WHERE ase.n_vip = B3.n_vip 
                          AND EXISTS (SELECT * 
                		 		      FROM A0_SUBJECTE s 
                			       	  WHERE s.ID = B3.N_VIP
                                     )  

                          AND NOT EXISTS (SELECT 1 
                                          FROM A0_ACOMPANYANT ANTIGUOS 
                                          WHERE ANTIGUOS.contacte_ID = B3.id_contacte
                                         );
           COMMIT;
                   
          END;  
   
    
    
    
        
    
    -- CREACION DE CATALOGO DE CÀRRECS
    
       
    
    
       
     
 

     
     
    PROCEDURE RESETEATOR_TABLAS IS
    BEGIN    
    
  		 DELETE FROM A0_ACOMPANYANT; 
         
		 DELETE FROM Z_B130_ACOMPANYANTS_VIPS;
         DELETE FROM Z_B130_ACOMPANYANTS;
    
         DELETE FROM A0_CONTACTE_CLASSIFICACIO;
         DELETE FROM A0_DM_CLASSIFICACIO;
         DELETE FROM Z_B121_CLASSIF_CONTACTE;
         DELETE FROM Z_B120_CLASSIFICACIONS;
         
         DELETE FROM Z_B111_TEL_PRINCIPALS;
         DELETE FROM Z_B110_TELEFONS_NUMERICS;   

	     DELETE FROM A0_CONTACTE_TELEFON;
    
    	 DELETE FROM A0_CONTACTE_CORREU;
		 DELETE FROM Z_B101_CORREUS_PRINCIPALS;
	     DELETE FROM Z_B100_CORREUS_CONTACTES;
    
         DELETE FROM A0_CONTACTE;
         DELETE FROM Z_B094_CONTACTES_SUBJECTES;
         DELETE FROM Z_B093_CONTACTES_CONTACTES;
         DELETE FROM Z_B092_TIPUS_CONTACTES;
         DELETE FROM Z_B091_DATA_ACT_CONTACTE;
         DELETE FROM Z_B090_CONTACTES_PRINCIPALS;
    
         DELETE FROM A0_ADRECA;
         DELETE FROM Z_B081_ADRECA_SUBJECTE;
         DELETE FROM Z_B080_ADRECA_CONTACTE;
    
         DELETE FROM A0_SUBJECTE;    
         DELETE FROM Z_B073_SUBJECTE_CONTACTE;
         DELETE FROM Z_B072_SUBJECTES_VIPS;
         DELETE FROM Z_B071_SUBJECTES_AMB_PRIORITAT;
         DELETE FROM Z_B070_SUBJECTES_DIFUNTS;
    
         DELETE FROM A0_DM_ENTITAT;
         DELETE FROM Z_B066_ENTITATS_CONTACTES;    
         DELETE FROM Z_B062_ENTITATS_CONTACTES;
         DELETE FROM Z_B061_ENTITAT_NORMALIZADA;
         DELETE FROM Z_B061_ENTITATS_CODI_NULL;  
         DELETE FROM Z_B060_ENTITAT_CATALOG;
         DELETE FROM Z_B060_ENTITAT;
         
         DELETE FROM A0_DM_CARREC;
         
         DELETE FROM Z_B053_CARRECS_CONTACTES;
         DELETE FROM Z_B052_CARRECS_CONTACTES_NULL;
         DELETE FROM Z_B051_CARRECS_CONTACTES_REL;
         DELETE FROM Z_B051_CARRECS_CONTACTES;
		 DELETE FROM Z_B050_CARRECS;
         
	     DELETE FROM A0_DM_TRACTAMENT;
		 DELETE FROM Z_B030_TRACTAMENT;
		 
         DELETE FROM Z_B005_CONTACTES_SIN_GENER;
         
         DELETE FROM Z_B004_SUBJECTES_ID;
         DELETE FROM Z_B004_CONTACTES_PART_ID;
         DELETE FROM Z_B003_CONTACTES_ID;
         DELETE FROM Z_B002_DIF_CONT_PART_VIPS;
         DELETE FROM Z_B002_CONTACTOS_VIPS;   
         DELETE FROM Z_B001_DIF_CONT_VIPS;
         DELETE FROM Z_B001_DIF_CONT;
         DELETE FROM Z_B001_CONTACTOS_ACTIVOS;
    
    
    COMMIT;
    END;
    
    
    
     PROCEDURE RESETEATOR_SECUENCIAS IS         
            TYPE V_Sequence IS VARRAY(11) OF VARCHAR2(100);
            Secuencia V_Sequence;
            total 						integer;  
    
    BEGIN
    
            
        Secuencia := V_Sequence('AUX_SEQ_CONTACTE_VIPS',
                                'AUX_SEQ_CONTACTE_CORREU_VIPS',
                                'AUX_SEQ_ACOMPANYANT_VIPS',
                                'AUX_SEQ_DM_TRACTAMENT_VIPS',
                                'AUX_SEQ_CONTACTE_TELEFON_VIPS',
                                'AUX_SEQ_DM_CARREC_VIPS',
                                'AUX_SEQ_DM_ENTITAT_VIPS',
                                'AUX_SEQ_ADRECA_VIPS',
                                'AUX_SEQ_DM_CLASSIFICACIO_VIPS',
                                'AUX_SEQ_CONTACTE_CLASSIF_VIPS');
        
                     
                
        total := Secuencia.count; 


        
        FOR i in 1 .. total LOOP
                DBMS_OUTPUT.PUT_LINE('jjsjsjsjs');
                execute immediate 'DROP SEQUENCE ' || Secuencia(i);  
                DBMS_OUTPUT.PUT_LINE('jjsjsjsjs1');
                execute immediate 'CREATE SEQUENCE ' || Secuencia(i) || ' MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE';
        DBMS_OUTPUT.PUT_LINE('jjsjsjsjs2');
  
        END LOOP;
    
     /*

DROP SEQUENCE AUX_SEQ_CONTACTE_VIPS;
CREATE SEQUENCE AUX_SEQ_CONTACTE_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_CONTACTE_CORREU_VIPS;
CREATE SEQUENCE AUX_SEQ_CONTACTE_CORREU_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_ACOMPANYANT_VIPS;
CREATE SEQUENCE AUX_SEQ_ACOMPANYANT_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_TRACTAMENT_VIPS;
CREATE SEQUENCE AUX_SEQ_DM_TRACTAMENT_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_CONTACTE_TELEFON_VIPS;
CREATE SEQUENCE AUX_SEQ_CONTACTE_TELEFON_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_CARREC_VIPS;
CREATE SEQUENCE AUX_SEQ_DM_CARREC_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_ENTITAT_VIPS;
CREATE SEQUENCE AUX_SEQ_DM_ENTITAT_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_ADRECA_VIPS;
CREATE SEQUENCE AUX_SEQ_ADRECA_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_DM_CLASSIFICACIO_VIPS;
CREATE SEQUENCE AUX_SEQ_DM_CLASSIFICACIO_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_CONTACTE_CLASSIF_VIPS;
CREATE SEQUENCE AUX_SEQ_CONTACTE_CLASSIF_VIPS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_SUBJECTE;
CREATE SEQUENCE AUX_SEQ_SUBJECTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_CONTACTE;
CREATE SEQUENCE AUX_SEQ_CONTACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;


 DELETE FROM A0_ACCIO;
 DELETE FROM A0_ACOMPANYANT;
 DELETE FROM A0_ACTE;
 
 DELETE FROM A0_AGENDA_DELEGACIO;
 DELETE FROM A0_ANNEX_ACTE;
 DELETE FROM A0_ANNEX_ASPECTE;
 DELETE FROM A0_ANNEX_REGISTRE;
 DELETE FROM A0_ASPECTE;
 DELETE FROM A0_CLASSIFICACIO_ARXIU;
 DELETE FROM A0_COMANDA;
 DELETE FROM A0_COMENTARI;
 
 DELETE FROM A0_CONTACTE_CLASSIFICACIO;
 DELETE FROM A0_CONTACTE_CONSENTIMENT;
 DELETE FROM A0_CONTACTE_CORREU;
 DELETE FROM A0_CONTACTE_TELEFON;
 DELETE FROM A0_CONVIDAT;
 DELETE FROM A0_CONVIDAT_ACOMPANYANT;
 DELETE FROM A0_CONVIDAT_CORREU;
 DELETE FROM A0_CONVIDAT_OBSEQUI;
 DELETE FROM A0_CONVIDAT_TELEFON;
 DELETE FROM A0_CONVIDAT_ZONA;
 DELETE FROM A0_DADES_HISTORIC;
 DELETE FROM A0_DM_AFECTA_AGENDA;
 
 DELETE FROM A0_DM_ARTICLE;
 DELETE FROM A0_DM_BARRI;
 
 DELETE FROM A0_DM_CATALEG_DOCUMENT;
 DELETE FROM A0_DM_CATEGORIA;
 DELETE FROM A0_DM_CLASSIFICACIO;
 DELETE FROM A0_DM_CONTRACTE;
 DELETE FROM A0_DM_DECISIO_AGENDA;
 DELETE FROM A0_DM_DESTINATARI_PERSONA;
 DELETE FROM A0_DM_DESTI_DELEGACIO;
 DELETE FROM A0_DM_DISTRICTE;
 
 DELETE FROM A0_DM_ESPAI;
 DELETE FROM A0_DM_ESPECIFIC;
 DELETE FROM A0_DM_ESTAT_ACTE;
 DELETE FROM A0_DM_ESTAT_COMANDA;
 DELETE FROM A0_DM_ESTAT_CONFIRMACIO;
 DELETE FROM A0_DM_ESTAT_ELEMENT;
 DELETE FROM A0_DM_ESTAT_GESTIO_ESPAIS;
 DELETE FROM A0_DM_ESTAT_GESTIO_INVITACIO;
 DELETE FROM A0_DM_ESTAT_TRUCADA;
 DELETE FROM A0_DM_IDIOMA;
 DELETE FROM A0_DM_INICIATIVA_RESPOSTA;
 DELETE FROM A0_DM_LLOC;
 DELETE FROM A0_DM_OBSEQUI;
 DELETE FROM A0_DM_ORIGEN_ELEMENT;
 DELETE FROM A0_DM_PAS_ACCIO;
 DELETE FROM A0_DM_PETICIONARI;
 DELETE FROM A0_DM_PLANTILLA_ESPAI;
 DELETE FROM A0_DM_PREFIX;
 DELETE FROM A0_DM_PREFIX_ANY;
 DELETE FROM A0_DM_PRESIDENT;
 DELETE FROM A0_DM_PRIORITAT;
 DELETE FROM A0_DM_PRIORITAT_ELEMENT;
 DELETE FROM A0_DM_PROVEIDOR;
 DELETE FROM A0_DM_RAO;
 DELETE FROM A0_DM_SECTOR;
 DELETE FROM A0_DM_SENTIT_TRUCADA;
 DELETE FROM A0_DM_SERIE;
 DELETE FROM A0_DM_SUBTIPUS_ACCIO;
 DELETE FROM A0_DM_TIPOLOGIA_CLASSIFICACIO;
 DELETE FROM A0_DM_TIPOLOGIA_OBSEQUI;
 DELETE FROM A0_DM_TIPUS_ACCIO;
 DELETE FROM A0_DM_TIPUS_ACTE;
 DELETE FROM A0_DM_TIPUS_AGENDA;
 DELETE FROM A0_DM_TIPUS_AMBIT;
 DELETE FROM A0_DM_TIPUS_ARG;
 
 DELETE FROM A0_DM_TIPUS_DATA;
 DELETE FROM A0_DM_TIPUS_ELEMENT;
 DELETE FROM A0_DM_TIPUS_SERVEI;
 
 DELETE FROM A0_DM_TIPUS_SUPORT;
 DELETE FROM A0_DM_TIPUS_TELEFON;
 DELETE FROM A0_DM_TIPUS_TEMA;
 DELETE FROM A0_DM_TIPUS_VIA_INVITACIO;
 DELETE FROM A0_DM_TIPUS_VIA_RESPOSTA;
 
 
 DELETE FROM A0_DOCUMENT;
 DELETE FROM A0_DOCUMENT_BAIXA_SUBJECTE;
 DELETE FROM A0_DOSSIER;
 DELETE FROM A0_ELEMENTS_RELACIONATS;
 DELETE FROM A0_ELEMENT_PRINCIPAL;
 DELETE FROM A0_ELEMENT_SECUNDARI;
 DELETE FROM A0_ENTRADA_AGENDA;
 DELETE FROM A0_ESPAI_ACTE;
 DELETE FROM A0_ESPAI_ACTE_CONFIG;
 DELETE FROM A0_HISTORIC_TRUCADA;
 DELETE FROM A0_MANTENIMENT_DM;
 DELETE FROM A0_OBSEQUI_ENTREGAT;
 DELETE FROM A0_OBSEQUI_INVENTARI;
 DELETE FROM A0_PARAMETRE;
 DELETE FROM A0_PERSONA_RELACIONADA;
 DELETE FROM A0_PLANTILLA_CONFIG_ESPAI;
 DELETE FROM A0_RASTRE;
 DELETE FROM A0_REGISTRE;
 
 DELETE FROM A0_TITULAR_DINS;
 DELETE FROM A0_TITULAR_FORA;
 DELETE FROM A0_TITULAR_FORA_CORREU;
 DELETE FROM A0_TITULAR_FORA_TELEFON;
 DELETE FROM A0_TRANSICIO_TRAMITACIO;
 DELETE FROM A0_TRUCADA;
 DELETE FROM A0_TRUCADA_ELEMENT_PRINCIPAL;
 DELETE FROM A0_TRUCADA_TEMA;
 DELETE FROM A0_ZONA;
 
 DELETE FROM A0_CONTACTE;
 
 DELETE FROM A0_SUBJECTE;
 
 DELETE FROM A0_ADRECA;
 DELETE FROM A0_DM_TIPUS_CONTACTE;
 DELETE FROM A0_DM_VISIBILITAT;
 DELETE FROM A0_DM_ENTITAT;
 DELETE FROM A0_DM_CARREC;
 DELETE FROM A0_DM_AMBIT;
 
 DELETE FROM A0_DM_TRACTAMENT;
DELETE FROM A0_DM_TIPUS_SUBJECTE;
 
 
INSERT INTO A0_DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'TELEFON FIX',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'TELEFON MOBIL',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'FAX',SYSDATE,null,null,'MIGRACIO',null,null);


INSERT INTO A0_DM_TIPUS_SUBJECTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'PERSONA',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPUS_SUBJECTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'ENTITAT',SYSDATE,null,null,'MIGRACIO',null,null);


INSERT INTO A0_DM_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI) VALUES  (1,'Alcaldia',SYSDATE,null,null,'MIGRACIO',null,null,'A');
INSERT INTO A0_DM_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI) VALUES  (2,'Protocol',SYSDATE,null,null,'MIGRACIO',null,null,'B');



INSERT INTO A0_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (1, 'PRIORITAT1', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
INSERT INTO A0_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (2, 'PRIORITAT2', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
INSERT INTO A0_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (3, 'PRIORITAT3', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
INSERT INTO A0_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (4, 'PRIORITAT4', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);


INSERT INTO A0_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'JOCS FLORALS',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'MEDALLES',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'CONCERTS',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (4,'OBJECTES VARIS',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (5,'FOTOS i VIDEO',SYSDATE,null,null,'MIGRACIO',null,null);

INSERT INTO A0_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (5,'FOTOS PAPER - NO',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO A0_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (4,'FOTOS PAPER - SI',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO A0_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (3,'CD -  NO',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO A0_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (2,'CD -  SI',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO A0_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (6,'CD - SI (FOTOS i VIDEO)',1,SYSDATE,null,null,'MIGRACIO',null,null,5);


INSERT INTO A0_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'Pública',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'Privada',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'Alcaldia',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (4,'Protocolo',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (5,'Gabinet',SYSDATE,null,null,'MIGRACIO',null,null);

INSERT INTO A0_DM_TIPUS_CONTACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (1,'Personal',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_TIPUS_CONTACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (2,'Profesional',SYSDATE,null,null,'MIGRACIO',null,null);




INSERT INTO A0_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (1,'Castellà',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (2,'Anglés',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (3,'Català',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO A0_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (4,'Francés',SYSDATE,null,null,'MIGRACIO',null,null);


INSERT INTO A0_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values (1,'TIPUS1',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);
INSERT INTO A0_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values(2,'TIPUS2',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);
INSERT INTO A0_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values(3,'TIPUS3',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);
INSERT INTO A0_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values(4,'TIPUS4',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);


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

END Z_LANZAR_AUX_VIPS;

/
