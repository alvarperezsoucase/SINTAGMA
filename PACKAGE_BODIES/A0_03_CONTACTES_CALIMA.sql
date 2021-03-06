--------------------------------------------------------
--  DDL for Package Body A0_03_CONTACTES_CALIMA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."A0_03_CONTACTES_CALIMA" AS

        PROCEDURE SC001_NEW_TRACTAMENT IS 
    BEGIN

            
            INSERT INTO Z_SC999_DM_TRACTAMENT (CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT NUEVOS.TRACTAMENT AS CODI , 
                           NUEVOS.TRACTAMENT AS DESCRIPCIO,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                           FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                           FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                           FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                           FUNC_NULOS_STRING() AS ABREUJADA,
                           NUEVOS.TRACTAMENT AS ID_ORIGINAL,
                           'CALIMA' AS ESQUEMA_ORIGINAL, 
                           'EXT_CONTACTES' AS TABLA_ORIGINAL                   
                    FROM (
                            SELECT TRACTAMENT AS TRACTAMENT, 
                                   FUNC_NORMALITZAR(calima.TRACTAMENT) AS TRACTAMENT_NORMALITZAT, 
                                   ROW_NUMBER ()  OVER (PARTITION BY FUNC_NORMALITZAR(calima.TRACTAMENT) ORDER BY FUNC_NORMALITZAR(calima.TRACTAMENT) ASC ) AS COLNUM
                              FROM  Z_TMP_CALIMA_U_EXT_CONTACTES calima
                              WHERE FUNC_NORMALITZAR(TRACTAMENT) IN (
                                                                        SELECT FUNC_NORMALITZAR(calima.TRACTAMENT)  AS TRACTAMENT
                                                                        FROM Z_TMP_CALIMA_U_EXT_CONTACTES calima
                                                                        LEFT OUTER JOIN 
                                                                            A0_DM_TRACTAMENT tractament
                                                                            on FUNC_NORMALITZAR(calima.TRACTAMENT) = FUNC_NORMALITZAR(tractament.DESCRIPCIO)
                                                                            WHERE FUNC_NORMALITZAR(tractament.DESCRIPCIO) IS NULL
                                                                        GROUP BY FUNC_NORMALITZAR(calima.TRACTAMENT)					
                                                                    )
                        ) NUEVOS
                    WHERE COLNUM=1
                      AND NOT EXISTS (SELECT 1
                                        FROM Z_SC999_DM_TRACTAMENT ANTIGUOS
                                       WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = FUNC_NORMALITZAR(NUEVOS.TRACTAMENT)
                                      );
    
    COMMIT;
    END;


    PROCEDURE SC002_DM_TRACTAMENT IS
    BEGIN
            
            
            INSERT INTO A0_DM_TRACTAMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ABREUJADA, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT A0_SEQ_DM_TRACTAMENT.NEXTVAL AS ID , 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_ESBORRAT, 
                        DATA_MODIFICACIO, 
                        USUARI_CREACIO, 
                        USUARI_ESBORRAT, 
                        USUARI_MODIFICACIO, 
                        ABREUJADA, 
                        ID_ORIGINAL, 
                        ESQUEMA_ORIGINAL, 
                        TABLA_ORIGINAL
                   FROM Z_SC999_DM_TRACTAMENT NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM A0_DM_TRACTAMENT ANTIGUOS
                                     WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                    );  
    
    COMMIT;
    END;


    PROCEDURE SC010_NEW_CARREC IS
    BEGIN
           INSERT INTO Z_SC999_DM_CARREC (CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT NUEVOS.CARREC_NORMALITZAT AS CODI , 
                           trim(NUEVOS.CARREC) AS DESCRIPCIO,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                           FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                           FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                           FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                           NUEVOS.CARREC AS ID_ORIGINAL,
                           'CALIMA' AS ESQUEMA_ORIGINAL, 
                           'EXT_CONTACTES' AS TABLA_ORIGINAL                   
                    FROM (
                            SELECT CARREC AS CARREC, 
                                   FUNC_NORMALITZAR(calima.CARREC) AS CARREC_NORMALITZAT, 
                                   ROW_NUMBER ()  OVER (PARTITION BY FUNC_NORMALITZAR(calima.CARREC) ORDER BY FUNC_NORMALITZAR(calima.CARREC) ASC ) AS COLNUM
                              FROM  Z_TMP_CALIMA_U_EXT_CONTACTES calima
                              WHERE FUNC_NORMALITZAR(CARREC) IN (
                                                                        SELECT FUNC_NORMALITZAR(calima.CARREC)  AS CARREC_NORMALITZAT
                                                                        FROM Z_TMP_CALIMA_U_EXT_CONTACTES calima
                                                                        LEFT OUTER JOIN 
                                                                            A0_DM_CARREC SINTAGMA
                                                                            on FUNC_NORMALITZAR(calima.CARREC) = FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO)
                                                                            WHERE FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO) IS NULL
                                                                        GROUP BY FUNC_NORMALITZAR(calima.CARREC)					
                                                                    )
                        ) NUEVOS
                    WHERE COLNUM=1
                      AND NOT EXISTS (SELECT 1
                                        FROM Z_SC999_DM_CARREC ANTIGUOS
                                       WHERE FUNC_NORMALITZAR(ANTIGUOS.DESCRIPCIO) = NUEVOS.CARREC_NORMALITZAT
                                      );

           
            
    
    COMMIT;
    END;


    PROCEDURE SC011_DM_CARREC IS
    BEGIN
            
            
            INSERT INTO A0_DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT A0_SEQ_DM_CARREC.NEXTVAL AS ID , 
                        DESCRIPCIO AS DECSRIPCIO, 
                        DATA_CREACIO, 
                        DATA_ESBORRAT, 
                        DATA_MODIFICACIO, 
                        USUARI_CREACIO, 
                        USUARI_ESBORRAT, 
                        USUARI_MODIFICACIO, 
                        SUBSTR(ID_ORIGINAL,1,30) AS ID_ORIGINAL, 
                        ESQUEMA_ORIGINAL, 
                        TABLA_ORIGINAL
                   FROM Z_SC999_DM_CARREC NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM A0_DM_CARREC ANTIGUOS
                                     WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                    );  
    
    COMMIT;
    END;

    PROCEDURE SC020_NEW_ENTITAT_CONTACTE IS
    BEGIN 
    
        INSERT INTO Z_SC999_DM_ENTITAT_CONTACTE (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
 
                    SELECT A0_SEQ_DM_ENTITAT.NEXTVAL AS ID , 
                           NUEVOS.ORGANISME_NORMALITZAT AS CODI , 
                           NUEVOS.ORGANISME AS DESCRIPCIO,
                           FUNC_FECHA_CREACIO(FUNC_FECHA_CHUNGA(DATA_CREACIO)) AS DATA_CREACIO,
                           FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DATA_ESBORRAT)) AS DATA_ESBORRAT,
                           FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DATA_MODIFICACIO)) AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                           FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                           NUEVOS.ORGANISME AS ID_ORIGINAL,
                           'CALIMA' AS ESQUEMA_ORIGINAL, 
                           'EXT_CONTACTES' AS TABLA_ORIGINAL                   
                    FROM (
                            SELECT ORGANISME AS ORGANISME, 
                                   FUNC_NORMALITZAR(calima.ORGANISME) AS ORGANISME_NORMALITZAT , 
                                   DATALTA AS DATA_CREACIO,
                                   DATADARRERA AS DATA_MODIFICACIO,
                                   DATA_BAIXA AS DATA_ESBORRAT,
                                   ROW_NUMBER ()  OVER (PARTITION BY FUNC_NORMALITZAR(calima.ORGANISME) ORDER BY FUNC_NORMALITZAR(calima.ORGANISME) ASC ) AS COLNUM
                              FROM  Z_TMP_CALIMA_U_EXT_CONTACTES calima
                              WHERE FUNC_NORMALITZAR(ORGANISME) IN (
                                                                        SELECT FUNC_NORMALITZAR(calima.ORGANISME)  AS ORGANISME
                                                                        FROM Z_TMP_CALIMA_U_EXT_CONTACTES calima
                                                                        LEFT OUTER JOIN 
                                                                            A0_DM_ENTITAT SINTAGMA
                                                                            on FUNC_NORMALITZAR(calima.ORGANISME) = FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO)
                                                                            WHERE FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO) IS NULL
                                                                        GROUP BY FUNC_NORMALITZAR(calima.ORGANISME)					
                                                                    )
                        ) NUEVOS
                    WHERE COLNUM=1
                      AND NOT EXISTS (SELECT 1
                                        FROM Z_SC999_DM_ENTITAT_CONTACTE ANTIGUOS
                                       WHERE CODI = NUEVOS.ORGANISME_NORMALITZAT
                                     );  

    COMMIT;
    END;


    PROCEDURE SC021_DM_ENTITAT_CONTACTE IS
    BEGIN
            
            
            INSERT INTO A0_DM_ENTITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT ID AS ID , 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_ESBORRAT, 
                        DATA_MODIFICACIO, 
                        USUARI_CREACIO, 
                        USUARI_ESBORRAT, 
                        USUARI_MODIFICACIO, 
                        SUBSTR(ID_ORIGINAL,1,30), 
                        ESQUEMA_ORIGINAL, 
                        TABLA_ORIGINAL
                   FROM Z_SC999_DM_ENTITAT_CONTACTE NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM A0_DM_ENTITAT ANTIGUOS
                                     WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                    );  
    
    COMMIT;
    END;
    
    PROCEDURE SC022_NEW_ENTITAT_TRUCADA IS
    BEGIN
    
            INSERT INTO Z_SC999_DM_ENTITAT_TRUCADA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A0_SEQ_DM_ENTITAT.NEXTVAL AS ID , 
                           NUEVOS.ORGANISME_NORMALITZAT AS CODI , 
                           NUEVOS.ORGANISME AS DESCRIPCIO,
                           FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                           FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                           FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DATA_MODIFICACIO)) AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                           FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                           NUEVOS.ORGANISME AS ID_ORIGINAL,
                           'CALIMA' AS ESQUEMA_ORIGINAL, 
                           'TRUC_ACTIVES' AS TABLA_ORIGINAL                   
                    FROM (
                            SELECT ORGANISME_ AS ORGANISME, 
                                   FUNC_NORMALITZAR(calima.ORGANISME_) AS ORGANISME_NORMALITZAT , 
                                   ULTIMA_MODIF AS DATA_MODIFICACIO,
                                   ROW_NUMBER ()  OVER (PARTITION BY FUNC_NORMALITZAR(calima.ORGANISME_) ORDER BY FUNC_NORMALITZAR(calima.ORGANISME_) ASC ) AS COLNUM
                              FROM  Z_TMP_CALIMA_U_TRUC_ACTIVES calima
                              WHERE FUNC_NORMALITZAR(ORGANISME_) IN (
                                                                        SELECT FUNC_NORMALITZAR(calima.ORGANISME_)  AS ORGANISME
                                                                        FROM Z_TMP_CALIMA_U_TRUC_ACTIVES calima
                                                                        LEFT OUTER JOIN 
                                                                            A0_DM_ENTITAT SINTAGMA
                                                                            on FUNC_NORMALITZAR(calima.ORGANISME_) = FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO)
                                                                            WHERE FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO) IS NULL
                                                                        GROUP BY FUNC_NORMALITZAR(calima.ORGANISME_)					
                                                                    )
                        ) NUEVOS
                    WHERE COLNUM=1
                      AND NOT EXISTS (SELECT 1
                                        FROM Z_SC999_DM_ENTITAT_TRUCADA ANTIGUOS
                                       WHERE CODI = NUEVOS.ORGANISME_NORMALITZAT
                                      );
    
    COMMIT;
    END;
    
    PROCEDURE SC023_DM_ENTITAT_TRUCADA IS
    BEGIN
            
            
            INSERT INTO A0_DM_ENTITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT ID AS ID , 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_ESBORRAT, 
                        DATA_MODIFICACIO, 
                        USUARI_CREACIO, 
                        USUARI_ESBORRAT, 
                        USUARI_MODIFICACIO, 
                        SUBSTR(ID_ORIGINAL,1,30), 
                        ESQUEMA_ORIGINAL, 
                        TABLA_ORIGINAL
                   FROM Z_SC999_DM_ENTITAT_TRUCADA NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM A0_DM_ENTITAT ANTIGUOS
                                     WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                    );  
    
    COMMIT;
    END;
    
    
    PROCEDURE SC024_DM_ENTITAT_TRUC_HIST IS
    BEGIN
    
            INSERT INTO Z_SC999_DM_ENTITAT_TRUC_HIST (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A0_SEQ_DM_ENTITAT.NEXTVAL AS ID , 
                           NUEVOS.ORGANISME_NORMALITZAT AS CODI , 
                           NUEVOS.ORGANISME AS DESCRIPCIO,
                           FUNC_FECHA_CREACIO(FUNC_FECHA_CHUNGA(DATA_CREACIO)) AS DATA_CREACIO,
                           FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                           FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DATA_MODIFICACIO)) AS DATA_MODIFICACIO,
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                           FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                           NUEVOS.ORGANISME AS ID_ORIGINAL,
                           'CALIMA' AS ESQUEMA_ORIGINAL, 
                           'EXT_CONTACTES' AS TABLA_ORIGINAL                   
                    FROM (
                            SELECT ORGANISME_ AS ORGANISME, 
                                   FUNC_NORMALITZAR(calima.ORGANISME_) AS ORGANISME_NORMALITZAT , 
                                   REGISTRE AS DATA_CREACIO,
                                   DARRERA_INTERV AS DATA_MODIFICACIO,
                                   ROW_NUMBER ()  OVER (PARTITION BY FUNC_NORMALITZAR(calima.ORGANISME_) ORDER BY FUNC_NORMALITZAR(calima.ORGANISME_) ASC ) AS COLNUM
                              FROM  Z_TMP_CALIMA_U_HIST_TRUCADA calima
                              WHERE FUNC_NORMALITZAR(ORGANISME_) IN (
                                                                        SELECT FUNC_NORMALITZAR(calima.ORGANISME_)  AS ORGANISME
                                                                        FROM Z_TMP_CALIMA_U_HIST_TRUCADA calima
                                                                        LEFT OUTER JOIN 
                                                                            A0_DM_ENTITAT SINTAGMA
                                                                            on FUNC_NORMALITZAR(calima.ORGANISME_) = FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO)
                                                                            WHERE FUNC_NORMALITZAR(SINTAGMA.DESCRIPCIO) IS NULL
                                                                        GROUP BY FUNC_NORMALITZAR(calima.ORGANISME_)					
                                                                    )
                        ) NUEVOS
                    WHERE COLNUM=1
                      AND NOT EXISTS (SELECT 1
                                        FROM Z_SC999_DM_ENTITAT_TRUC_HIST ANTIGUOS
                                       WHERE CODI = NUEVOS.ORGANISME_NORMALITZAT
                                      );
    
    COMMIT;
    END;
    
    PROCEDURE SC025_DM_ENTITAT_TRUC_HIST IS
    BEGIN
            
            
            INSERT INTO A0_DM_ENTITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT ID , 
                        DESCRIPCIO, 
                        DATA_CREACIO, 
                        DATA_ESBORRAT, 
                        DATA_MODIFICACIO, 
                        USUARI_CREACIO, 
                        USUARI_ESBORRAT, 
                        USUARI_MODIFICACIO, 
                        SUBSTR(ID_ORIGINAL,1,30), 
                        ESQUEMA_ORIGINAL, 
                        TABLA_ORIGINAL
                   FROM Z_SC999_DM_ENTITAT_TRUC_HIST NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                      FROM A0_DM_ENTITAT ANTIGUOS
                                     WHERE ANTIGUOS.DESCRIPCIO = NUEVOS.DESCRIPCIO
                                    );  
    
    COMMIT;
    END;
    
    --CONTACTOS CON LOS SUBJECTES QUE LE CORRESPONDEN. LOS SUBJECETS HAN SIDO AGRUPADOS PARA OBTENERLOS �NICOS
    PROCEDURE SC030_SUBJECTE_UNIC_CONTACTES IS
    BEGIN
    
    /*
                 OBSOLETO: ESTA SELECT NO CONTIENE AQUELLOS CONTACTES QUE S�LO TIENEN UN REGISTRO Y EL CAMPO 'PRC' NO EST� MARCADO
                INSERT INTO Z_SC030_SUBJ_UNICOS_CONTAC (PRC, PART, NP, TRACTAMENT, NOM, NOM2, COGNOM_1, COGNOM_2, ALIES, DNI, IDIOMA, SEXE, DATA_NAIXE, DATA_DEFUNCIO, DATA_BAIXA, BAIXA_REGISTRE, VINC, NC, CARREC, ORGANISME, DIRECCIO, POBLACIO, PROVINCIA, PAIS, CODI_POSTAL, TEL_FIX, TEL_MOBIL, TEL_FIX_CENTRALETA, TEL_ALTRES, FAX, TEL_VERMELL, DISTRICTE, EMAIL, CODI_ACTIV, ACTIVITAT, SECTOR, ADHOC, IND_NADAL, DATA_EFECTE_CARREC, DATA_DIMISSIO_CARREC, DATADARRERA, DATALTA, MOTIU, OBSERV)
                     SELECT *
                       FROM Z_TMP_CALIMA_U_EXT_CONTACTES
                      WHERE NP IN (SELECT NP
                                     FROM Z_TMP_CALIMA_U_EXT_CONTACTES
                                    GROUP BY NP
                                   )
                        AND PRC ='S'            
                      ORDER BY NP, PRC;
      */
      
      INSERT INTO Z_SC030_SUBJ_UNICOS_CONTAC 
      SELECT PRC, PART, NP, TRACTAMENT, NOM, NOM2, COGNOM_1, COGNOM_2, ALIES, DNI, IDIOMA, SEXE, DATA_NAIXE, DATA_DEFUNCIO, DATA_BAIXA, BAIXA_REGISTRE, VINC, NC, CARREC, ORGANISME, DIRECCIO, POBLACIO, PROVINCIA, PAIS, CODI_POSTAL, TEL_FIX, TEL_MOBIL, TEL_FIX_CENTRALETA, TEL_ALTRES, FAX, TEL_VERMELL, DISTRICTE, EMAIL, CODI_ACTIV, ACTIVITAT, SECTOR, ADHOC, IND_NADAL, DATA_EFECTE_CARREC, DATA_DIMISSIO_CARREC, DATADARRERA, DATALTA, MOTIU, OBSERV, COLNUM
        FROM (
                     SELECT CONTACTES.*,
                     ROW_NUMBER ()  OVER (PARTITION BY FUNC_NORMALITZAR(NP) ORDER BY FUNC_NORMALITZAR(NP) ASC ) AS COLNUM
                       FROM Z_TMP_CALIMA_U_EXT_CONTACTES CONTACTES
                      WHERE NP IN (SELECT NP
                                     FROM Z_TMP_CALIMA_U_EXT_CONTACTES
                                    GROUP BY NP
                                   )
		
                      ORDER BY NP, PRC DESC
                ) TODOS_CONTACTES
                WHERE COLNUM=1;
    
    
    COMMIT;
    END;
    

    
    
    PROCEDURE SC031_SUBJECTES_TIPO_PERSONA IS
    BEGIN
      -- CRUZANDO CON LA Z_SC030_SUBJ_UNICOS_CONTAC OBTENEMOS SUJETOS �NICOS. AS� CUANDO RELLENEMOS CONTACTES NO NOS DAR� DUPLICADOS DE QUE PARA UN ID_SUBJECTE EXISTEN 2 ID_ORIGINALES (HAY SUJETOS REPETIDOS)
        INSERT INTO Z_SC031_SUBJECTE_PERSONA (ID_SUBJECTE,NC, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT ID_SUBJECTE, 
                           NC,
                           NOM, 
                           COGNOM1, 
                           COGNOM2, 
                           ALIES, 
                           DATA_DEFUNCIO, 
                           ConstNO AS ES_PROVISIONAL,
                           NOM_NORMALITZAT, 
                           MOTIU_BAIXA,                           
                           DATA_CREACIO,
                           DATA_ESBORRAT, 
                           DATA_MODIFICACIO,                            
                           FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                           FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                           FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                           TRACTAMENT_ID,
                           PRIORITAT_ID, 
                           TIPUS_SUBJECTE_ID,
                           AMBIT_ID,
                           IDIOMA_ID,
                           ARTICLE_ID,
                           ID_SUBJECTE AS ID_ORIGINAL,
                           'CALIMA' AS ESQUEMA_ORIGINAL,
                           'EXT_PERSONES' AS TABLA_ORIGINAL
                     FROM (
                           SELECT SUBJECTES.N_P as ID_SUBJECTE, 
                                 CONTACTES.NC AS NC,
                                 SUBJECTES.NOM2 AS NOM, 
                                 SUBJECTES.COGNOM_1 AS COGNOM1, 
                                 SUBJECTES.COGNOM_2 AS COGNOM2, 
                                 SUBJECTES.ALIES,                                                 
                                 SUBJECTES.RIP AS DATA_DEFUNCIO,                    
                                 FUNC_NORMALITZAR(SUBJECTES.NOM2 || SUBJECTES.CogNom_1 || SUBJECTES.CogNom_2) AS NOM_NORMALITZAT,           
                                 FUNC_NULOS_STRING() AS MOTIU_BAIXA,
                                 FUNC_FECHA_CHUNGA(CONTACTES.DATALTA) AS DATA_CREACIO,
                                 FUNC_FECHA_CHUNGA(SUBJECTES.DATADARRERA) AS DATA_MODIFICACIO,
                                 FUNC_FECHA_CHUNGA(SUBJECTES.DATA_BAIXA) AS DATA_ESBORRAT,               
                                 (SELECT ID FROM A0_DM_TRACTAMENT WHERE DESCRIPCIO = CONTACTES.TRACTAMENT) AS TRACTAMENT_ID,
                                 FUNC_NULOS_STRING() as PRIORITAT_ID,
                                 ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                                 ConstALCALDIA as AMBIT_ID, --Alcald�a
                                 (SELECT ID FROM A0_DM_IDIOMA WHERE DESCRIPCIO = CONTACTES.IDIOMA) AS IDIOMA_ID,
                                 FUNC_NULOS_STRING() AS ARTICLE_ID
                            FROM Z_TMP_CALIMA_U_EXT_PERSONES SUBJECTES,
                                 Z_SC030_SUBJ_UNICOS_CONTAC CONTACTES
                           WHERE (SUBJECTES.SEXE IS NOT NULL OR (SUBJECTES.SEXE IS NULL AND SUBJECTES.NOM2 IS NOT NULL AND (SUBJECTES.COGNOM_1 IS NOT NULL OR SUBJECTES.COGNOM_2 IS NOT NULL)))
                             AND SUBJECTES.N_P =  CONTACTES.NP
                         )PRINCIPAL
                     WHERE NOT EXISTS (SELECT 1
                                         FROM Z_SC031_SUBJECTE_PERSONA NUEVOS 
                                         WHERE NUEVOS.ID_SUBJECTE = PRINCIPAL.ID_SUBJECTE
                                       );
    
    
    COMMIT;
    END;
    
    
    PROCEDURE SC032_SUBJECTES_TIPO_ENTITAT IS
    BEGIN
    
                --SUBJECTES DE TIPO ENTITAT. Por eso tienen la constante de subjectes
                 --LAS ENTIDADES TIENEN EL SEXO A NULO Y ALGUNO DE LOS 3 CAMPOS NO EST� INFORMADO (LOS SUBJECTES TIENEN AL MENOS 2 INFORMADOS)   
              INSERT INTO Z_SC032_SUBJECTES_TIPO_ENTITAT (ID_SUBJECTE, NC, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                          SELECT ID_SUBJECTE, 
                                   NC,
                                   NOM, 
                                   COGNOM1, 
                                   COGNOM2, 
                                   ALIES, 
                                   DATA_DEFUNCIO, 
                                   0 AS ES_PROVISIONAL,
                                   NOM_NORMALITZAT, 
                                   MOTIU_BAIXA,                           
                                   DATA_CREACIO,
                                   DATA_ESBORRAT, 
                                   DATA_MODIFICACIO,                            
                                   FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                                   FUNC_USUARI(NULL) AS USUARI_ESBORRAT,
                                   FUNC_USUARI(NULL) AS USUARI_MODIFICACIO,
                                   TRACTAMENT_ID,
                                   PRIORITAT_ID, 
                                   TIPUS_SUBJECTE_ID,
                                   AMBIT_ID,
                                   IDIOMA_ID,
                                   ARTICLE_ID,
                                   ID_SUBJECTE AS ID_ORIGINAL,
                                   'CALIMA' AS ESQUEMA_ORIGINAL,
                                   'EXT_PERSONES//EXT_CONTACTES' AS TABLA_ORIGINAL
                            FROM (   
                                     SELECT (SUBJECTES.N_P) as ID_SUBJECTE, 
                                            MAX(CONTACTES.NC )AS NC,
                                            MAX((SUBJECTES.NOM2 || ' ' || SUBJECTES.COGNOM_1)) AS NOM, 
                                            MAX(FUNC_NULOS_STRING()) AS COGNOM1, 
                                            MAX(SUBJECTES.COGNOM_2) AS COGNOM2, 
                                            MAX(SUBJECTES.ALIES) AS ALIES, 
                                            MAX(SUBJECTES.RIP) AS DATA_DEFUNCIO,
                                            MAX(LimpiarChars(SUBJECTES.NOM2 || SUBJECTES.CogNom_1 || SUBJECTES.CogNom_2)) AS NOM_NORMALITZAT,
                                            MAX(FUNC_NULOS_STRING()) AS MOTIU_BAIXA,
                                            MAX(FUNC_FECHA_CHUNGA(CONTACTES.DATALTA)) AS DATA_CREACIO,
                                            MAX(FUNC_FECHA_CHUNGA(SUBJECTES.DATADARRERA)) AS DATA_MODIFICACIO,
                                            MAX(FUNC_FECHA_CHUNGA(SUBJECTES.DATA_BAIXA)) AS DATA_ESBORRAT,      
                                            MAX((SELECT ID FROM A0_DM_TRACTAMENT WHERE DESCRIPCIO = CONTACTES.TRACTAMENT)) AS TRACTAMENT_ID,
                                            MAX(FUNC_NULOS_STRING()) as PRIORITAT_ID,
                                            MAX(ConstSubjecteEntitat) AS TIPUS_SUBJECTE_ID, 
                                            MAX(ConstALCALDIA) as AMBIT_ID, --alcaldia
                                            MAX((SELECT ID FROM A0_DM_IDIOMA WHERE DESCRIPCIO = CONTACTES.IDIOMA)) AS IDIOMA_ID,
                                            MAX(FUNC_NULOS_STRING()) AS ARTICLE_ID
                                   FROM Z_TMP_CALIMA_U_EXT_PERSONES  SUBJECTES,
                                         Z_TMP_CALIMA_U_EXT_CONTACTES CONTACTES
                                    WHERE SUBJECTES.SEXE IS NULL AND (SUBJECTES.NOM2 IS NULL AND (SUBJECTES.COGNOM_1 IS NOT NULL OR SUBJECTES.COGNOM_2 IS NOT NULL))
                                      AND SUBJECTES.N_P =  CONTACTES.NP
                                 GROUP BY SUBJECTES.N_P   
                                 ) PRINCIPAL     
                                 WHERE NOT EXISTS (SELECT 1
                                                            FROM Z_SC032_SUBJECTES_TIPO_ENTITAT NUEVOS 
                                                            WHERE NUEVOS.ID_SUBJECTE = PRINCIPAL.ID_SUBJECTE
                                                     );
    
    
    COMMIT;
    
    
    
    
    
    END;
    

    PROCEDURE SC033_NEW_SUBJECTES is
    BEGIN
                 INSERT INTO Z_SC999_SUBJECTE (ID,NC, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)                  
                     SELECT A0_SEQ_SUBJECTE.NEXTVAL AS ID,
                            NC,
                            NOM,
                            COGNOM1,
                            COGNOM2,
                            ALIES,
                            DATA_DEFUNCIO,
                            ES_PROVISIONAL,
                            NOM_NORMALITZAT,
                            MOTIU_BAIXA,
                            FUNC_FECHA_CREACIO(DATA_CREACIO) AS DATA_CREACIO,
                            DATA_ESBORRAT,
                            DATA_MODIFICACIO,
                            USUARI_CREACIO,
                            USUARI_ESBORRAT,
                            USUARI_MODIFICACIO,
                            TRACTAMENT_ID,
                            PRIORITAT_ID,
                            TIPUS_SUBJECTE_ID,
                            AMBIT_ID,
                            IDIOMA_ID,
                            ARTICLE_ID,
                            ID_ORIGINAL,
                            ESQUEMA_ORIGINAL,
                            TABLA_ORIGINAL
                     FROM (   
                             SELECT ID_SUBJECTE,NC, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL
                               FROM Z_SC031_SUBJECTE_PERSONA
                                    UNION ALL 
                             SELECT ID_SUBJECTE,NC, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL
                               FROM Z_SC032_SUBJECTES_TIPO_ENTITAT
                           ) NUEVOS
                       WHERE NOT EXISTS (SELECT 1
                                           FROM Z_SC999_SUBJECTE ANTIGUOS
                                          WHERE  ANTIGUOS.ID_ORIGINAL = NUEVOS.ID_ORIGINAL
                                        );
                       
    COMMIT;
    /*CONTACTES TIPO ENTITAT*/
    /*
    INSERT INTO Z_SC999_SUBJECTE (ID,NC, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
        SELECT A0_SEQ_SUBJECTE.NEXTVAL AS ID,
               NC AS ID_CONTACTE ,
               ORGANISME AS NOM,
               FUNC_NULOS_STRING() AS COGNOM1,
               FUNC_NULOS_STRING() AS COGNOM2,
               FUNC_NULOS_STRING() AS ALIES,
               FUNC_FECHA_NULA(NULL) AS DATA_DEFUNCIO,
               0 AS ES_PROVISIONAL,
               FUNC_NORMALITZAR(ORGANISME) as NOM_NORMALITZAT,
               FUNC_NULOS_STRING() AS MOTIU_BAIXA,
               FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DATALTA)) AS DATA_CREACIO,
               FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DATA_BAIXA)) AS DATA_ESBORRAT,               
               FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DATADARRERA)) AS DATA_MODIFICACIO,
               FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
               FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
               FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
               FUNC_NULOS_STRING() AS TRACTAMENT_ID,
               FUNC_NULOS_STRING() AS PRIORITAT_ID, 
               ConstSubjecteEntitat AS TIPUS_SUBJECTE_ID, 
               ConstALCALDIA AS AMBIT_ID, 
               FUNC_NULOS_STRING() AS IDIOMA_ID, 
               FUNC_NULOS_STRING() AS ARTICLE_ID, 
               NC AS ID_ORIGINAL, 
               'CALIMA' as ESQUEMA_ORIGINAL, 
               'EXT_CONTACTES' as TABLA_ORIGINAL             
        FROM Z_TMP_CALIMA_U_EXT_CONTACTES NUEVOS
        WHERE NOT EXISTS (SELECT 1
                            FROM Z_SC999_SUBJECTE ANTIGUOS
                           WHERE NUEVOS.NC = ANTIGUOS.ID_ORIGINAL
                         );
    */
    COMMIT;
    END;
    
    
     PROCEDURE SC034_SUBJECTES IS
     BEGIN
             INSERT INTO A0_SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                     SELECT ID,
                            NOM,
                            COGNOM1,
                            COGNOM2,
                            ALIES,
                            DATA_DEFUNCIO,
                            ES_PROVISIONAL,
                            NOM_NORMALITZAT,
                            MOTIU_BAIXA,
                            DATA_CREACIO,
                            DATA_ESBORRAT,
                            DATA_MODIFICACIO,
                            USUARI_CREACIO,
                            USUARI_ESBORRAT,
                            USUARI_MODIFICACIO,
                            TRACTAMENT_ID,
                            PRIORITAT_ID,
                            TIPUS_SUBJECTE_ID,
                            AMBIT_ID,
                            IDIOMA_ID,
                            ARTICLE_ID,
                            ID_ORIGINAL,
                            ESQUEMA_ORIGINAL,
                            TABLA_ORIGINAL
                       FROM Z_SC999_SUBJECTE NUEVOS
                      WHERE NOT EXISTS (SELECT 1 
                                          FROM A0_SUBJECTE ANTIGUOS
                                         WHERE NUEVOS.ID = ANTIGUOS.ID
                                        )
                       -- OCG1 // APS1
                       AND FUNC_SIGNES_LITERAL(NOM) IS NOT NULL
                       AND FUNC_SIGNES_LITERAL(COGNOM1) IS NOT NULL
                       AND TRACTAMENT_ID IS NOT NULL;                
     
     COMMIT;
     END;
    
     PROCEDURE SC035_ERR_SUBJECTE IS
    BEGIN
    
        INSERT INTO ERR_SUBJECTE (ID, NOM, COGNOM1, COGNOM2, TRACTAMENT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,ERROR_DESCRIPCION)
                SELECT  ID AS ID,
                        NOM AS NOM,
                        COGNOM1 AS COGNOM1,
                        COGNOM2 AS COGNOM2,
                        TRACTAMENT_ID AS TRACTAMENT_ID,
                        ID_ORIGINAL AS ID_ORIGINAL,
                        ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                        TABLA_ORIGINAL AS TABLA_ORIGINAL,
                        'CAMPO NOM//cognom/tractament' AS ERROR_DESCRIPCION
                FROM Z_SC999_SUBJECTE NUEVOS
                WHERE NOT EXISTS (SELECT 1
                                   FROM A0_SUBJECTE ANTIGUOS
                                  WHERE  ANTIGUOS.ID = NUEVOS.ID
                                 )
                 -- OCG1 // APS1
                AND FUNC_SIGNES_LITERAL(NOM) IS NULL
                OR FUNC_SIGNES_LITERAL(COGNOM1) IS NULL
                OR TRACTAMENT_ID IS NULL;
    
    COMMIT;
    END;
    
    
    PROCEDURE SC040_ADRECAS IS 
    BEGIN
    
             INSERT INTO Z_SC999_ADRECAS (ADRECA_ID, ID_CONTACTE, DIRECCIO, POBLACIO, PROVINCIA, PAIS, CODI_POSTAL,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT A0_SEQ_ADRECA.NEXTVAL AS ADRECA_ID,
                        NC AS ID_CONTACTE,
                        DIRECCIO,
                        POBLACIO,
                        PROVINCIA,
                        PAIS,
                        CODI_POSTAL,
                        FUNC_FECHA_CHUNGA(DATALTA) AS DATA_CREACIO, 
                        FUNC_FECHA_CHUNGA(DATA_BAIXA) AS DATA_ESBORRAT, 
                        FUNC_FECHA_CHUNGA(DATADARRERA) AS DATA_MODIFICACIO,
                        NC AS ID_ORIGINAL,
                        'CALIMA' AS ESQUEMA_ORIGINAL,
                        'EXT_CONTACTES' AS TABLA_ORIGINAL                        
                   FROM Z_TMP_CALIMA_U_EXT_CONTACTES NUEVOS
                  WHERE NOT EXISTS (SELECT 1
				                      FROM Z_SC999_ADRECAS ANTIGUOS
				                     WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.NC
				                   );       
                 
    COMMIT;
    END;

    PROCEDURE SC041_ADRECA IS
    BEGIN
    
         INSERT INTO A0_ADRECA (ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_CARRER, NOM_CARRER, LLETRA_INICI, LLETRA_FI, ESCALA, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PIS, PORTA, BLOC, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL)
                 SELECT ADRECA_ID AS ID,
                        NULL AS CODI_MUNICIPI, 
                            NUEVOS.POBLACIO AS	MUNICIPI, 
                            NULL AS CODI_PROVINCIA, 
                            NUEVOS.PROVINCIA AS PROVINCIA, 
                            NULL AS CODI_PAIS, 
                            NUEVOS.PAIS AS PAIS, 
                            NULL AS CODI_CARRER, 
                            FUNC_NULOS_ASTERICO(NUEVOS.DIRECCIO)  AS NOM_CARRER,
                            NULL AS LLETRA_INICI, 
                            NULL AS LLETRA_FI, 
                            NULL AS ESCALA,
                            SUBSTR(NUEVOS.CODI_POSTAL,1,10) AS CODI_POSTAL, 
                            NULL AS COORDENADA_X, 
                            NULL AS COORDENADA_Y, 
                            NULL AS SECCIO_CENSAL, 
                            NULL AS ANY_CONST, 
                            NULL AS NUMERO_INICI,
                            NULL AS NUMERO_FI, 
                            FUNC_FECHA_CREACIO(DATA_CREACIO) AS DATA_CREACIO,
                            DATA_ESBORRAT AS DATA_ESBORRAT,
                            DATA_MODIFICACIO AS DATA_MODIFICACIO,
                            FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MODIFICACIO,
                            NULL AS PIS,
                            NULL AS PORTA,
                            NULL AS BLOC,
                            NULL AS CODI_TIPUS_VIA,
                            NULL AS CODI_BARRI,
                            NULL AS BARRI,
                            NULL AS CODI_DISTRICTE,
                            NULL AS DISTRICTE,
                            ID_ORIGINAL AS ID_ORIGINAL,
                            ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                            TABLA_ORIGINAL AS TABLA_ORIGINAL
                   FROM Z_SC999_ADRECAS NUEVOS
                  WHERE NOT EXISTS (SELECT 1
				                      FROM A0_ADRECA ANTIGUOS
				                     WHERE ANTIGUOS.ID = NUEVOS.ADRECA_ID
				                   )
                   -- OCG1 // APS1
                   AND  FUNC_NULOS_ASTERICO(NUEVOS.DIRECCIO) IS NOT NULL;                
    
    COMMIT;
    END;


 PROCEDURE SC042_ERR_ADRECA  IS
     BEGIN
     
     
        INSERT INTO ERR_ADRECA (ID, NOM_CARRER, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL,ERROR_DESCRIPCION)
                 SELECT ADRECA_ID AS ID, 
                        DIRECCIO AS NOM_CARRER,
                        ID_ORIGINAL AS ID_ORIGINAL,
                        ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                        TABLA_ORIGINAL AS TABLA_ORIGINAL,
                        'CAMPO NOM_CARRER' AS ERROR_DESCRIPCION
                   FROM Z_SC999_ADRECAS ADRECA
              -- OCG1 // APS1
               WHERE FUNC_SIGNES_LITERAL(DIRECCIO) IS NULL;
     
     
     COMMIT;
     END;


    procedure SC049_CONTACTES_SUBJECTES IS
    BEGIN 
         --AGRUPAMOS S�LO LOS CONTACTES QUE TIENEN SUBJECTES QUE SE HAN INTRODUCIDO
         INSERT INTO Z_SC049_CONTACTES_SUBJECTE 
                   SELECT contactes.nc,contactes.np
                     FROM Z_TMP_CALIMA_U_EXT_CONTACTES contactes
                    WHERE contactes.Nc IN (SELECT Nc
                                             FROM Z_TMP_CALIMA_U_EXT_CONTACTES
                                         GROUP BY Nc
                                         )
                      AND contactes.NP IN (SELECT subjectes.id_original 
                                             FROM Z_SC999_SUBJECTE subjectes);
         
         /*
                    SELECT nc,np
                       FROM Z_TMP_CALIMA_U_EXT_CONTACTES
                      WHERE Nc IN (SELECT Nc
                                     FROM Z_TMP_CALIMA_U_EXT_CONTACTES
                                    GROUP BY Nc
                                   )
                        AND NP IN (SELECT N_P FROM Z_TMP_CALIMA_U_EXT_PERSONES);             
        */
 
    
    
    COMMIT;
    END;
    
     /* SI VIENEN DE CONTACTES ES TIPO_CONTACTE_ID =2 */
     /* SI VIENEN DE PERSNAS ES TIPO_CONTACTE_ID =1 */
    PROCEDURE SC050_CONTACTES_PROFESIONAL IS
    BEGIN
    
            INSERT INTO Z_SC999_CONTACTE (ID, NC, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,DATA_FI_VIGENCIA_CARREC,NOM_NORMALITZAT)
                SELECT A0_SEQ_CONTACTE.NEXTVAL AS ID,
                       NC AS NC,
                       (CASE WHEN PRC = 'S' THEN
                             ConstSI
                        ELSE
                            ConstNo
                        END) AS ES_PRINCIPAL,
                       ORGANISME AS DEPARTAMENT,
                       1 AS DADES_QUALITAT,
                       FUNC_FECHA_CHUNGA(DATADARRERA) AS DATA_DARRERA_ACTUALITZACIO,
                       FUNC_FECHA_CHUNGA(DATALTA) AS DATA_CREACIO,
                       FUNC_FECHA_CHUNGA(DATA_BAIXA) AS DATA_ESBORRAT,
                       FUNC_FECHA_CHUNGA(DATADARRERA) AS DATA_MODIFICACIO,
                       FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                       FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                       FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,                             
--                       (SELECT TIPUS_SUBJECTE_ID FROM Z_SC999_SUBJECTE SUBJECTES WHERE SUBJECTES.ID_ORIGINAL = (SELECT NP FROM SC049_CONTACTES_SUBJECTE WHERE NC = NUEVOS.NC AND ROWNUM=1) AS TIPUS_CONTACTE_ID,
                       ConstContacteProfesional AS TIPUS_CONTACTE_ID,
--                       (SELECT ID FROM Z_SC999_SUBJECTE SUBJECTES WHERE SUBJECTES.NC = NUEVOS.NC AND ROWNUM=1) AS SUBJECTE_ID, 
                       (SELECT ID FROM Z_SC999_SUBJECTE SUBJECTES WHERE SUBJECTES.ID_ORIGINAL = (SELECT NP FROM Z_SC049_CONTACTES_SUBJECTE WHERE NC = NUEVOS.NC) AND ROWNUM=1) AS SUBJECTE_ID,
                       (SELECT ADRECA_ID FROM Z_SC999_ADRECAS ADRECA WHERE ADRECA.ID_CONTACTE = NUEVOS.NC AND ROWNUM=1) AS ADRECA_ID, 
                       (SELECT ID FROM A0_DM_ENTITAT ENTITAT WHERE FUNC_NORMALITZAR(ENTITAT.DESCRIPCIO) = FUNC_NORMALITZAR(ORGANISME) AND ROWNUM=1) AS ENTITAT_ID, 
                        FUNC_NULOS_STRING() AS CONTACTE_ORIGEN_ID, 
                        ConstVISIBILITAT_PRIVADA AS VISIBILITAT_ID, 
                        ConstAMBIT_ALCALDIA AS AMBIT_ID, 
                        (SELECT ID FROM A0_DM_CARREC CARREC WHERE FUNC_NORMALITZAR(CARREC.DESCRIPCIO) = FUNC_NORMALITZAR(CARREC) AND ROWNUM=1) AS CARREC_ID,
                        NC AS ID_ORIGINAL,
                        'CALIMA' AS ESQUEMA_ORIGINAL,
                        'EXT_CONTACTES' AS TABLA_ORIGINAL,
                        FUNC_FECHA_CHUNGA(DATA_DIMISSIO_CARREC) AS DATA_FI_VIGENCIA_CARREC,
                        FUNC_NORMALITZAR(NOM || COGNOM_1 || COGNOM_2) AS NOM_NORMALITZAT
                  FROM Z_TMP_CALIMA_U_EXT_CONTACTES NUEVOS ;
--                  WHERE ADRECA_ID IS NOT NULL AND SUBJECTE_ID IS NOT NULL;
--                  WHERE NOT EXISTS (SELECT * 
--                                    FROM Z_SC999_CONTACTE ANTIGUOS
--                                    WHERE NUEVOS.NC = ANTIGUOS.NC);
    
    
    COMMIT;
    END;
    
    PROCEDURE SC051_NEW_CONTACTES IS
    BEGIN
    
         INSERT INTO A0_CONTACTE (ID, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, DATA_FI_VIGENCIA_CARREC)
             SELECT ID,
                    ES_PRINCIPAL,
                    DEPARTAMENT,
                    DADES_QUALITAT,
                    DATA_DARRERA_ACTUALITZACIO,
                    FUNC_FECHA_CREACIO(DATA_CREACIO) AS DATA_CREACIO,
                    DATA_ESBORRAT,
                    DATA_MODIFICACIO,
                    USUARI_CREACIO,
                    USUARI_ESBORRAT,
                    USUARI_MODIFICACIO,
                    TIPUS_CONTACTE_ID,
                    SUBJECTE_ID,
                    ADRECA_ID,
                    ENTITAT_ID,
                    CONTACTE_ORIGEN_ID,
                    VISIBILITAT_ID,
                    AMBIT_ID,
                    CARREC_ID,
                    ID_ORIGINAL,
                    ESQUEMA_ORIGINAL,
                    TABLA_ORIGINAL,
                    DATA_FI_VIGENCIA_CARREC
              FROM  Z_SC999_CONTACTE NUEVOS
              WHERE TIPUS_CONTACTE_ID IS NOT NULL
                AND NOT EXISTS (SELECT 1
                      FROM A0_CONTACTE ANTIGUOS
                     WHERE ANTIGUOS.ID = NUEVOS.ID
                    )
                -- OCG1 // APS1                     
                AND (CARREC_ID IS NOT NULL AND TIPUS_CONTACTE_ID=ConstContacteProfesional)
                AND (ENTITAT_ID IS NOT NULL AND TIPUS_CONTACTE_ID=ConstContacteProfesional)
                  -- OCG1 // APS1                 SE INSERTAN S�LO LOS CONTACTES QUE TIENEN SUBJECTE Y DIRECCI�N  QUE SE HAYAN INSERTADO                         
                AND EXISTS (SELECT 1 
                          FROM A0_SUBJECTE EXISTEN
                         WHERE  NUEVOS.SUBJECTE_ID = EXISTEN.ID
                        )
                -- OCG1 // APS1                 SE INSERTAN S�LO LOS CONTACTES QUE TIENEN SUBJECTE Y DIRECCI�N  QUE SE HAYAN INSERTADO
               AND EXISTS (SELECT 1 
                          FROM A0_ADRECA EXISTEN
                         WHERE  NUEVOS.ADRECA_ID = EXISTEN.ID
                        ) ;                           
    
    
    COMMIT;
    END;
    
    
     PROCEDURE SC055_ERR_CONTACTES IS
    BEGIN
    
        INSERT INTO ERR_CONTACTE (ID, NOM,COGNOMS, TIPUS_CONTACTE_ID, CARREC_ID, ENTITAT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL, ERR_DESCRIPCION)
              SELECT ID AS ID,   
              	     NOM,
                     (COGNOM1 || ' ' || COGNOM2) AS COGNOMS,
                     TIPUS_CONTACTE_ID,
                     CARREC_ID,
                     ENTITAT_ID,
                     ID_ORIGINAL,                     
                     ESQUEMA_ORIGINAL, 
                     TABLA_ORIGINAL,
                     'PROFESIONAL CON CARREC//ENTITAT NULL' ERR_DESCRIPCION
              FROM (
                           SELECT CONTACTES.ID AS ID,
                         	    SUBJECTE.NOM AS NOM,
                         	    SUBJECTE.COGNOM1,
                                SUBJECTE.COGNOM2,
                                TIPUS_CONTACTE_ID,
                                CARREC_ID,
                                ENTITAT_ID,          
                                CONTACTES.ID_ORIGINAL AS ID_ORIGINAL, 
                                CONTACTES.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL, 
                                CONTACTES.TABLA_ORIGINAL AS TABLA_ORIGINAL 
                        FROM Z_SC999_CONTACTE CONTACTES,
                             Z_SC999_SUBJECTE SUBJECTE
                        WHERE CONTACTES.SUBJECTE_ID = SUBJECTE.ID
                     ) NUEVOS   

                   -- OCG1 // APS1                 
               WHERE (CARREC_ID IS NULL AND TIPUS_CONTACTE_ID=ConstContacteProfesional)
                 OR (ENTITAT_ID IS NULL AND TIPUS_CONTACTE_ID=ConstContacteProfesional);
                   
            COMMIT;       
    
            /* SB093  INSERTAMOS LOS CONTACTES QUE BNO SE METEN PORQUE SU SUBJECTE NO SE HA INTRODUCIDO*/
            INSERT INTO ERR_CONTACTE (ID, NOM,COGNOMS, TIPUS_CONTACTE_ID, CARREC_ID, ENTITAT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL, ERR_DESCRIPCION)
              SELECT ID AS ID,   
              	     NOM,
                     (COGNOM1 || ' ' || COGNOM2) AS COGNOMS ,
                     TIPUS_CONTACTE_ID,
                     CARREC_ID,
                     ENTITAT_ID,
                     ID_ORIGINAL,                     
                     ESQUEMA_ORIGINAL, 
                     TABLA_ORIGINAL,
                     'CONTACTE SIN SUBJECTE' ERR_DESCRIPCION
              FROM (
                        SELECT CONTACTES.ID AS ID,
                         	    SUBJECTE.NOM AS NOM,
                         	    SUBJECTE.COGNOM1,
                                SUBJECTE.COGNOM2,
                                CONTACTES.SUBJECTE_ID,
                                TIPUS_CONTACTE_ID,
                                CARREC_ID,
                                ENTITAT_ID,          
                                CONTACTES.ID_ORIGINAL AS ID_ORIGINAL, 
                                CONTACTES.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL, 
                                CONTACTES.TABLA_ORIGINAL AS TABLA_ORIGINAL 
                        FROM Z_SC999_CONTACTE CONTACTES,
                             Z_SC999_SUBJECTE SUBJECTE
                        WHERE CONTACTES.SUBJECTE_ID = SUBJECTE.ID
   
                     ) NUEVOS   

                   -- OCG1 // APS1                 
               WHERE NOT EXISTS (SELECT 1 
                          FROM A0_SUBJECTE EXISTEN
                         WHERE  NUEVOS.SUBJECTE_ID = EXISTEN.ID
                        );
           
           COMMIT; 
         
           
           /* SB093 ADRECA  INSERTAMOS LOS CONTACTES QUE NO SE METEN PORQUE LA DIRECCI�N DEL SUBJECTE NO SE HA INTRODUCIDO*/
            INSERT INTO ERR_CONTACTE (ID, NOM,COGNOMS, TIPUS_CONTACTE_ID, CARREC_ID, ENTITAT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL, ERR_DESCRIPCION)
              SELECT ID AS ID,   
              	     NOM,
                     (COGNOM1 || ' ' || COGNOM2) AS COGNOMS,              
                     TIPUS_CONTACTE_ID,
                     CARREC_ID,
                     ENTITAT_ID,
                     ID_ORIGINAL,                     
                     ESQUEMA_ORIGINAL, 
                     TABLA_ORIGINAL,
                     'CONTACTE SIN ADRECA' ERR_DESCRIPCION
              FROM (
                        SELECT CONTACTES.ID AS ID,
                         	    SUBJECTE.NOM AS NOM,
                         	    SUBJECTE.COGNOM1,
                                SUBJECTE.COGNOM2,
                                TIPUS_CONTACTE_ID,
                                CARREC_ID,
                                ENTITAT_ID,
                                CONTACTES.ADRECA_ID AS ADRECA_ID,
                                CONTACTES.ID_ORIGINAL AS ID_ORIGINAL, 
                                CONTACTES.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL, 
                                CONTACTES.TABLA_ORIGINAL AS TABLA_ORIGINAL 
                         FROM Z_SC999_CONTACTE CONTACTES,
                             Z_SC999_SUBJECTE SUBJECTE
                        WHERE CONTACTES.SUBJECTE_ID = SUBJECTE.ID
   
                     ) NUEVOS   

                   -- OCG1 // APS1                 
               WHERE NOT EXISTS (SELECT 1 
                          FROM A0_ADRECA EXISTEN
                         WHERE  NUEVOS.ADRECA_ID = EXISTEN.ID
                        );                      
           
           COMMIT;
           
          
           
            
    
    COMMIT;
    END;
/*
    PROCEDURE SC052_SUBJECTES_SIN_CONTACTE IS
    BEGIN
    
            INSERT INTO A0_SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID, ARTICLE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                             SELECT A0_SEQ_SUBJECTE.NEXTVAL AS ID,
                                     SUBJECTES.NOM2 AS NOM, 
                                     SUBJECTES.COGNOM_1 AS COGNOM1, 
                                     SUBJECTES.COGNOM_2 AS COGNOM2, 
                                     SUBJECTES.ALIES,                                                 
                                     SUBJECTES.DATA_DEFUNCIO AS DATA_DEFUNCIO,                    
                                     FUNC_NORMALITZAR(SUBJECTES.NOM2 || SUBJECTES.CogNom_1 || SUBJECTES.CogNom_2) AS NOM_NORMALITZAT,           
                                     FUNC_NULOS_STRING() AS MOTIU_BAIXA,
                                     FUNC_FECHA_CHUNGA(SUBJECTES.DATALTA) AS DATA_CREACIO,
                                     FUNC_FECHA_CHUNGA(SUBJECTES.DATADARRERA) AS DATA_MODIFICACIO,
                                     FUNC_FECHA_CHUNGA(SUBJECTES.DATA_BAIXA) AS DATA_ESBORRAT,               
                                     (SELECT ID FROM A0_DM_TRACTAMENT WHERE DESCRIPCIO = SUBJECTES.TRACTAMENT) AS TRACTAMENT_ID,
                                     FUNC_NULOS_STRING() as PRIORITAT_ID,
                                     ConstSubjectePersona AS TIPUS_SUBJECTE_ID,
                                     ConstALCALDIA as AMBIT_ID, --Alcald�a
                                     (SELECT ID FROM A0_DM_IDIOMA WHERE DESCRIPCIO = SUBJECTES.IDIOMA) AS IDIOMA_ID,
                                     FUNC_NULOS_STRING() AS ARTICLE_ID,
                                     SUBJECTES.NC AS  ID_ORIGINAL,
                                     'CALIMA' AS ESQUEMA_ORIGINAL,
                                     'EXT_CONTACTES' AS TABLA_ORIGINAL
                                FROM Z_SC999_CONTACTE NUEVOS,
                                     Z_TMP_CALIMA_U_EXT_CONTACTES SUBJECTES
                               WHERE TIPUS_CONTACTE_ID IS NULL 
                                 AND NUEVOS.NC = SUBJECTES.NC
                                 AND NOT EXISTS (SELECT 1 
                                                  FROM A0_SUBJECTE ANTIGUOS
                                                 WHERE NUEVOS.ID = ANTIGUOS.ID
                                                ); 


    COMMIT;
    END;

 PROCEDURE SC053_NEW_CONTACTES_PART2 IS
    BEGIN
    
         INSERT INTO A0_CONTACTE (ID, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, DATA_FI_VIGENCIA_CARREC)
             SELECT ID,
                    ES_PRINCIPAL,
                    DEPARTAMENT,
                    DADES_QUALITAT,
                    DATA_DARRERA_ACTUALITZACIO,
                    FUNC_FECHA_CREACIO(DATA_CREACIO) AS DATA_CREACIO,
                    DATA_ESBORRAT,
                    DATA_MODIFICACIO,
                    USUARI_CREACIO,
                    USUARI_ESBORRAT,
                    USUARI_MODIFICACIO,
                    (SELECT TIPUS_SUBJECTE_ID FROM Z_SC999_SUBJECTE SUBJECTES WHERE SUBJECTES.ID_ORIGINAL = (SELECT NP FROM Z_SC049_CONTACTES_SUBJECTE WHERE NC = NUEVOS.NC) AND ROWNUM=1) AS TIPUS_CONTACTE_ID,
                    (SELECT ID FROM Z_SC999_SUBJECTE SUBJECTES WHERE SUBJECTES.ID_ORIGINAL = (SELECT NP FROM Z_SC049_CONTACTES_SUBJECTE WHERE NC = NUEVOS.NC) AND ROWNUM=1) AS SUBJECTE_ID,
                    ADRECA_ID,
                    ENTITAT_ID,
                    CONTACTE_ORIGEN_ID,
                    VISIBILITAT_ID,
                    AMBIT_ID,
                    CARREC_ID,
                    ID_ORIGINAL,
                    ESQUEMA_ORIGINAL,
                    TABLA_ORIGINAL,
                    DATA_FI_VIGENCIA_CARREC
              FROM  Z_SC999_CONTACTE NUEVOS
              WHERE TIPUS_CONTACTE_ID IS NULL
                AND NOT EXISTS (SELECT 1
                      FROM A0_CONTACTE ANTIGUOS
                     WHERE ANTIGUOS.ID = NUEVOS.ID
                    );
    
    
    COMMIT;
    END;


*/

    PROCEDURE SC060_CORREUS_CONTACTES IS
            BEGIN
            
            INSERT INTO Z_SC060_CORREUS_CONTACTES 
                SELECT (SELECT ID FROM Z_SC999_CONTACTE CONTACTE WHERE CONTACTE.NC = aux.NC) AS ID_CONTACTE, 
                       AUX.NC,
                       aux.email
                FROM(                                                                         
                     select distinct  t.NC,
                                      trim(regexp_substr(t.email, '[^;]+', 1, levels.column_value))  as email
                    from 
                        (SELECT NC, 
                                email 
                         FROM Z_SC030_SUBJ_UNICOS_CONTAC 
                         WHERE email IS NOT NULL AND email LIKE '%@%'                             
                        ) t,
                    table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(t.EMAIL, '[^;]+'))  + 1) as sys.OdciNumberList)) levels
                    order by NC
                 ) aux
                 WHERE TRIM(aux.email) is not null
                   AND NOT EXISTS (SELECT * 
                                     FROM Z_SC060_CORREUS_CONTACTES NUEVOS
                                    WHERE NUEVOS.NC = AUX.NC
                                    AND NUEVOS.EMAIL = AUX.EMAIL
                                   );
                
            COMMIT;   
            
   END;
   
   
    PROCEDURE SC061_CORREUS_PRINCIPALES IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT ID_CONTACTE,
                   NC, 
                   EMAIL 
              FROM  Z_SC060_CORREUS_CONTACTES 
          ORDER BY NC
        )
        LOOP
            
            IF c.NC <> id_contacte_ant THEN
              id_contacte_ant:= c.NC;
              INSERT INTO Z_SC061_CORREUS_PRINCIPALES VALUES (c.NC , c.email, 1);
            ELSE
              INSERT INTO Z_SC061_CORREUS_PRINCIPALES VALUES (c.NC , c.email, 0);           
            END IF;

        END LOOP;
        
        COMMIT;            
        
        END;
                
        
        PROCEDURE SC062_CORREOS_CONTACTOS IS   
        
        BEGIN
         /*
           INSERT INTO  A0_CONTACTE_CORREU (ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT (A0_SEQ_CONTACTE_CORREU.NEXTVAL) AS ID,
		                NUEVOS.correu AS CORREU_ELECTRONIC, 
		                NUEVOS.principal ES_PRINCIPAL, 
		                sysdate AS DATA_CREACIO, 
                        NULL AS DATA_ESBORRAT,
                        NULL AS DATA_MODIFICACIO,
		                'MIGRACIO' AS USUARI_CREACIO,
                        NULL AS USUARI_ESBORRAT,
                        NULL AS USUARI_MODIFICACIO,
		                (SELECT ID FROM Z_SC999_CONTACTE CONTACTES WHERE CONTACTES.NC = NUEVOS.ID_CONTACTE) AS CONTACTE_ID,
                        NUEVOS.id_contacte AS ID_ORIGINAL, 
                        'CALIMA' AS ESQUEMA_ORIGINAL, 
                        'EXT_CONTACTES' AS TABLA_ORIGINAL
                 FROM Z_SC061_CORREUS_PRINCIPALES NUEVOS
                 WHERE NOT EXISTS(SELECT 1 
                                  FROM A0_CONTACTE_CORREU  ANTIGUOS
                                  WHERE ANTIGUOS.id = NUEVOS.id_contacte
                                    AND ANTIGUOS.CORREU_ELECTRONIC = NUEVOS.correu
                                 )
                       and exists (select 1
                                     from Z_SC999_CONTACTE contacte
                                    where  contacte.nc = NUEVOS.ID_CONTACTE
                                  );  
          */
          
         INSERT INTO  A0_CONTACTE_CORREU (ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT (A0_SEQ_CONTACTE_CORREU.NEXTVAL) AS ID,
		                NUEVOS.correu AS CORREU_ELECTRONIC, 
		                NUEVOS.principal ES_PRINCIPAL, 
		                sysdate AS DATA_CREACIO, 
                        NULL AS DATA_ESBORRAT,
                        NULL AS DATA_MODIFICACIO,
		                'MIGRACIO' AS USUARI_CREACIO,
                        NULL AS USUARI_ESBORRAT,
                        NULL AS USUARI_MODIFICACIO,
  		                EXISTEN.ID AS CONTACTE_ID,
                        NUEVOS.id_contacte AS ID_ORIGINAL, 
                        'CALIMA' AS ESQUEMA_ORIGINAL, 
                        'EXT_CONTACTES' AS TABLA_ORIGINAL
                 FROM Z_SC061_CORREUS_PRINCIPALES NUEVOS,
                      A0_CONTACTE EXISTEN 
                  WHERE EXISTEN.id_original = NUEVOS.ID_CONTACTE
                    AND existen.ESQUEMA_ORIGINAL='CALIMA'
                    AND NOT EXISTS(SELECT 1 
                                  FROM A0_CONTACTE_CORREU  ANTIGUOS
                                  WHERE ANTIGUOS.id = NUEVOS.id_contacte
                                    AND ANTIGUOS.CORREU_ELECTRONIC = NUEVOS.correu
                                 );
          
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN Z_C51_CORREUS_PRINCIPALES
        
        END;  



PROCEDURE SC070_TELEFONS_FIX IS
    BEGIN
    
        INSERT INTO Z_SC070_TELEFON_FIX (ID_CONTACTE, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE,                 	   
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstSI as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.NC as ID_ORIGINAL,
                       'CALIMA' AS ESQUEMA_ORIGINAL,
                       'EXT_CONTACTES //TEL_fix       ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT CONTACTE.NC As NC,
                              CONTACTE.ID AS ID_CONTACTE,
                             (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TEL_FIX),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TEL_FIX))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TEL_FIX) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TEL_FIX) AS CONCEPTE                              
                       FROM Z_SC030_SUBJ_UNICOS_CONTAC C30,
                            Z_SC999_CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TEL_FIX))=1
                         AND CONTACTE.NC = C30.NC
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SC070_TELEFON_FIX ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     INSERT INTO A0_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A0_SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           subStr(NUEVOS.TELEFON,1,20) AS NUMERO, 
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
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SC070_TELEFON_FIX NUEVOS,
                          A0_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.ID_CONTACTE
                    AND existen.ESQUEMA_ORIGINAL='CALIMA'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A0_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
     
     
  END;


  
  PROCEDURE SC071_TELEFONS_MOBIL IS
    BEGIN
    
        INSERT INTO Z_SC071_TELEFON_MOBIL (ID_CONTACTE, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE,                 	   
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.NC as ID_ORIGINAL,
                       'CALIMA' AS ESQUEMA_ORIGINAL,
                       'EXT_CONTACTES //TEL_MOBIL       ' as TABLA_ORIGINAL
                FROM (	   
                       SELECT CONTACTE.NC As NC,
                              CONTACTE.ID AS ID_CONTACTE,
                             (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TEL_MOBIL),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TEL_MOBIL))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TEL_MOBIL) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TEL_MOBIL) AS CONCEPTE                              
                       FROM Z_SC030_SUBJ_UNICOS_CONTAC C30,
                            Z_SC999_CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TEL_MOBIL))=1
                         AND CONTACTE.NC = C30.NC
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SC071_TELEFON_MOBIL ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     
     INSERT INTO A0_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A0_SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           subStr(NUEVOS.TELEFON,1,20) AS NUMERO, 
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
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SC071_TELEFON_MOBIL NUEVOS,
                          A0_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.ID_CONTACTE
                    AND existen.ESQUEMA_ORIGINAL='CALIMA'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A0_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
     
    
  COMMIT;   
  END;
  


