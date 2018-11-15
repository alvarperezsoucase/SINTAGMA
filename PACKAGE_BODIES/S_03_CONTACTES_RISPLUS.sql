--------------------------------------------------------
--  DDL for Package Body S_03_CONTACTES_RISPLUS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."S_03_CONTACTES_RISPLUS" AS

    --Hay que extraer los contactes que sean instalacioID 30 y que tengan elementos principales
    PROCEDURE SD00_CONTACTES IS
    BEGIN
            INSERT INTO Z_SD000_CONTACTES (CONTACTEID, TRACTAMENT, NOM, COGNOMS, CARREC, EMPRESA, DEPARTAMENT, ADRECA, DISTRICTE, CODIPOSTAL, MUNICIPI, PROVINCIA, PAIS, TELEFONMOBIL, TELEFONFIXE, EMAIL, INTERESSAT1, INTERESSAT2, PERTANYREPOSITORI, INSTALACIOID, DATAMODIF, USUARI)
                        SELECT CONTACTEID, TRACTAMENT, NOM, COGNOMS, CARREC, EMPRESA, DEPARTAMENT, ADRECA, DISTRICTE, CODIPOSTAL, MUNICIPI, PROVINCIA, PAIS, TELEFONMOBIL, TELEFONFIXE, EMAIL, INTERESSAT1, INTERESSAT2, PERTANYREPOSITORI, INSTALACIOID, DATAMODIF, USUARI
                          FROM Z_T_RP_CONTACTES contacte
                         WHERE contacteid IN ( SELECT contacte.CONTACTEID
                                                 FROM Z_T_RP_CONTACTES contacte,
                                                      Z_T_RP_ELEMENTS el
                                                WHERE CONTACTE.INSTALACIOID IN ConstInstalacioAlcaldia
                                                  AND el.TITULARFORAID = contacte.CONTACTEID
                                             GROUP BY CONTACTEID);
                
            
    
    COMMIT;
    END;



      PROCEDURE SD01_EXTRAER_TRACTAMENT IS
    BEGIN
    /*
    INSERT INTO Z_SD001_DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA)
               		SELECT  A1_SEQ_DM_TRACTAMENT.NEXTVAL AS ID, 
                            NEW_TRACTAMENT.TRACTAMENT AS DESCRIPCIO,
                            FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                            FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                            FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                            FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                            FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                            FUNC_NULOS_STRING() AS ABREUJADA                            
					FROM (
						SELECT Trim(RISPLUS.TRACTAMENT)  AS TRACTAMENT
						FROM Z_SD000_CONTACTES RISPLUS
						LEFT OUTER JOIN 
	  						A1_DM_TRACTAMENT tractament
							on TRIM(RISPLUS.TRACTAMENT) = TRIM(tractament.DESCRIPCIO)
							WHERE tractament.DESCRIPCIO IS NULL
						GROUP BY trim(RISPLUS.TRACTAMENT)					
	    				ORDER BY 1
					) NEW_TRACTAMENT
                    WHERE NEW_TRACTAMENT.TRACTAMENT IS NOT NULL 
                      AND NOT EXISTS (SELECT * 
                                      FROM Z_SD001_DM_TRACTAMENT ANTIGUOS
                                      WHERE TRIM(ANTIGUOS.DESCRIPCIO) = TRIM(NEW_TRACTAMENT.TRACTAMENT)
                                      );
        */
         INSERT INTO Z_SD001_DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA)
               		SELECT  A1_SEQ_DM_TRACTAMENT.NEXTVAL AS ID, 
                            NUEVOS.TRACTAMENT AS DESCRIPCIO,
                            FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                            FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                            FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                            FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                            FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                            FUNC_NULOS_STRING() AS ABREUJADA                            
					FROM (
                            SELECT TRACTAMENT AS TRACTAMENT, 
                                                   FUNC_NORMALITZAR_TRACTAMENT(RISPLUS.TRACTAMENT) AS TRACTAMENT_NORMALITZAT, 
                                                   ROW_NUMBER ()  OVER (PARTITION BY FUNC_NORMALITZAR_TRACTAMENT(RISPLUS.TRACTAMENT) ORDER BY FUNC_NORMALITZAR_TRACTAMENT(RISPLUS.TRACTAMENT) ASC ) AS COLNUM
                                              FROM  Z_SD000_CONTACTES RISPLUS
                                              WHERE FUNC_NORMALITZAR_TRACTAMENT(TRACTAMENT) IN (
                                                                                        SELECT FUNC_NORMALITZAR_TRACTAMENT(RISPLUS.TRACTAMENT)  AS TRACTAMENT
                                                                                        FROM Z_SD000_CONTACTES RISPLUS
                                                                                        LEFT OUTER JOIN 
                                                                                            A1_DM_TRACTAMENT tractament
                                                                                            on FUNC_NORMALITZAR_TRACTAMENT(RISPLUS.TRACTAMENT) = FUNC_NORMALITZAR_TRACTAMENT(tractament.DESCRIPCIO)
                                                                                            WHERE FUNC_NORMALITZAR_TRACTAMENT(tractament.DESCRIPCIO) IS NULL
                                                                                        GROUP BY FUNC_NORMALITZAR_TRACTAMENT(RISPLUS.TRACTAMENT)					
                                                                                    )
                            ) NUEVOS
                    WHERE COLNUM=1
                      AND NOT EXISTS (SELECT 1
                                        FROM Z_SC999_DM_TRACTAMENT ANTIGUOS
                                       WHERE FUNC_NORMALITZAR_TRACTAMENT(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR_TRACTAMENT(NUEVOS.TRACTAMENT)
                                      );
    COMMIT;
    END;
    
    
    PROCEDURE SD02_DM_TRACTAMENTS IS
    BEGIN
        
        INSERT INTO A1_DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
            SELECT  ID AS ID, 
                    DESCRIPCIO AS DESCRIPCIO,                    
                    DATA_CREACIO AS CREACIO,
                    DATA_ESBORRAT AS DATA_ESBORRAT,
                    DATA_MODIFICACIO AS DATA_MODIFICACIO,
                    USUARI_CREACIO AS USUARI_CREACIO,
                    USUARI_ESBORRAT AS USUARI_ESBORRAT,
                    USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                    ABREUJADA AS ABREUJADA, 
                    0 AS ID_ORIGINAL,
                    'RISPLUS' AS ESQUEMA_ORIGINAL,
                    'CONTACTES' AS TABLA_ORIGINAL
               FROM Z_SD001_DM_TRACTAMENT NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                 FROM A1_DM_TRACTAMENT ANTIGUOS
                                WHERE NUEVOS.ID = ANTIGUOS.ID
                               );
    
    COMMIT;
    END;
    
    
    PROCEDURE SD03_EXTRAER_CARREC IS
    BEGIN
        
        INSERT INTO Z_SD003_DM_CARREC 
                    SELECT  A1_SEQ_DM_CARREC.NEXTVAL AS ID, 
                            NEW_CARREC.CARREC  AS DESCRIPCIO,
                            FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                            FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                            FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                            FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                            FUNC_USUARI(NULL) AS USUARI_MODIFICACIO
                    FROM (
                            SELECT Trim(RISPLUS.carrec)  AS CARREC
                            FROM Z_SD000_CONTACTES RISPLUS
                                LEFT OUTER JOIN 
                                        DM_CARREC carrec
                                on FUNC_NORMALITZAR(RISPLUS.carrec) = FUNC_NORMALITZAR(carrec.DESCRIPCIO)
							WHERE carrec.DESCRIPCIO IS NULL
                            GROUP BY TRIM(RISPLUS.carrec)					
                            ORDER BY 1
                    ) NEW_CARREC                    
                    WHERE FUNC_NORMALITZAR(NEW_CARREC.CARREC) IS NOT NULL
                      AND NOT EXISTS (SELECT * 
                    				  FROM Z_SD003_DM_CARREC ANTIGUOS
                    				  WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR(NEW_CARREC.CARREC));
    
    
    COMMIT;
    END;
    
    PROCEDURE SD04_DM_CARREC IS
    BEGIN
       INSERT INTO A1_DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT  ID, 
                        TRIM(DESCRIPCIO),
                        DATA_CREACIO,
                        DATA_ESBORRAT,
                        DATA_MODIFICACIO,
                        USUARI_CREACIO,
                        USUARI_ESBORRAT,
                        USUARI_MODIFICACIO,
                        0 AS ID_ORIGINAL,
                        'RISPLUS' AS ESQUEMA_ORIGINAL,
                        'CONTACTES' AS TABLA_ORIGINAL
                  FROM  Z_SD003_DM_CARREC NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM A1_DM_CARREC ANTIGUOS
                                    WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR(NUEVOS.DESCRIPCIO)
                                  );
    
    
    
    COMMIT;
    END;
    
    
    
    PROCEDURE SD10_ENTITAT_EXISTENTES IS
    BEGIN
    
        INSERT INTO Z_SD010_ENTITAT_EXISTENTE (CONTACTE_ID, ENTITAT_ID, DESCRIPCIO_ENTITAT, NOM_NORMALIZAT)
            SELECT CONTACTE_ID, ENTITAT_ID, NUEVOS.DESCRIPCIO_ENTITAT, NUEVOS.NOM_NORMALIZAT 
               FROM (
                     SELECT CONTACTE.CONTACTEID AS CONTACTE_ID, 
                            DM_ENTITAT.ID AS ENTITAT_ID, 
                            DM_ENTITAT.DESCRIPCIO AS DESCRIPCIO_ENTITAT, 
                            ENTITAT.NOM_NORMALIZAT AS NOM_NORMALIZAT 
                     FROM (
                            SELECT FUNC_NORMALITZAR_ENTITAT(empresa) AS NOM_NORMALIZAT
                            FROM Z_SD000_CONTACTES
                            WHERE empresa IS NOT null  
                            GROUP BY FUNC_NORMALITZAR_ENTITAT(EMPRESA)
                            ORDER BY 1
                          ) ENTITAT,
                            A1_DM_ENTITAT DM_ENTITAT,
                            Z_SD000_CONTACTES CONTACTE
                    WHERE FUNC_NORMALITZAR_ENTITAT(DM_ENTITAT.DESCRIPCIO) = ENTITAT.NOM_NORMALIZAT
                    AND FUNC_NORMALITZAR_ENTITAT(CONTACTE.EMPRESA) = ENTITAT.NOM_NORMALIZAT
                ) NUEVOS
                WHERE NOT EXISTS ( SELECT 1 
                                   FROM Z_SD010_ENTITAT_EXISTENTE ANTIGUOS 
                                   WHERE NUEVOS.ENTITAT_ID = ANTIGUOS.ENTITAT_ID);
                
    
    COMMIT;
    END;
    
    PROCEDURE ERR_CONTACTES_EMPRESA_NULL IS
    BEGIN
    
        INSERT INTO ERR_R_CONTACTES_EMPRESA_NULL
             SELECT CONTACTE_ID,
                   'TIENE CAMPO EMPRESA A NULL' AS ERR,
                   'Z_SD000_CONTACTES' AS TABLA,
                   'RISPLUS' AS ESQUEMA          
               FROM (
                     SELECT CONTACTE.CONTACTEID AS CONTACTE_ID
                     FROM Z_SD000_CONTACTES CONTACTE
                    WHERE EMPRESA IS NULL
                ) NUEVOS
                WHERE NOT EXISTS ( SELECT 1 
                                   FROM ERR_R_CONTACTES_EMPRESA_NULL ANTIGUOS 
                                   WHERE NUEVOS.CONTACTE_ID = ANTIGUOS.CONTACTE_ID);
    
    
    
    COMMIT;
    END;
    
    
    -- Aislamos las entidades agrupadas y les añadimos un id único
    PROCEDURE SD11_A_ENTITAT_NO_EXISTENTES IS
    BEGIN
    
        INSERT INTO  Z_SD011_A_ENTITAT_NO_EXISTENTE (ENTITAT_ID, NOM_NORMALIZAT)
             SELECT (A1_SEQ_DM_ENTITAT.NEXTVAL) AS entitat_id, 
                    Nom_Normalizat
             FROM (
                    SELECT FUNC_NORMALITZAR_ENTITAT(Contactes.Empresa) AS Nom_Normalizat
                    FROM Z_SD000_CONTACTES CONTACTES
                    WHERE EMPRESA IS NOT NULL  
                      AND NOT EXISTS(SELECT 1 
                                     FROM Z_SD010_ENTITAT_EXISTENTE D10 
                                     WHERE D10.NOM_NORMALIZAT=FUNC_NORMALITZAR_ENTITAT(CONTACTES.EMPRESA)
                                    )
                    GROUP BY FUNC_NORMALITZAR_ENTITAT(Contactes.Empresa)
                   ) nuevos
                   where not exists (select 1 
                                     from Z_SD011_A_ENTITAT_NO_EXISTENTE antiguos
                                     where antiguos.Nom_Normalizat = nuevos.Nom_Normalizat
                                    );

    COMMIT;
    END;
    
    
    PROCEDURE SD11_B_ENTITAT_NO_EXISTENTES IS
    BEGIN
        INSERT INTO Z_SD011_B_ENTITAT_NO_EXIST (CONTACTEID, EMPRESA, ENTITAT_ID, NOM_NORMALIZAT) 
           SELECT CONTACTEID, 
                  EMPRESA, 
                  ENTITAT_ID, 
                  NOM_NORMALIZAT
             FROM (     
                     SELECT CONTACtes.CONTACTEID,
                            CONTACtes.EMPRESA,
                            d11.ENTITAT_ID, 
                            d11.NOM_NORMALIZAT   
                     FROM  Z_SD011_A_ENTITAT_NO_EXISTENTE D11,
                           Z_SD000_CONTACTES CONTACTES
                     WHERE D11.NOM_NORMALIZAT = FUNC_NORMALITZAR_ENTITAT(CONTACTES.EMPRESA)
                   ) NUEVOS
             WHERE NOT EXISTS (SELECT 1 
                                 FROM Z_SD011_B_ENTITAT_NO_EXIST ANTIGUOS
                                WHERE ANTIGUOS.CONTACTEID = NUEVOS.CONTACTEID
                              );  
                     
    COMMIT;
    END;
    
    PROCEDURE SD14_DM_ENTITAT IS
    BEGIN
         INSERT INTO A1_DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
           SELECT ENTITAT_ID AS ID,
                  NULL AS CODI,
                  (SELECT D011.EMPRESA FROM Z_SD011_B_ENTITAT_NO_EXIST D011 WHERE D011.ENTITAT_ID = AGRUPACION.ENTITAT_ID AND ROWNUM =1) AS DESCRIPCIO,
                  FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                  FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                  FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                  FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                  FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                  FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                  NULL AS ID_ORIGINAL,
                  'RISPLUS' AS ESQUEMA_ORIGINAL,
                  'CONTACTE' AS TABLA_ORIGINAL
            FROM (      
                    SELECT ENTITAT_ID AS ENTITAT_ID                           
           			  FROM Z_SD011_B_ENTITAT_NO_EXIST
          		     GROUP BY ENTITAT_ID
          		  )   AGRUPACION;
            
        
    
    COMMIT;
    END;
    
    
    
    PROCEDURE SD15_ENTITAT_CONTACTES IS
    BEGIN
        INSERT INTO Z_SD015_ENTITAT_CONTACTE (CONTACTE_ID, ENTITAT_ID, DESCRIPCIO_ENTITAT, NOM_NORMALIZAT)
         SELECT CONTACTE_ID, 
                 ENTITAT_ID, 
                 DESCRIPCIO_ENTITAT, 
                 NOM_NORMALIZAT
           FROM (                 
                    SELECT CONTACTE_ID, 
                           ENTITAT_ID, 
                           DESCRIPCIO_ENTITAT, 
                           NOM_NORMALIZAT
                    FROM Z_SD010_ENTITAT_EXISTENTE
                        UNION                 
                    SELECT CONTACTEID, 
                           ENTITAT_ID, 
                           EMPRESA,
                           NOM_NORMALIZAT    
                    FROM Z_SD011_B_ENTITAT_NO_EXIST
                 ) NUEVOS
           WHERE NOT EXISTS (SELECT 1 
                               FROM Z_SD015_ENTITAT_CONTACTE ANTIGUOS
                              WHERE ANTIGUOS.CONTACTE_ID = NUEVOS.CONTACTE_ID
                            );  
            
            
    
    COMMIT;
    END;
    
    -- SE AGRUPAN LOS SUBJECTES POR NOMBRE Y EMPRESA Y CARGO Y SE ASIGNA UN ID POR NOM_NORMALITZAT
    PROCEDURE SD20_SUBJECTES_PERSONAS_UNICOS IS
            max_seq number;
             

    BEGIN
    
            SELECT MAX(ID) INTO max_seq
              FROM A1_SUBJECTE;
            
            max_seq := max_seq +1;
            
            --SET_SEQ('A1_SEQ_SUBJECTE',max_seq);
            PROC_ACTUALIZAR_SECUENCIA('A1_','SUBJECTE');
    
     INSERT INTO Z_SD020_SUBJECTE_PERSONA_UNIC (ID_SUBJECTE, NOM, COGNOMS, COGNOM1, COGNOM2, NOM_NORMALITZAT, NOMALITZAT_CONTACTE, TRACTAMENT, EMPRESA, CARREC, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
               SELECT  (A1_SEQ_SUBJECTE.NEXTVAL) AS ID_SUBJECTE,	
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
                        ConstSebjectePersona AS TIPUS_SUBJECTE_ID,
                        ID_ORIGINAL AS ID_ORIGINAL, 
                        'RISPLUS'  AS ESQUEMA_ORIGINAL , 
                        'CONTACTES' AS TABLA_ORIGINAL
                FROM (        
                                                              SELECT MAX(NOM) AS NOM,
                                                              MAX(COGNOMS) AS COGNOMS,
                                                              MAX(FUNC_NORMALITZAR(NOM || COGNOMS)) AS NOM_NORMALITZAT,
                                                              FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC) AS NOMALITZAT_CONTACTE,
                                                              MAX(TRACTAMENT) AS TRACTAMENT,
                                                              MAX(FUNC_NORMALITZAR_ENTITAT(EMPRESA)) AS EMPRESA,
                                                              MAX(FUNC_NORMALITZAR(CARREC)) AS CARREC,
                                                              MAX(DATAMODIF) AS DATA_MODIFICACIO,
                                                              MAX(USUARI) AS USUARI_MODIFICACIO,
                                                              MAX(CONTACTEID) AS ID_ORIGINAL
                                                        FROM Z_SD000_CONTACTES
                                                        WHERE FUNC_NORMALITZAR(NOM || COGNOMS) IS NOT NULL 
                                                        GROUP BY FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC)
                        ) AGRUPATOR
                        WHERE NOM_NORMALITZAT IS NOT NULL
                          AND NOT EXISTS (SELECT 1 
                                            FROM Z_SD020_SUBJECTE_PERSONA_UNIC ANTIGUOS
                                           WHERE ANTIGUOS.NOM_NORMALITZAT = AGRUPATOR.NOM_NORMALITZAT
                                             AND NVL(ANTIGUOS.EMPRESA,'*') = NVL(AGRUPATOR.EMPRESA,'*')
                                             AND NVL(ANTIGUOS.CARREC,'*') = NVL(AGRUPATOR.CARREC,'*')
                                          ); 
    COMMIT;
    END;
 /*   
    --Relaciona los contactes con los subjectes de tipo persona 
    PROCEDURE SD21_SUBJECTES_PERSONAS_CONTAC IS
    BEGIN
    
          INSERT INTO Z_SD021_SUBJECTES_PERSONAS_CONT  
                SELECT CONTACTE.CONTACTEID,
                       SUBJECTE.*
                  FROM Z_SD000_CONTACTES CONTACTE,       
                       Z_SD020_SUBJECTES_PERSONAS_UNIC SUBJECTE
                 WHERE SUBJECTE.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)	 
                  AND NOT EXISTS (SELECT 1
                  					FROM Z_SD021_SUBJECTES_PERSONAS_CONT ANTIGUOS
                  				   WHERE ANTIGUOS.NOMALITZAT_CONTACTE = SUBJECTE.NOMALITZAT_CONTACTE
                                  );
            
    
    
    COMMIT;
    END;
*/    
    --se Extraen los sujectos sin nombres y apellidos  pero con empresa informada. lA EMPRESA SE PONE EN EL NOMBREe
    PROCEDURE SD22_SUBJECTES_ENTITATS_UNICS IS
    BEGIN
    
        
       INSERT INTO Z_SD022_SUBJECTE_ENTITAT_UNIC (ID_SUBJECTE, NOM, COGNOMS, COGNOM1, COGNOM2, NOM_NORMALITZAT,NOMALITZAT_CONTACTE,TRACTAMENT, EMPRESA, CARREC, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                 SELECT  (A1_SEQ_SUBJECTE.NEXTVAL) AS ID_SUBJECTE,	
                                    AGRUPATOR.NOM AS NOM ,
                                    AGRUPATOR.COGNOMS AS COGNOMS,        
                                    FUNC_NULOS_STRING() AS COGNOM1,
                                    FUNC_NULOS_STRING() AS COGNOM2,
                                    AGRUPATOR.NOM_NORMALITZAT AS NOM_NORMALITZAT,
                                    NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                    TRACTAMENT AS TRACTAMENT,
                                    AGRUPATOR.EMPRESA,
                                    AGRUPATOR.CARREC,
                                    AGRUPATOR.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                    AGRUPATOR.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                    ConstSebjecteEntitat AS TIPUS_SUBJECTE_ID,
                                    ID_ORIGINAL AS ID_ORIGINAL, 
                                    'RISPLUS' AS ESQUEMA_ORIGINAL , 
                                    'CONTACTES' AS TABLA_ORIGINAL
                     FROM (                        
                            SELECT EMPRESA AS NOM,
                                   FUNC_NULOS_STRING() AS COGNOMS,
                                   FUNC_NORMALITZAR_ENTITAT(EMPRESA) AS NOM_NORMALITZAT,
                                   MAX(FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC)) AS NOMALITZAT_CONTACTE,
                                   MAX(TRACTAMENT) AS TRACTAMENT,
                                   EMPRESA AS EMPRESA,
                                   CARREC AS CARREC,
                                   MAX(DATAMODIF) AS DATA_MODIFICACIO,
                                   MAX(USUARI) AS USUARI_MODIFICACIO,
                                   MAX(CONTACTEID) AS ID_ORIGINAL
                            FROM Z_SD000_CONTACTES
                            WHERE FUNC_NORMALITZAR(NOM || COGNOMS) IS NULL
                              AND FUNC_NORMALITZAR_ENTITAT(EMPRESA) IS NOT NULL
                         GROUP BY EMPRESA, CARREC 
                       ) AGRUPATOR
                   WHERE  NOT EXISTS (SELECT 1 
                                        FROM Z_SD022_SUBJECTE_ENTITAT_UNIC ANTIGUOS
                                       WHERE NVL(ANTIGUOS.EMPRESA,'*') = NVL(AGRUPATOR.EMPRESA,'*')
                                         AND NVL(ANTIGUOS.CARREC,'*') = NVL(AGRUPATOR.CARREC,'*')
                                      );
                                      

    
    COMMIT;
    END;
