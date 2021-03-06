--------------------------------------------------------
--  DDL for Package Body D_01_CONTACTES_RISPLUS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."D_01_CONTACTES_RISPLUS" AS

PROCEDURE D01_EXTRAER_TRACTAMENT IS
    BEGIN
    
    INSERT INTO Z_D01_DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MIGRACIO, ABREUJADA)
               		SELECT  (ConstTractament +  AUX_SEQ_RISPLUS_DM_TRACTAMENT.NEXTVAL) AS ID, 
                            NEW_TRACTAMENT.TRACTAMENT AS DESCRIPCIO,
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MIGRACIO,
                            NULL AS ABREUJADA
					FROM (
						SELECT Trim(RISPLUS.TRACTAMENT)  AS TRACTAMENT
						FROM Z_TMP_RISPLUS_U_CONTACTES RISPLUS
						LEFT OUTER JOIN 
	  						DM_TRACTAMENT tractament
							on TRIM(RISPLUS.TRACTAMENT) = TRIM(tractament.DESCRIPCIO)
							WHERE tractament.DESCRIPCIO IS NULL
						GROUP BY trim(RISPLUS.TRACTAMENT)					
	    				ORDER BY 1
					) NEW_TRACTAMENT
                    WHERE NEW_TRACTAMENT.TRACTAMENT IS NOT NULL 
                      AND NOT EXISTS (SELECT * 
                                      FROM Z_D01_DM_TRACTAMENT ANTIGUOS
                                      WHERE TRIM(ANTIGUOS.DESCRIPCIO) = TRIM(NEW_TRACTAMENT.TRACTAMENT)
                                      );
    COMMIT;
    END;
    
    
    PROCEDURE D02_DM_TRACTAMENTS IS
    BEGIN
        
        INSERT INTO DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA)
            SELECT  ID AS ID, 
                    DESCRIPCIO AS DESCRIPCIO,                    
                    DATA_CREACIO AS CREACIO,
                    DATA_ESBORRAT AS DATA_ESBORRAT,
                    DATA_MODIFICACIO AS DATA_MODIFICACIO,
                    USUARI_CREACIO AS USUARI_CREACIO,
                    USUARI_ESBORRAT AS USUARI_ESBORRAT,
                    USUARI_MIGRACIO AS USUARI_MIGRACIO,
                    ABREUJADA AS ABREUJADA
               FROM Z_D01_DM_TRACTAMENT NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                 FROM DM_TRACTAMENT ANTIGUOS
                                WHERE NUEVOS.ID = ANTIGUOS.ID
                               );
    
    COMMIT;
    END;
    
    
    PROCEDURE D03_EXTRAER_CARREC IS
    BEGIN
        
        INSERT INTO Z_D03_DM_CARREC
                    SELECT  (ConstCarrec +  AUX_SEQ_RISPLUS_DM_CARREC.NEXTVAL) AS ID, 
                            NEW_CARREC.CARREC  AS DESCRIPCIO,
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MIGRACIO
                    FROM (
                            SELECT Trim(RISPLUS.carrec)  AS CARREC
                            FROM Z_TMP_RISPLUS_U_CONTACTES RISPLUS
                                LEFT OUTER JOIN 
                                        DM_CARREC carrec
                                on FUNC_NORMALITZAR(RISPLUS.carrec) = FUNC_NORMALITZAR(carrec.DESCRIPCIO)
							WHERE carrec.DESCRIPCIO IS NULL
                            GROUP BY TRIM(RISPLUS.carrec)					
                            ORDER BY 1
                    ) NEW_CARREC                    
                    WHERE FUNC_NORMALITZAR(NEW_CARREC.CARREC) IS NOT NULL
                      AND NOT EXISTS (SELECT * 
                    				  FROM Z_D03_DM_CARREC ANTIGUOS
                    				  WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR(NEW_CARREC.CARREC));
    
    
    COMMIT;
    END;
    
    PROCEDURE D04_DM_CARREC IS
    BEGIN
       INSERT INTO DM_CARREC
                SELECT  ID, 
                        DESCRIPCIO,
                        DATA_CREACIO,
                        DATA_ESBORRAT,
                        DATA_MODIFICACIO,
                        USUARI_CREACIO,
                        USUARI_ESBORRAT,
                        USUARI_MIGRACIO
                  FROM  Z_D03_DM_CARREC NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM DM_CARREC ANTIGUOS
                                    WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR(NUEVOS.DESCRIPCIO)
                                  );
    
    
    
    COMMIT;
    END;
    
    
    
    PROCEDURE D10_ENTITAT_EXISTENTES IS
    BEGIN
    
        INSERT INTO Z_D10_ENTITAT_EXISTENTE (CONTACTE_ID, ENTITAT_ID, DESCRIPCIO_ENTITAT, NOM_NORMALIZAT)
            SELECT CONTACTE_ID, ENTITAT_ID, NUEVOS.DESCRIPCIO_ENTITAT, NUEVOS.NOM_NORMALIZAT 
               FROM (
                     SELECT CONTACTE.CONTACTEID AS CONTACTE_ID, 
                            DM_ENTITAT.ID AS ENTITAT_ID, 
                            DM_ENTITAT.DESCRIPCIO AS DESCRIPCIO_ENTITAT, 
                            ENTITAT.NOM_NORMALIZAT AS NOM_NORMALIZAT 
                     FROM (
                            SELECT FUNC_NORMALITZAR_ENTITAT(empresa) AS NOM_NORMALIZAT
                            FROM Z_TMP_RISPLUS_U_CONTACTES
                            WHERE empresa IS NOT null  
                            GROUP BY FUNC_NORMALITZAR_ENTITAT(EMPRESA)
                            ORDER BY 1
                          ) ENTITAT,
                            DM_ENTITAT,
                            Z_TMP_RISPLUS_U_CONTACTES CONTACTE
                    WHERE FUNC_NORMALITZAR_ENTITAT(DM_ENTITAT.DESCRIPCIO) = ENTITAT.NOM_NORMALIZAT
                    AND FUNC_NORMALITZAR_ENTITAT(CONTACTE.EMPRESA) = ENTITAT.NOM_NORMALIZAT
                ) NUEVOS
                WHERE NOT EXISTS ( SELECT 1 
                                   FROM Z_D10_ENTITAT_EXISTENTE ANTIGUOS 
                                   WHERE NUEVOS.ENTITAT_ID = ANTIGUOS.ENTITAT_ID);
                
    
    COMMIT;
    END;
    
    PROCEDURE ERR_CONTACTES_EMPRESA_NULL IS
    BEGIN
    
        INSERT INTO ERR_R_CONTACTES_EMPRESA_NULL
             SELECT CONTACTE_ID,
                   'TIENE CAMPO EMPRESA A NULL' AS ERR,
                   'Z_TMP_RISPLUS_U_CONTACTES' AS TABLA,
                   'RISPLUS' AS ESQUEMA          
               FROM (
                     SELECT CONTACTE.CONTACTEID AS CONTACTE_ID
                     FROM Z_TMP_RISPLUS_U_CONTACTES CONTACTE
                    WHERE EMPRESA IS NULL
                ) NUEVOS
                WHERE NOT EXISTS ( SELECT 1 
                                   FROM ERR_R_CONTACTES_EMPRESA_NULL ANTIGUOS 
                                   WHERE NUEVOS.CONTACTE_ID = ANTIGUOS.CONTACTE_ID);
    
    
    
    COMMIT;
    END;
    
    
    -- Aislamos las entidades agrupadas y les a�adimos un id �nico
    PROCEDURE D11_A_ENTITAT_NO_EXISTENTES IS
    BEGIN
    
        INSERT INTO  Z_D11_A_ENTITAT_NO_EXISTENTE (ENTITAT_ID, NOM_NORMALIZAT)
             SELECT (ConstEntitat +  AUX_SEQ_RISPLUS_DM_ENTITAT.NEXTVAL) AS entitat_id, 
                    Nom_Normalizat
             FROM (
                    SELECT FUNC_NORMALITZAR_ENTITAT(Contactes.Empresa) AS Nom_Normalizat
                    FROM Z_TMP_RISPLUS_U_CONTACTES CONTACTES
                    WHERE EMPRESA IS NOT NULL  
                      AND NOT EXISTS(SELECT 1 
                                     FROM Z_D10_ENTITAT_EXISTENTE D10 
                                     WHERE D10.NOM_NORMALIZAT=FUNC_NORMALITZAR_ENTITAT(CONTACTES.EMPRESA)
                                    )
                    GROUP BY FUNC_NORMALITZAR_ENTITAT(Contactes.Empresa)
                   ) nuevos
                   where not exists (select 1 
                                     from Z_D11_A_ENTITAT_NO_EXISTENTE antiguos
                                     where antiguos.Nom_Normalizat = nuevos.Nom_Normalizat
                                    );

    COMMIT;
    END;
    
    
    PROCEDURE D11_B_ENTITAT_NO_EXISTENTES IS
    BEGIN
        INSERT INTO Z_D11_B_ENTITAT_NO_EXISTENTES (CONTACTEID, EMPRESA, ENTITAT_ID, NOM_NORMALIZAT) 
           SELECT CONTACTEID, 
                  EMPRESA, 
                  ENTITAT_ID, 
                  NOM_NORMALIZAT
             FROM (     
                     SELECT CONTACtes.CONTACTEID,
                            CONTACtes.EMPRESA,
                            d11.ENTITAT_ID, 
                            d11.NOM_NORMALIZAT   
                     FROM  Z_D11_A_ENTITAT_NO_EXISTENTE D11,
                           Z_TMP_RISPLUS_U_CONTACTES CONTACTES
                     WHERE D11.NOM_NORMALIZAT = FUNC_NORMALITZAR_ENTITAT(CONTACTES.EMPRESA)
                   ) NUEVOS
             WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_D11_B_ENTITAT_NO_EXISTENTES ANTIGUOS
                                WHERE ANTIGUOS.CONTACTEID = NUEVOS.CONTACTEID
                              );  
                     
    COMMIT;
    END;
    
    
    PROCEDURE D15_ENTITAT_CONTACTES IS
    BEGIN
        INSERT INTO Z_D15_ENTITAT_CONTACTE (CONTACTE_ID, ENTITAT_ID, DESCRIPCIO_ENTITAT, NOM_NORMALIZAT)
         SELECT CONTACTE_ID, 
                 ENTITAT_ID, 
                 DESCRIPCIO_ENTITAT, 
                 NOM_NORMALIZAT
           FROM (                 
                    SELECT CONTACTE_ID, 
                           ENTITAT_ID, 
                           DESCRIPCIO_ENTITAT, 
                           NOM_NORMALIZAT
                    FROM Z_D10_ENTITAT_EXISTENTE
                        UNION                 
                    SELECT CONTACTEID, 
                           ENTITAT_ID, 
                           EMPRESA,
                           NOM_NORMALIZAT    
                    FROM Z_D11_B_ENTITAT_NO_EXISTENTES
                 ) NUEVOS
           WHERE NOT EXISTS (SELECT 1 
                               FROM Z_D15_ENTITAT_CONTACTE ANTIGUOS
                              WHERE ANTIGUOS.CONTACTE_ID = NUEVOS.CONTACTE_ID
                            );  
            
            
    COMMIT;
    END;
    
    PROCEDURE D16_DM_ENTITAT IS
    BEGIN
    
                    INSERT INTO DM_ENTITAT
                               SELECT ID AS ID,
                                      ID AS CODI,
                                      (SELECT DESCRIPCIO_ENTITAT FROM Z_D15_ENTITAT_CONTACTE WHERE entitat_id = ID AND ROWNUM=1)  AS DESCRIPCIO,
                                      sysdate AS DATA_CREACIO,
                                      NULL AS DATA_ESBORRAT,
                                      NULL AS DATA_MODIFICACIO,
                                      'MIGRACIO' AS USUARI_CREACIO,
                                      NULL AS USUARI_ESBORRAT,
                                      NULL AS USUARI_MODIFICACIO
                              FROM (
                                       SELECT nuevos.entitat_id AS id	          
                                         FROM Z_D15_ENTITAT_CONTACTE NUEVOS
                                         GROUP BY nuevos.entitat_id
                                    ) GROUP_ENTIDADES  
                                WHERE NOT EXISTS (SELECT 1
                                                    FROM DM_ENTITAT antiguos
                                                   WHERE ANTIGUOS.ID = GROUP_ENTIDADES.ID
                                                 );
    
    
    
    COMMIT;
    END;

    
    -- SE AGRUPAN LOS SUBJECTES POR NOMBRE Y EMPRESA Y CARGO Y SE ASIGNA UN ID POR NOM_NORMALITZAT
    PROCEDURE D20_SUBJECTES_PERSONAS_UNICOS IS
    BEGIN
     INSERT INTO Z_D20_SUBJECTES_PERSONAS_UNIC (ID_SUBJECTE, NOM, COGNOMS, COGNOM1, COGNOM2, NOM_NORMALITZAT, NOMALITZAT_CONTACTE, TRACTAMENT, EMPRESA, CARREC, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID)                    
               SELECT  (ConstSubjecte +  AUX_SEQ_RISPLUS_SUBJECTE.NEXTVAL) AS ID_SUBJECTE,	
                        AGRUPATOR.NOM AS NOM ,
                        AGRUPATOR.COGNOMS AS COGNOMS,        
                        (CASE WHEN(length(AGRUPATOR.COGNOMS) - length(replace(AGRUPATOR.COGNOMS, ' ', '')) + 1) = 2 THEN 
                                  trim(SUBSTR(AGRUPATOR.COGNOMS,1,INSTR(AGRUPATOR.COGNOMS,' ')-1))
                        WHEN trim(SUBSTR(AGRUPATOR.COGNOMS,1, INSTR(LOWER(AGRUPATOR.COGNOMS),' i ')-1)) IS NULL THEN 
                                   AGRUPATOR.COGNOMS 
                        ELSE  
                                   trim(SUBSTR(AGRUPATOR.COGNOMS,1, INSTR(LOWER(AGRUPATOR.COGNOMS),' i ')-1))
                        END)  AS COGNOM1, 
                        (CASE WHEN trim(SUBSTR(AGRUPATOR.COGNOMS,1, INSTR(LOWER(AGRUPATOR.COGNOMS),' i ')-1)) IS NOT NULL THEN 
                                   trim(SUBSTR(AGRUPATOR.COGNOMS,INSTR(LOWER(AGRUPATOR.COGNOMS),' i ')))
                              WHEN (length(AGRUPATOR.COGNOMS) - length(replace(AGRUPATOR.COGNOMS, ' ', '')) + 1) = 2 THEN  
                                   trim(SUBSTR(AGRUPATOR.COGNOMS, INSTR(AGRUPATOR.COGNOMS,' ')))
                        ELSE 
                                   NULL 
                        END) AS COGNOM2,
                        AGRUPATOR.NOM_NORMALITZAT AS NOM_NORMALITZAT, 
                        AGRUPATOR.NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                        AGRUPATOR.TRACTAMENT AS TRACTAMENT,
                        AGRUPATOR.EMPRESA,
                        AGRUPATOR.CARREC,
                        AGRUPATOR.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                        AGRUPATOR.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                        ConstSebjectePersona AS TIPUS_SUBJECTE_ID
                        
                FROM (        
                                                              SELECT MAX(NOM) AS NOM,
                                                              MAX(COGNOMS) AS COGNOMS,
                                                              MAX(FUNC_NORMALITZAR(NOM || COGNOMS)) AS NOM_NORMALITZAT,
                                                              FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC) AS NOMALITZAT_CONTACTE,
                                                              MAX(TRACTAMENT) AS TRACTAMENT,
                                                              MAX(FUNC_NORMALITZAR_ENTITAT(EMPRESA)) AS EMPRESA,
                                                              MAX(FUNC_NORMALITZAR(CARREC)) AS CARREC,
                                                              MAX(DATAMODIF) AS DATA_MODIFICACIO,
                                                              MAX(USUARI) AS USUARI_MODIFICACIO
                                                        FROM Z_TMP_RISPLUS_U_CONTACTES
                                                        WHERE FUNC_NORMALITZAR(NOM || COGNOMS) IS NOT NULL 
                                                        GROUP BY FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC)
                        ) AGRUPATOR
                        WHERE NOM_NORMALITZAT IS NOT NULL
                          AND NOT EXISTS (SELECT 1 
                                            FROM Z_D20_SUBJECTES_PERSONAS_UNIC ANTIGUOS
                                           WHERE ANTIGUOS.NOM_NORMALITZAT = AGRUPATOR.NOM_NORMALITZAT
                                             AND NVL(ANTIGUOS.EMPRESA,'*') = NVL(AGRUPATOR.EMPRESA,'*')
                                             AND NVL(ANTIGUOS.CARREC,'*') = NVL(AGRUPATOR.CARREC,'*')
                                          ); 
    COMMIT;
    END;
 /*   
    --Relaciona los contactes con los subjectes de tipo persona 
    PROCEDURE D21_SUBJECTES_PERSONAS_CONTAC IS
    BEGIN
    
          INSERT INTO Z_D21_SUBJECTES_PERSONAS_CONT  
                SELECT CONTACTE.CONTACTEID,
                       SUBJECTE.*
                  FROM Z_TMP_RISPLUS_U_CONTACTES CONTACTE,       
                       Z_D20_SUBJECTES_PERSONAS_UNIC SUBJECTE
                 WHERE SUBJECTE.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)	 
                  AND NOT EXISTS (SELECT 1
                  					FROM Z_D21_SUBJECTES_PERSONAS_CONT ANTIGUOS
                  				   WHERE ANTIGUOS.NOMALITZAT_CONTACTE = SUBJECTE.NOMALITZAT_CONTACTE
                                  );
            
    
    
    COMMIT;
    END;
*/    
    --se Extraen los sujectos sin nombres y apellidos  pero con empresa informada. lA EMPRESA SE PONE EN EL NOMBREe
    PROCEDURE D22_SUBJECTES_ENTITATS_UNICS IS
    BEGIN
    
        
       INSERT INTO Z_D22_SUBJECTES_ENTITATS_UNIC (ID_SUBJECTE, NOM, COGNOMS, COGNOM1, COGNOM2, NOM_NORMALITZAT,NOMALITZAT_CONTACTE,TRACTAMENT, EMPRESA, CARREC, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID)
                 SELECT  (ConstSubjecte +  AUX_SEQ_RISPLUS_SUBJECTE.NEXTVAL) AS ID_SUBJECTE,	
                                    AGRUPATOR.NOM AS NOM ,
                                    AGRUPATOR.COGNOMS AS COGNOMS,        
                                    NULL AS COGNOM1,
                                    NULL AS COGNOM2,
                                    AGRUPATOR.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                    NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                    TRACTAMENT AS TRACTAMENT,
                                    AGRUPATOR.EMPRESA,
                                    AGRUPATOR.CARREC,
                                    AGRUPATOR.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                    AGRUPATOR.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                    ConstSebjecteEntitat AS TIPUS_SUBJECTE_ID
                     FROM (                        
                            SELECT EMPRESA AS NOM,
                                   NULL AS COGNOMS,
                                   FUNC_NORMALITZAR_ENTITAT(EMPRESA) AS NOM_NORMALITZAT,
                                   MAX(FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC)) AS NOMALITZAT_CONTACTE,
                                   MAX(TRACTAMENT) AS TRACTAMENT,
                                   EMPRESA AS EMPRESA,
                                   CARREC AS CARREC,
                                   MAX(DATAMODIF) AS DATA_MODIFICACIO,
                                   MAX(USUARI) AS USUARI_MODIFICACIO
                            FROM Z_TMP_RISPLUS_U_CONTACTES
                            WHERE FUNC_NORMALITZAR(NOM || COGNOMS) IS NULL
                              AND FUNC_NORMALITZAR_ENTITAT(EMPRESA) IS NOT NULL
                         GROUP BY EMPRESA, CARREC 
                       ) AGRUPATOR
                   WHERE  NOT EXISTS (SELECT 1 
                                        FROM Z_D22_SUBJECTES_ENTITATS_UNIC ANTIGUOS
                                       WHERE NVL(ANTIGUOS.EMPRESA,'*') = NVL(AGRUPATOR.EMPRESA,'*')
                                         AND NVL(ANTIGUOS.CARREC,'*') = NVL(AGRUPATOR.CARREC,'*')
                                      );
                                      

    
    COMMIT;
    END;