PROCEDURE SC072_TELEFONS_CENTRALETA IS
    BEGIN
    
        INSERT INTO Z_SC072_TELEFON_CENTRALETA (ID_CONTACTE, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE,                 	   
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.NC as ID_ORIGINAL,
                       'CALIMA' AS ESQUEMA_ORIGINAL,
                       'EXT_CONTACTES //TEL_CENTRALETA' as TABLA_ORIGINAL
                FROM (	   
                       SELECT CONTACTE.NC As NC,
                              CONTACTE.ID AS ID_CONTACTE,
                             (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TEL_FIX_CENTRALETA),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TEL_FIX_CENTRALETA))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TEL_FIX_CENTRALETA) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TEL_FIX_CENTRALETA) AS CONCEPTE                              
                       FROM Z_SC030_SUBJ_UNICOS_CONTAC C30,
                            Z_SC999_CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TEL_FIX_CENTRALETA))=1
                         AND CONTACTE.NC = C30.NC
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SC072_TELEFON_CENTRALETA ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     
     INSERT INTO A0_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A0_SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           subStr(NUEVOS.TELEFON,1,20) AS NUMERO, 
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
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SC072_TELEFON_CENTRALETA NUEVOS,
                          A0_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.ID_CONTACTE
                    AND existen.ESQUEMA_ORIGINAL='CALIMA'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A0_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
     
    
  COMMIT;   
  END;



