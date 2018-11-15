--------------------------------------------------------
--  DDL for Package Body MIGRACIO_VIPS_DANI
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."MIGRACIO_VIPS_DANI" AS


    -- SEPARA LOS CONTACTOS
    PROCEDURE B01_DIF_CONT_VIPS IS
    BEGIN              
        INSERT INTO Z_B01_DIF_CONT_VIPS (ID_CONTACTE, N_VIP, CARREC,	ENTITAT, ADRECA, MUNICIPI)
        SELECT Z_SEQ_CONTACTE.NEXTVAL AS ID_CONTACTE, 
                   N_VIP, 
                   NVL(T.CARREC,'NULL') AS CARREC,  
                   NVL(T.ENTITAT,'NULL') AS ENTITAT,  
                   NVL(T.ADRECA,'NULL') AS ADRECA, 
                   NVL(T.MUNICIPI,'NULL') AS MUNICIPI 
            FROM (
                    SELECT  N_VIP, 
                            TRIM(CARREC) AS CARREC, 
                            TRIM(ENTITAT) AS ENTITAT, 
                            TRIM(REPLACE(LIMPIARCHARS(ADRECA),'.','')) AS ADRECA, 
                            TRIM(REPLACE(MUNICIPI,'.','')) AS MUNICIPI

                    FROM SINTAGMA_U.Z_TMP_VIPS_U_CLASSIF_VIP , 
                         DANI_TB_CLASSIF_ACTIVES act
                    WHERE CLASSIF = act.codi
                    GROUP BY N_VIP, 
                             TRIM(CARREC), 
                             TRIM(ENTITAT), 
                             TRIM(REPLACE(LIMPIARCHARS(ADRECA),'.','')), 
                             TRIM(REPLACE(MUNICIPI,'.','')) 
                ) T;
        
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
        SELECT Z_SEQ_CONTACTE.NEXTVAL AS ID_CONTACTE, 
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
                     DANI_TB_CLASSIF_ACTIVES act
                WHERE DIF.CARREC = NVL(TRIM(CV.CARREC),'NULL') 
                  AND DIF.ENTITAT = NVL(TRIM(CV.ENTITAT),'NULL')  
                  AND DIF.ADRECA = NVL(TRIM(LIMPIARCHARS(CV.ADRECA)),'NULL')  
                  AND DIF.MUNICIPI = NVL(TRIM(CV.MUNICIPI),'NULL')  
                  AND DIF.N_VIP = CV.N_VIP
                  AND CV.CLASSIF = act.codi;        
    
      COMMIT;
    
    END;  
    
        /* REVISAR */
    PROCEDURE B04_CONTACTES_PART_ID IS
    BEGIN
             
      INSERT INTO Z_B04_CONTACTES_PART_ID --DADES_IDCONTACTES_CLASS_VIPS
      SELECT DIF.Id_Contacte,
             (CASE WHEN(length(CV.COGNOMS) - length(replace(CV.COGNOMS, ' ', '')) + 1) = 2 THEN trim(SUBSTR(CV.COGNOMS,1,INSTR(CV.COGNOMS,' ')-1))
               WHEN trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1)) IS NULL THEN CV.COGNOMS 
              ELSE  trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1))
              END)  AS COGNOM1, 
              (CASE WHEN trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1)) IS NOT NULL THEN trim(SUBSTR(CV.COGNOMS,INSTR(LOWER(CV.COGNOMS),' i ')))
              WHEN (length(CV.COGNOMS) - length(replace(CV.COGNOMS, ' ', '')) + 1) = 2 THEN  trim(SUBSTR(CV.COGNOMS, INSTR(CV.COGNOMS,' ')))
              ELSE NULL END) AS COGNOM2,         
      CV.* 
      FROM Z_B02_DIF_CONT_PART_VIPS DIF, 
           z_Tmp_Vips_u_Vips CV
      WHERE DIF.N_VIP = CV.N_VIP
        AND DIF.ADRECA_P = NVL(CV.ADRECA_P,'NULL')  
        AND DIF.MUNICIPI_P = NVL(CV.MUNICIPI_P,'NULL')  
        AND DIF.TELEFON_P =  NVL(CV.TELEFON_P,'NULL') ;         
      COMMIT;
    
    END;  
      
        PROCEDURE B10_CORREUS_CONTACTES IS
            BEGIN
            
                        INSERT INTO Z_B10_CORREUS_CONTACTES (ID_CONTACTE, INTERNET)
            		SELECT aux.ID_CONTACTE, aux.INTERNET 
            		FROM(                                                                         
              			  select distinct  t.ID_CONTACTE,
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
            	      AND NOT EXISTS (SELECT * 
            	     				  FROM Z_B10_CORREUS_CONTACTES con 
            	     				  WHERE con.ID_CONTACTE = aux.ID_CONTACTE 
            	     				    AND con.internet = aux.internet
            	     				  );                                                                 

            COMMIT;   
            
          END;  
          
        PROCEDURE DANI_CORREUS_PRINCIPALS IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT * FROM  Z_B10_CORREUS_CONTACTES ORDER BY ID_CONTACTE
        )
        LOOP
            
            IF c.id_contacte <> id_contacte_ant THEN
              id_contacte_ant:= c.id_contacte;
              INSERT INTO DANI_TB_AUX_CORREUS_PRINCIPALS VALUES (c.id_contacte, c.internet, 1);
            ELSE
              INSERT INTO DANI_TB_AUX_CORREUS_PRINCIPALS VALUES (c.id_contacte, c.internet, 0);           
            END IF;

        END LOOP;
        
        COMMIT;            
        
        END;
                
        
        PROCEDURE DANI_CORREUS_CONTACTES IS   
        
        BEGIN
         
            INSERT INTO CONTACTE_CORREU(ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, Contacte_Id)
            SELECT SEQ_CONTACTE_CORREU.NEXTVAL, cc.correu, cc.principal, sysdate, 'MIGRACIO', cc.id_contacte
            FROM DANI_TB_AUX_CORREUS_PRINCIPALS cc
            WHERE EXISTS(SELECT * FROM CONTACTE WHERE id = cc.id_contacte);
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN DANI_TB_AUX_CORREUS_PRINCIPALS
        
        END;  
                
          
        PROCEDURE DANI_ACOMPANYANTS_SUBJECTE IS 
            BEGIN
            
            INSERT INTO DANI_TB_ACOMPANYANTS_SEPARATS                                                                           
            SELECT N_VIP, TRACTAMENT_A, NOM_A, 
              (CASE WHEN(length(COGNOMS_A) - length(replace(COGNOMS_A, ' ', '')) + 1) = 2 THEN trim(SUBSTR(COGNOMS_A,1,INSTR(COGNOMS_A,' ')-1))
               WHEN trim(SUBSTR(COGNOMS_A,1, INSTR(LOWER(COGNOMS_A),' i ')-1)) IS NULL THEN COGNOMS_A 
              ELSE  trim(SUBSTR(COGNOMS_A,1, INSTR(LOWER(COGNOMS_A),' i ')-1))
              END)  AS COGNOM_A_1, 
              (CASE WHEN trim(SUBSTR(COGNOMS_A,1, INSTR(LOWER(COGNOMS_A),' i ')-1)) IS NOT NULL THEN trim(SUBSTR(COGNOMS_A,INSTR(LOWER(COGNOMS_A),' i ')))
              WHEN (length(COGNOMS_A) - length(replace(COGNOMS_A, ' ', '')) + 1) = 2 THEN  trim(SUBSTR(COGNOMS_A, INSTR(COGNOMS_A,' ')))
              ELSE NULL END) AS COGNOM_A_2,
              Z_TMP_VIPS_U_VIPS.Data_Alta,
              Z_TMP_VIPS_U_VIPS.Data_Modif,
              Z_TMP_VIPS_U_VIPS.DATA_BAIXA,
              Z_TMP_VIPS_U_VIPS.Usu_Alta,
              Z_TMP_VIPS_U_VIPS.Usu_Modif
            FROM Z_TMP_VIPS_U_VIPS 
            WHERE TRIM(NOM_A) IS NOT NULL AND TRIM(COGNOMS_A) IS NOT NULL AND TRACTAMENT_A IS NOT NULL ;                                                                         
           COMMIT;                                                                   
           
           INSERT INTO ACOMPANYANT (ID, NOM, COGNOM1, COGNOM2, CONTACTE_ID,DATA_CREACIO, DATA_MODIFICACIO, Data_Esborrat, USUARI_CREACIO, USUARI_MODIFICACIO,TRACTAMENT_ID)
           SELECT  SEQ_ACOMPANYANT.NEXTVAL, NVL(ase.nom_a,'.'), NVL(ase.cognom_a_1,'.'), ase.cognom_a_2, c.id_contacte, NVL(ase.data_alta,TO_DATE('01/01/1970','dd/mm/yyyy')), ase.data_modif, ase.data_baixa, NVL(ase.usu_modif,'NO_INFO'), NULL, ase.tractament_a
           FROM DANI_TB_ACOMPANYANTS_SEPARATS ase, Z_B03_CONTACTES_ID c
           WHERE ase.n_vip = c.n_vip AND EXISTS (SELECT * FROM CONTACTE c1 WHERE c1.subjecte_id = ase.n_vip);
           COMMIT;
                   
          END;  
          
          
          PROCEDURE DANI_TRACTAMENTS IS 
            
            max_seq number;
             
            BEGIN
            
            INSERT INTO DANI_AUX_DM_TRACTAMENT (ID, CODI, DESCRIPCIO, ABREUJADA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_BAIXA)                                                                       
            SELECT t.CODI, t.CODI, NVL(t.descripcio,t.codi) AS DESCRIPCIO, t.abreujada, sysdate AS DATA_CREACIO, NULL AS DATA_MODIFICACIO, NULL AS DATA_ESBORRAT, 'MIGRACIO' AS USUARI_CREACIO, NULL AS USUARI_MODIFICACIO, NULL AS USUARI_BAIXA 
            FROM Z_TMP_VIPS_U_TRACTAMENTS t
            WHERE NOT EXISTS (SELECT * FROM DANI_AUX_DM_TRACTAMENT WHERE CODI=t.CODI) AND LENGTH(TRIM(TRANSLATE(t.CODI, ' +-.0123456789', ' '))) IS NULL;
            
            SELECT MAX(ID) INTO max_seq FROM DANI_AUX_DM_TRACTAMENT;
            
            SET_SEQ('SEQ_DM_TRACTAMENT',max_seq);
            
            INSERT INTO   DANI_AUX_DM_TRACTAMENT (ID, CODI, DESCRIPCIO, ABREUJADA, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_BAIXA)                                                                      
            SELECT SEQ_DM_TRACTAMENT.NEXTVAL, t.CODI, NVL(t.descripcio,t.codi), t.abreujada, sysdate, NULL, NULL, 'MIGRACIO', NULL, NULL 
            FROM Z_TMP_VIPS_U_TRACTAMENTS t
            WHERE NOT EXISTS (SELECT * FROM DANI_AUX_DM_TRACTAMENT WHERE CODI=t.CODI OR DESCRIPCIO = t.descripcio) AND LENGTH(TRIM(TRANSLATE(t.CODI, ' +-.0123456789', ' '))) IS NOT NULL;
            COMMIT;
                        
            -- BUSCAR MAPEO PARA DESCRIPCIONES IGUALES, MAPEAR AL MISMO TRACTAMENT (ejecutado cambiando valor duplicado H. Sr. 2,74 en auxiliar) 
            
            INSERT INTO DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO,USUARI_CREACIO)
            SELECT aux.id, aux.descripcio, aux.data_creacio, aux.usuari_creacio
            FROM DANI_AUX_DM_TRACTAMENT aux
            WHERE NOT EXISTS (SELECT * FROM DM_TRACTAMENT tr WHERE tr.id = aux.id)  ;
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
    
    
        PROCEDURE DANI_TELEFONS_NUMERICS is 
            BEGIN           
            
             INSERT INTO DANI_TB_TELEFONS_NUMERICS
             SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   CASE WHEN SUBSTR(TRIM(TELEFON1),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFON1,' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON1),'-',''),' ',''),'.','') AS TELEFON
            FROM Z_B03_CONTACTES_ID C
            WHERE TRIM(TELEFON1) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON1, ' +-.0123456789', ' '))) IS NULL AND TRIM(TELEFON1) <> '.'
                  AND NOT EXISTS (SELECT * FROM DANI_TB_TELEFONS_NUMERICS AUX  WHERE C.ID_CONTACTE = AUX.ID_CONTACTE AND C.N_VIP = AUX.N_VIP AND REPLACE(REPLACE(REPLACE(TRIM(C.Telefon1),'-',''),' ',''),'.','') = AUX.TELEFON);
         
            INSERT INTO DANI_TB_TELEFONS_NUMERICS            
            SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   CASE WHEN SUBSTR(TRIM(TELEFON2),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON2,'.',''),' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON2),'-',''),' ',''),'.','') 
            FROM Z_B03_CONTACTES_ID C
            WHERE TRIM(TELEFON2) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON2, ' +-.0123456789', ' '))) IS NULL AND TRIM(TELEFON2) <> '.'
                  AND NOT EXISTS (SELECT * FROM DANI_TB_TELEFONS_NUMERICS AUX  WHERE C.ID_CONTACTE = AUX.ID_CONTACTE AND C.N_VIP = AUX.N_VIP AND REPLACE(REPLACE(REPLACE(TRIM(C.Telefon2),'-',''),' ',''),'.','') = AUX.TELEFON);
            
            INSERT INTO DANI_TB_TELEFONS_NUMERICS
            SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   CASE WHEN SUBSTR(TRIM(TELEFON_MOBIL),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON_MOBIL,'.',''),' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON_MOBIL),'-',''),' ',''),'.','') 
            FROM Z_B03_CONTACTES_ID C
            WHERE TRIM(TELEFON_MOBIL) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON_MOBIL, ' +-.0123456789', ' '))) IS NULL AND TRIM(TELEFON_MOBIL) <> '.'
                  AND NOT EXISTS (SELECT * FROM DANI_TB_TELEFONS_NUMERICS AUX  WHERE C.ID_CONTACTE = AUX.ID_CONTACTE AND C.N_VIP = AUX.N_VIP AND REPLACE(REPLACE(REPLACE(TRIM(C.TELEFON_MOBIL),'-',''),' ',''),'.','') = AUX.TELEFON);

            INSERT INTO DANI_TB_TELEFONS_NUMERICS
             SELECT DISTINCT ID_CONTACTE,
                   N_VIP,
                   3 AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(FAX),'-',''),' ',''),'.','') 
            FROM Z_B03_CONTACTES_ID C
            WHERE TRIM(FAX) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(FAX, ' +-.0123456789', ' '))) IS NULL AND TRIM(FAX) <> '.'
                  AND NOT EXISTS (SELECT * FROM DANI_TB_TELEFONS_NUMERICS AUX  WHERE C.ID_CONTACTE = AUX.ID_CONTACTE AND C.N_VIP = AUX.N_VIP AND REPLACE(REPLACE(REPLACE(TRIM(C.Fax),'-',''),' ',''),'.','') = AUX.TELEFON);
                              
           INSERT INTO DANI_TB_TELEFONS_NUMERICS
           SELECT ID_CONTACTE, 
                  N_VIP,
                  CASE WHEN SUBSTR(TRIM(TELEFON_P),1,1)= '6' AND LENGTH(TRIM(REPLACE(REPLACE(TELEFON_P,'.',''),' ','')))= 9 THEN 2
                    ELSE 1 
                   END AS TIPUS_TELEFON,
                   REPLACE(REPLACE(REPLACE(TRIM(TELEFON_P),'-',''),' ',''),'.','') AS TELEFON
           FROM Z_B04_CONTACTES_PART_ID C
           WHERE TRIM(TELEFON_P) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TELEFON_P, ' +-.0123456789', ' '))) IS NULL AND TRIM(TELEFON_P) <> '.'
                  AND NOT EXISTS (SELECT * FROM DANI_TB_TELEFONS_NUMERICS AUX  WHERE C.ID_CONTACTE = AUX.ID_CONTACTE AND C.N_VIP = AUX.N_VIP AND REPLACE(REPLACE(REPLACE(TRIM(C.TELEFON_P),'-',''),' ',''),'.','') = AUX.TELEFON);
            
           COMMIT;
           
          END;


      PROCEDURE DANI_TELEFON_PRINCIPAL IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT * FROM  DANI_TB_TELEFONS_NUMERICS ORDER BY ID_CONTACTE
        )
        LOOP
            
            IF c.id_contacte <> id_contacte_ant THEN
              id_contacte_ant:= c.id_contacte;
              INSERT INTO DANI_TB_AUX_TEL_PRINCIPALS VALUES (c.id_contacte, c.tipus_telefon,c.telefon, 1);
            ELSE
              INSERT INTO DANI_TB_AUX_TEL_PRINCIPALS VALUES (c.id_contacte, c.tipus_telefon,c.telefon, 0);           
            END IF;

        END LOOP;
        
        COMMIT;       
      
      END;


      PROCEDURE DANI_CONTACTE_TELEFON is 
           
      BEGIN
        
           INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, CONTACTE_ID, TIPUS_TELEFON_ID)
           SELECT SEQ_CONTACTE_TELEFON.NEXTVAL, t.telefon, t.principal, sysdate, 'MIGRACIO', t.id_contacte, t.tipus_telefon
           FROM DANI_TB_AUX_TEL_PRINCIPALS t WHERE EXISTS(SELECT * FROM CONTACTE WHERE ID = t.id_contacte) AND 
           NOT EXISTS(SELECT * FROM CONTACTE_TELEFON ct WHERE ct.numero = t.telefon AND ct.contacte_id = t.id_contacte) AND t.TELEFON IS NOT NULL;    
           COMMIT;

      END;


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
        
    PROCEDURE B35_CREACIO_SUBJECTES is       
          
    BEGIN

      INSERT INTO SUBJECTE (ID, NOM,COGNOM1,COGNOM2,ALIES,DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,	USUARI_ESBORRAT,	USUARI_MODIFICACIO,	TRACTAMENT_ID,	PRIORITAT_ID,	TIPUS_SUBJECTE_ID,	AMBIT_ID,	IDIOMA_ID)
      SELECT N_VIP, MAX(NOM), MAX(COGNOM1), MAX(COGNOM2), MAX(ALIES), MAX(DATA_DEFUNCIO), MAX(MOTIU_BAIXA), MAX(DATA_ALTA), MAX(DATA_BAIXA), MAX(DATA_MODIF),MAX(USU_ALTA), MAX(USU_MODIF), MAX(USU_BAIXA), MAX(TRACTAMENT), MAX(PRIORITAT), MAX(TIPUS_SUBJECTE_ID), MAX(AMBIT_ID), MAX(IDIOMA_ID)
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
              (SELECT admt.ID FROM DANI_AUX_DM_TRACTAMENT admt WHERE admt.CODI = c.Tractament) AS TRACTAMENT,
              (SELECT dmp.ID FROM DM_PRIORITAT dmp WHERE dmp.DESCRIPCIO = pr.prioritat) AS PRIORITAT,
              1 AS TIPUS_SUBJECTE_ID,
              2 AS AMBIT_ID,
              NULL AS IDIOMA_ID         
      FROM Z_B04_CONTACTES_PART_ID c, Z_B30_SUBJECTES_DIFUNTS dif, Z_B32_SUBJECTES_AMB_PRIORITAT PR
      WHERE c.N_VIP = dif.N_VIP (+) 
      AND c.n_Vip = PR.N_VIP (+)
      AND NOT EXISTS (SELECT * FROM SUBJECTE s WHERE s.ID = c.N_VIP)
      ) T
      GROUP BY N_VIP;
      COMMIT;
      
      -- NUEVO
      INSERT INTO SUBJECTE (ID, NOM,COGNOM1,COGNOM2,ALIES,DATA_DEFUNCIO,MOTIU_BAIXA,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,	USUARI_ESBORRAT,	USUARI_MODIFICACIO,	TRACTAMENT_ID,	PRIORITAT_ID,	TIPUS_SUBJECTE_ID,	AMBIT_ID,	IDIOMA_ID)
      SELECT N_VIP, MAX(NOM), MAX(COGNOM1), MAX(COGNOM2), MAX(ALIES), MAX(DATA_DEFUNCIO), MAX(MOTIU_BAIXA), MAX(DATA_ALTA), MAX(DATA_BAIXA),MAX(DATA_MODI), MAX(USU_ALTA), MAX(USU_MODIF), MAX(USU_BAIXA), MAX(TRACTAMENT), MAX(PRIORITAT), MAX(TIPUS_SUBJECTE_ID), MAX(AMBIT_ID), MAX(IDIOMA_ID)
      FROM (
      SELECT  c.N_VIP,
              NVL(CV.NOM,'.') AS NOM,
              (CASE WHEN(length(CV.COGNOMS) - length(replace(CV.COGNOMS, ' ', '')) + 1) = 2 THEN trim(SUBSTR(CV.COGNOMS,1,INSTR(CV.COGNOMS,' ')-1))
              WHEN trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1)) IS NULL THEN CV.COGNOMS 
              ELSE  trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1))
              END)  AS COGNOM1, 
              (CASE WHEN trim(SUBSTR(CV.COGNOMS,1, INSTR(LOWER(CV.COGNOMS),' i ')-1)) IS NOT NULL THEN trim(SUBSTR(CV.COGNOMS,INSTR(LOWER(CV.COGNOMS),' i ')))
              WHEN (length(CV.COGNOMS) - length(replace(CV.COGNOMS, ' ', '')) + 1) = 2 THEN  trim(SUBSTR(CV.COGNOMS, INSTR(CV.COGNOMS,' ')))
              ELSE NULL END) AS COGNOM2, 
              NULL AS ALIES,
              dif.DATA_DEFUNCIO,
              NULL AS MOTIU_BAIXA,
              NVL2(c.DATA_ALTA, c.DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA,
              DATA_MODI, 
              CV.Data_Baixa AS DATA_BAIXA,
              NVL(c.USU_ALTA, 'NO_INFO') AS USU_ALTA,   
              NVL2(c.USU_MODI, c.USU_MODI, NVL2(c.DATA_MODI, 'NO_INFO', NULL)) AS USU_MODIF,
              NVL2(CV.Data_Baixa,'NO_INFO',NULL) AS USU_BAIXA, 
              (SELECT admt.ID FROM DANI_AUX_DM_TRACTAMENT admt WHERE admt.CODI = CV.TRACTAMENT ) AS TRACTAMENT, 
              (SELECT dmp.ID FROM DM_PRIORITAT dmp WHERE dmp.DESCRIPCIO = pr.prioritat) AS PRIORITAT,
              1 AS TIPUS_SUBJECTE_ID,
              2 AS AMBIT_ID,
              NULL AS IDIOMA_ID 
      FROM Z_B03_CONTACTES_ID c, Z_B30_SUBJECTES_DIFUNTS dif, Z_B32_SUBJECTES_AMB_PRIORITAT PR, Z_TMP_VIPS_U_VIPS CV
      WHERE c.N_VIP = dif.N_VIP (+) 
      AND c.N_VIP = CV.N_VIP 
      AND c.n_Vip = PR.N_VIP (+)
      AND NOT EXISTS (SELECT * FROM SUBJECTE s WHERE s.ID = c.N_VIP)
      ) T
      GROUP BY N_VIP;
      
      COMMIT;
    
    END;
        
    PROCEDURE B32_SUBJECTES_AMB_PRIORITAT IS
      
    BEGIN
           INSERT INTO Z_B32_SUBJECTES_AMB_PRIORITAT    
           SELECT N_VIP, REPLACE(TRIM(FAX), '91-SC','1-SC') 
           FROM Z_B03_CONTACTES_ID WHERE TRIM(FAX) IN ('1-SC','91-SC')
           GROUP BY N_VIP, REPLACE(TRIM(FAX),'91-SC','1-SC') ;
           COMMIT;
    END;
        
    
    PROCEDURE DANI_CONTACTES_PRINCIPALS IS
   
    BEGIN
              INSERT INTO DANI_TB_CONTACTES_PRINCIPALS
              SELECT ID_CONTACTE 
              FROM Z_B03_CONTACTES_ID
              WHERE CLASSIF = 'GENER';
              COMMIT;
              
    END;
    
    
    PROCEDURE DANI_DATA_ACT_CONTACTE IS
      
    BEGIN
    
           INSERT INTO DANI_TB_DATA_ACTUALITZACIO
           SELECT ID_CONTACTE,
                    CASE WHEN LENGTH(PAIS) =5 THEN TO_DATE(PAIS||'-2018','dd-mm-yyyy') 
                    WHEN LENGTH(PAIS) = 7 AND SUBSTR(PAIS, 3, 1) = '-' THEN TO_DATE(SUBSTR(PAIS, 1,3)||'0'||SUBSTR(PAIS, 4,7), 'dd-mm-yy')
                    WHEN LENGTH(PAIS) = 7 THEN TO_DATE(PAIS, 'ddmm-yy')
                    WHEN LENGTH(PAIS) = 8 THEN TO_DATE(PAIS, 'dd-mm-yy')
                    WHEN LENGTH(PAIS) = 10 THEN TO_DATE(PAIS, 'dd-mm-yyyy')
                    ELSE TO_DATE('01-01-1970','dd-mm-yyyy')
                    END AS DATA_ACTUALITZACIO
            FROM  Z_B03_CONTACTES_ID WHERE PAIS IS NOT NULL AND LENGTH(TRIM(TRANSLATE(SUBSTR(PAIS,1,5), ' +-.0123456789', ' '))) IS NULL AND TO_NUMBER(SUBSTR(PAIS,1,1)) IN (0,1,2,3) AND TRIM(PAIS)<>'.';
            COMMIT;
            
    END;
    
    
    
    PROCEDURE DANI_TIPUS_CONTACTES IS

    BEGIN   
      
            INSERT INTO DANI_TB_TIPUS_CONTACTES   
            SELECT ID_CONTACTE, MAX(1) AS TIPUS
            FROM  Z_B04_CONTACTES_PART_ID part
            GROUP BY(ID_CONTACTE)
            UNION
            SELECT ID_CONTACTE, MAX(2)
            FROM Z_B03_CONTACTES_ID t 
            GROUP BY(ID_CONTACTE);
            
            COMMIT;

    END;
    
    
    PROCEDURE DANI_ADRECA_CONTACTE IS
      
    BEGIN
              INSERT INTO DANI_TB_ADRECA_CONTACTE
              SELECT SEQ_ADRECA.NEXTVAL, ID_CONTACTE, ADRECA, MUNICIPI, CP, PROVINCIA, PAIS, USU_ALTA,DATA_ALTA, USU_MODI, DATA_MODI
              FROM (
                SELECT c.ID_CONTACTE, MAX(c.ADRECA) AS ADRECA, MAX(c.MUNICIPI) AS MUNICIPI, MAX(c.CP) AS CP, MAX(c.PROVINCIA) AS PROVINCIA, MAX(t.PAIS) AS PAIS, MAX(NVL(c.USU_ALTA,'NO_INFO')) AS USU_ALTA, MAX(NVL(c.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy'))) AS DATA_ALTA, MAX(c.USU_MODI) AS USU_MODI, MAX(c.DATA_MODI) AS DATA_MODI
                FROM Z_B03_CONTACTES_ID c, (              
                      SELECT ID_CONTACTE, REPLACE(REPLACE(PAIS,'(',''),')','') AS PAIS
                      FROM Z_B03_CONTACTES_ID
                      WHERE LENGTH(TRIM(TRANSLATE(PAIS, ' +-.0123456789', ' '))) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(SUBSTR(PAIS,1,1), ' +-.0123456789', ' '))) IS NOT NULL AND PAIS NOT IN ('PP','CIU') AND SUBSTR(PAIS,1,3) <> 'AUT'
                       )T
                WHERE c.ID_CONTACTE = T.ID_CONTACTE (+)
                GROUP BY c.ID_CONTACTE
              ) a;
              
              -- CREAR PARA PARTICULARES B4 (CON DATOS DE DIRECCION INFORMADO)
              INSERT INTO DANI_TB_ADRECA_CONTACTE (ID_ADRECA,ID_CONTACTE,ADRECA,MUNICIPI,CP,PROVINCIA,PAIS,USU_ALTA,DATA_ALTA,USU_MODI,DATA_MODI)
              SELECT SEQ_ADRECA.NEXTVAL, c.ID_CONTACTE, c.ADRECA_P, c.MUNICIPI_P, c.CP_P , c.PROVINCIA_P, c.PAIS_P, NVL(c.USU_ALTA,'NO_INFO') AS USU_ALTA, NVL(c.DATA_ALTA, TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, c.USU_MODIF, c.DATA_MODIF
              FROM Z_B04_CONTACTES_PART_ID c
              WHERE TRIM(c.ADRECA_P) IS NOT NULL OR
                    TRIM(c.MUNICIPI_P) IS NOT NULL OR
                    TRIM(c.PROVINCIA_P) IS NOT NULL OR
                    TRIM(c.PAIS_P) IS NOT NULL OR
                    TRIM(c.CP_P) IS NOT NULL;
                             
              COMMIT;
        
              -- FALTAN DIRECCIONES PARTICULARES
                 
              INSERT INTO ADRECA (ID, MUNICIPI, NOM_CARRER, PROVINCIA, PAIS, USUARI_CREACIO, DATA_CREACIO, USUARI_MODIFICACIO,DATA_MODIFICACIO)
              SELECT ac.ID_ADRECA , ac.municipi, nvl(ac.adreca,'.'), ac.provincia, ac.pais,  ac.usu_alta, ac.data_alta, ac.usu_modi, ac.data_modi
              FROM DANI_TB_ADRECA_CONTACTE ac;
              COMMIT;
                     
    END;
    
    
    PROCEDURE DANI_CREACIO_CONTACTES is       
         
    BEGIN

        INSERT INTO CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID)
                SELECT ID_CONTACTE, MAX(PRINCIPAL), MAX(ID_CARREC), MAX(DEPART), MAX(QUALITAT), MAX(DATA_ACTUALITZACIO), MIN(DATA_ALTA), MAX(DATA_MODI), MAX(DATA_BAIXA), MAX(USU_ALTA), MAX(USU_MODI), MAX(USU_BAIXA), MAX(TIPUS_CONTACTE_ID), MAX(N_VIP), MAX(ID_ADRECA), MAX(ENTITAT_ID), MAX(VISIBILITAT_ID), MAX(AMBIT_ID) 
        FROM (
        SELECT co1.ID_CONTACTE, NVL2(cp.ID_CONTACTE, '1','0') AS PRINCIPAL, car.id_carrec, co1.DEPART, 1 AS QUALITAT, ddm.DATA_ACTUALITZACIO, NVL(co1.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, co1.DATA_MODI,s.data_esborrat AS DATA_BAIXA, NVL(co1.USU_ALTA,'NO_INFO') AS USU_ALTA, co1.USU_MODI, s.usuari_esborrat AS USU_BAIXA, 2 AS TIPUS_CONTACTE_ID, co1.N_VIP, ad.ID_ADRECA, ec.ID AS ENTITAT_ID , 3 AS VISIBILITAT_ID  ,2 AS AMBIT_ID
        FROM  DANI_TB_ADRECA_CONTACTE ad, DANI_TB_CONTACTES_PRINCIPALS cp, DANI_TB_DATA_ACTUALITZACIO ddm, DANI_TB_CARRECS_CONTACTES car, DANI_TB_ENTITAT_CONTACTE ec, SUBJECTE s, 
            (SELECT ID_CONTACTE, MAX(DEPART) AS DEPART, MIN(DATA_ALTA) AS DATA_ALTA,MAX(DATA_MODI) AS DATA_MODI, MAX(USU_ALTA) AS USU_ALTA , MAX(USU_MODI) AS USU_MODI, MAX(N_VIP) AS N_VIP
             FROM Z_B03_CONTACTES_ID 
             GROUP BY ID_CONTACTE) co1
        WHERE co1.n_vip = s.id AND
              co1.ID_CONTACTE = ad.ID_CONTACTE (+) AND
              co1.ID_CONTACTE = cp.ID_CONTACTE (+) AND
              co1.ID_CONTACTE = ddm.ID_CONTACTE (+) AND
              co1.Id_Contacte = car.id_contacte (+) AND
              co1.ID_CONTACTE = ec.ID_CONTACTE (+)  AND 
              NOT EXISTS (SELECT * FROM CONTACTE c1 WHERE c1.id = co1.id_contacte)
        ) T
        GROUP BY T.ID_CONTACTE;
        
        
        -- PARTICULARES QUE TENIAN DIRECCION INFORMADA
        INSERT INTO CONTACTE (ID, ES_PRINCIPAL, CARREC_ID, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID,VISIBILITAT_ID, AMBIT_ID)
        SELECT ID_CONTACTE, MAX(PRINCIPAL), MAX(ID_CARREC), MAX(DEPART), MAX(QUALITAT), MAX(DATA_ACTUALITZACIO), MIN(DATA_ALTA), MAX(DATA_MODIF), MAX(DATA_BAIXA), MAX(USU_ALTA),  MAX(USU_MODIF), MAX(USU_BAIXA), MAX(TIPUS_CONTACTE_ID), MAX(N_VIP), MAX(ID_ADRECA), MAX(ENTITAT_ID), MAX(VISIBILITAT_ID), MAX(AMBIT_ID) 
        FROM (
        SELECT co1.ID_CONTACTE, NVL2(cp.ID_CONTACTE, '1','0') AS PRINCIPAL, car.id_carrec, '' AS DEPART, 1 AS QUALITAT, ddm.DATA_ACTUALITZACIO, NVL(co1.DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_ALTA, co1.DATA_MODIF, s.data_esborrat AS DATA_BAIXA, NVL(co1.USU_ALTA,'NO_INFO') AS USU_ALTA, co1.USU_MODIF, s.usuari_esborrat AS USU_BAIXA, 1 AS TIPUS_CONTACTE_ID, co1.N_VIP, ad.ID_ADRECA, ec.ID AS ENTITAT_ID , 3 AS VISIBILITAT_ID  ,2 AS AMBIT_ID
        FROM Z_B04_CONTACTES_PART_ID co1, DANI_TB_ADRECA_CONTACTE ad, DANI_TB_CONTACTES_PRINCIPALS cp, DANI_TB_DATA_ACTUALITZACIO ddm, DANI_TB_CARRECS_CONTACTES car, DANI_TB_ENTITAT_CONTACTE ec, SUBJECTE s
        WHERE co1.n_vip = s.id AND       
              co1.ID_CONTACTE = ad.ID_CONTACTE AND
              co1.ID_CONTACTE = cp.ID_CONTACTE (+) AND
              co1.ID_CONTACTE = ddm.ID_CONTACTE (+) AND
              co1.Id_Contacte = car.id_contacte (+) AND
              co1.ID_CONTACTE = ec.ID_CONTACTE (+)  AND 
              NOT EXISTS (SELECT * FROM CONTACTE c1 WHERE c1.id = co1.id_contacte)
        ) T
        GROUP BY T.ID_CONTACTE;
       
        COMMIT;               
    END;
    
    
    PROCEDURE DANI_CREATE_CLASSIFICACIO IS
      
    BEGIN
          -- AFEGIR ORDRE DE PRELACIO ENTRE CLASSIFICACIONS I ASSIGNAR IDENTIFICADOR INTERN   
          INSERT INTO DANI_TB_CLASSIFICACIONS 
          SELECT SEQ_DM_CLASSIFICACIO.NEXTVAL,cl.CODI, cl.DESCRIPCIO, p.orden
          FROM Z_TMP_VIPS_U_CLASSIFICACIONS cl, Z_TMP_VIPS_U_PRELA_LLISTA p, DANI_TB_CLASSIF_ACTIVES act
          WHERE cl.codi = p.classif AND cl.codi = act.codi AND
          NOT EXISTS (SELECT * FROM DANI_TB_CLASSIFICACIONS WHERE DANI_TB_CLASSIFICACIONS.CODI = cl.codi);
          COMMIT;    
          --OUTER METERLE FECHA DE MODIF LAS QUE NO ESTÉN. LAS QUE TENGAN ACT A NULO ---> SE PONE FECHA DE DATA_ESBORRAT Y LAS QUE EXISTAN 
          
          
          --OJO COGER DATA_ESBORRAT DE DANI_TB
          INSERT INTO DM_CLASSIFICACIO (ID,  CODI, DESCRIPCIO, PRELACIO,TIPOLOGIA_ID,AMBIT_ID, DATA_CREACIO, Usuari_Creacio)
          SELECT cl.id ,cl.CODI, NVL(cl.DESCRIPCIO,'.'), cl.ORDEN, 1, 2 ,SYSDATE, 'MIGRACIO' 
          FROM DANI_TB_CLASSIFICACIONS cl
          WHERE NOT EXISTS (SELECT * FROM DM_CLASSIFICACIO WHERE CODI = cl.codi);
          COMMIT;          
    
    END;
    
            
    -- CRUZAR CON CLASIFICACIONES ACTIVAS
    
    PROCEDURE DANI_CLASSIF_CONTACTE IS
    
    BEGIN
    
      INSERT INTO DANI_TB_CLASSIF_CONTACTE
      SELECT ID_CONTACTE, CLASSIF, N_PRELACIO, CL.ID AS ID_CLASSIFICACIO, NVL(USU_ALTA,'NO_INFO'), NVL(DATA_ALTA,TO_DATE('01/01/1970','dd/mm/yyyy')), USU_MODI, DATA_MODI 
      FROM Z_B03_CONTACTES_ID C, DM_CLASSIFICACIO CL
      WHERE CLASSIF <> 'GENER' AND CL.CODI = C.CLASSIF AND
      NOT EXISTS(SELECT * FROM DANI_TB_CLASSIF_CONTACTE cc WHERE cc.id_contacte = c.id_contacte AND cc.classif = c.CLASSIF );    
      COMMIT;
      
      INSERT INTO CONTACTE_CLASSIFICACIO (ID, PRELACIO, CLASSIFICACIO_ID, CONTACTE_ID, DATA_CREACIO, USUARI_CREACIO , USUARI_MODIFICACIO, DATA_MODIFICACIO)
      SELECT SEQ_CONTACTE_CLASSIFICACIO.NEXTVAL, cc.n_prelacio, cc.id_classificacio, cc.id_contacte, cc.data_alta,cc.usu_alta, cc.usu_modi, cc.data_modi  
      FROM DANI_TB_CLASSIF_CONTACTE cc
      WHERE EXISTS(SELECT * FROM CONTACTE c1 WHERE c1.id = cc.id_contacte);
      COMMIT;
      
    END;
        
    
    PROCEDURE B30_SUBJECTES_DIFUNTS IS       
          
    BEGIN
   
       INSERT INTO Z_B30_SUBJECTES_DIFUNTS
       SELECT N_VIP, 
       NVL2(DATA_ALTA,TRUNC(DATA_ALTA),TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_DEFUNCIO
       FROM Z_B03_CONTACTES_ID 
       WHERE CLASSIF = 'DEFU'; 
       COMMIT;          
   
    END;
    
    
    PROCEDURE DANI_ENTITATS IS 
      
    BEGIN
      
            -- VALORS UTILTIZATS DEL CATALEG
            INSERT INTO DANI_TB_ENTITAT
            SELECT SEQ_DM_ENTITAT.NEXTVAL, CODI, ENTITAT, ENTITAT NORM
            FROM (
                SELECT  MAX(CODI) AS CODI, MAX(NVL(ent.ENTITAT,ent.CODI)) AS ENTITAT, LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.','')) AS ENTITAT_NORM
                FROM Z_TMP_VIPS_U_ENTITAT ent, Z_B03_CONTACTES_ID c
                WHERE c.codi_entitat = ent.codi AND TRIM(ent.ENTITAT) IS NOT NULL
                GROUP BY LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.',''))
            ) T
            WHERE NOT EXISTS (SELECT * FROM DANI_TB_ENTITAT WHERE CODI = t.CODI) AND
              NOT EXISTS (SELECT * FROM DM_ENTITAT where LIMPIARCHARS(REPLACE(REPLACE(t.entitat,' de ',''), 'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE(DESCRIPCIO,' de ',''), 'S.A.',''))); COMMIT;
            
            
            -- VALORS EN FORMAT TEXT QUE COINCIDEIXEN AMB CATÀLEG
            INSERT INTO DANI_TB_ENTITAT
            SELECT SEQ_DM_ENTITAT.NEXTVAL, CODI, ENTITAT, ENTITAT NORM
            FROM (
                SELECT  MAX(CODI) AS CODI, MAX(NVL(ent.ENTITAT,ent.CODI)) AS ENTITAT, LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.','')) AS ENTITAT_NORM
                FROM Z_B03_CONTACTES_ID c, Z_TMP_VIPS_U_ENTITAT ent 
                WHERE LIMPIARCHARS(REPLACE(REPLACE(c.entitat,' de ',''), 'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE(ent.entitat,' de ',''),'S.A.',''))
                GROUP BY LIMPIARCHARS(REPLACE(REPLACE(ent.ENTITAT,' de ',''),'S.A.',''))
            ) T
            WHERE NOT EXISTS (SELECT * FROM DANI_TB_ENTITAT WHERE CODI = t.CODI) AND
                  NOT EXISTS (SELECT * FROM DM_ENTITAT where LIMPIARCHARS(REPLACE(REPLACE(t.entitat,' de ',''), 'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE(DESCRIPCIO,' de ',''), 'S.A.','')));
                
            -- ALTA CATALOGO DE LITERALES QUE NO ESTAN EN EL CATALOGO
            INSERT INTO DANI_TB_AUX_ENTITAS_CONTACTES
            SELECT SEQ_DM_ENTITAT.NEXTVAL AS ID, aec.entitat AS ENTITAT, aec.ENTITAT_NORM AS ENTITAT_NORMALITZADA FROM 
            (
              SELECT LIMPIARCHARS(REPLACE(REPLACE(ENTITAT,' de ',''), 'S.A.','')) AS ENTITAT_NORM, MAX(ENTITAT) AS ENTITAT
              FROM Z_B03_CONTACTES_ID
              WHERE REPLACE(REPLACE(ENTITAT,'.',''),'-','') IS NOT NULL AND CODI_ENTITAT IS NULL
              GROUP BY LIMPIARCHARS(REPLACE(REPLACE(ENTITAT,' de ',''),'S.A.',''))
            ) aec
            WHERE NOT EXISTS(SELECT * FROM DANI_TB_ENTITAT aux where aux.entitat_norm = aec.ENTITAT_NORM) AND
                  NOT EXISTS(SELECT * FROM DANI_TB_AUX_ENTITAS_CONTACTES aux2 WHERE aec.ENTITAT_NORM = aux2.entitat_normalitzada)    AND 
                  NOT EXISTS(SELECT * FROM DM_ENTITAT a1 where LIMPIARCHARS(REPLACE(REPLACE(a1.descripcio,' de ',''), 'S.A.','')) = aec.ENTITAT_NORM);
            COMMIT;
            
            -- INSERTA LOS QUE VIENEN DE CATALAOGO (y las que coinciden por descripcion con alguna del catàlogo)
            INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, USUARI_CREACIO)
            SELECT aux.id, aux.codi, aux.entitat, SYSDATE, 'MIGRACIO'
            FROM DANI_TB_ENTITAT aux
            WHERE NOT EXISTS (SELECT * FROM DM_ENTITAT e WHERE e.codi = aux.codi);
           
            -- INSERTA LAS 
            INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, USUARI_CREACIO)
            SELECT aux.id, aux.id, aux.entitat, SYSDATE, 'MIGRACIO'
            FROM DANI_TB_AUX_ENTITAS_CONTACTES aux
            WHERE NOT EXISTS (SELECT * FROM DM_ENTITAT e WHERE LIMPIARCHARS(REPLACE(REPLACE(e.descripcio,' de ',''), 'S.A.',''))= aux.entitat_normalitzada);
            COMMIT; 
            
    END;
    
    
    PROCEDURE DANI_ENTITATS_CONTACTES IS
    
    BEGIN
    
    
            INSERT INTO DANI_TB_ENTITAT_CONTACTE
            SELECT ent.id AS ID, c.id_contacte
            FROM DM_ENTITAT ent, Z_B03_CONTACTES_ID c
            WHERE LIMPIARCHARS(REPLACE(REPLACE(ent.descripcio,' de ',''),'S.A.','')) = LIMPIARCHARS(REPLACE(REPLACE( c.entitat,' de ',''),'S.A.','')) AND TRIM(REPLACE(REPLACE(c.entitat,'.',''),'-','')) IS NOT NULL AND 
            NOT EXISTS(SELECT * FROM DANI_TB_ENTITAT_CONTACTE ec WHERE ec.id_contacte = c.id_contacte and ec.id = ent.id)
            GROUP BY ent.id, c.id_contacte;
            COMMIT;
            
            INSERT INTO DANI_TB_ENTITAT_CONTACTE
            SELECT ent.id AS ID, c.id_contacte
            FROM DM_ENTITAT ent, Z_B03_CONTACTES_ID c
            WHERE LIMPIARCHARS(REPLACE(REPLACE(ent.descripcio,' de ',''),'S.A.','')) =  LIMPIARCHARS(REPLACE(REPLACE( c.entitat,' de ',''),'S.A.','')) AND TRIM(REPLACE(REPLACE(c.entitat,'.',''),'-','')) IS NOT NULL
            AND NOT EXISTS(SELECT * FROM DANI_TB_ENTITAT_CONTACTE ec WHERE ec.id_contacte = c.id_contacte and ec.id = ent.id)
            GROUP BY ent.id, c.id_contacte;
            COMMIT;
            
    END;
        
    
    -- CREACION DE CATALOGO DE CÀRRECS
    PROCEDURE DANI_CARRECS IS
      
    BEGIN
    
            INSERT INTO DANI_TB_CATALEG_CARRECS_NORM
            SELECT SEQ_DM_CARREC.NEXTVAL AS ID_CARREC, T.CARREC_NORM
            FROM ( 
                SELECT LIMPIARCHARS(CARREC) AS CARREC_NORM
                FROM Z_B03_CONTACTES_ID 
                WHERE TRIM(CARREC) IS NOT NULL
                GROUP BY LIMPIARCHARS(CARREC)
            )T
            WHERE NOT EXISTS (SELECT * FROM DANI_TB_CATALEG_CARRECS_NORM aux WHERE t.carrec_norm = aux.carrec_norm);
            COMMIT;
            
            INSERT INTO DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, USUARI_CREACIO)
            SELECT norm.ID_CARREC, MAX(c.CARREC) AS DESCRIPCIO, MAX(SYSDATE) AS DATA_CREACIO, MAX('MIGRACIO') AS USUARI_CREACIO
            FROM DANI_TB_CATALEG_CARRECS_NORM norm, Z_B03_CONTACTES_ID c
            WHERE LIMPIARCHARS(c.CARREC) = norm.CARREC_NORM 
            AND NOT EXISTS(SELECT * FROM DM_CARREC aux WHERE LIMPIARCHARS(aux.DESCRIPCIO) = norm.CARREC_NORM)
            GROUP BY norm.ID_CARREC;
            COMMIT;
                
    END;
       
    
    PROCEDURE DANI_CARRECS_CONTACTES IS
      
    BEGIN
    
           INSERT INTO DANI_TB_CARRECS_CONTACTES
            SELECT c.ID_CONTACTE, norm.ID_CARREC
            FROM Z_B03_CONTACTES_ID c, DANI_TB_CATALEG_CARRECS_NORM norm
            WHERE TRIM(c.CARREC) IS NOT NULL AND LIMPIARCHARS(c.CARREC) = norm.CARREC_NORM
            GROUP BY c.ID_CONTACTE, norm.ID_CARREC;
            COMMIT;
    
    END;
       
     
    PROCEDURE ACTUALITZAR_SEQUENCIES IS
      
       max_seq number;
    
    BEGIN
            
      SELECT MAX(ID) INTO max_seq FROM ACOMPANYANT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_ACOMPANYANT',max_seq); END IF;
      SELECT MAX(ID) INTO max_seq FROM ACTE;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_ACTE',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM ADRECA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_ADRECA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM CONTACTE;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_CONTACTE',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM CONTACTE_ACTE;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_CONTACTE_ACTE',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM CONTACTE_CLASSIFICACIO;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_CONTACTE_CLASSIFICACIO',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM CONTACTE_CONSENTIMENT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_CONTACTE_CONSENTIMENT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM CONTACTE_CORREU;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_CONTACTE_CORREU',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM CONTACTE_TELEFON;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_CONTACTE_TELEFON',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DADES_HISTORIC;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DADES_HISTORIC',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_AMBIT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_AMBIT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_CARREC;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_CARREC',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_CATALEG_DOCUMENT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_CATALEG_DOCUMENT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_CLASSIFICACIO;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_CLASSIFICACIO',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_DESTINATARI_PERSONA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_DESTINATARI_PERSONA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_ENTITAT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_ENTITAT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_ESTAT_TRUCADA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_ESTAT_TRUCADA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_IDIOMA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_IDIOMA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_OBSEQUI;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_OBSEQUI',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_PRIORITAT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_PRIORITAT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_RAO;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_RAO',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_SENTIT_TRUCADA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_SENTIT_TRUCADA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_TIPOLOGIA_CLASSIFICACIO;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_TIPOLOGIA_CLASSIFICACIO',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_TIPOLOGIA_OBSEQUI;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_TIPOLOGIA_OBSEQUI',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_TIPUS_CONTACTE;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_TIPUS_CONTACTE',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_TIPUS_SUBJECTE;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_TIPUS_SUBJECTE',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_TIPUS_TELEFON;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_TIPUS_TELEFON',max_seq);END IF;
--      SELECT MAX(ID) INTO max_seq FROM DM_TIPUS_VIA;
 --     IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_TIPUS_VIA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_TRACTAMENT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_TRACTAMENT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DM_VISIBILITAT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DM_VISIBILITAT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM DOCUMENT;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_DOCUMENT',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM HISTORIC_TRUCADA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_HISTORIC_TRUCADA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM INVENTARI;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_INVENTARI',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM PERSONA_RELACIONADA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_PERSONA_RELACIONADA',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM SUBJECTE;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_SUBJECTE',max_seq);END IF;
      SELECT MAX(ID) INTO max_seq FROM TRUCADA;
      IF (max_seq IS NOT NULL) THEN SET_SEQ('SEQ_TRUCADA',max_seq);END IF;
    
    END;
    
    PROCEDURE BORRAR_TODOS_DATOS IS
      
    BEGIN
              
        /* DELETE TABLAS AUXILIARES MIGRACION */      
--------- 
---------   
        DELETE FROM DANI_AUX_DM_TRACTAMENT;
        DELETE FROM DANI_TB_ACOMPANYANTS_SEPARATS;
        DELETE FROM DANI_TB_ADRECA_CONTACTE;
        DELETE FROM DANI_TB_AUX_CORREUS_PRINCIPALS;
        DELETE FROM DANI_TB_AUX_ENTITAS_CONTACTES;
        DELETE FROM DANI_TB_AUX_TEL_PRINCIPALS;
        DELETE FROM DANI_TB_CARRECS_CONTACTES;
        DELETE FROM DANI_TB_CATALEG_CARRECS_NORM;
        DELETE FROM DANI_TB_CLASSIFICACIONS;
        DELETE FROM DANI_TB_CLASSIF_ACTIVES;
        DELETE FROM DANI_TB_CLASSIF_CONTACTE;
        DELETE FROM DANI_TB_CONTACTES_AUX;
        DELETE FROM DANI_TB_CONTACTES_PRINCIPALS;
        DELETE FROM DANI_TB_CORREUS_CONTACTES;
        DELETE FROM DANI_TB_DATA_ACTUALITZACIO;
        DELETE FROM DANI_TB_ENTITAT;
        DELETE FROM DANI_TB_ENTITAT_CONTACTE;
        DELETE FROM Z_B30_SUBJECTES_DIFUNTS;
        DELETE FROM DANI_TB_SUBJECTES_PRIORITAT;
        DELETE FROM DANI_TB_TELEFONS_NO_NUMERICS;
        DELETE FROM DANI_TB_TELEFONS_NUMERICS;
        DELETE FROM DANI_TB_TIPUS_CONTACTES;
        DELETE FROM DANI_Y_VIPS_U_TELEFON_I99;

-------------------
-------------------
    
        DELETE FROM CONTACTE_CONSENTIMENT;
        DELETE FROM CONTACTE_CORREU;
        DELETE FROM CONTACTE_TELEFON;
        DELETE FROM ACOMPANYANT;
        DELETE FROM DADES_HISTORIC;
        DELETE FROM PERSONA_RELACIONADA;
        DELETE FROM HISTORIC_TRUCADA;
        DELETE FROM CONTACTE_CLASSIFICACIO;
        DELETE FROM TRUCADA_TEMA;
        DELETE FROM TRUCADA;        
        DELETE FROM CONTACTE;
        DELETE FROM ADRECA;
        DELETE FROM ACTE;
--        DELETE FROM AUX_DM_CLASSIFICACIO;
        DELETE FROM CONTACTE_ACTE;
        DELETE FROM DOCUMENT;
        DELETE FROM DOCUMENT_BAIXA_SUBJECTE;
        DELETE FROM INVENTARI;
        DELETE FROM SUBJECTE;        
        
        DELETE FROM Z_B01_DIF_CONT_VIPS;
        DELETE FROM Z_B02_DIF_CONT_PART_VIPS;
        DELETE FROM Z_B03_CONTACTES_ID;
        DELETE FROM Z_B04_CONTACTES_PART_ID;
        
        DELETE FROM DM_CLASSIFICACIO;
        DELETE FROM DM_CARREC;
        DELETE FROM DM_CATALEG_DOCUMENT;
        DELETE FROM DM_DESTINATARI_PERSONA;
        DELETE FROM DM_ENTITAT;
        DELETE FROM DM_RAO;
        DELETE FROM DM_ESTAT_TRUCADA;
        DELETE FROM DM_IDIOMA;
        DELETE FROM DM_OBSEQUI;
        DELETE FROM DM_PRIORITAT;
        DELETE FROM DM_SENTIT_TRUCADA;
        DELETE FROM DM_TIPOLOGIA_CLASSIFICACIO;
        DELETE FROM MANTENIMENT_DM;
        DELETE FROM DM_TIPOLOGIA_OBSEQUI;
        DELETE FROM DM_TIPUS_CONTACTE;
        DELETE FROM DM_TIPUS_SUBJECTE;
        DELETE FROM DM_TIPUS_TELEFON;
--        DELETE FROM DM_TIPUS_VIA;
        DELETE FROM DM_TRACTAMENT;
        DELETE FROM DM_VISIBILITAT;
        DELETE FROM DM_AMBIT;
        
        DELETE FROM DANI_TB_AUX_ENTITAS_CONTACTES;
        
        COMMIT;
     END;
     
     
     PROCEDURE RESET_SEQUENCES IS
          
        BEGIN
          
          RESET_SEQ('SEQ_ACOMPANYANT');
          RESET_SEQ('SEQ_ACTE');
          RESET_SEQ('SEQ_ADRECA');
          RESET_SEQ('SEQ_CONTACTE');
          RESET_SEQ('SEQ_CONTACTE_ACTE');
          RESET_SEQ('SEQ_CONTACTE_CLASSIFICACIO');
          RESET_SEQ('SEQ_CONTACTE_CONSENTIMENT');
          RESET_SEQ('SEQ_CONTACTE_CORREU');
          RESET_SEQ('SEQ_CONTACTE_TELEFON');
          RESET_SEQ('SEQ_DADES_HISTORIC');
          RESET_SEQ('SEQ_DM_AMBIT');
          RESET_SEQ('SEQ_DM_CARREC');
          RESET_SEQ('SEQ_DM_CATALEG_DOCUMENT');
          RESET_SEQ('SEQ_DM_CLASSIFICACIO');
          RESET_SEQ('SEQ_DM_DESTINATARI_PERSONA');
          RESET_SEQ('SEQ_DM_ENTITAT');
          RESET_SEQ('SEQ_DM_ESTAT_TRUCADA');
          RESET_SEQ('SEQ_DM_IDIOMA');
          RESET_SEQ('SEQ_DM_OBSEQUI');
          RESET_SEQ('SEQ_DM_PRIORITAT');
          RESET_SEQ('SEQ_DM_RAO');
          RESET_SEQ('SEQ_DM_SENTIT_TRUCADA');
          RESET_SEQ('SEQ_DM_TIPOLOGIA_CLASSIFICACIO');
          RESET_SEQ('SEQ_DM_TIPOLOGIA_OBSEQUI');
          RESET_SEQ('SEQ_DM_TIPUS_CONTACTE');
          RESET_SEQ('SEQ_DM_TIPUS_SUBJECTE');
          RESET_SEQ('SEQ_DM_TIPUS_TELEFON');
          RESET_SEQ('SEQ_DM_TIPUS_VIA');
          RESET_SEQ('SEQ_DM_TRACTAMENT');
          RESET_SEQ('SEQ_DM_VISIBILITAT');
          RESET_SEQ('SEQ_DOCUMENT');
          RESET_SEQ('SEQ_HISTORIC_TRUCADA');
          RESET_SEQ('SEQ_INVENTARI');
          RESET_SEQ('SEQ_PERSONA_RELACIONADA');
          RESET_SEQ('SEQ_SUBJECTE');
          RESET_SEQ('SEQ_TRUCADA');
    
    END;
    
    PROCEDURE INSERT_MESTRES IS
      
    BEGIN
      
      INSERT INTO  DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'Telefon fix',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'Telefon mòbil MOBIL',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'Fax',SYSDATE,null,null,'MIGRACIO',null,null);


      INSERT INTO  DM_TIPUS_SUBJECTE (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'PERSONA','Persona',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  DM_TIPUS_SUBJECTE (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'ENTITAT','Entitat',SYSDATE,null,null,'MIGRACIO',null,null);


      INSERT INTO  DM_AMBIT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (1,'ALCALDIA','Alcaldia',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  DM_AMBIT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (2,'PROTOCOL','Protocol',SYSDATE,null,null,'MIGRACIO',null,null);


      INSERT INTO SINTAGMA_U.DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (1, '1-SC', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
      INSERT INTO SINTAGMA_U.DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (2, 'PRIORITAT2', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
      INSERT INTO SINTAGMA_U.DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (3, 'PRIORITAT3', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
      INSERT INTO SINTAGMA_U.DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (4, 'PRIORITAT4', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);


      INSERT INTO  SINTAGMA_U.DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'JOCS FLORALS',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  SINTAGMA_U.DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'MEDALLES',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  SINTAGMA_U.DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'CONCERTS',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  SINTAGMA_U.DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (4,'OBJECTES VARIS',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  SINTAGMA_U.DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (5,'FOTOS i VIDEO',SYSDATE,null,null,'MIGRACIO',null,null);

      INSERT INTO  SINTAGMA_U.DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (5,'FOTOS PAPER - NO',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
      INSERT INTO  SINTAGMA_U.DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (4,'FOTOS PAPER - SI',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
      INSERT INTO  SINTAGMA_U.DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (3,'CD -  NO',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
      INSERT INTO  SINTAGMA_U.DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (2,'CD -  SI',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
      INSERT INTO  SINTAGMA_U.DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (6,'CD - SI (FOTOS i VIDEO)',1,SYSDATE,null,null,'MIGRACIO',null,null,5);


      INSERT INTO  DM_VISIBILITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'PUBLICA','Pública',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  DM_VISIBILITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'PRIVADA','Privada',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  DM_VISIBILITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'COMPARTIDA','Alcaldia',SYSDATE,null,null,'MIGRACIO',null,null);


      INSERT INTO  DM_TIPUS_CONTACTE (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (1,'PERSONAL','Personal',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO  DM_TIPUS_CONTACTE (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (2,'PROFESSIONAL','Professional',SYSDATE,null,null,'MIGRACIO',null,null);


      INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (1,'Castellà',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (2,'Anglés',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (3,'Català',SYSDATE,null,null,'MIGRACIO',null,null);
      INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (4,'Francés',SYSDATE,null,null,'MIGRACIO',null,null);


      INSERT INTO DM_TIPOLOGIA_CLASSIFICACIO (AMBIT_ID, ID,DESCRIPCIO, DATA_CREACIO,USUARI_CREACIO) VALUES(2,1,'PROVA',SYSDATE,'MIGRACIO');



      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('GOES','0001 - Govern Espanyol');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('OGIN','0005 - Organismes i governs internacionals');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PCAU','0010 - Presidents de Comunitats Autònomes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MECO','0015 - Mesa del Congreso de los Diputados');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MCDI','0016 - Mesa del Congrés dels Diputats i Diputades');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MESE','0020 - Mesa del Senado');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DICB','0025 - Diputats de Barcelona al Congrès amb domicili a BCN');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DICC','0026 - Diputats de Catalunya al Congrès');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('SEBA','0030 - Senadors per Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('SEPC','0035 - Senadors que represent. al Parlament de Cat. al Senat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('SCSE','0037 - Senadors catalans al Senat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DCPE','0040 - Diputats Catalans al Parlament Europeu');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PSAS','0045 - Primeres Autoritats Catalanes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AUTC','0050 - Autoritats Catalanes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PAPS','0055 - Presidents i Secretaris Grals. dels Partits Polítics');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MEPC','0060 - Mesa del Parlament de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PGPA','0065 - President i Portaveus dels G P -Parlament Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PDGP','0070 - Portaveus del Grups Parlamentaris');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DIPC','0075 - Diputats al Parlament de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CPM4','0076 - Càrrecs Politics  (Diputació, Generalitat, Parlament)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EXPP','0080 - Expresidents del Parlament de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CEGC','0085 - Consell Executiu de la Generalitat de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('SGGE','0090 - Secretaris Generals de la Generalitat de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EXGE','0100 - Expresidents Generalitat de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('REGI','0105 - Corporació Municipal de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CAAJ','0115 - Comissionats de l''Alcaldia - Ajuntament de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('GAAJ','0120 - Gerents dels Sectors d''Actuació - Ajunt. de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CSDI','0125 - Gerents de Districtes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('GEAJ','0130 - Orga.Autòn.(1)Empreses Mpals(2) i Empreses Mixtes(3)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CDAJ','0135 - Càrrecs Directius de l''Ajuntament de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CNAJ','0140 - Cossos Nacionals de l''Ajuntament de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CGTA','0145 - Caps Gab. Alcaldia, Tinents d''Alcalde i Regidors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CGAJ','0150 - Assessors Tècnics dels Regidors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CTDI','0155 - Consellers Tècnics dels Districtes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COCV','0160 - Consellers Districte de Ciutat Vella');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CODE','0165 - Consellers Districte de l''Eixample');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COSM','0170 - Consellers Districte de Sants-Montjuïc');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COLC','0175 - Consellers Districte de Les Corts');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COSG','0180 - Consellers Districte Sarrià-Sant Gervasi');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CODG','0185 - Consellers Districte de Gràcia');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COHG','0190 - Consellers Districte d''Horta-Guinardó');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CONB','0195 - Consellers Districte Nou Barris');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COSA','0200 - Consellers Districte de Sant Andreu');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COND','0205 - Consellers Districte Sant Martí');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('INGU','0210 - Intendents Guàrdia Urbana');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EXAL','0215 - Ex-Alcaldes de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EXRE','0220 - Ex-Regidors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ASCC','0225 - Associació Consell de Cent');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PDCA','0245 - Presidents de les Diputacions de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CGDI','0250 - Diputació de Barcelona-Presidenta i Diputats Àrees');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DPCA','0255 - Diputats president i coord. àrea Diputació de BCN');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DIPU','0260 - Diputats  - Diputació de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AES7','0265 - Alcaldes de les grans ciutats espanyoles');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ATLG','0270 - Alcaldes de les capitals de províncies catalanes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AEME','0275 - Alcaldes. Entitats Metropolitanes i Mancomunitat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ALCO','0280 - Alcaldes 2a. Corona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ACCA','0285 - Alcaldes Ajuntaments Capitals Comunitats Autònomes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ACOM','0290 - Alcaldes Ciutats Corredor Mediterrani');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('APCV','0291 - Alcaldes poblacions catalanes visitades per l''alcal');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FEMU','0295 - Federació de Municipis de Catalunya, Fed. Mun. España');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ASMU','0300 - Associació Catalana Municipis - President');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CCAB','0305- Cos Consular a Barcelona (CE=PRE.100)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CECC','0310 - Comitè Executiu del Cos Consular');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CSEG','0315 - Cossos de Seguretat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JLSB','0320 - Junta Local de Seguretat de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COCI','0322 - Consell de la Ciutat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('VCOM','0323 - Vicepresidents/tes Consells Municipals');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('REUN','0325 - Rectors Universitats Catalanes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AUBC','0327 - Autoritats Socials Barcelona en Comú');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MCBC','0328 - Membres Candidatura Barcelona en Comú');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('LCBC','0329 - Convidats Entitats Socials');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ENCU','0330 - Institucions Culturals');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('REAC','0335 - Reials Acadèmies');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ESCI','0340 - Escriptors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ESCU','0345 - Escultors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('HIST','0350 - Historiadors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PENC','0353 - PEN Català (Plataforma projecció intern. literatura C');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EDIT','0355 - Editors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PINT','0360 - Pintors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('GADA','0365 - Galeries d''Art');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DISS','0370 -  Dissenyadors');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COLE','0375 - Col.leccionistes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FOTO','0380 - Fotògrafs');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MUSE','0385 - Museus');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ICEB','0390 - Instituts Culturals Estrangers a Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('TCIE','0395 - Teatre, Cinema i Música');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MICO','0400 - Mitjans de Comunicació');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PUBL','0405 - Empresaris-agències publicitat i disseny');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('BTVCA','0406 - BTV  Consell Administració');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IEC','0415 - Institut d''estudis catalans (Consell permanent)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CDIC','0416 - Junta Directiva de l''Institut de Cultura de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JDAB','0420 - Junta Directiva Ateneu Barcelonès');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JDGE','0422 - GREMI EDITORS (JUNTA DIRECTIVA)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JUDIR','0425 - Junta Directiva d''Ateneus de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JDOC','0430 - Junta Directiva d''Òmnium Cultural');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CONCA','0435 - Consell Nacional de la Cultura i de les Arts (CoNCA)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('BIBL','0440 - Consorci de Biblioteques de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JDGL','0445 - Gremi de Llibreters de Catalunya (JUNTA DIRECTIVA)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IRLL','0450 - Institut Ramon Llull (JUNTA DIRECTIVA)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CAAL','0453 - Càrrecs Alcaldia Ajuntament de barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PCCI','0455 - Ple Consell Cultura ICUB  ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AELC','0460 - Associació d''Escriptors en llengua Catalana');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CCLP','0462 - Comissió de la Lectura Pública');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ASEC','0463 -Associació d''Editors en Llengua Catalana (Junta Direc)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ACEC','0464 -  Associació Col·legial d''Escriptors de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JDBL','0465 - Junta directiva de les Bones Lletres');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('RMEB','0465 - Representants del Mon Empresarial');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AGEC','0469 - AGENTS ECONÒMICS DE LA CIUTAT');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('BANC','0470 - Entitats Financeres  Bancs (pre. 0)  Caixes (prel. 1)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('OROF','0471 - Organismes Oficials a Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AESB','0472 - Agents Económics i Serveis ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ESNB','0473 - ESCOLES DE NEGOCIS DE BARCELONA');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('G16B','0475 - El G-16 de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ARQU','0480 - Arquitectes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CECB','0490 - Cambres de Comerç Estrangeres a Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PMWC','0491 - Patronato Mobile World Capital');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CMWC','0492 - COMISIÓ EXECUTIVA MOBILE WORLD CAPITAL');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('HOTE','0495 - Hotels');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PECB','0500  - Presidents Eixos Comercials de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EEBA','0505 - Empreses Estrangeres ubicades a Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('XAES','0510 - Xarxa d''Economia Solidaria');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ALER','0511-REUNIÓ ALCALDESSA-EMPRESES RENOVABLES (BCN  ACTIVA)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ALDO','0512-ESMORZAR  ALCALDESSA-DONES EMPRENADORES (BCN ACTIVA)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ALUN','0513-ESMORZAR ALCALDESSA-UNIVERSITATS');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ALEM','0514-ESMORZAR ALCALDESSA-EMPRESES');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IVAC','0515 - REUNIÓ TRACTAMENT IVA CULTURAL');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CPRO','0516 - CONSELL ASSESSOR DE PROMOCIÓ DE CIUTAT');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('RSCB','0525 - Representants de la Societat Civil de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('SIND','0530 - Sindicats i Agrupacions Empresarials');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ASVB','0531 - Associació de Veïns i Veïnes de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('GREM','0535  - Gremis');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JDGR','0538 - Junta directiva Consell de Gremis ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COOF','0540 - Col.legis Oficials');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CRBA','0542 - Confessions Religioses a Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('SAFI','0545 - Presidents de Salons de Fira');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CGFI','0550 - Consell General de la Fira de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CETB','0551 - Turisme de Barcelona - Comitè Executiu');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CEFI','0555 - Consell d''Administració Fira de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CGTB','0560 - Turisme de Barcelona -Consell General');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CGPE','0566 - Pla Estratègic Metropolità BCN- Consell Rector');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CARE','0570 - Cases Regionals');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ECAS','0572 - Entitats Catalanes d''Acció Social');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ENOC','0572 - Entitats de Nova Ciutadania');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FECR','0575 - Federacions Cases Regionals');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ENCI','0580 - Entitats Cíviques (0) Associació (1) Fundació (2)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ONGS','0581 - Federacions ONGS');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IDHC','0582 - Institut de Drets Humans de Catalunya');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('TESE','0585 - Tercer Sector');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ENME','0590 - Entitats Memòria Històrica');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CUIN','0590 - Restauradors Vips de BCN  (Cuiners)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FEDE','0595 - Federacions, clubs, entitats esportives i esportiste ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AMCI','0600 - Mon  mèdic i científic');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ACCC','0602 - Associació Catalana de Comunicació Científica');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EMAG','0603 - AGÈNCIA EUROPEA DEL MEDICAMENT - COMITÈ SUPORT');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('TIRB','0604 - Trobada Innovació i Recerca Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AECB','0605 - Associació Esport Cultura Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MEOR','0610 - Medalles de la Ciutat en la Categoria d''Or');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('UFEC','0610 - Unió de Federacions Esportives Catalanes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MEHO','0615 - Medalles d''Honor de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MECV','0620 - Medalla d''Or Merit cívic');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MECI','0625 - Medalles d''Or al mèrit Científic');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MEAR','0630 - Medalles d''Or al Mèrit Artístic');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MOMC','0635 - Medalla d''Or al Mèrit Cultural');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MOME','0640 - Medalla d''Or al Mèrit Esportiu');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CEEA','0718 - Comitè Executiu Consell Cent');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CBES','0850 - Consell Municipal de Benestar Social');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('BREG','0890 - Barcelona Regional - Comitè de Direcció');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AMBA','0892 - Entitats Area Metropolitana de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CEPE','0915 - Pla Estratègic Metropolità de BCN  Comissió Executiva');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PCCB','0955 - Consell Municipal de Cultura de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CMDE','1000 - Consell Municipal d''Esports');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FCIC','1180 - Fòrum Ciutat i Comerç');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CTRI','1185 - Consell Tributari');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('RRPP','1210 - Caps de Protocol i Relacions Institucionals');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('2022','1250 - Candidatura Olímpica Barcelona-Pirineus 2022');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PRME','1286 - Pregoners - Pregoneres de la Festa de La Mercè');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CMER','1290 - Cartells Mercè 1980-1997');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('APBA','1295 - Alcaldes Diada Castellera');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('APMD','1440 - Anfitrions de Pasqual Maragall als Districtes');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FMPM','1445 - Convidats  Pasqual Maragall');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PMAL','1450 - Llistat Gabinet Alcaldia Medall Pasqual Margall ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('REMA','1455 - REGIDORS MARAGALL');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('VMPM','1460 -Varis Medalla Pasqual maragall');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CCID','1500 - Consell Mpal Cooperació Internacional desenvolupament');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FAVB','1500-Fed. d''Associacions de Veïns i Veïnes de Barcelona(J.D.');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ALSP','1705- Alcaldes Pas Torxa Paralímpica');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ALSU','1710- Alcaldes de les Ciutats Subseus Olímpiques');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ADCB','1715 - Assemblea del COOB''92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CECO','1720 - Comitè Executiu del COOB''92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CHJJ','1725- Comitè d''Honor X Aniversari JJ.OO. Barcelona''92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DB92','1730 - Diplomes Ciutat de Barcelona''92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ERME','1735 - Ex-Regidors Xè.Aniv.Com.Candidatura Barcelona JJ.OO.');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MEBA','1740 - Medalles Barcelona 92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MOJO','1745 - Medalles d''Or Jocs Olímpics''92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MOJP','1750 - Medalles d''Or Jocs Paralímpics''92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('MPJO','1755 - Medalles de Plata Jocs Olímpics''92');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DEFU','1900 - Defuncions');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('GENER','1905 - GENERIC - Classificacio generica');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CCCO','2000 - Consell Ciutat i Comerç');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CMCO','2000 - Consell Municipal de Consum');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PICU','2000 - Proposta convidats inauguració Born - ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ACCO','2015 - Alcaldes de capitals de Comarques');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CAB1','2030 - Cabruja - Proposta Llista Convidats (20 anys JJOO''92)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('EREA','2050 - Exregidors d''Esports Ajuntament de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('SGEG','2095 - Secretaris Generals de l''Esport - Generalitat de Cat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AUM7','3500 - AUTORITATS MEDALLES D''HONOR 2017');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PPM7','4010 - Peticions Protocol Mercè 2017');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('AE17','AGENTS ECONÒMICS 2017');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ARPL','Arts Plastiques');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CAPM','Cartes Autoritats Pregó Mercè');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CIRC','Circ Cultura ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CC17','CIUTAT CONVIDADA MERCÈ 2017');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CPTC','Comissió Permanent Consell Municipal Turisme i Ciutat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB05','Comité de Direcció ICUB Mercè 2017  ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB12','Comité Executiu Consell Cultura Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('COMEX','COMITE EXECUTIU EXREGIDORS AJUNTAMENT BCN JJOO12');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB17','CONCA Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB09','Consell Administració ICUB Mercè 2017');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CESB','Consell Econòmic i Social de Barcelona');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CC15','CONSELL MUNICIPAL  COOPERACIÓ INTERNACIONAL PER EL DESENVOLU');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CTIC','Consell Municipal Turisme i Ciutat');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('CCSH','Consell Social de l''Habitatge');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('DANS','Dansa');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB11','Dir. Equip.Culturals Artístics Consorciats Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB07','Direcció Segona tinència Mercè 2017  ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ICUB','DIRECTORS DE L''ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB10','Directors Museus-Espais i Directors Artístics Mercè 17 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB03','Dissenyadors Cartells Mercè 2017  ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB08','Equip Festes Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('RE92','Exregidors JJOO''92 (mandat 1991-1995)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FRSS','Familiar Regidors Saló de Cent 2015');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FA15','Familiars Alcaldessa Presa de Possessió 2015');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FRAS','Familiars Regidors Altres Salons 2015');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('FOT7','Fotografs 2017');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('GAD7','Galeries d''art 17');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB18','ICUB Com. Seg. Seguici Popular Bcn Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ICIC','Institucions Culturals (2017)');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('ESC7','literatura');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('LITE','LITERATURA');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PP17','MAILING PREGONER  MERCÈ 2017');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB15','PATROCINADORS MERCÈ EMPRESES Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB16','PATROCINADORS MERCE MITJANS Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB14','Patrons Fundació Barcelona Cultura Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PEPR','Peticions Protocol Presa Possessió 2015');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB13','Ple Consell Cultura Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB02','Pregoners Mercè 2017 ICUB');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('PC16','PREMIS CIUTAT DE BARCELONA 2016');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('IB06','Reunió de Direcció ICUB Mercè 2017  ICUB ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('TTRI','Taula Treball per Recerca i Innovació ');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('TBCR','0510 - Membres Taula Barcelona Creixement');
      INSERT INTO DANI_TB_CLASSIF_ACTIVES (CODI, DESCRIPCIO) VALUES ('JDEX','351-ASS. CATALANA EXPRESSOS POLÍTICS DEL FRANQUISME');

COMMIT;
    
    
    END;
 
    PROCEDURE NYAPA_CLASSIFICACIONS IS
      
    BEGIN
      
      INSERT INTO DM_CLASSIFICACIO (ID,DESCRIPCIO,CODI,PRELACIO,DATA_CREACIO,USUARI_CREACIO, TIPOLOGIA_ID, AMBIT_ID) VALUES (99999, '1905 - GENERIC - Classificació genèrica', 'GENER',99,SYSDATE,'MIGRACIO',1,2);         
    
      INSERT INTO CONTACTE_CLASSIFICACIO (ID, PRELACIO, CLASSIFICACIO_ID, CONTACTE_ID, DATA_CREACIO, USUARI_CREACIO)
      SELECT SEQ_CONTACTE_CLASSIFICACIO.NEXTVAL, 99, (SELECT ID FROM DM_CLASSIFICACIO WHERE CODI = 'GENER'), co.id, SYSDATE, 'MIGRACIO'
      FROM CONTACTE_CLASSIFICACIO cc, CONTACTE co
      WHERE co.id = cc.contacte_id (+) AND 
      cc.id IS NULL;
      COMMIT;
    
    END;
   
END MIGRACIO_VIPS_DANI;

/