/*   
   PROCEDURE D23_SUBJECTE_ENTITAT_CONTACTE IS
   BEGIN
      INSERT INTO Z_D23_SUBJECTES_ENTITATS_CONT
                 SELECT CONTACTE.CONTACTEID,
                       SUBJECTE.*
                  FROM Z_TMP_RISPLUS_U_CONTACTES CONTACTE,       
                       Z_D22_SUBJECTES_ENTITATS_UNIC SUBJECTE
                 WHERE SUBJECTE.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)
                  AND NOT EXISTS (SELECT 1
                  					FROM Z_D23_SUBJECTES_ENTITATS_CONT ANTIGUOS
                  				   WHERE ANTIGUOS.NOMALITZAT_CONTACTE = SUBJECTE.NOMALITZAT_CONTACTE
                                  );
    
   
   
   COMMIT;
   END;
 */  
   
   PROCEDURE D24_SUBJECTES_CARREC_UNIC IS
   BEGIN
   
    INSERT INTO Z_D24_SUBJECTES_CARREC_UNIC (ID_SUBJECTE, NOM, COGNOMS, COGNOM1, COGNOM2, NOM_NORMALITZAT, NOMALITZAT_CONTACTE,TRACTAMENT, EMPRESA, CARREC, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID)
                 SELECT  (ConstSubjecte +  AUX_SEQ_RISPLUS_SUBJECTE.NEXTVAL) AS ID_SUBJECTE,	
                                    AGRUPATOR.NOM AS NOM ,
                                    AGRUPATOR.COGNOMS AS COGNOMS,        
                                    NULL AS COGNOM1,
                                    NULL AS COGNOM2,
                                    AGRUPATOR.NOM_NORMALITZAT AS NOM_NORMALITZAT, 
                                    NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                    AGRUPATOR.TRACTAMENT AS TRACTAMENT,
                                    AGRUPATOR.EMPRESA,
                                    AGRUPATOR.CARREC,
                                    AGRUPATOR.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                    AGRUPATOR.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                    ConstSebjecteEntitat AS TIPUS_SUBJECTE_ID
                     FROM (                        
                            SELECT CARREC AS NOM,
                                   NULL AS COGNOMS,
                                   FUNC_NORMALITZAR_ENTITAT(CARREC) AS NOM_NORMALITZAT,
                                   MAX(FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC)) AS NOMALITZAT_CONTACTE,
                                   MAX(TRACTAMENT) AS TRACTAMENT,
                                   NULL AS EMPRESA,
                                   CARREC AS CARREC,
                                   MAX(DATAMODIF) AS DATA_MODIFICACIO,
                                   MAX(USUARI) AS USUARI_MODIFICACIO
                            FROM Z_TMP_RISPLUS_U_CONTACTES
                            WHERE FUNC_NORMALITZAR(NOM || COGNOMS) IS NULL
                              AND FUNC_NORMALITZAR_ENTITAT(EMPRESA) IS NULL        
                              AND FUNC_NORMALITZAR_ENTITAT(CARREC) IS NOT NULL
                         GROUP BY CARREC 
                       ) AGRUPATOR
                     WHERE  NOT EXISTS (SELECT 1 
                                        FROM Z_D24_SUBJECTES_CARREC_UNIC ANTIGUOS
                                       WHERE ANTIGUOS.NOMALITZAT_CONTACTE = AGRUPATOR.NOMALITZAT_CONTACTE
                                      );  
   COMMIT;   
   END;
   