PROCEDURE SC073_TELEFONS_ALTRES IS
    BEGIN
    
        INSERT INTO Z_SC073_TELEFON_ALTRES (ID_CONTACTE, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE,                 	   
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.NC as ID_ORIGINAL,
                       'CALIMA' AS ESQUEMA_ORIGINAL,
                       'EXT_CONTACTES //TEL_ALTRES' as TABLA_ORIGINAL
                FROM (	   
                       SELECT CONTACTE.NC As NC,
                              CONTACTE.ID AS ID_CONTACTE,
                             (CASE WHEN SUBSTR(FUNC_NORMALITZAR_TFN(TEL_ALTRES),1,1)= '6' AND LENGTH(FUNC_NORMALITZAR_TFN(TEL_ALTRES))= 9 THEN 
                                          ConstTelefonMobil
                                ELSE 
                                          ConstTelefonFix
                                END) AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(TEL_ALTRES) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(TEL_ALTRES) AS CONCEPTE                              
                       FROM Z_SC030_SUBJ_UNICOS_CONTAC C30,
                            Z_SC999_CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TEL_ALTRES))=1
                         AND CONTACTE.NC = C30.NC
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SC073_TELEFON_ALTRES ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     
     INSERT INTO A0_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT A0_SEQ_CONTACTE_TELEFON.NEXTVAL AS ID, 
                           subStr(NUEVOS.TELEFON,1,20) AS NUMERO, 
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
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SC073_TELEFON_ALTRES NUEVOS,
                          A0_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.ID_CONTACTE
                    AND existen.ESQUEMA_ORIGINAL='CALIMA'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A0_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
     
    
  COMMIT;   
  END;