/*   
   PROCEDURE SD23_SUBJECTE_ENTITAT_CONTACTE IS
   BEGIN
      INSERT INTO Z_SD023_SUBJECTES_ENTITATS_CONT
                 SELECT CONTACTE.CONTACTEID,
                       SUBJECTE.*
                  FROM Z_SD000_CONTACTES CONTACTE,       
                       Z_SD022_SUBJECTES_ENTITATS_UNIC SUBJECTE
                 WHERE SUBJECTE.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)
                  AND NOT EXISTS (SELECT 1
                  					FROM Z_SD023_SUBJECTES_ENTITATS_CONT ANTIGUOS
                  				   WHERE ANTIGUOS.NOMALITZAT_CONTACTE = SUBJECTE.NOMALITZAT_CONTACTE
                                  );
    
   
   
   COMMIT;
   END;
 */  
   
   PROCEDURE SD24_SUBJECTES_CARREC_UNIC IS
   BEGIN
   
    INSERT INTO Z_SD024_SUBJECTES_CARREC_UNIC (ID_SUBJECTE, NOM, COGNOMS, COGNOM1, COGNOM2, NOM_NORMALITZAT, NOMALITZAT_CONTACTE,TRACTAMENT, EMPRESA, CARREC, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                 SELECT  (A1_SEQ_SUBJECTE.NEXTVAL) AS ID_SUBJECTE,	
                                    AGRUPATOR.NOM AS NOM ,
                                    AGRUPATOR.COGNOMS AS COGNOMS,        
                                    FUNC_NULOS_STRING() AS COGNOM1,
                                    FUNC_NULOS_STRING() AS COGNOM2,
                                    AGRUPATOR.NOM_NORMALITZAT AS NOM_NORMALITZAT, 
                                    NOMALITZAT_CONTACTE AS NOMALITZAT_CONTACTE,
                                    AGRUPATOR.TRACTAMENT AS TRACTAMENT,
                                    AGRUPATOR.EMPRESA,
                                    AGRUPATOR.CARREC,
                                    AGRUPATOR.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                                    AGRUPATOR.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                                    ConstSebjecteEntitat AS TIPUS_SUBJECTE_ID,
                                    ID_ORIGINAL AS ID_ORIGINAL, 
                                    'RISPLUS' AS ESQUEMA_ORIGINAL , 
                                    'CONTACTES' AS TABLA_ORIGINAL
                     FROM (                        
                            SELECT CARREC AS NOM,
                                   FUNC_NULOS_STRING() AS COGNOMS,
                                   FUNC_NORMALITZAR_ENTITAT(CARREC) AS NOM_NORMALITZAT,
                                   MAX(FUNC_NORMALITZAR(NOM || COGNOMS || EMPRESA || CARREC)) AS NOMALITZAT_CONTACTE,
                                   MAX(TRACTAMENT) AS TRACTAMENT,
                                   FUNC_NULOS_STRING() AS EMPRESA,
                                   CARREC AS CARREC,
                                   MAX(DATAMODIF) AS DATA_MODIFICACIO,
                                   MAX(USUARI) AS USUARI_MODIFICACIO,
                                   MAX(CONTACTEID) AS ID_ORIGINAL       
                            FROM Z_SD000_CONTACTES
                            WHERE FUNC_NORMALITZAR(NOM || COGNOMS) IS NULL
                              AND FUNC_NORMALITZAR_ENTITAT(EMPRESA) IS NULL        
                              AND FUNC_NORMALITZAR_ENTITAT(CARREC) IS NOT NULL
                         GROUP BY CARREC 
                       ) AGRUPATOR
                     WHERE  NOT EXISTS (SELECT 1 
                                        FROM Z_SD024_SUBJECTES_CARREC_UNIC ANTIGUOS
                                       WHERE ANTIGUOS.NOMALITZAT_CONTACTE = AGRUPATOR.NOMALITZAT_CONTACTE
                                      );  
   COMMIT;   
   END;
   
/*   
   PROCEDURE SD25_SUBJECTE_CARREC_CONTACTE IS
   BEGIN
            INSERT INTO Z_SD025_SUBJECTES_CARREC_CONT
                 SELECT CONTACTE.CONTACTEID,
                       SUBJECTE.*
                  FROM Z_SD000_CONTACTES CONTACTE,       
                       Z_SD024_SUBJECTES_CARREC_UNIC SUBJECTE
                 WHERE SUBJECTE.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)
                  AND NOT EXISTS (SELECT 1
                  					FROM Z_SD025_SUBJECTES_CARREC_CONT ANTIGUOS
                  				   WHERE ANTIGUOS.NOMALITZAT_CONTACTE = SUBJECTE.NOMALITZAT_CONTACTE
                                  );
   COMMIT;
   END;
*/   
   
   PROCEDURE SD26_SUBJECTES_UNION IS
   BEGIN
       INSERT INTO Z_SD026_SUBJECTES_UNION (ID, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT, NOMALITZAT_CONTACTE, TRACTAMENT, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)   
         SELECT ID, 
         	    NOM, 
         	    COGNOM1, 
         	    COGNOM2, 
         	    NOM_NORMALITZAT, 
         	    NOMALITZAT_CONTACTE, 
         	    TRACTAMENT, 
         	    DATA_MODIFICACIO, 
         	    USUARI_MODIFICACIO, 
         	    TIPUS_SUBJECTE_ID,
                ID_ORIGINAL, 
                ESQUEMA_ORIGINAL , 
                TABLA_ORIGINAL
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
                                        SUBJECTES_PERSONAS.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID,
                                        ID_ORIGINAL, 
                                        ESQUEMA_ORIGINAL , 
                                        TABLA_ORIGINAL
                             FROM Z_SD020_SUBJECTE_PERSONA_UNIC SUBJECTES_PERSONAS
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
                                        SUBJECTES_ENTITATS.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID,
                                        ID_ORIGINAL, 
                                        ESQUEMA_ORIGINAL , 
                                        TABLA_ORIGINAL
                              FROM Z_SD022_SUBJECTE_ENTITAT_UNIC SUBJECTES_ENTITATS
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
                                        SUBJECTES_CARREC.TIPUS_SUBJECTE_ID AS TIPUS_SUBJECTE_ID,
                                        ID_ORIGINAL, 
                                        ESQUEMA_ORIGINAL , 
                                        TABLA_ORIGINAL
                                  FROM Z_SD024_SUBJECTES_CARREC_UNIC SUBJECTES_CARREC
                ) SUBJECTES_UNION
                WHERE NOT EXISTS (SELECT 1
                                    FROM Z_SD026_SUBJECTES_UNION ANTIGUOS
                                   WHERE SUBJECTES_UNION.NOMALITZAT_CONTACTE = ANTIGUOS.NOMALITZAT_CONTACTE
                                  );  
       
   
   COMMIT;
   END;
   
   
   
   PROCEDURE SD27_SUBJECTES_RISPLUS IS
   BEGIN
   
        INSERT INTO Z_SD999_SUBJECTES (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                     SELECT NUEVOS.ID AS ID,
                            substr(NUEVOS.NOM,1,50) AS NOM,
                            substr(NUEVOS.COGNOM1,1,40) AS COGNOM1,
                            substr(NUEVOS.COGNOM2,1,40) AS COGNOM2,
                            FUNC_NULOS_STRING() AS ALIES,
                            FUNC_NULOS_STRING() AS DATA_DEFUNCIO,
                            0 AS ES_PROVISIONAL,
                            substr(NUEVOS.NOM_NORMALITZAT,1,60) AS NOM_NORMALITZAT,
                            FUNC_NULOS_STRING() AS MOTIU_BAIXA,
                            FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                            FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                            NUEVOS.DATA_MODIFICACIO AS DATA_MODIFICACIO,
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                            FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                            NUEVOS.USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                            (SELECT ID FROM A1_DM_TRACTAMENT WHERE DESCRIPCIO = NUEVOS.TRACTAMENT) AS TRACTAMENT_ID,
                            FUNC_NULOS_STRING() AS PRIORITAT_ID,
                            NUEVOS.TIPUS_SUBJECTE_ID,
                            ConstALCALDIA AS AMBIT_ID,
                            FUNC_NULOS_STRING() AS IDIOMA_ID,
                            FUNC_NULOS_STRING() AS ARTICLE_ID,
                            ID_ORIGINAL AS ID_ORIGINAL, 
                            'RISPLUS' AS ESQUEMA_ORIGINAL , 
                            'CONTACTES' AS TABLA_ORIGINAL
                       FROM Z_SD026_SUBJECTES_UNION NUEVOS
                      WHERE NOT EXISTS (SELECT 1
                                          FROM Z_SD999_SUBJECTES ANTIGUOS
                                         WHERE ANTIGUOS.NOM_NORMALITZAT = NUEVOS.NOM_NORMALITZAT
                                        ); 
   COMMIT;
                INSERT INTO A1_SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                            SELECT * 
                            FROM Z_SD999_SUBJECTES NUEVOS
                           WHERE NOT EXISTS(SELECT 1
                                              FROM A1_SUBJECTE ANTIGUOS
                                             WHERE ANTIGUOS.ID = NUEVOS.ID
                                           );  
   
   COMMIT;
   END;
   
   
    PROCEDURE SD30_CONTACTES_SUBJECTES IS
    BEGIN
            
             INSERT INTO Z_SD030_CONTACTES_SUBJECTES (CONTACTEID,ID_SUBJECTE,NOMALITZAT_CONTACTE)                  
                            SELECT      CONTACTE.CONTACTEID AS CONTACTEID,
                                        SUBJECTES.ID AS ID_SUBJECTE,
                                        SUBJECTES.NOMALITZAT_CONTACTE
                             FROM Z_SD026_SUBJECTES_UNION SUBJECTES,
                                  Z_SD000_CONTACTES CONTACTE
                             WHERE SUBJECTES.NOMALITZAT_CONTACTE = FUNC_NORMALITZAR(CONTACTE.NOM || CONTACTE.COGNOMS || CONTACTE.EMPRESA || CONTACTE.CARREC)                            
    						   AND NOT EXISTS (SELECT 1
                                        FROM Z_SD030_CONTACTES_SUBJECTES ANTIGUOS
                                       WHERE ANTIGUOS.NOMALITZAT_CONTACTE =  SUBJECTES.NOMALITZAT_CONTACTE
                                     );    
    COMMIT;
    END;
   
   
/*    
    -- SE MONTA LA TABLA FINAL DE SUJETOS RELACIONADA CON ID_CONTACTE
    PROCEDURE SD30_CONTACTES_SUBJECTES_UNION IS
    BEGIN
    
        INSERT INTO Z_SD030_CONTACTES_SUBJE_UNION (CONTACTEID, ID_SUBJECTE, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT,NOMALITZAT_CONTACTE, TRACTAMENT, DATA_MODIFICACIO, USUARI_MODIFICACIO, TIPUS_SUBJECTE_ID)
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
                             FROM Z_SD021_SUBJECTES_PERSONAS_CONT SUBJECTES_PERSONAS
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
                              FROM Z_SD023_SUBJECTES_ENTITATS_CONT SUBJECTES_ENTITATS
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
                                  FROM Z_SD025_SUBJECTES_CARREC_CONT SUBJECTES_CARREC
                    ) CONTACTES_UNION
                    WHERE NOT EXISTS (SELECT 1
                                        FROM Z_SD030_SUBJECTES_CONT_UNION ANTIGUOS
                                       WHERE ANTIGUOS.NOMALITZAT_CONTACTE =  CONTACTES_UNION.NOMALITZAT_CONTACTE
                                     );
    
    COMMIT;
    END;
*/    
    
    
    
   
    
    --------CONTACTES
    
     PROCEDURE SD40_ADRECA_UNICAS IS
     BEGIN    
     
                 INSERT INTO Z_SD040_ADRECAS_UNICAS (ID_ADRECA,NOM_ADRECA,MUNICIPI,CODIPOSTAL,PROVINCIA,PAIS) 
                         SELECT (A1_SEQ_ADRECA.NEXTVAL) AS ID_ADRECA, 
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
                                      FROM  Z_SD000_CONTACTES RISPLUS 
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
                                                 FROM Z_SD040_ADRECAS_UNICAS ANTIGUAS
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
						'Z_SD000_CONTACTES' AS TABLA,
						'ADRECA ' AS CAMPO_ERROR,
						ADRECA || ' -> ES NULO' AS ERROR_DESC
                FROM Z_SD000_CONTACTES CONTACTES 
               WHERE  FUNC_NULOS(CONTACTES.ADRECA) = '*';
                                                
            
          --B) CODIGOS POSTALES NO NUMERICOS
          INSERT INTO ERR_R_ADRECAS (CONTACTEID, ESQUEMA, TABLA,CAMPO_ERROR, ERROR_DESC)     
                SELECT CONTACTES.CONTACTEID AS CONTACTE_ID,
                       'RISPLUS' AS ESQUEMA,
						'Z_SD000_CONTACTES' AS TABLA,
						'CODIPOSTAL' AS CAMPO_ERROR,
						CODIPOSTAL || ' -> NO ES NUMERICO' AS ERROR_DESC
                FROM Z_SD000_CONTACTES CONTACTES 
               WHERE  FUNC_ES_NUMERICO(TRIM(CODIPOSTAL))=0;
                
    COMMIT;
    END;
    
    

    PROCEDURE SD41_ADRECA_CONTACTE IS
    BEGIN
    
            INSERT INTO Z_SD041_ADRECAS_CONTACTES (CONTACTEID, ID_ADRECA) 
                       SELECT CONTACTEID,
                              ID_ADRECA
                        FROM (     
                                SELECT CONTACTES.CONTACTEID AS CONTACTEID,
                                       ADRECA.ID_ADRECA AS ID_ADRECA
                                FROM Z_SD040_ADRECAS_UNICAS ADRECA,
                                     Z_SD000_CONTACTES CONTACTES
                                WHERE FUNC_NULOS(ADRECA.NOM_ADRECA) = FUNC_NULOS(CONTACTES.ADRECA)
                                  AND FUNC_NULOS(ADRECA.MUNICIPI) = FUNC_NULOS(CONTACTES.MUNICIPI)
                                  AND FUNC_NULOS(ADRECA.CODIPOSTAL) = FUNC_NULOS(CONTACTES.CODIPOSTAL)
                                  AND FUNC_NULOS(ADRECA.Provincia) = FUNC_NULOS(CONTACTES.Provincia)
                                  AND FUNC_NULOS(ADRECA.pais) = FUNC_NULOS(CONTACTES.PAIS)
                            ) NUEVOS
                        WHERE NOT EXISTS (SELECT 1
                                            FROM Z_SD041_ADRECAS_CONTACTES ANTIGUOS
                                           WHERE ANTIGUOS.CONTACTEID=NUEVOS.CONTACTEID 
                                             AND ANTIGUOS.ID_ADRECA = ANTIGUOS.ID_ADRECA
                                          ); 
    
    COMMIT;
    END;
    
    PROCEDURE SD42_AUX_ADRECA IS
    BEGIN
             INSERT INTO Z_SD999_ADRECA (ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_CARRER, NOM_CARRER, LLETRA_INICI, LLETRA_FI, ESCALA, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PIS, PORTA, BLOC, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE)
					SELECT  ID_ADRECA AS ID, 
                            FUNC_NULOS_STRING() AS CODI_MUNICIPI, 
                            MUNICIPI AS	MUNICIPI, 
                            FUNC_NULOS_STRING() AS CODI_PROVINCIA, 
                            PROVINCIA AS PROVINCIA, 
                            FUNC_NULOS_STRING() AS CODI_PAIS, 
                            PAIS AS PAIS, 
                            FUNC_NULOS_STRING() AS CODI_CARRER, 
                            FUNC_NULOS(NOM_ADRECA)  AS NOM_CARRER,
                            FUNC_NULOS_STRING() AS LLETRA_INICI, 
                            FUNC_NULOS_STRING() AS LLETRA_FI, 
                            FUNC_NULOS_STRING() AS ESCALA,
                            CODIPOSTAL AS CODI_POSTAL, 
                            FUNC_NULOS_STRING() AS COORDENADA_X, 
                            FUNC_NULOS_STRING() AS COORDENADA_Y, 
                            FUNC_NULOS_STRING() AS SECCIO_CENSAL, 
                            FUNC_NULOS_STRING() AS ANY_CONST, 
                            FUNC_NULOS_STRING() AS NUMERO_INICI,
                            FUNC_NULOS_STRING() AS NUMERO_FI, 
                            FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                            FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                            FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                            FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                            FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                            FUNC_NULOS_STRING() AS PIS,
                            FUNC_NULOS_STRING() AS PORTA,
                            FUNC_NULOS_STRING() AS BLOC,
                            FUNC_NULOS_STRING() AS CODI_TIPUS_VIA,
                            FUNC_NULOS_STRING() AS CODI_BARRI,
                            FUNC_NULOS_STRING() AS BARRI,
                            FUNC_NULOS_STRING() AS CODI_DISTRICTE,
                            FUNC_NULOS_STRING() AS DISTRICTE                           
						FROM Z_SD040_ADRECAS_UNICAS NUEVAS 
                       WHERE NOT EXISTS (SELECT 1 
                                         FROM Z_SD999_ADRECA ANTIGUAS
                                         WHERE FUNC_NULOS(NUEVAS.NOM_ADRECA) = FUNC_NULOS(ANTIGUAS.NOM_CARRER)
                                           AND FUNC_NULOS(NUEVAS.MUNICIPI) = FUNC_NULOS(ANTIGUAS.MUNICIPI)
                                           AND FUNC_NULOS(NUEVAS.CODIPOSTAL) = FUNC_NULOS(ANTIGUAS.CODI_POSTAL)
                                           AND FUNC_NULOS(NUEVAS.Provincia) = FUNC_NULOS(ANTIGUAS.Provincia)
                                           AND FUNC_NULOS(NUEVAS.pais) = FUNC_NULOS(ANTIGUAS.PAIS)
                                         );

    COMMIT;
                                         
             INSERT INTO A1_ADRECA (ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_CARRER, NOM_CARRER, LLETRA_INICI, LLETRA_FI, ESCALA, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PIS, PORTA, BLOC, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
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
                        DISTRICTE,
                        FUNC_NULOS_STRING() AS ID_ORIGINAL, 
                        'RISPLUS' AS ESQUEMA_ORIGINAL , 
                        'CONTACTES' AS TABLA_ORIGINAL
                        FROM Z_SD999_ADRECA;    
    
    COMMIT;
    END;
    
    

    
    PROCEDURE SD50_AUX_CONTACTES IS
    BEGIN
            INSERT INTO Z_SD999_CONTACTES (ID, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,DATA_FI_VIGENCIA_CARREC)
            SELECT A1_SEQ_CONTACTE.NEXTVAL AS ID,
                    0 AS ES_PRINCIPAL,
                    substr(DEPARTAMENT,1,35) AS DEPARTAMENT,
                    0 AS DADES_QUALITAT,
                    DATAMODIF AS DATA_DARRERA_ACTUALITZACIO,
                    FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                    FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                    DATAMODIF AS DATA_MODIFICACIO,
                    FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                    FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                    USUARI AS USUARI_MODIFICACIO,
                    (CASE WHEN (EMPRESA IS NOT NULL) THEN
                        ConstProfesional
                    ELSE 
                        ConstPersonal
                    END) AS TIPUS_CONTACTE_ID,
                    (SELECT ID_SUBJECTE FROM Z_SD030_CONTACTES_SUBJECTES WHERE contacteid= contacteid and ROWNUM = 1) AS SUBJECTE_ID,
                    (SELECT ID_ADRECA FROM Z_SD041_ADRECAS_CONTACTES WHERE contacteid= contacteid and ROWNUM = 1) AS ADRECA_ID,
--                    (SELECT ENTITAT_ID FROM Z_SD015_ENTITAT_CONTACTE WHERE CONTACTE_ID = CONTACTEID and ROWNUM = 1) AS ENTITAT_ID,
--                   (SELECT D011.ENTITAT_ID FROM Z_SD011_B_ENTITAT_NO_EXIST D011 WHERE D011.CONTACTEID = CONTACTEID and ROWNUM = 1) AS ENTITAT_ID,
                   (SELECT ENTITAT.ID FROM A1_DM_ENTITAT ENTITAT WHERE FUNC_NORMALITZAR(ENTITAT.DESCRIPCIO) = FUNC_NORMALITZAR(EMPRESA) and ROWNUM = 1) AS ENTITAT_ID,
                    FUNC_NULOS_STRING() AS CONTACTE_ORIGEN_ID,
                    ConstVisibilitatPrivada AS VISIBILITAT_ID,
                    ConstAlcaldia AS AMBIT_ID,
                    (SELECT id FROM A1_DM_CARREC WHERE FUNC_NORMALITZAR(CARREC) = FUNC_NORMALITZAR(DESCRIPCIO) and ROWNUM = 1) AS CARREC_ID,
                    CONTACTEID AS ID_ORIGINAL,
                    'RISPLUS' AS ESQUEMA_ORIGINAL,
                    'CONTACTES' AS TABLA_ORIGINAL,
                    FUNC_NULOS_STRING() AS DATA_FI_VIGENCIA_CARREC
               FROM Z_SD000_CONTACTES
               WHERE NOT EXISTS (SELECT 1
                                 FROM Z_SD999_CONTACTES ANTIGUOS
                                 WHERE CONTACTEID = ANTIGUOS.ID_ORIGINAL
                                   AND ESQUEMA_ORIGINAL = 'RISPLUS');
    
    
      COMMIT;
    
       INSERT INTO A1_CONTACTE
                  SELECT * 
                    FROM Z_SD999_CONTACTES NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM A1_CONTACTE ANTIGUOS
                                     WHERE NUEVOS.ID =  ANTIGUOS.ID
                                    );
    
    
    COMMIT;
    END;
    
    
    
   PROCEDURE SD60_CORREUS_CONTACTES IS
    BEGIN
            
            INSERT INTO Z_SD060_CORREUS_CONTACTES (CONTACTEID, EMAIL)
                SELECT aux.CONTACTEID, aux.email
                FROM(                                                                         
                     select DISTINCT(t.CONTACTEID) AS CONTACTEID,
                            trim(regexp_substr(t.email, '[^;]+', 1, levels.column_value))  as email
                    from 
                        (SELECT (CONTACTEID) AS CONTACTEID, email 
                         FROM Z_SD000_CONTACTES 
                         WHERE email IS NOT NULL AND email LIKE '%@%' and
                              EMAIL IS NOT NULL                            
                        ) t,
                    table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(t.EMAIL, '[^;]+'))  + 1) as sys.OdciNumberList)) levels
                    order by CONTACTEID
                 ) aux
                 WHERE TRIM(aux.email) is not null
                   AND NOT EXISTS (SELECT 1 
                                  FROM Z_SD060_CORREUS_CONTACTES NUEVOS
                                  WHERE NUEVOS.CONTACTEID = AUX.CONTACTEID
                                    AND NUEVOS.EMAIL = AUX.EMAIL);
                
    COMMIT;               
   END;
   
   
    PROCEDURE SD61_CORREUS_PRINCIPALES IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT CONTACTEID, EMAIL FROM  Z_SD060_CORREUS_CONTACTES ORDER BY CONTACTEID
        )
        LOOP
            
            IF c.CONTACTEID <> id_contacte_ant THEN
              id_contacte_ant:= c.CONTACTEID;
              INSERT INTO Z_SD061_CORREUS_PRINCIPALES VALUES (c.CONTACTEID, c.email, 1);
            ELSE
              INSERT INTO Z_SD061_CORREUS_PRINCIPALES VALUES (c.CONTACTEID, c.email, 0);           
            END IF;

        END LOOP;
        
        COMMIT;            
        
        END;
                
        
        PROCEDURE SD62_CORREOS_CONTACTOS IS   
        
        BEGIN
         
           INSERT INTO  A1_CONTACTE_CORREU (ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                SELECT (A1_SEQ_CONTACTE_CORREU.NEXTVAL) AS ID,
		                cc.correu AS CORREU_ELECTRONIC, 
		                cc.principal ES_PRINCIPAL, 
		                FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                        FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                        FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
		                FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                        FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                        FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
		                cc.id_contacte AS CONTACTE_ID,
                        NULL AS ID_ORIGINAL, 
                        'RISPLUS' AS ESQUEMA_ORIGINAL , 
                        'CONTACTE' AS TABLA_ORIGINAL
                 FROM Z_SD061_CORREUS_PRINCIPALES cc
                 WHERE NOT EXISTS(SELECT 1 
                                  FROM A1_CONTACTE_CORREU 
                                  WHERE id = cc.id_contacte)
                       AND EXISTS (SELECT 1 
                                     FROM A1_CONTACTE CONTACTE
                                    WHERE CC.ID_CONTACTE =  CONTACTE.ID);
                 
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN Z_C51_CORREUS_PRINCIPALES
        
        END;  
    
    
    PROCEDURE SD070_TELEFONS_FIXE_SPLIT IS
    BEGIN
           
           INSERT INTO Z_SD070_TELEFONS_FIXE_SPLIT
            SELECT aux.CONTACTEID, aux.TELEFONFIXE
                FROM(                                                                         
                     select DISTINCT(t.CONTACTEID) AS CONTACTEID,
                            trim(regexp_substr(t.TELEFONFIXE, '[^;/-]+', 1, levels.column_value))  as TELEFONFIXE
                    from 
                        (SELECT (CONTACTEID) AS CONTACTEID, 
                                TELEFONFIXE 
                         FROM Z_SD000_CONTACTES 
                         WHERE TELEFONFIXE IS NOT NULL AND (TELEFONFIXE LIKE '%-%' OR TELEFONFIXE LIKE '%/%') and
                              TELEFONFIXE IS NOT NULL                            
                        ) t,
                    table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(t.TELEFONFIXE, '[^;/-]+'))  + 1) as sys.OdciNumberList)) levels
                    order by CONTACTEID
                 ) aux
                   WHERE TRIM(aux.TELEFONFIXE) is not null
                   AND NOT EXISTS (SELECT 1 
                                  FROM Z_SD070_TELEFONS_FIXE_SPLIT NUEVOS
                                  WHERE NUEVOS.CONTACTEID = AUX.CONTACTEID
                                    AND NUEVOS.TELEFONFIXE = AUX.TELEFONFIXE);
    
    COMMIT;
    END;
    
    
    PROCEDURE SD070_TELEFONS_FIXE IS
    BEGIN
          INSERT INTO Z_SD070_TELEFON_FIXE
             SELECT NUEVOS.CONTACTEID,                 	   
               	    NUEVOS.TIPUS_TELEFON,
                	NUEVOS.TELEFON,
                    (CASE WHEN COLNUM=1 THEN
                                ConstSI 
                     ELSE           
                                ConstNO
                     END) as ES_PRINCIPAL,
                    CONCEPTE AS CONCEPTE,
                    FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                    NUEVOS.CONTACTEID as ID_ORIGINAL,
                    'RISPLUS' AS ESQUEMA_ORIGINAL,
                    'CONTACTES //TELEFONFIXE       ' as TABLA_ORIGINAL
             FROM (    
                         SELECT CONTACTEID,
                                FUNC_NORMALITZAR_TFN(TELEFONFIXE) AS TELEFON,
                                FUNC_NORMALITZAR_CONCEPTE(TELEFONFIXE) AS CONCEPTE,
                                ConstTelefonFix AS TIPUS_TELEFON,
                                ROW_NUMBER ()  OVER (PARTITION BY CONTACTEID ORDER BY CONTACTEID, LENGTH(FUNC_NORMALITZAR_TFN(TELEFONFIXE)) DESC ) AS COLNUM
                                FROM Z_SD070_TELEFONS_FIXE_SPLIT              
                  ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SD070_TELEFON_FIXE ANTIGUOS
                                    WHERE ANTIGUOS.CONTACTEID = NUEVOS.CONTACTEID
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
                  
    
    COMMIT;
    
        INSERT INTO A1_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A1_SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           subStr(NUEVOS.TELEFON,1,20) AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.CONTACTEID AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SD070_TELEFON_FIXE NUEVOS,
                          A1_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.CONTACTEID
                    AND existen.ESQUEMA_ORIGINAL='RISPLUS'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A1_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.CONTACTEID
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
                                     
         COMMIT;                                     
    
    
    END;
    
    
    /*
    PROCEDURE SD070_TELEFONS_FIXE IS
    BEGIN
    
        INSERT INTO Z_SD070_TELEFON_FIXE (CONTACTEID, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.CONTACTEID,                 	   
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstSI as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.CONTACTEID as ID_ORIGINAL,
                       'RISPLUS' AS ESQUEMA_ORIGINAL,
                       'CONTACTES //TELEFONFIXE       ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT CONTACTE.CONTACTEID As CONTACTEID,
                             (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TELEFONFIXE),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TELEFONFIXE))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TELEFONFIXE) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TELEFONFIXE) AS CONCEPTE                              
                       FROM Z_SD000_CONTACTES CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TELEFONFIXE))=1
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SD070_TELEFON_FIXE ANTIGUOS
                                    WHERE ANTIGUOS.CONTACTEID = NUEVOS.CONTACTEID
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     
     INSERT INTO A1_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A1_SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           subStr(NUEVOS.TELEFON,1,20) AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.CONTACTEID AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SD070_TELEFON_FIXE NUEVOS,
                          A1_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.CONTACTEID
                    AND existen.ESQUEMA_ORIGINAL='RISPLUS'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A1_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.CONTACTEID
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
     
  COMMIT;   
  END;  
  */
  
  
   PROCEDURE SD071_TELEFONS_MOBIL IS
    BEGIN
    
        INSERT INTO Z_SD071_TELEFON_MOBIL (CONTACTEID, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.CONTACTEID,                 	   
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.CONTACTEID as ID_ORIGINAL,
                       'RISPLUS' AS ESQUEMA_ORIGINAL,
                       'CONTACTES //TELEFONFIXE       ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT CONTACTE.CONTACTEID As CONTACTEID,
                             (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TELEFONMOBIL),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TELEFONMOBIL))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TELEFONMOBIL) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TELEFONMOBIL) AS CONCEPTE                              
                       FROM Z_SD000_CONTACTES CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TELEFONMOBIL))=1
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SD070_TELEFON_FIXE ANTIGUOS
                                    WHERE ANTIGUOS.CONTACTEID = NUEVOS.CONTACTEID
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     
     INSERT INTO A1_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A1_SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           subStr(NUEVOS.TELEFON,1,20) AS NUMERO, 
                           NUEVOS.ES_PRINCIPAL AS ES_PRINCIPAL, 
                           FUNC_NULOS_STRING() AS OBSERVACIONS,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO, 
                           NULL AS DATA_ESBORRAT,
                           NULL AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL), 
                           NULL AS USUARI_ESBORRAT,
                           NULL AS USUARI_MODIFICACIO,
                           NUEVOS.CONTACTEID AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SD070_TELEFON_FIXE NUEVOS,
                          A1_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.CONTACTEID
                    AND existen.ESQUEMA_ORIGINAL='RISPLUS'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A1_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.CONTACTEID
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
     
  COMMIT;   
  END;  
    
    