/*   
   PROCEDURE D25_SUBJECTE_CARREC_CONTACTE IS
   BEGIN
            INSERT INTO Z_D25_SUBJECTES_CARREC_CONT
                 SELECT CONTACTE.CONTACTEID,
                       SUBJECTE.*
                  FROM Z_TMP_RISPLUS_U_CONTACTES CONTACTE,       
                       Z_D24_SUBJECTES_CARREC_UNIC SUBJECTE
                 WHERE SUBJECTE.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)
                  AND NOT EXISTS (SELECT 1
                  					FROM Z_D25_SUBJECTES_CARREC_CONT ANTIGUOS
                  				   WHERE ANTIGUOS.NOMALITZAT_CONTACTE = SUBJECTE.NOMALITZAT_CONTACTE
                                  );
   COMMIT;
   END;
*/   
   
   PROCEDURE D26_SUBJECTES_UNION IS
   BEGIN
       INSERT INTO Z_D26_SUBJECTES_UNION (ID, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT, NOMALITZAT_CONTACTE, TRACTAMENT, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID)   
         SELECT ID, 
         	    NOM, 
         	    COGNOM1, 
         	    COGNOM2, 
         	    NOM_NORMALITZAT, 
         	    NOMALITZAT_CONTACTE, 
         	    TRACTAMENT, 
         	    DATA_MODIFICACIO, 
         	    USUARI_MODIFICACIO, 
         	    TIPUS_SUBJECTE_ID
         FROM (
                            SELECT SUBJECTES_PERSONAS.ID_SUBJECTE AS ID,
                                        SUBJECTES_PERSONAS.NOM AS NOM,
                                        SUBJECTES_PERSONAS.COGNOM1 AS COGNOM1,
                                        SUBJECTES_PERSONAS.COGNOM2 AS COGNOM2,
                                        SUBJECTES_PERSONAS.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                        SUBJECTES_PERSONAS.NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                        SUBJECTES_PERSONAS.TRACTAMENT AS TRACTAMENT,
                                        SUBJECTES_PERSONAS.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                        SUBJECTES_PERSONAS.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                        SUBJECTES_PERSONAS.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID
                             FROM Z_D20_SUBJECTES_PERSONAS_UNIC SUBJECTES_PERSONAS
                                        UNION ALL
                             SELECT SUBJECTES_ENTITATS.ID_SUBJECTE AS ID,
                                        SUBJECTES_ENTITATS.NOM AS NOM,
                                        SUBJECTES_ENTITATS.COGNOM1 AS COGNOM1,
                                        SUBJECTES_ENTITATS.COGNOM2 AS COGNOM2,
                                        SUBJECTES_ENTITATS.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                        SUBJECTES_ENTITATS.NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                        SUBJECTES_ENTITATS.TRACTAMENT AS TRACTAMENT,
                                        SUBJECTES_ENTITATS.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                        SUBJECTES_ENTITATS.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                        SUBJECTES_ENTITATS.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID                           
                              FROM Z_D22_SUBJECTES_ENTITATS_UNIC SUBJECTES_ENTITATS
                                        UNION ALL
                              SELECT SUBJECTES_CARREC.ID_SUBJECTE AS ID,
                                        SUBJECTES_CARREC.NOM AS NOM,
                                        SUBJECTES_CARREC.COGNOM1 AS COGNOM1,
                                        SUBJECTES_CARREC.COGNOM2 AS COGNOM2,
                                        SUBJECTES_CARREC.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                        SUBJECTES_CARREC.NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,                                        
                                        SUBJECTES_CARREC.TRACTAMENT AS TRACTAMENT,
                                        SUBJECTES_CARREC.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                        SUBJECTES_CARREC.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                        SUBJECTES_CARREC.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID 
                                  FROM Z_D24_SUBJECTES_CARREC_UNIC SUBJECTES_CARREC
                ) SUBJECTES_UNION
                WHERE NOT EXISTS (SELECT 1
                                    FROM Z_D26_SUBJECTES_UNION ANTIGUOS
                                   WHERE SUBJECTES_UNION.NOMALITZAT_CONTACTE = ANTIGUOS.NOMALITZAT_CONTACTE
                                  );  
       
   
   COMMIT;
   END;
   
   
   
   PROCEDURE D27_SUBJECTES_RISPLUS IS
   BEGIN
   
        INSERT INTO Z_D99_SUBJECTES (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID)
                     SELECT NUEVOS.ID AS ID,
                            substr(NUEVOS.NOM,1,50) AS NOM,
                            substr(NUEVOS.COGNOM1,1,40) AS COGNOM1,
                            NUEVOS.COGNOM2 AS COGNOM2,
                            NULL AS ALIES,
                            NULL AS DATA_DEFUNCIO,
                            0 AS ES_PROVISIONAL,
                            substr(NUEVOS.NOM_NORMALITZAT,1,60),
                            NULL AS MOTIU_BAIXA,
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NUEVOS.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NUEVOS.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                            (SELECT ID FROM DM_TRACTAMENT WHERE DESCRIPCIO = NUEVOS.TRACTAMENT) AS TRACTAMENT_ID,
                            null AS PRIORITAT_ID,
                            NUEVOS.TIPUS_SUBJECTE_ID,
                            ConstALCALDIA AS AMBIT_ID,
                            NULL AS IDIOMA_ID,
                            1 AS ARTICLE_ID
                       FROM Z_D26_SUBJECTES_UNION NUEVOS
                      WHERE NOT EXISTS (SELECT 1
                                          FROM Z_D99_SUBJECTES ANTIGUOS
                                         WHERE ANTIGUOS.NOM_NORMALITZAT = NUEVOS.NOM_NORMALITZAT
                                        ); 
   
                INSERT INTO SUBJECTE 
                            SELECT * 
                            FROM Z_D99_SUBJECTES NUEVOS
                           WHERE NOT EXISTS(SELECT 1
                                              FROM SUBJECTE ANTIGUOS
                                             WHERE ANTIGUOS.ID = NUEVOS.ID
                                           );  
   
   COMMIT;
   END;
   
   
    PROCEDURE D30_CONTACTES_SUBJECTES IS
    BEGIN
            
             INSERT INTO Z_D30_CONTACTES_SUBJECTES (CONTACTEID,ID_SUBJECTE,NOMALITZAT_CONTACTE)                  
                            SELECT      CONTACTE.CONTACTEID AS CONTACTEID,
                                        SUBJECTES.ID AS ID_SUBJECTE,
                                        SUBJECTES.NOMALITZAT_CONTACTE
                             FROM Z_D26_SUBJECTES_UNION SUBJECTES,
                                  Z_TMP_RISPLUS_U_CONTACTES CONTACTE
                             WHERE SUBJECTES.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)                            
    						   AND NOT EXISTS (SELECT 1
                                        FROM Z_D30_CONTACTES_SUBJECTES ANTIGUOS
                                       WHERE ANTIGUOS.NOMALITZAT_CONTACTE =  SUBJECTES.NOMALITZAT_CONTACTE
                                     );    
    COMMIT;
    END;
   
   