PROCEDURE SC074_TELEFONS_FAX IS
    BEGIN
    
        INSERT INTO Z_SC074_TELEFON_FAX (ID_CONTACTE, TIPUS_TELEFON, TELEFON, ES_PRINCIPAL, CONCEPTE, ES_PARTICULAR, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)

                SELECT NUEVOS.ID_CONTACTE,                 	   
                	   NUEVOS.TIPUS_TELEFON,
                	   NUEVOS.TELEFON,
                       ConstNO as ES_PRINCIPAL,
                       CONCEPTE AS CONCEPTE,
                       FUNC_ES_PARTICULAR(CONCEPTE) AS ES_PARTICULAR,
                       NUEVOS.NC as ID_ORIGINAL,
                       'CALIMA' AS ESQUEMA_ORIGINAL,
                       'EXT_CONTACTES //FAX' as TABLA_ORIGINAL
                FROM (	   
                       SELECT CONTACTE.NC As NC,
                              CONTACTE.ID AS ID_CONTACTE,
                              ConstTelefonFAx AS TIPUS_TELEFON,
                              FUNC_NORMALITZAR_TFN(FAX) AS TELEFON,
                              FUNC_NORMALITZAR_CONCEPTE(FAX) AS CONCEPTE                              
                       FROM Z_SC030_SUBJ_UNICOS_CONTAC C30,
                            Z_SC999_CONTACTE  CONTACTE
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(FAX))=1
                         AND CONTACTE.NC = C30.NC
                     ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                     FROM Z_SC074_TELEFON_FAX ANTIGUOS
                                    WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.ID_CONTACTE
                                      AND ANTIGUOS.TIPUS_TELEFON = NUEVOS.TIPUS_TELEFON
                                      AND ANTIGUOS.TELEFON = NUEVOS.TELEFON     
                                   );
     
     COMMIT;
     
     
     INSERT INTO A0_CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, OBSERVACIONS, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID, TIPUS_TELEFON_ID, CONCEPTE, ES_PRIVAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
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
                           NUEVOS.ID_CONTACTE AS CONTACTE_ID, 
                           NUEVOS.TIPUS_TELEFON AS TIPUS_TELEFON_ID,
                           NUEVOS.CONCEPTE AS CONCEPTE,
                           NUEVOS.ES_PARTICULAR AS ES_PRIVAT,
                           NUEVOS.ID_ORIGINAL AS ID_ORIGINAL,
                           NUEVOS.ESQUEMA_ORIGINAL AS ESQUEMA_ORIGINAL,
                           TRIM(NUEVOS.TABLA_ORIGINAL) AS TABLA_ORIGINAL
                     FROM Z_SC074_TELEFON_FAX NUEVOS,
                          A0_CONTACTE EXISTEN 
                     WHERE NUEVOS.TELEFON IS NOT NULL       
                       and EXISTEN.ID = NUEVOS.ID_CONTACTE
                    AND existen.ESQUEMA_ORIGINAL='CALIMA'
                       AND NOT EXISTS(SELECT 1 
                                      FROM A0_CONTACTE_TELEFON ANTIGUOS
                                      WHERE ANTIGUOS.numero = NUEVOS.telefon
                                        AND ANTIGUOS.contacte_id =  NUEVOS.id_contacte
                                        AND ANTIGUOS.TIPUS_TELEFON_ID =NUEVOS.tipus_telefon
                                     ); 
     
    
  COMMIT;   
  END;
  



  PROCEDURE SC090_TRUCADA_DESTINATARI IS
   BEGIN
   
    
   
        INSERT INTO Z_SC090_TRUCADA_DESTINATARI
            SELECT (A0_SEQ_DM_DESTINATARI_PERSONA.NEXTVAL) AS DESTINATARI_ID, 
                    Group_Destinataris.Destinatari AS Destinatari
                    
            FROM ( 	
            
	            SELECT  Destinatari

	            FROM (
	                    SELECT QUI AS Destinatari
	                    FROM Z_TMP_CALIMA_U_TRUC_ACTIVES 	
	                    WHERE QUI IS NOT NULL
	                    GROUP BY QUI
	                        UNION
	                    SELECT QUI AS Destinatari
	                    FROM Z_TMP_CALIMA_U_HIST_TRUCADA
	                    WHERE QUI IS NOT NULL
	                    GROUP BY QUI			   
	                ) Filtro1
				GROUP BY Destinatari
            )Group_Destinataris     
         WHERE NOT EXISTS (SELECT 1 
                           FROM Z_SC090_TRUCADA_DESTINATARI ANTIGUOS
                           WHERE ANTIGUOS.Destinatari = Group_Destinataris.Destinatari
                          );  

   COMMIT;
   END;

 

   PROCEDURE  SC093_INSERTAR_DM_DESTINATARI IS
   BEGIN
         INSERT INTO A0_DM_DESTINATARI_PERSONA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT DESTINATARI_ID AS ID,                    
                   DESTINATARI AS DESCRIPCIO,                   
                   FUNC_FECHA_CREACIO(NULL) AS DATA_CREACIO,
                   NULL AS DATA_ESBORRAT,
                   NULL AS DATA_MODIFICACIO,
                   FUNC_USU_CREACIO(NULL) AS USUARI_CREACIO,
                   NULL AS USUARI_ESBORRAT,
                   NULL AS USUARI_MODIFICACIO,
                   NULL ID_ORIGINAL, 
                   'CALIMA' ESQUEMA_ORIGINAL, 
                   'TRUC' AS TABLA_ORIGINAL
                FROM Z_SC090_TRUCADA_DESTINATARI
                