/*    
    PROCEDURE SD70_TELEFONS_NUMERICS is 
            BEGIN           
            
             INSERT INTO Z_SD070_TELEFONS_NUMERICS
                 SELECT (CONTACTEID) AS ID_CONTACTE_SINTAGMA,
                       CASE WHEN SUBSTR(TRIM(TELEFONFIXE),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFONFIXE,' ','')))= 9 THEN 2
                        ELSE 1 
                       END AS TIPUS_TELEFON,
                       FUNC_NORMALITZAR_SIGNES(TELEFONFIXE) AS TELEFON
                 FROM Z_SD000_CONTACTES C
                 WHERE TRIM(TELEFONFIXE) IS NOT NULL 
                   AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFONFIXE)) IS NULL 
                   AND TRIM(TELEFONFIXE) <> '.';

                
             
            

                INSERT INTO Z_SD070_TELEFONS_NUMERICS
                 SELECT (CONTACTEID) AS ,
                       CASE WHEN SUBSTR(TRIM(TELEFONMOBIL),1,1)= '6' AND LENGTH(TRIM(REPLACE(TELEFONMOBIL,' ','')))= 9 THEN 2
                        ELSE 1 
                       END AS TIPUS_TELEFON,
                       FUNC_NORMALITZAR_SIGNES(TELEFONMOBIL) AS TELEFON
                FROM Z_SD000_CONTACTES C
                WHERE TRIM(TELEFONMOBIL) IS NOT NULL 
                  AND LENGTH(FUNC_NORMALITZAR_NUMERICS(TELEFONMOBIL)) IS NULL 
                  AND TRIM(TELEFONMOBIL) <> '.';
              
            
           COMMIT;
           
          END;
    
    
    PROCEDURE SD71_TELEFON_PRINCIPAL IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT * FROM  Z_SD070_TELEFONS_NUMERICS ORDER BY ID_CONTACTE_SINTAGMA
        )
        LOOP
            
            IF c.ID_CONTACTE_SINTAGMA <> id_contacte_ant THEN
              id_contacte_ant:= c.ID_CONTACTE_SINTAGMA;
              INSERT INTO Z_SD071_TELEFONS_NUMERICS VALUES (c.ID_CONTACTE_SINTAGMA, c.tipus_telefon,c.telefon, 1);
            ELSE
              INSERT INTO Z_SD071_TELEFONS_NUMERICS VALUES (c.ID_CONTACTE_SINTAGMA, c.tipus_telefon,c.telefon, 0);           
            END IF;

        END LOOP;
        
        COMMIT;       
      
      END;


      PROCEDURE SD72_CONTACTE_TELEFON is 
           
      BEGIN
        
           INSERT INTO A1_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, CONTACTE_ID, TIPUS_TELEFON_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                    SELECT (A1_SEQ_CONTACTE_TELEFON.NEXTVAL), 
                           substr(t.telefon,1,20), 
                           t.principal, 
                           FUNC_FECHA_CREACIO(NULL), 
                           FUNC_USU_CREACIO(NULL), 
                           t.id_contacte, 
                           t.tipus_telefon,
                           NULL AS ID_ORIGINAL, 
                           'RISPLUS' AS ESQUEMA_ORIGINAL , 
                           'CONTACTE' AS TABLA_ORIGINAL
            FROM Z_SD071_TELEFONS_NUMERICS t 
            WHERE not EXISTS(SELECT * FROM CONTACTE WHERE ID = t.id_contacte) 
                  AND t.TELEFON IS NOT NULL  
                  AND NOT EXISTS(SELECT * 
                                 FROM A1_CONTACTE_TELEFON ct 
                                 WHERE ct.numero = t.telefon AND ct.contacte_id = t.id_contacte) 
                 AND EXISTS (SELECT 1 
                                     FROM A1_CONTACTE CONTACTE
                                    WHERE T.ID_CONTACTE =  CONTACTE.ID);

       COMMIT;

      END;
    */
    
    
    /*
    
    PROCEDURE SD25_SUBJECTES IS
    BEGIN 
    
        -- Sujetos (A -> tipo persona)
        INSERT INTO Z_SD025_SUBJECTES (SINTAGMA_SUBJECTE_ID, CONTACTE_RISPLUS_ID, TRACTAMENT, TRACTAMENT_ID, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA)        
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
                        FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                        FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                        DATAMODIF AS DATA_MODIFICACIO,
                        FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                        FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                        USUARI AS USUARI_MODIFICACIO,
                        NULL AS PRIORITAT_ID,
                        ConstSebjectePersona AS TIPUS_SUBJECTE_ID,
                        ConstALCALDIA AS AMBIT_ID,
                        NULL AS IDIOMA
                FROM Z_SD000_CONTACTES
                WHERE CARREC is NULL and EMPRESA IS NULL 
                  AND NOT EXISTS (SELECT 1 
                                  FROM Z_SD020_SUBJECTES ANTIGUOS
                                  WHERE (ConstSubjecte + Z_SD000_CONTACTES.CONTACTEID) = ANTIGUOS.ID_SUBJECTE
                                 ); 
 -------------------------------------------------------------------------               
        -- Subjectes (Tipo Entitat)
        
        INSERT INTO Z_SD025_SUBJECTES (SINTAGMA_SUBJECTE_ID, CONTACTE_RISPLUS_ID, TRACTAMENT, TRACTAMENT_ID, NOM, COGNOM1, COGNOM2, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA)
            SELECT (ConstSubjecte + CONTACTEID) AS SINTAGMA_SUBJECTE_ID, 
                    CONTACTEID AS CONTACTE_RISPLUS_ID, 
                    TRACTAMENT AS TRACTAMENT,
                    (SELECT ID FROM DM_TRACTAMENT WHERE DESCRIPCIO = TRACTAMENT AND TRACTAMENT IS NOT NULL) AS TRACTAMENT_ID,
                    EMPRESA AS NOM,
                    COGNOMS AS COGNOM1,
                    NULL AS COGNOM2,
                    LimpiarChars(NOM || COGNOMS) AS NOM_NORMALITZAT,
                    'NULL' AS MOTIU_BAIXA,
                    FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                    FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                    DATAMODIF AS DATA_MODIFICACIO,
                    FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
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
            FROM Z_SD000_CONTACTES
            WHERE (CARREC is NULL and EMPRESA IS NULL) --SUBJECTES (tipo persona)
               OR (nom='.' AND COGNOMS<>'.' AND EMPRESA IS NOT NULL) -- subjectes (tipo entiodad) 
               OR NOT(CARREC is NULL and EMPRESA IS NULL); --CONTACTES (tipo profesional) 
    
    
    COMMIT;
    END;
    */
    
    PROCEDURE RESETEATOR_TABLAS IS
    BEGIN
  
        DELETE FROM Z_SD071_TELEFON_MOBIL;
        DELETE FROM Z_SD070_TELEFON_FIXE;
        DELETE FROM Z_SD070_TELEFONS_FIXE_SPLIT;
    
        DELETE FROM Z_SD061_CORREUS_PRINCIPALES;
        DELETE FROM Z_SD060_CORREUS_CONTACTES;