/*    
    -- SE MONTA LA TABLA FINAL DE SUJETOS RELACIONADA CON ID_CONTACTE
    PROCEDURE D30_CONTACTES_SUBJECTES_UNION IS
    BEGIN
    
        INSERT INTO Z_D30_CONTACTES_SUBJE_UNION (CONTACTEID, ID_SUBJECTE, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT,NOMALITZAT_CONTACTE, TRACTAMENT, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID)
               SELECT CONTACTEID, 
                      ID_SUBJECTE, 
                      NOM, 
                      COGNOM1, 
                      COGNOM2, 
                      NOM_NORMALITZAT, 
                      NOMALITZAT_CONTACTE,
                      TRACTAMENT, 
                      DATA_MODIFICACIO, 
                      USUARI_MODIFICACIO, 
                      TIPUS_SUBJECTE_ID
                 FROM (     
                            SELECT      SUBJECTES_PERSONAS.CONTACTEID AS CONTACTEID,
                                        SUBJECTES_PERSONAS.ID_SUBJECTE AS ID_SUBJECTE,
                                        SUBJECTES_PERSONAS.NOM AS NOM,
                                        SUBJECTES_PERSONAS.COGNOM1 AS COGNOM1,
                                        SUBJECTES_PERSONAS.COGNOM2 AS COGNOM2,
                                        SUBJECTES_PERSONAS.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                        SUBJECTES_PERSONAS.NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                        SUBJECTES_PERSONAS.TRACTAMENT AS TRACTAMENT,
                                        SUBJECTES_PERSONAS.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                        SUBJECTES_PERSONAS.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                        SUBJECTES_PERSONAS.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID
                             FROM Z_D21_SUBJECTES_PERSONAS_CONT SUBJECTES_PERSONAS
                                        UNION ALL
                             SELECT     SUBJECTES_ENTITATS.CONTACTEID AS CONTACTEID,
                                        SUBJECTES_ENTITATS.ID_SUBJECTE AS ID_SUBJECTE,
                                        SUBJECTES_ENTITATS.NOM AS NOM,
                                        SUBJECTES_ENTITATS.COGNOM1 AS COGNOM1,
                                        SUBJECTES_ENTITATS.COGNOM2 AS COGNOM2,
                                        SUBJECTES_ENTITATS.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                        SUBJECTES_ENTITATS.NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                        SUBJECTES_ENTITATS.TRACTAMENT AS TRACTAMENT,
                                        SUBJECTES_ENTITATS.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                        SUBJECTES_ENTITATS.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                        SUBJECTES_ENTITATS.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID                           
                              FROM Z_D23_SUBJECTES_ENTITATS_CONT SUBJECTES_ENTITATS
                                        UNION ALL
                                 SELECT SUBJECTES_CARREC.CONTACTEID AS CONTACTEID,
                                        SUBJECTES_CARREC.ID_SUBJECTE AS ID_SUBJECTE,
                                        SUBJECTES_CARREC.NOM AS NOM,
                                        SUBJECTES_CARREC.COGNOM1 AS COGNOM1,
                                        SUBJECTES_CARREC.COGNOM2 AS COGNOM2,
                                        SUBJECTES_CARREC.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                        SUBJECTES_CARREC.NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                        SUBJECTES_CARREC.TRACTAMENT AS TRACTAMENT,
                                        SUBJECTES_CARREC.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                        SUBJECTES_CARREC.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                        SUBJECTES_CARREC.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID 
                                  FROM Z_D25_SUBJECTES_CARREC_CONT SUBJECTES_CARREC
                    ) CONTACTES_UNION
                    WHERE NOT EXISTS (SELECT 1
                                        FROM Z_D30_SUBJECTES_CONT_UNION ANTIGUOS
                                       WHERE ANTIGUOS.NOMALITZAT_CONTACTE =  CONTACTES_UNION.NOMALITZAT_CONTACTE
                                     );
    
    COMMIT;
    END;
*/    
    
    
    
   
    
    --------CONTACTES
    
     PROCEDURE D40_ADRECA_UNICAS IS
     BEGIN    
     
                 INSERT INTO Z_D40_ADRECAS_UNICAS (ID_ADRECA,NOM_ADRECA,MUNICIPI,CODIPOSTAL,PROVINCIA,PAIS) 
                         SELECT (ConstAdreca +  AUX_SEQ_RISPLUS_ADRECA.NEXTVAL) AS ID_ADRECA, 
                                NOM_ADRECA,
                                MUNICIPI,
                                CODIPOSTAL,
                                PROVINCIA,
                                PAIS
                           FROM (     
                                     SELECT Trim(RISPLUS.ADRECA)  AS NOM_ADRECA,
                                            TRIM(RISPLUS.MUNICIPI) AS MUNICIPI,
                                            TRIM(RISPLUS.CODIPOSTAL) AS CODIPOSTAL,
                                            TRIM(RISPLUS.Provincia) AS Provincia,
                                            TRIM(RISPLUS.pais) AS pais 
                                      FROM  Z_TMP_RISPLUS_U_CONTACTES RISPLUS 
        --                             WHERE trim(RISPLUS.ADRECA) IS NOT NULL 
        --                               AND TRIM(RISPLUS.MUNICIPI) IS NOT NULL
        --                               AND TRIM(RISPLUS.CODIPOSTAL) IS NOT NULL
        --                               AND TRIM(RISPLUS.provincia) IS NOT NULL
        --                               AND TRIM(RISPLUS.pais) IS NOT NULL
                                  GROUP BY trim(RISPLUS.ADRECA),
                                           TRIM(RISPLUS.MUNICIPI),
                                           TRIM(RISPLUS.CODIPOSTAL),
                                           TRIM(RISPLUS.provincia),
                                           TRIM(RISPLUS.pais)  
                                   ) ADRECAS_UNICAS
                             WHERE NOT EXISTS (SELECT 1
                                                 FROM Z_D40_ADRECAS_UNICAS ANTIGUAS
                                                WHERE FUNC_NULOS(ANTIGUAS.NOM_ADRECA) = FUNC_NULOS(ADRECAS_UNICAS.NOM_ADRECA)
                                                  AND FUNC_NULOS(ANTIGUAS.MUNICIPI) = FUNC_NULOS(ADRECAS_UNICAS.MUNICIPI)
                                                  AND FUNC_NULOS(ANTIGUAS.CODIPOSTAL) = FUNC_NULOS(ADRECAS_UNICAS.CODIPOSTAL)
                                                  AND FUNC_NULOS(ANTIGUAS.Provincia) = FUNC_NULOS(ADRECAS_UNICAS.Provincia)
                                                  AND FUNC_NULOS(ANTIGUAS.pais) = FUNC_NULOS(ADRECAS_UNICAS.pais) 
                                               );   
     COMMIT;
     END;


    PROCEDURE ERR_ADRECA_RISPLUS IS
    BEGIN
        --A) DIRECCIONES NULAS
            INSERT INTO ERR_R_ADRECAS (CONTACTEID, ESQUEMA, TABLA,CAMPO_ERROR, ERROR_DESC)     
                SELECT CONTACTES.CONTACTEID,
                       'RISPLUS' AS ESQUEMA,
						'Z_TMP_RISPLUS_U_CONTACTES' AS TABLA,
						'ADRECA ' AS CAMPO_ERROR,
						ADRECA || ' -> ES NULO' AS ERROR_DESC
                FROM Z_TMP_RISPLUS_U_CONTACTES CONTACTES 
               WHERE  FUNC_NULOS(CONTACTES.ADRECA) = '*';
                                                
            
          --B) CODIGOS POSTALES NO NUMERICOS
          INSERT INTO ERR_R_ADRECAS (CONTACTEID, ESQUEMA, TABLA,CAMPO_ERROR, ERROR_DESC)     
                SELECT CONTACTES.CONTACTEID AS CONTACTE_ID,
                       'RISPLUS' AS ESQUEMA,
						'Z_TMP_RISPLUS_U_CONTACTES' AS TABLA,
						'CODIPOSTAL' AS CAMPO_ERROR,
						CODIPOSTAL || ' -> NO ES NUMERICO' AS ERROR_DESC
                FROM Z_TMP_RISPLUS_U_CONTACTES CONTACTES 
               WHERE  ES_NUMERICO(TRIM(CODIPOSTAL))=0;
                
    COMMIT;
    END;
    
    

    PROCEDURE D41_ADRECA_CONTACTE IS
    BEGIN
    
            INSERT INTO Z_D41_ADRECAS_CONTACTES (CONTACTEID, ID_ADRECA) 
                       SELECT CONTACTEID,
                              ID_ADRECA
                        FROM (     
                                SELECT CONTACTES.CONTACTEID AS CONTACTEID,
                                       ADRECA.ID_ADRECA AS ID_ADRECA
                                FROM Z_D40_ADRECAS_UNICAS ADRECA,
                                     Z_TMP_RISPLUS_U_CONTACTES CONTACTES
                                WHERE FUNC_NULOS(ADRECA.NOM_ADRECA) = FUNC_NULOS(CONTACTES.ADRECA)
                                  AND FUNC_NULOS(ADRECA.MUNICIPI) = FUNC_NULOS(CONTACTES.MUNICIPI)
                                  AND FUNC_NULOS(ADRECA.CODIPOSTAL) = FUNC_NULOS(CONTACTES.CODIPOSTAL)
                                  AND FUNC_NULOS(ADRECA.Provincia) = FUNC_NULOS(CONTACTES.Provincia)
                                  AND FUNC_NULOS(ADRECA.pais) = FUNC_NULOS(CONTACTES.PAIS)
                            ) NUEVOS
                        WHERE NOT EXISTS (SELECT 1
                                            FROM Z_D41_ADRECAS_CONTACTES ANTIGUOS
                                           WHERE ANTIGUOS.CONTACTEID=NUEVOS.CONTACTEID 
                                             AND ANTIGUOS.ID_ADRECA = ANTIGUOS.ID_ADRECA
                                          ); 
    
    COMMIT;
    END;
    
    PROCEDURE D42_AUX_ADRECA IS
    BEGIN
            INSERT INTO Z_D99_ADRECA (ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_CARRER, NOM_CARRER, LLETRA_INICI, LLETRA_FI, ESCALA, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PIS, PORTA, BLOC, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE)
					SELECT  ID_ADRECA AS ID, 
                            NULL AS CODI_MUNICIPI, 
                            MUNICIPI AS	MUNICIPI, 
                            NULL AS CODI_PROVINCIA, 
                            PROVINCIA AS PROVINCIA, 
                            NULL AS CODI_PAIS, 
                            PAIS AS PAIS, 
                            NULL AS CODI_CARRER, 
                            FUNC_NULOS(NOM_ADRECA)  AS NOM_CARRER,
                            NULL AS LLETRA_INICI, 
                            NULL AS LLETRA_FI, 
                            NULL AS ESCALA,
                            CODIPOSTAL AS CODI_POSTAL, 
                            NULL AS COORDENADA_X, 
                            NULL AS COORDENADA_Y, 
                            NULL AS SECCIO_CENSAL, 
                            NULL AS ANY_CONST, 
                            NULL AS NUMERO_INICI,
                            NULL AS NUMERO_FI, 
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MODIFICACIO,
                            NULL AS PIS,
                            NULL AS PORTA,
                            NULL AS BLOC,
                            NULL AS CODI_TIPUS_VIA,
                            NULL AS CODI_BARRI,
                            NULL AS BARRI,
                            NULL AS CODI_DISTRICTE,
                            NULL AS DISTRICTE
						FROM Z_D40_ADRECAS_UNICAS NUEVAS 
                       WHERE NOT EXISTS (SELECT 1 
                                         FROM Z_D99_ADRECA ANTIGUAS
                                         WHERE FUNC_NULOS(NUEVAS.NOM_ADRECA) = FUNC_NULOS(ANTIGUAS.NOM_CARRER)
                                           AND FUNC_NULOS(NUEVAS.MUNICIPI) = FUNC_NULOS(ANTIGUAS.MUNICIPI)
                                           AND FUNC_NULOS(NUEVAS.CODIPOSTAL) = FUNC_NULOS(ANTIGUAS.CODI_POSTAL)
                                           AND FUNC_NULOS(NUEVAS.Provincia) = FUNC_NULOS(ANTIGUAS.Provincia)
                                           AND FUNC_NULOS(NUEVAS.pais) = FUNC_NULOS(ANTIGUAS.PAIS)
                                         );


                                         
             INSERT INTO ADRECA (ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_CARRER, NOM_CARRER, LLETRA_INICI, LLETRA_FI, ESCALA, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PIS, PORTA, BLOC, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE)
                SELECT ID,
                        CODI_MUNICIPI,
                        MUNICIPI,
                        CODI_PROVINCIA,
                        PROVINCIA,
                        CODI_PAIS,
                        PAIS,
                        CODI_CARRER,
                        NOM_CARRER,
                        LLETRA_INICI,
                        LLETRA_FI,
                        ESCALA,
                        CODI_POSTAL,
                        COORDENADA_X,
                        COORDENADA_Y,
                        SECCIO_CENSAL,
                        ANY_CONST,
                        NUMERO_INICI,
                        NUMERO_FI,
                        DATA_CREACIO,
                        DATA_ESBORRAT,
                        DATA_MODIFICACIO,
                        USUARI_CREACIO,
                        USUARI_ESBORRAT,
                        USUARI_MODIFICACIO,
                        PIS,
                        PORTA,
                        BLOC,
                        CODI_TIPUS_VIA,
                        CODI_BARRI,
                        BARRI,
                        CODI_DISTRICTE,
                        DISTRICTE
                        FROM Z_D99_ADRECA;    
    
    COMMIT;
    END;
    
    
    /*
    PROCEDURE D40_ADRECA IS
    BEGIN
    
        INSERT INTO ADRECA 	(ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_CARRER, NOM_CARRER, LLETRA_INICI, LLETRA_FI, ESCALA, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PIS, PORTA, BLOC, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE)
					SELECT  (ConstAdreca +  AUX_SEQ_RISPLUS_ADRECA.NEXTVAL) AS ID, 
                              NULL AS CODI_MUNICIPI, 
                            NEW_MUNICIPI AS	MUNICIPI, 
                            NULL AS CODI_PROVINCIA, 
                            NEW_PROVINCIA AS PROVINCIA, 
                            NULL AS CODI_PAIS, 
                            NEW_PAIS AS PAIS, 
                            NULL AS CODI_CARRER, 
                            NVL(trim(NEW_NOM_CARRER),'*')  AS NOM_CARRER,
                            NULL AS LLETRA_INICI, 
                            NULL AS LLETRA_FI, 
                            NULL AS ESCALA,
                            substr(NEW_CODIPOSTAL,1,10) AS CODI_POSTAL, 
                            NULL AS COORDENADA_X, 
                            NULL AS COORDENADA_Y, 
                            NULL AS SECCIO_CENSAL, 
                            NULL AS ANY_CONST, 
                            NULL AS NUMERO_INICI,
                            NULL AS NUMERO_FI, 
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MIGRACIO,
                            NULL AS PIS,
                            NULL AS PORTA,
                            NULL AS BLOC,
                            NULL AS CODI_TIPUS_VIA,
                            NULL AS CODI_BARRI,
                            NULL AS BARRI,
                            NULL AS CODI_DISTRICTE,
                            NULL AS DISTRICTE
						FROM (
                             SELECT TRIM(NEW_ADRECA.NOM_ADRECA) AS NEW_NOM_CARRER,
                                     TRIM(NEW_ADRECA.MUNICIPI) AS NEW_MUNICIPI,
						         	 TRIM(NEW_ADRECA.CODIPOSTAL) AS NEW_CODIPOSTAL,
						         	 TRIM(NEW_ADRECA.Provincia) AS NEW_Provincia,
						         	 TRIM(NEW_ADRECA.pais) AS NEW_pais
						      FROM (
                                    SELECT Trim(RISPLUS.ADRECA)  AS NOM_ADRECA,
                                           TRIM(RISPLUS.MUNICIPI) AS MUNICIPI,
                                           TRIM(RISPLUS.CODIPOSTAL) AS CODIPOSTAL,
                                           TRIM(RISPLUS.Provincia) AS Provincia,
                                           TRIM(RISPLUS.pais) AS pais
    								FROM Z_TMP_RISPLUS_U_CONTACTES RISPLUS
										LEFT OUTER JOIN 
					  						 ADRECA ADRECA
											 on LimpiarChars(RISPLUS.ADRECA) = LimpiarChars(ADRECA.NOM_CARRER)
									WHERE ADRECA.NOM_CARRER IS NULL
									GROUP BY trim(RISPLUS.ADRECA),
                                             TRIM(RISPLUS.MUNICIPI),
                                             TRIM(RISPLUS.CODIPOSTAL),
                                             TRIM(RISPLUS.provincia),
                                             TRIM(RISPLUS.pais) 
            	    				ORDER BY 1
							 ) NEW_ADRECA
                         ) WHERE NOT EXISTS ( SELECT 1 
                                              FROM ADRECA ANTIGUO
                                              WHERE LimpiarChars(NEW_NOM_CARRER) = LimpiarChars(ANTIGUO.NOM_CARRER)
                                            );
        
    
    
    COMMIT;
    END;
    */

    
    PROCEDURE D50_AUX_CONTACTES IS
    BEGIN
    INSERT INTO Z_D99_CONTACTES (ID, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID)
	SELECT (ConstContacte + CONTACTEID) AS ID,
	        0 AS ES_PRINCIPAL,
	        substr(DEPARTAMENT,1,35) AS DEPARTAMENT,
	        0 AS DADES_QUALITAT,
	        DATAMODIF AS DATA_DARRERA_ACTUALITZACIO,
	        SYSDATE AS DATA_CREACIO,
	        NULL AS DATA_ESBORRAT,
	        DATAMODIF AS DATA_MODIFICACIO,
	        'MIGRACIO' AS USUARI_CREACIO,
	        NULL AS USUARI_ESBORRAT,
	        USUARI AS USUARI_MODIFICACIO,
	        (CASE WHEN (EMPRESA IS NOT NULL) THEN
	        	ConstProfesional
	        ELSE 
	        	ConstPersonal
			END) AS TIPUS_CONTACTE_ID,
			(SELECT ID_SUBJECTE FROM Z_D30_CONTACTES_SUBJECTES WHERE contacteid= contacteid and ROWNUM = 1) AS SUBJECTE_ID,
			(SELECT ID_ADRECA FROM Z_D41_ADRECAS_CONTACTES WHERE contacteid= contacteid and ROWNUM = 1) AS ADRECA_ID,
            (SELECT ENTITAT_ID FROM Z_D15_ENTITAT_CONTACTE WHERE CONTACTE_ID = CONTACTEID and ROWNUM = 1) AS ENTITAT_ID,
            NULL AS CONTACTE_ORIGEN_ID,
            ConstVisibilitatPrivada AS VISIBILITAT_ID,
            ConstAlcaldia AS AMBIT_ID,
            (SELECT id FROM DM_CARREC WHERE FUNC_NORMALITZAR(CARREC) = FUNC_NORMALITZAR(DESCRIPCIO) and ROWNUM = 1) AS CARREC_ID
       FROM Z_TMP_RISPLUS_U_CONTACTES
       WHERE NOT EXISTS (SELECT 1
                         FROM Z_D99_CONTACTES ANTIGUOS
                         WHERE ID = ANTIGUOS.ID);
    
    
       INSERT INTO CONTACTE
                  SELECT * 
                    FROM Z_D99_CONTACTES NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM CONTACTE ANTIGUOS
                                     WHERE NUEVOS.ID =  ANTIGUOS.ID
                                    );
    
    
    COMMIT;
    END;
    
    
    
   PROCEDURE D60_CORREUS_CONTACTES IS
    BEGIN
            
            INSERT INTO Z_D60_CORREUS_CONTACTES (CONTACTEID, EMAIL)
                SELECT aux.CONTACTEID, aux.email
                FROM(                                                                         
                     select DISTINCT(t.CONTACTEID) AS CONTACTEID,
                            trim(regexp_substr(t.email, '[^;]+', 1, levels.column_value))  as email
                    from 
                        (SELECT (ConstContacteCorreu +CONTACTEID) AS CONTACTEID, email 
                         FROM Z_TMP_RISPLUS_U_CONTACTES 
                         WHERE email IS NOT NULL AND email LIKE '%@%' and
                              EMAIL IS NOT NULL                            
                        ) t,
                    table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(t.EMAIL, '[^;]+'))  + 1) as sys.OdciNumberList)) levels
                    order by CONTACTEID
                 ) aux
                 WHERE TRIM(aux.email) is not null
                   AND NOT EXISTS (SELECT 1 
                                  FROM Z_D60_CORREUS_CONTACTES NUEVOS
                                  WHERE NUEVOS.CONTACTEID = AUX.CONTACTEID
                                    AND NUEVOS.EMAIL = AUX.EMAIL);
                
    COMMIT;               
   END;
   
   
    PROCEDURE D61_CORREUS_PRINCIPALES IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT CONTACTEID, EMAIL FROM  Z_D60_CORREUS_CONTACTES ORDER BY CONTACTEID
        )
        LOOP
            
            IF c.CONTACTEID <> id_contacte_ant THEN
              id_contacte_ant:= c.CONTACTEID;
              INSERT INTO Z_D61_CORREUS_PRINCIPALES VALUES (c.CONTACTEID, c.email, 1);
            ELSE
              INSERT INTO Z_D61_CORREUS_PRINCIPALES VALUES (c.CONTACTEID, c.email, 0);           
            END IF;

        END LOOP;
        
        COMMIT;            
        
        END;
                
        
        PROCEDURE D62_CORREOS_CONTACTOS IS   
        
        BEGIN
         
           INSERT INTO  CONTACTE_CORREU (ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID)
                SELECT (ConstContacteCorreu +  AUX_SEQ_RISPLUS_CONT_CORREU.NEXTVAL) AS ID,
		                cc.correu AS CORREU_ELECTRONIC, 
		                cc.principal ES_PRINCIPAL, 
		                sysdate AS DATA_CREACIO, 
                        NULL AS DATA_ESBORRAT,
                        NULL AS DATA_MODIFICACIO,
		                'MIGRACIO' AS USUARI_CREACIO,
                        NULL AS USUARI_ESBORRAT,
                        NULL AS USUARI_MODIFICACIO,
		                cc.id_contacte AS CONTACTE_ID
                 FROM Z_D61_CORREUS_PRINCIPALES cc
                 WHERE NOT EXISTS(SELECT 1 
                                  FROM CONTACTE_CORREU 
                                  WHERE id = cc.id_contacte);
                 
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN Z_C51_CORREUS_PRINCIPALES
        
        END;  
    
    
    
    PROCEDURE D70_TELEFONS_NUMERICS is 
            BEGIN           
            
             INSERT INTO Z_D70_TELEFONS_NUMERICS
                 SELECT (ConstContacte + CONTACTEID) AS ID_CONTACTE_SINTAGMA,
                       CASE WHEN SUBSTR(TRIM(TELEFONFIXE),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFONFIXE,' ','')))= 9 THEN 2
                        ELSE 1 
                       END AS TIPUS_TELEFON,
                       FUNC_NORMALITZAR_SIGNES(TELEFONFIXE) AS TELEFON
                 FROM Z_TMP_RISPLUS_U_CONTACTES C
                 WHERE TRIM(TELEFONFIXE) IS NOT NULL 
                   AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFONFIXE)) IS NULL 
                   AND TRIM(TELEFONFIXE) <> '.';

                