/*                
                    SELECT 
                       HIST.QUI AS CODI,
	                   HIST.QUI AS DESCRIPCIO,
	                   FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
	                   NULL AS DATA_MODIFICACIO,
	                   'MIGRACIO' AS USUARI_CREACIO,
	                   NULL AS USUARI_ESBORRAT,
	                   NULL AS USUARI_MODIFICACIO,
	                   QUI AS ID_ORIGINAL, 
	                   'CALIMA' AS ESQUEMA_ORIGINAL, 
	                   'HIST_TRUCADA' AS TABLA_ORIGINAL
                    FROM Z_TMP_CALIMA_U_HIST_TRUCADA HIST,
                         Z_SC090_TRUCADA_DESTINATARI C90
                    WHERE C90.DESTINATARI = QUI
                        UNION
                    SELECT 
                       TRUC.QUI AS CODI,
	                   TRUC.QUI AS DESCRIPCIO,
	                   NULL AS DATA_ESBORRAT,
	                   NULL AS DATA_MODIFICACIO,
	                   'MIGRACIO' AS USUARI_CREACIO,
	                   NULL AS USUARI_ESBORRAT,
	                   NULL AS USUARI_MODIFICACIO,
	                   QUI AS ID_ORIGINAL, 
	                   'CALIMA' AS ESQUEMA_ORIGINAL, 
	                   'TRUC_ACTIVES' AS TABLA_ORIGINAL
                    FROM Z_TMP_CALIMA_U_TRUC_ACTIVES TRUC,
                         Z_SC090_TRUCADA_DESTINATARI C90
                    WHERE C90.DESTINATARI = QUI	  
                    GROUP BY QUI
                ) TABLA_FINAL
                WHERE NOT EXISTS ( SELECT NULL
                                     FROM  A0_DM_DESTINATARI_PERSONA ANTIGUOS  
                                    WHERE TABLA_FINAL.DESCRIPCIO = ANTIGUOS.DESCRIPCIO
                                 );
*/                                 
  COMMIT;
  END;


   PROCEDURE SC095_TRUCADAS_ACTIVES IS
   BEGIN
      INSERT INTO Z_SC095_TRUCADAS_ACTIVES (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
          SELECT A0_SEQ_TRUCADA.NEXTVAL AS ID,
                 FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(REGISTRE)) AS DATA_REGISTRE,
                 FUNC_NULOS_STRING() AS DATA_RESOLUCIO,
                (CASE WHEN TRIM(SUBSTR(NOM, LENGTH(NOM)-2)) = ',' THEN    --SI EL FINAL ES UNA COMA QUIERE DECIR QUE NO HAY APELLIDOS Y LO PRIMERO ES EL NOMBRE
                    trim(SUBSTR(NOM,1, INSTR(LOWER(NOM),',')-1)) --EN LA PARTE DE LOS APELLIDOS EST� EL NOMBRE (SI LO �LTIMO ES ','
                 ELSE
                    TRIM(SUBSTR(NOM, INSTR(NOM,',')+1)) -- COGEMOS LO QUE VA DESP��S DE LA COMA
                 END) AS NOM,
                 (CASE WHEN TRIM(SUBSTR(NOM, LENGTH(NOM)-2)) = ',' THEN --SI EL FINAL ES COMA NO HAY APELLIDOS SINO HAY QUE COGER LA PRIMERA PARTE (Y POSTERIORMENTE SEPARAR LOS DOS APELLIDOS)
                          NULL
                  ELSE        
                          TRIM(SUBSTR(trim(SUBSTR(NOM,1, INSTR(LOWER(NOM),',')-1)),1,INSTR(LOWER(NOM),' ')))      
                 END) AS COGNOM1,
                 (CASE WHEN TRIM(SUBSTR(NOM, LENGTH(NOM)-2)) = ',' THEN --SI EL FINAL ES COMA NO HAY APELLIDOS SINO HAY QUE COGER LA PRIMERA PARTE (Y POSTERIORMENTE SEPARAR LOS DOS APELLIDOS)
                          NULL
                 ELSE 
                         TRIM(SUBSTR(trim(SUBSTR(NOM,1, INSTR(LOWER(NOM),',')-1)),LENGTH(SUBSTR(trim(SUBSTR(NOM,1, INSTR(LOWER(NOM),','))),1,INSTR(LOWER(NOM),' ')))))
                 END) AS COGNOM2,
                 CARREC AS CARREC,
                 TEL_CONTACTAT AS TELEFON,
                 FUNC_NULOS_STRING() AS TELEFON_SECUNDARI,
                 ASSUMPTE AS DESCRIPCIO,
                 FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(REGISTRE)) AS DATA_CREACIO,
                 FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                 FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                 USUARI_MODIFICACIO AS USUARI_CREACIO,
                 FUNC_NULOS_STRING() AS USUARI_ESBORRAT,        
                 USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                 (SELECT ID FROM Z_SC999_DM_ENTITAT_TRUCADA WHERE DESCRIPCIO = ORGANISME_) AS ENTITAT_ID,
                  (CASE WHEN ESTAT='PAS' THEN 
                      ConstTRUCADAPAS
                    WHEN ESTAT='PEN' THEN   
                      ConstTRUECADAPEN
                    ELSE     
                      3
                END) AS ESTAT_TRUCADA_ID,     
                (SELECT ID FROM A0_DM_DESTINATARI_PERSONA WHERE DESCRIPCIO= QUI) AS DESTINATARI_PERSONA_ID,
                FUNC_NULOS_STRING() AS CONTACTE_ID,
                (CASE WHEN E_S='E' THEN 
                    ConstENTRADA
                 ELSE 
                    ConstSALIDA
                END) AS SENTIT_ID,
                N AS ID_ORIGINAL, 
                'CALIMA' AS ESQUEMA_ORIGINAL, 
                'TRUC_ACTIVES' AS TABLA_ORIGINAL
               FROM Z_TMP_CALIMA_U_TRUC_ACTIVES NUEVOS
            WHERE NOT EXISTS (SELECT NULL
                              FROM Z_SC095_TRUCADAS_ACTIVES ANTIGUOS 
                              WHERE NUEVOS.N = ANTIGUOS.ID_ORIGINAL
                        );
   
   COMMIT;
   END;
   

 PROCEDURE SC096_TRUCADAS_HISTORIC IS
   BEGIN
   
        INSERT INTO Z_SC096_TRUCADAS_HISTORIC (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                 SELECT A0_SEQ_TRUCADA.NEXTVAL AS ID,
                        FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(REGISTRE)) AS DATA_REGISTRE,
                        FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(DARRERA_INTERV)) AS DATA_RESOLUCIO,
                        (CASE WHEN NOM2 IS NULL THEN 
                            SUBSTR(COGNOM_1,1,30)
                        ELSE 
                            SUBSTR(NOM2,1,30)
                        END) AS NOM,
                        (CASE WHEN NOM2 IS NULL THEN
                                NULL
                        ELSE 
                                COGNOM_1
                        END) AS COGNOM1,
                        SUBSTR(COGNOM_2,1,40) AS COGNOM2,
                        CARREC AS CARREC,
                        FUNC_NULOS_ASTERICO(SUBSTR(TEL_CONTACTAT,1,40)) AS TELEFON,
                        FUNC_NULOS_ASTERICO(SUBSTR(nvl(TEL_FIX_DIRECTE,tel_mobil),1,40)) AS TELEFON_SECUNDARI,
                        ASSUMPTE AS DESCRIPCIO,
                        FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(REGISTRE)) AS DATA_CREACIO,
                        FUNC_FECHA_NULA(NULL) AS DATA_ESBORRAT,
                        FUNC_FECHA_NULA(NULL) AS DATA_MODIFICACIO,
                        'MIGRACIO' AS USUARI_CREACIO,
                        FUNC_NULOS_STRING() AS USUARI_ESBORRAT,        
                        FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
                        (SELECT ID FROM Z_SC999_DM_ENTITAT_TRUC_HIST WHERE DESCRIPCIO = ORGANISME_) AS ENTITAT_ID,
                        (CASE 
                            WHEN ESTAT='PAS' THEN 
                              ConstTRUCADAPAS
                            WHEN ESTAT='PEN' THEN   
                              ConstTRUECADAPEN
                            ELSE     
                              NULL
                        END) AS ESTAT_TRUCADA_ID,     
                       (SELECT ID FROM A0_DM_DESTINATARI_PERSONA WHERE DESCRIPCIO= QUI) AS DESTINATARI_PERSONA_ID,
                       FUNC_NULOS_STRING() AS CONTACTE_ID,
                       (CASE WHEN E_S='E' THEN 
                            ConstENTRADA
                        ELSE 
                            ConstSALIDA
                        END) AS SENTIT_ID,
                        N AS ID_ORIGINAL, 
                        'CALIMA' AS ESQUEMA_ORIGINAL, 
                        'HIST_TRUCADA' AS TABLA_ORIGINAL
                       FROM Z_TMP_CALIMA_U_HIST_TRUCADA NUEVOS
                      WHERE NOT EXISTS (SELECT 1
                                        FROM Z_SC096_TRUCADAS_HISTORIC ANTIGUOS 
                                         WHERE NUEVOS.N = ANTIGUOS.ID_ORIGINAL
                                       );
   
   COMMIT;
   END;