--        DELETE FROM Z_SD025_SUBJECTES;
        DELETE FROM Z_SD999_CONTACTES;
        DELETE FROM Z_SD999_SUBJECTES;
    
--        DELETE FROM Z_SD021_SUBJECTE_CONTACTES;
        
--        DELETE FROM ERR_R_SUBJECTES_NOM_NULL;

        DELETE Z_SD999_ADRECA;
        DELETE Z_SD041_ADRECAS_CONTACTES;
        DELETE ERR_R_ADRECAS;
        DELETE Z_SD040_ADRECAS_UNICAS; 
        
        


        DELETE FROM Z_SD030_CONTACTES_SUBJECTES;

        DELETE FROM Z_SD026_SUBJECTES_UNION;

--        DELETE FROM Z_SD025_SUBJECTES_CARREC_CONT;        
        DELETE FROM Z_SD024_SUBJECTES_CARREC_UNIC;
        
--        DELETE FROM Z_SD023_SUBJECTES_ENTITATS_CONT;
        DELETE FROM Z_SD022_SUBJECTE_ENTITAT_UNIC;

--        DELETE FROM Z_SD021_SUBJECTES_PERSONAS_CONT;
        DELETE FROM Z_SD020_SUBJECTE_PERSONA_UNIC;        
        
        
    
        DELETE FROM Z_SD015_ENTITAT_CONTACTE;
        DELETE FROM Z_SD011_B_ENTITAT_NO_EXIST;
        DELETE FROM Z_SD011_A_ENTITAT_NO_EXISTENTE;
        DELETE FROM ERR_R_CONTACTES_EMPRESA_NULL;
        DELETE FROM Z_SD010_ENTITAT_EXISTENTE;
  
        DELETE FROM Z_SD003_DM_CARREC;
        
--        DELETE FROM Z_SD002_DM_CARREC;
        DELETE FROM Z_SD001_DM_TRACTAMENT;
        DELETE FROM Z_SD000_CONTACTES;        
        

        
    COMMIT;
    END;



END S_03_CONTACTES_RISPLUS;

/