--                      AND NOT EXISTS (SELECT * FROM Z_C55_TELEFONS_NUMERICS AUX  WHERE C.ID_CONTACTE_SINTAGMA = AUX.ID_CONTACTE_SINTAGMA AND REPLACE(REPLACE(REPLACE(TRIM(C.TEL_FIX),'-',''),' ',''),'.','') = AUX.TELEFON);
             
            

                INSERT INTO Z_D70_TELEFONS_NUMERICS
                 SELECT (ConstContacte + CONTACTEID) AS ,
                       CASE WHEN SUBSTR(TRIM(TELEFONMOBIL),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFONMOBIL,' ','')))= 9 THEN 2
                        ELSE 1 
                       END AS TIPUS_TELEFON,
                       FUNC_NORMALITZAR_SIGNES(TELEFONMOBIL) AS TELEFON
                FROM Z_TMP_RISPLUS_U_CONTACTES C
                WHERE TRIM(TELEFONMOBIL) IS NOT NULL 
                  AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFONMOBIL)) IS NULL 
                  AND TRIM(TELEFONMOBIL) <> '.';
              
            
           COMMIT;
           
          END;
    
    
    PROCEDURE D71_TELEFON_PRINCIPAL IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT * FROM  Z_D70_TELEFONS_NUMERICS ORDER BY ID_CONTACTE_SINTAGMA
        )
        LOOP
            
            IF c.ID_CONTACTE_SINTAGMA <> id_contacte_ant THEN
              id_contacte_ant:= c.ID_CONTACTE_SINTAGMA;
              INSERT INTO Z_D71_TELEFONS_NUMERICS VALUES (c.ID_CONTACTE_SINTAGMA, c.tipus_telefon,c.telefon, 1);
            ELSE
              INSERT INTO Z_D71_TELEFONS_NUMERICS VALUES (c.ID_CONTACTE_SINTAGMA, c.tipus_telefon,c.telefon, 0);           
            END IF;

        END LOOP;
        
        COMMIT;       
      
      END;


      PROCEDURE D72_CONTACTE_TELEFON is 
           
      BEGIN
        
           INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, CONTACTE_ID, TIPUS_TELEFON_ID)
                    SELECT (ConstContacteTelefon +  AUX_SEQ_RISPLUS_CONT_TFN.NEXTVAL), 
                           substr(t.telefon,1,20), 
                           t.principal, 
                           sysdate, 
                           'MIGRACIO', 
                           t.id_contacte, 
                           t.tipus_telefon
            FROM Z_D71_TELEFONS_NUMERICS t 
            WHERE not EXISTS(SELECT * FROM CONTACTE WHERE ID = t.id_contacte) 
                  AND t.TELEFON IS NOT NULL  
                  AND NOT EXISTS(SELECT * 
                                 FROM CONTACTE_TELEFON ct 
                                 WHERE ct.numero = t.telefon AND ct.contacte_id = t.id_contacte) ;

       COMMIT;

      END;
    
    
    
    /*
    
    PROCEDURE D25_SUBJECTES IS
    BEGIN 
    
        -- Sujetos (A -> tipo persona)
        INSERT INTO Z_D25_SUBJECTES (SINTAGMA_SUBJECTE_ID, CONTACTE_RISPLUS_ID, TRACTAMENT, TRACTAMENT_ID, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA)        
                SELECT (ConstSubjecte + CONTACTEID) AS SINTAGMA_SUBJECTE_ID, 
                        CONTACTEID AS CONTACTE_RISPLUS_ID, 
                        TRACTAMENT AS TRACTAMENT,
                        (SELECT ID FROM DM_TRACTAMENT WHERE DESCRIPCIO = TRACTAMENT AND TRACTAMENT IS NOT NULL) AS TRACTAMENT_ID,
                        NOM AS NOM,
                        (CASE WHEN(length(COGNOMS) - length(replace(COGNOMS, ' ', '')) + 1) = 2 THEN 
                                   trim(SUBSTR(COGNOMS,1,INSTR(COGNOMS,' ')-1))
                              WHEN trim(SUBSTR(COGNOMS,1, INSTR(LOWER(COGNOMS),' i ')-1)) IS NULL THEN 
                                   COGNOMS 
                        ELSE  
                                   trim(SUBSTR(COGNOMS,1, INSTR(LOWER(COGNOMS),' i ')-1))
                        END)  AS COGNOM1, 
                        (CASE WHEN trim(SUBSTR(COGNOMS,1, INSTR(LOWER(COGNOMS),' i ')-1)) IS NOT NULL THEN 
                                   trim(SUBSTR(COGNOMS,INSTR(LOWER(COGNOMS),' i ')))
                              WHEN (length(COGNOMS) - length(replace(COGNOMS, ' ', '')) + 1) = 2 THEN  
                                   trim(SUBSTR(COGNOMS, INSTR(COGNOMS,' ')))
                        ELSE 
                                    NULL 
                        END) AS COGNOM2,
                        
                        LimpiarChars(NOM || COGNOMS) AS NOM_NORMALITZAT,
                        NULL AS MOTIU_BAIXA,
                        SYSDATE AS DATA_CREACIO,
                        NULL AS DATA_ESBORRAT,
                        DATAMODIF AS DATA_MODIFICACIO,
                        'MIGRACIO' AS USUARI_CREACIO,
                        NULL AS USUARI_ESBORRAT,
                        USUARI AS USUARI_MODIFICACIO,
                        NULL AS PRIORITAT_ID,
                        ConstSebjectePersona AS TIPUS_SUBJECTE_ID,
                        ConstALCALDIA AS AMBIT_ID,
                        NULL AS IDIOMA
                FROM Z_TMP_RISPLUS_U_CONTACTES
                WHERE CARREC is NULL and EMPRESA IS NULL 
                  AND NOT EXISTS (SELECT 1 
                                  FROM Z_D20_SUBJECTES ANTIGUOS
                                  WHERE (ConstSubjecte + Z_TMP_RISPLUS_U_CONTACTES.CONTACTEID) = ANTIGUOS.ID_SUBJECTE
                                 ); 
 -------------------------------------------------------------------------               
        -- Subjectes (Tipo Entitat)
        
        INSERT INTO Z_D25_SUBJECTES (SINTAGMA_SUBJECTE_ID, CONTACTE_RISPLUS_ID, TRACTAMENT, TRACTAMENT_ID, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA)
            SELECT (ConstSubjecte + CONTACTEID) AS SINTAGMA_SUBJECTE_ID, 
                    CONTACTEID AS CONTACTE_RISPLUS_ID, 
                    TRACTAMENT AS TRACTAMENT,
                    (SELECT ID FROM DM_TRACTAMENT WHERE DESCRIPCIO = TRACTAMENT AND TRACTAMENT IS NOT NULL) AS TRACTAMENT_ID,
                    EMPRESA AS NOM,
                    COGNOMS AS COGNOM1,
                    NULL AS COGNOM2,
                    LimpiarChars(NOM || COGNOMS) AS NOM_NORMALITZAT,
                    'NULL' AS MOTIU_BAIXA,
                    SYSDATE AS DATA_CREACIO,
                    NULL AS DATA_ESBORRAT,
                    DATAMODIF AS DATA_MODIFICACIO,
                    'MIGRACIO' AS USUARI_CREACIO,
                    'NULL' AS USUARI_ESBORRAT,
                    USUARI AS USUARI_MODIFICACIO,
                    NULL AS PRIORITAT_ID,
                    (CASE WHEN (CARREC is NULL and EMPRESA IS NULL) THEN 
                                ConstSebjectePersona 
                          WHEN (nom='.' AND COGNOMS<>'.' AND EMPRESA IS NOT NULL) OR (NOT(CARREC is NULL and EMPRESA IS NULL))THEN
                                ConstSebjecteEntitat
                    ELSE
                          NULL	
                    END) AS TIPUS_SUBJECTE_ID,
                    ConstALCALDIA AS AMBIT_ID,
                    NULL AS IDIOMA
            FROM Z_TMP_RISPLUS_U_CONTACTES
            WHERE (CARREC is NULL and EMPRESA IS NULL) --SUBJECTES (tipo persona)
               OR (nom='.' AND COGNOMS<>'.' AND EMPRESA IS NOT NULL) -- subjectes (tipo entiodad) 
               OR NOT(CARREC is NULL and EMPRESA IS NULL); --CONTACTES (tipo profesional) 
    
    
    COMMIT;
    END;
    */
    
    PROCEDURE RESETEATOR_TABLAS IS
    BEGIN
    
        DELETE FROM Z_D71_TELEFONS_NUMERICS;
        DELETE FROM Z_D70_TELEFONS_NUMERICS;
    
        DELETE FROM Z_D61_CORREUS_PRINCIPALES;
        DELETE FROM Z_D60_CORREUS_CONTACTES;