PROCEDURE SC097_TRUCADAS IS
   BEGIN
        INSERT INTO A0_TRUCADA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL
                    FROM (
                          SELECT ID,
                                 DATA_REGISTRE,
                                 FUNC_FECHA_NULA(DATA_RESOLUCIO) AS DATA_RESOLUCIO,
                                 NOM,
                                 COGNOM1,
                                 COGNOM2,
                                 CARREC,
                                 TELEFON,
                                 TELEFON_SECUNDARI,
                                 DESCRIPCIO,
                                 DATA_CREACIO,
                                 DATA_ESBORRAT,
                                 DATA_MODIFICACIO,
                                 USUARI_CREACIO,
                                 USUARI_ESBORRAT,
                                 USUARI_MODIFICACIO,
                                 ENTITAT_ID,
                                 ESTAT_TRUCADA_ID,
                                 DESTINATARI_PERSONA_ID,
                                 CONTACTE_ID,
                                 SENTIT_ID,
                                 ID_ORIGINAL, 
                                 ESQUEMA_ORIGINAL, 
                                 TABLA_ORIGINAL
                            FROM Z_SC095_TRUCADAS_ACTIVES
                                UNION ALL 
                          SELECT ID,
                                 DATA_REGISTRE,
                                 FUNC_FECHA_NULA(DATA_RESOLUCIO) AS DATA_RESOLUCIO,
                                 NOM,
                                 COGNOM1,
                                 COGNOM2,
                                 CARREC,
                                 TELEFON,
                                 TELEFON_SECUNDARI,
                                 DESCRIPCIO,
                                 DATA_CREACIO,
                                 DATA_ESBORRAT,
                                 DATA_MODIFICACIO,
                                 USUARI_CREACIO,
                                 USUARI_ESBORRAT,
                                 USUARI_MODIFICACIO,
                                 ENTITAT_ID,
                                 ESTAT_TRUCADA_ID,
                                 DESTINATARI_PERSONA_ID,
                                 CONTACTE_ID,
                                 SENTIT_ID,
                                 ID_ORIGINAL, 
                                 ESQUEMA_ORIGINAL, 
                                 TABLA_ORIGINAL
                            FROM Z_SC096_TRUCADAS_HISTORIC
                           WHERE TELEFON IS NOT NULL 
                         ) NUEVOS
                         WHERE NOT EXISTS (SELECT 1
                                             FROM A0_TRUCADA ANTIGUOS
                                            WHERE ANTIGUOS.ID = NUEVOS.ID
                                           ); 
   
   
   COMMIT;
   END;