--        DELETE FROM Z_D25_SUBJECTES;
        DELETE FROM Z_D99_CONTACTES;
        DELETE FROM Z_D99_SUBJECTES;
    
--        DELETE FROM Z_D21_SUBJECTE_CONTACTES;
        
--        DELETE FROM ERR_R_SUBJECTES_NOM_NULL;

        DELETE Z_D99_ADRECA;
        DELETE Z_D41_ADRECAS_CONTACTES;
        DELETE ERR_R_ADRECAS;
        DELETE Z_D40_ADRECAS_UNICAS; 
        
        


        DELETE FROM Z_D30_CONTACTES_SUBJECTES;

        DELETE FROM Z_D26_SUBJECTES_UNION;

--        DELETE FROM Z_D25_SUBJECTES_CARREC_CONT;        
        DELETE FROM Z_D24_SUBJECTES_CARREC_UNIC;
        
--        DELETE FROM Z_D23_SUBJECTES_ENTITATS_CONT;
        DELETE FROM Z_D22_SUBJECTES_ENTITATS_UNIC;

--        DELETE FROM Z_D21_SUBJECTES_PERSONAS_CONT;
        DELETE FROM Z_D20_SUBJECTES_PERSONAS_UNIC;        
        
        
    
        DELETE FROM Z_D15_ENTITAT_CONTACTE;
        DELETE FROM Z_D11_B_ENTITAT_NO_EXISTENTES;
        DELETE FROM Z_D11_A_ENTITAT_NO_EXISTENTE;
        DELETE FROM ERR_R_CONTACTES_EMPRESA_NULL;
        DELETE FROM Z_D10_ENTITAT_EXISTENTE;
  
        DELETE FROM Z_D03_DM_CARREC;
        