PROCEDURE SC098_ERR_TRUCADA IS
BEGIN
      
              INSERT INTO ERR_TRUCADA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,ERR_DESCRIPCION)

                          SELECT ID,
                                 DATA_REGISTRE,
                                 FUNC_FECHA_NULA(DATA_RESOLUCIO) AS DATA_RESOLUCIO,
                                 NOM,
                                 COGNOM1,
                                 COGNOM2,
                                 CARREC,
                                 TELEFON,
                                 TELEFON_SECUNDARI,
                                 DESCRIPCIO,                            
                                 ENTITAT_ID,
                                 ESTAT_TRUCADA_ID,
                                 DESTINATARI_PERSONA_ID,
                                 CONTACTE_ID,
                                 SENTIT_ID,
                                 ID_ORIGINAL, 
                                 ESQUEMA_ORIGINAL, 
                                 TABLA_ORIGINAL,
                                 'CAMPO TELEFON NULO' AS ERR_DESCRIPCION
                            FROM Z_SC095_TRUCADAS_ACTIVES
                            WHERE TELEFON IS NULL ;
    COMMIT;

            INSERT INTO ERR_TRUCADA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,ERR_DESCRIPCION)
                          SELECT ID,
                                 DATA_REGISTRE,
                                 FUNC_FECHA_NULA(DATA_RESOLUCIO) AS DATA_RESOLUCIO,
                                 NOM,
                                 COGNOM1,
                                 COGNOM2,
                                 CARREC,
                                 TELEFON,
                                 TELEFON_SECUNDARI,
                                 DESCRIPCIO,                            
                                 ENTITAT_ID,
                                 ESTAT_TRUCADA_ID,
                                 DESTINATARI_PERSONA_ID,
                                 CONTACTE_ID,
                                 SENTIT_ID,
                                 ID_ORIGINAL, 
                                 ESQUEMA_ORIGINAL, 
                                 TABLA_ORIGINAL,
                                 'CAMPO TELEFON NULO' AS ERR_DESCRIPCION
                            FROM Z_SC096_TRUCADAS_HISTORIC
                            WHERE TELEFON IS NULL ;


COMMIT;
END;

/*
PROCEDURE SC099_HIST_TRUCADAS IS
   BEGIN
     INSERT INTO A0_HISTORIC_TRUCADA (ID, DESCRIPCIO, SENTIT_ID, TELEFON, DATA_REGISTRE, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRUCADA_ID, RAO_ID, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
          SELECT A0_SEQ_HISTORIC_TRUCADA.NEXTVAL AS ID,
                 ASSUMPTE AS DESCRIPCIO,
                  (CASE WHEN E_S='E' THEN 
                        2
                   ELSE 
                        1
                    END) AS SENTIT_ID,
                SUBSTR(TEL_CONTACTAT,1,20) AS TELEFON,
                FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(REGISTRE)) AS DATA_REGISTRE,
                FUNC_FECHA_NULA(FUNC_FECHA_CHUNGA(REGISTRE)) AS DATA_CREACIO,
                FUNC_NULOS_STRING() AS DATA_ESBORRAT,
                FUNC_NULOS_STRING() AS DATA_MODIFICACIO,
                'MIGRACIO' AS USUARI_CREACIO,
                FUNC_NULOS_STRING() AS USUARI_ESBORRAT,
                FUNC_NULOS_STRING() AS USUARI_MODIFICACIO,
               (SELECT ID FROM A0_TRUCADA WHERE ID_ORIGINAL = N) AS TRUCADA_ID,
                (CASE WHEN ESTAT='PAS' THEN  
                      5
                      WHEN ESTAT='PEN' THEN 
                      2
                END) AS RAO_ID,
                 (CASE  WHEN ESTAT='PAS' THEN 
                            2
                        WHEN ESTAT='PEN' THEN   
                            1
                ELSE     
                            NULL
                END) AS ESTAT_TRUCADA_ID,
                N AS ID_ORIGINAL, 
                'CALIMA' AS ESQUEMA_ORIGINAL, 
                'HIST_TRUCADA'  AS TABLA_ORIGINAL
          FROM Z_TMP_CALIMA_U_HIST_TRUCADA NUEVOS
         WHERE ESTAT = 'PEN' OR ESTAT ='PAS'
           AND NOT EXISTS (SELECT 1
                             FROM A0_HISTORIC_TRUCADA ANTIGUOS
                            WHERE NUEVOS.N = ANTIGUOS.ID
                          );
   
   
   
   COMMIT;
   END;
   */


    PROCEDURE RESETEATOR_TABLAS_SINTAGMA IS
    BEGIN
          DELETE FROM A0_DM_TRACTAMENT SINTAGMA WHERE EXISTS (SELECT 1 
                                                       FROM Z_SC999_DM_TRACTAMENT BORRAR
                                                      WHERE BORRAR.DESCRIPCIO = SINTAGMA.DESCRIPCIO
                                                    );

          DELETE FROM A0_DM_CARREC SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC999_DM_CARREC BORRAR
                                                           WHERE BORRAR.DESCRIPCIO = SINTAGMA.DESCRIPCIO
                                                          );

          DELETE FROM A0_DM_ENTITAT SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC999_DM_ENTITAT_CONTACTE BORRAR
                                                           WHERE BORRAR.DESCRIPCIO = SINTAGMA.DESCRIPCIO
                                                          );
          DELETE FROM A0_DM_ENTITAT SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC999_DM_ENTITAT_TRUCADA BORRAR
                                                           WHERE BORRAR.DESCRIPCIO = SINTAGMA.DESCRIPCIO
                                                          );
          
          DELETE FROM A0_DM_ENTITAT SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC999_DM_ENTITAT_TRUC_HIST BORRAR
                                                           WHERE BORRAR.DESCRIPCIO = SINTAGMA.DESCRIPCIO
                                                          );                                                

          DELETE FROM A0_SUBJECTE SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC999_SUBJECTE BORRAR
                                                           WHERE BORRAR.ID = SINTAGMA.ID
                                                          );                                                

          DELETE FROM A0_ADRECA SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC999_ADRECAS BORRAR
                                                           WHERE BORRAR.ADRECA_ID = SINTAGMA.ID
                                                          );    

          DELETE FROM A0_CONTACTE SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC999_CONTACTE BORRAR
                                                           WHERE BORRAR.ID = SINTAGMA.ID
                                                          );    
                                                          
          DELETE FROM A0_CONTACTE_CORREU SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC061_CORREUS_PRINCIPALES BORRAR
                                                           WHERE BORRAR.ID_CONTACTE = SINTAGMA.ID
                                                             AND BORRAR.CORREU = SINTAGMA.CORREU_ELECTRONIC
                                                          );                                                              
                                                          
           DELETE FROM A0_DM_DESTINATARI_PERSONA SINTAGMA WHERE EXISTS (SELECT 1 
                                                            FROM Z_SC090_TRUCADA_DESTINATARI BORRAR
                                                           WHERE BORRAR.DESTINATARI = SINTAGMA.DESCRIPCIO
                                                          );                                                    
                                                          

    COMMIT;    
    END;

    PROCEDURE RESETEATOR_TABLAS_AUX IS
    BEGIN
           DELETE FROM Z_SC030_SUBJ_UNICOS_CONTAC;
           DELETE FROM Z_SC031_SUBJECTE_PERSONA;
           DELETE FROM Z_SC032_SUBJECTES_TIPO_ENTITAT;

           DELETE FROM Z_SC049_CONTACTES_SUBJECTE;
           DELETE FROM Z_SC060_CORREUS_CONTACTES;
           DELETE FROM Z_SC061_CORREUS_PRINCIPALES;
           
           DELETE FROM Z_SC070_TELEFON_FIX;
           DELETE FROM Z_SC071_TELEFON_MOBIL;
           DELETE FROM Z_SC072_TELEFON_CENTRALETA;
           DELETE FROM Z_SC073_TELEFON_ALTRES;
           DELETE FROM Z_SC074_TELEFON_FAX;
           
           DELETE FROM Z_SC090_TRUCADA_DESTINATARI;
           DELETE FROM Z_SC095_TRUCADAS_ACTIVES;
           DELETE FROM Z_SC096_TRUCADAS_HISTORIC;
           
           
           
           DELETE FROM Z_SC999_DM_TRACTAMENT;
           DELETE FROM Z_SC999_DM_CARREC;
           DELETE FROM Z_SC999_DM_ENTITAT_CONTACTE;
           DELETE FROM Z_SC999_DM_ENTITAT_TRUCADA;
           DELETE FROM Z_SC999_DM_ENTITAT_TRUC_HIST;
           DELETE FROM Z_SC999_SUBJECTE;
           DELETE FROM Z_SC999_ADRECAS;
           DELETE FROM Z_SC999_CONTACTE;
           
           DELETE FROM A0_TRUCADA;
           DELETE FROM A0_HISTORIC_TRUCADA;
           DELETE FROM A0_DM_DESTINATARI_PERSONA;

    COMMIT;    
    END;  

    PROCEDURE RESETEATOR_SECUENCIAS IS
    BEGIN
            PROC_ACTUALIZAR_SECUENCIA('A0_','CONTACTE');
            PROC_ACTUALIZAR_SECUENCIA('A0_','CONTACTE_CORREU');

            PROC_ACTUALIZAR_SECUENCIA('A0_','DM_TRACTAMENT');
            PROC_ACTUALIZAR_SECUENCIA('A0_','DM_CARREC');
            PROC_ACTUALIZAR_SECUENCIA('A0_','DM_ENTITAT');
            PROC_ACTUALIZAR_SECUENCIA('A0_','SUBJECTE');
            PROC_ACTUALIZAR_SECUENCIA('A0_','ADRECA');
            PROC_ACTUALIZAR_SECUENCIA('A0_','TRUCADA');
            PROC_ACTUALIZAR_SECUENCIA('A0_','HISTORIC_TRUCADA');
            PROC_ACTUALIZAR_SECUENCIA('A0_','DM_DESTINATARI_PERSONA');
            
            
        
    COMMIT;    
    END;

END A0_03_CONTACTES_CALIMA;

/