--        DELETE FROM Z_D02_DM_CARREC;
        DELETE FROM Z_D01_DM_TRACTAMENT;
        
        
    COMMIT;
    END;
    


    PROCEDURE RESETEATOR_SECUENCIAS IS
        TYPE V_Sequence IS VARRAY(7) OF VARCHAR2(100);
            Secuencias V_Sequence;
            total 						integer;  
    BEGIN
    
      Secuencias := V_Sequence('AUX_SEQ_RISPLUS_DM_TRACTAMENT',
                               'AUX_SEQ_RISPLUS_DM_CARREC',
                               'AUX_SEQ_RISPLUS_DM_ENTITAT',                               
                               'AUX_SEQ_RISPLUS_SUBJECTE',
                               'AUX_SEQ_RISPLUS_ADRECA',
                               'AUX_SEQ_RISPLUS_CONT_CORREU',
                               'AUX_SEQ_RISPLUS_CONT_TFN'
                              );                            
        total := Secuencias.count; 
    
    
    
     FOR i in 1 .. total LOOP
                execute immediate 'DROP SEQUENCE ' || Secuencias(i);           
                execute immediate 'CREATE SEQUENCE ' || Secuencias(i) || ' MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE';            
        
  
        END LOOP;
    
    
    COMMIT;
    END;

/*

DROP SEQUENCE AUX_SEQ_RISPLUS_DM_TRACTAMENT;
CREATE SEQUENCE AUX_SEQ_RISPLUS_DM_TRACTAMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_RISPLUS_DM_CARREC;
CREATE SEQUENCE AUX_SEQ_RISPLUS_DM_CARREC MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_RISPLUS_DM_ENTITAT;
CREATE SEQUENCE AUX_SEQ_RISPLUS_DM_ENTITAT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_RISPLUS_SUBJECTE;
CREATE SEQUENCE AUX_SEQ_RISPLUS_SUBJECTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_RISPLUS_ADRECA;
CREATE SEQUENCE AUX_SEQ_RISPLUS_ADRECA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_RISPLUS_CONT_CORREU;
CREATE SEQUENCE AUX_SEQ_RISPLUS_CONT_CORREU MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE AUX_SEQ_RISPLUS_CONT_TFN;
CREATE SEQUENCE AUX_SEQ_RISPLUS_CONT_TFN MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;
*/


END D_01_CONTACTES_RISPLUS;

/
