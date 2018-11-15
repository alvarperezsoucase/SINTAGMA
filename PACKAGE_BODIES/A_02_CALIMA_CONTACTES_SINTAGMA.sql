--------------------------------------------------------
--  DDL for Package Body A_02_CALIMA_CONTACTES_SINTAGMA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."A_02_CALIMA_CONTACTES_SINTAGMA" AS

/*
PROCEDURE C00_TABLAS_ESENCIALES IS
BEGIN

            Insert into DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI) values ('2','Passada',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null,'PASSADA');
            Insert into DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI) values ('3','Prevista',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null,'PREVISTA');
            Insert into DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI) values ('1','Pendent',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null,'PENDENT');


            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(1, 'Altres', sysdate, null, null, 'MIGRACIO', NULL, NULL, 1, null, null, null);
            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(2, 'No es troba disponible el remitent', sysdate, null, null, 'MIGRACIO', NULL, NULL, 1, null, null, null);
            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(3, 'Respon una altra persona', sysdate, null, null, 'MIGRACIO', NULL, NULL, 1, null, null, null);
            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(4, 'Comunica', sysdate, null, null, 'MIGRACIO', NULL, NULL, 1, null, null, null);
            
            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(5, 'Trucada passada al remitent', sysdate, null, null, 'MIGRACIO', NULL, NULL, 2, null, null, null);
            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(6, 'Trucada derivada a un altre telefon de contacte', sysdate, null, null, 'MIGRACIO', NULL, NULL, 2, null, null, null);
            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(7, 'Trucada derivada a un altre telefon de contacte', sysdate, null, null, 'MIGRACIO', NULL, NULL, 2, null, null, null);
            INSERT INTO DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(8, 'Altres', sysdate, null, null, 'MIGRACIO', NULL, NULL, 2, null, null, null);



COMMIT;
END;
*/
 
 PROCEDURE C01_EXTRAER_SUBJECTES_PERSONAS IS
    BEGIN
    
        --SI SEXE ES NULO ES ENTITAT SINO ES ES PERSONA
        --Buscamos las personas y 
        INSERT INTO Z_C01_SUBJECTE_CALIMA (ID_SUBJECTE, NOM2, COGNOM_1, COGNOM_2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID,AMBIT_ID)
              SELECT N_P as ID_SUBJECTE, 
                        NOM2 , 
                        COGNOM_1, 
                        COGNOM_2, 
                        ALIES, 
                        FUNC_NORMALITZAR(NOM2 || CogNom_1 || CogNom_2) AS NOM_NORMALITZAT,
                        RIP AS DATA_DEFUNCIO,                    
                        NULL AS IDIOMA_ID,                    
                        DATADARRERA AS DATA_DARRERA,
                        DATA_BAIXA AS DATA_BAIXA,                    
                        NULL as ID_PRIORITAT,
                        ConstSebjectePersona AS TIPUS_SUBJECTE_ID, 
                        ConstALCALDIA as AMBIT_ID --Alcaldía                    
                FROM Z_TMP_CALIMA_U_EXT_PERSONES  PRINCIPAL
                WHERE SEXE IS NOT NULL OR (SEXE IS NULL AND NOM2 IS NOT NULL AND (COGNOM_1 IS NOT NULL OR COGNOM_2 IS NOT NULL))
                  AND NOT EXISTS (SELECT NULL
                                    FROM Z_C01_SUBJECTE_CALIMA NUEVOS 
                                    WHERE NUEVOS.ID_SUBJECTE = PRINCIPAL.N_P);
      COMMIT;   
    END;
    

    
    /*Sujetos de Calima que existen en vips*/
    PROCEDURE C02_EXISTE_SUBJECTE  IS
    BEGIN

         INSERT INTO Z_C02_EXISTE_SUBJECTE_CALIMA (SINTAGMA_ID, SINTAGMA_NOM, SINTAGMA_COGNOM1, SINTAGMA_COGNOM2, ID_SUBJECTE, NOM2, COGNOM_1, COGNOM_2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID, AMBIT_ID)
                SELECT SUBJECTE.ID AS SINTAGMA_ID, 
                       SUBJECTE.NOM AS SINTAGMA_NOM, 
                       SUBJECTE.COGNOM1 AS SINTAGMA_COGNOM1, 
                       SUBJECTE.COGNOM2 AS SINTAGMA_COGNOM2, 
                       PRINCIPAL.* 
                FROM Z_C01_SUBJECTE_CALIMA  PRINCIPAL,
                     SUBJECTE SUBJECTE
                WHERE PRINCIPAL.NOM_NORMALITZAT = FUNC_NORMALITZAR(SUBJECTE.NOM || SUBJECTE.COGNOM1 || SUBJECTE.COGNOM2)
                  and SUBJECTE.DATA_ESBORRAT IS NOT NULL  
                  AND NOT EXISTS (SELECT 1 
                                    FROM Z_C02_EXISTE_SUBJECTE_CALIMA ANTIGUOS
                                    WHERE ANTIGUOS.ID_SUBJECTE = principal.ID_SUBJECTE 
                                  );

     COMMIT;
    END;

/*Sujetos que no existen en Calima */
    PROCEDURE C03_NO_EXISTE_SUBJECTE IS
    BEGIN
      -- se suma 1.500.000 al id de calima para tenerlos identificados.
       INSERT INTO Z_C03_NO_EXISTE_SUBJECTE (ID_SUBJECTE_SINTAGMA, ID_SUBJECTE, NOM2, COGNOM_1, COGNOM_2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID, AMBIT_ID)
           SELECT (SUBJECTES_TODOS.ID_SUBJECTE) AS ID_SUBJECTE_SINTAGMA, 
                   SUBJECTES_TODOS.*
            FROM Z_C01_SUBJECTE_CALIMA SUBJECTES_TODOS
                 LEFT OUTER JOIN 
                    Z_C02_EXISTE_SUBJECTE_CALIMA SUBJECTES_EXISTEN
                 ON   SUBJECTES_TODOS.ID_SUBJECTE = SUBJECTES_EXISTEN.ID_SUBJECTE 
            WHERE SUBJECTES_EXISTEN.ID_SUBJECTE IS NULL
              AND NOT EXISTS (SELECT NULL 
                              FROM Z_C03_NO_EXISTE_SUBJECTE ANTIGUOS 
                              WHERE ANTIGUOS.ID_SUBJECTE = SUBJECTES_TODOS.ID_SUBJECTE
                             );  
      COMMIT;
    END;
    
    --RELACIÓN DE LOS SUBJECTES DE CALIMA CON EL ID QUE TIENEN O TENDRÁN EN SINTAGMA
    --SE USARÁ PARA ASIGNAR EL ID_SUBJECTE EN CONTACTES. 
    procedure C04_SUBJECTES_CALIMA_REL_VIPS IS
    BEGIN
      INSERT INTO Z_C04_IDSUBJECTE_SINTAGMA (ID_SUBJECTE_SINTAGMA, ID_SUBJECTE, NOM, COGNOM1, COGNOM2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID, AMBIT_ID)
       SELECT ID_SUBJECTE_SINTAGMA, 
              ID_SUBJECTE, 
              NOM, 
              COGNOM1, 
              COGNOM2, 
              ALIES, 
              NOM_NORMALITZAT, 
              DATA_DEFUNCIO, 
              IDIOMA_ID, 
              DATA_DARRERA, 
              DATA_BAIXA, 
              ID_PRIORITAT, 
              TIPUS_SUBJECTE_ID, 
              AMBIT_ID
       FROM (       
               SELECT SINTAGMA_ID AS ID_SUBJECTE_SINTAGMA,
                      ID_SUBJECTE AS ID_SUBJECTE,
                      SINTAGMA_NOM AS nom, 
                      SINTAGMA_COGNOM1 AS COGNOM1, 
                      SINTAGMA_COGNOM2 AS COGNOM2, 
                      ALIES, 
                      NOM_NORMALITZAT, 
                      DATA_DEFUNCIO, 
                      IDIOMA_ID, 
                      DATA_DARRERA, 
                      DATA_BAIXA, 
                      ID_PRIORITAT, 
                      TIPUS_SUBJECTE_ID, 
                      AMBIT_ID
               FROM Z_C02_EXISTE_SUBJECTE_CALIMA 									  
                UNION
               SELECT ID_SUBJECTE_SINTAGMA, 
                      ID_SUBJECTE, 
                      NOM2 AS nom, 
                      COGNOM_1 AS COGNOM1, 
                      COGNOM_2 AS COGNOM2, 
                      ALIES, 
                      NOM_NORMALITZAT, 
                      DATA_DEFUNCIO, 
                      IDIOMA_ID, 
                      DATA_DARRERA, 
                      DATA_BAIXA, 
                      ID_PRIORITAT, 
                      TIPUS_SUBJECTE_ID, 
                      AMBIT_ID
               FROM Z_C03_NO_EXISTE_SUBJECTE
        ) NUEVOS
       WHERE NOT EXISTS (SELECT 1
                         FROM  Z_C04_IDSUBJECTE_SINTAGMA ANTIGUOS
                         WHERE ANTIGUOS.ID_SUBJECTE = NUEVOS.ID_SUBJECTE
                        ); 
                         
    
    COMMIT;
    END;
    
    PROCEDURE C05_EXTRAER_Subjectes_ENTITAT IS
    BEGIN    
    --SUBJECTES DE TIPO ENTITAT. Por eso tienen la constante de subjectes
     --LAS ENTIDADES TIENEN EL SEXO A NULO Y ALGUNO DE LOS 3 CAMPOS NO ESTÁ INFORMADO (LOS SUBJECTES TIENEN AL MENOS 2 INFORMADOS)   
     INSERT INTO Z_C05_SUBJ_ENTITATS_CALIMA (ID_SUBJECTE, NOM2, COGNOM_1, COGNOM_2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID, AMBIT_ID)
            SELECT (N_P) as ID_SUBJECTE, 
                    NOM2 || ' ' || COGNOM_1, 
                    NULL , 
                    COGNOM_2, 
                    ALIES, 
                    LimpiarChars(NOM2 || CogNom_1 || CogNom_2) AS NOM_NORMALITZAT,
                    RIP AS DATA_DEFUNCIO,                    
                    NULL AS IDIOMA_ID,                    
                    DATADARRERA AS DATA_DARRERA,
                    DATA_BAIXA AS DATA_BAIXA,                    
                    NULL as ID_PRIORITAT,
                    ConstSebjecteEntitat AS TIPUS_SUBJECTE_ID, 
                    ConstALCALDIA as AMBIT_ID --alcaldia
            FROM Z_TMP_CALIMA_U_EXT_PERSONES  PRINCIPAL
            WHERE  PRINCIPAL.SEXE IS NULL AND (nom2 IS NULL AND (COGNOM_1 IS NOT NULL OR COGNOM_2 IS NOT NULL))
                   AND NOT EXISTS (SELECT 1
                                    FROM Z_C10_ENTITATS_CALIMA NUEVOS 
                                    WHERE NUEVOS.ID_SUBJECTE = PRINCIPAL.N_P);  
        COMMIT;           
    END;
    
           
    PROCEDURE C10_EXTRAER_ENTITAT IS
    BEGIN    
     --LAS ENTIDADES TIENEN EL SEXO A NULO Y ALGUNO DE LOS 3 CAMPOS NO ESTÁ INFORMADO (LOS SUBJECTES TIENEN AL MENOS 2 INFORMADOS)   
     INSERT INTO Z_C10_ENTITATS_CALIMA (ID_SUBJECTE, NOM2, COGNOM_1, COGNOM_2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID, AMBIT_ID)
            SELECT N_P as ID_SUBJECTE, 
                    NOM2 || ' ' || COGNOM_1 , 
                    NULL, 
                    COGNOM_2, 
                    ALIES, 
                    LimpiarChars(NOM2 || CogNom_1 || CogNom_2) AS NOM_NORMALITZAT,
                    RIP AS DATA_DEFUNCIO,                    
                    NULL AS IDIOMA_ID,                    
                    DATADARRERA AS DATA_DARRERA,
                    DATA_BAIXA AS DATA_BAIXA,                    
                    NULL as ID_PRIORITAT,
                    ConstSebjecteEntitat AS TIPUS_SUBJECTE_ID, 
                    ConstALCALDIA as AMBIT_ID --alcaldia
            FROM Z_TMP_CALIMA_U_EXT_PERSONES  PRINCIPAL
            WHERE  PRINCIPAL.SEXE IS NULL AND (nom2 IS NULL AND (COGNOM_1 IS NOT NULL OR COGNOM_2 IS NOT NULL))
              AND NOT EXISTS (SELECT NULL
                              FROM Z_C10_ENTITATS_CALIMA NUEVOS 
                              WHERE NUEVOS.ID_SUBJECTE = PRINCIPAL.N_P
                            );  
        COMMIT;           
    END;

    PROCEDURE C10BIS_EXTRAER_ENTITAT_CONTACT IS
    BEGIN
      INSERT INTO Z_C10BIS_ENTITAT_CONTACTE_CAL
               SELECT NC AS ID_CONTACTE ,
               ORGANISME AS NOM_ENTITAT,
               LimpiarChars(ORGANISME) as NOM_NORMALITZAT,
               TO_DATE(DATADARRERA,'dd/mm/yyyy HH24:MI:SS') AS DATA_DARRERA,
               TO_DATE(DATA_BAIXA,'dd/mm/yyyy HH24:MI:SS') AS DATA_BAIXA,
               TO_DATE(DATALTA,'dd/mm/yyyy HH24:MI:SS') AS DATA_ALTA
        FROM Z_TMP_CALIMA_U_EXT_CONTACTES NUEVOS
        WHERE NOT EXISTS (SELECT 1 
                          FROM Z_C10BIS_ENTITAT_CONTACTE_CAL ANTIGUOS
                          WHERE ANTIGUOS.ID_CONTACTE = NUEVOS.NC
                         ); 
    
    COMMIT;
    END;


    PROCEDURE C11_EXISTE_ENTITAT_SUBJECTE  IS
    BEGIN
              INSERT INTO Z_C11_EXISTE_ENTITAT_SUBJECTE (SINTAGMA_ID, SINTAGMA_CODI, SINTAGMA_DESCRIPCIO, ID_SUBJECTE, NOM2, COGNOM_1, COGNOM_2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID, AMBIT_ID)
                SELECT ENTITAT.ID AS SINTAGMA_ID, 
                       ENTITAT.CODI AS SINTAGMA_CODI, 
                       ENTITAT.DESCRIPCIO AS SINTAGMA_DESCRIPCIO, 
                       PRINCIPAL.* 
                FROM Z_C10_ENTITATS_CALIMA  PRINCIPAL,
                     DM_ENTITAT ENTITAT
                WHERE PRINCIPAL.NOM_NORMALITZAT = FUNC_NORMALITZAR(ENTITAT.DESCRIPCIO)
                 AND NOT EXISTS (SELECT * 
                                 FROM Z_C11_EXISTE_ENTITAT_SUBJECTE ANTIGUOS
                                 WHERE ANTIGUOS.ID_SUBJECTE = principal.ID_SUBJECTE 
                                );
       COMMIT;           
    END;

    PROCEDURE C11BIS_EXIST_ENTITAT_CONTACTE IS
    BEGIN
    
            INSERT INTO Z_C11_EXIST_ENTITAT_CONTACTE (SINTAGMA_ID, SINTAGMA_CODI, SINTAGMA_DESCRIPCIO, ID_CONTACTE, NOM_ENTITAT, NOM_NORMALITZAT, DATA_DARRERA, DATA_BAIXA, DATA_ALTA)
                SELECT ENTITAT.ID AS SINTAGMA_ID, 
                       ENTITAT.CODI AS SINTAGMA_CODI, 
                       ENTITAT.DESCRIPCIO AS SINTAGMA_DESCRIPCIO, 
                       PRINCIPAL.* 
                FROM Z_C10BIS_ENTITAT_CONTACTE_CAL PRINCIPAL,                     
                     DM_ENTITAT ENTITAT
                WHERE PRINCIPAL.NOM_NORMALITZAT = FUNC_NORMALITZAR(ENTITAT.DESCRIPCIO)
                  AND NOT EXISTS (SELECT 1
                                  FROM Z_C11_EXIST_ENTITAT_CONTACTE ANTIGUOS
                                  WHERE ANTIGUOS.SINTAGMA_ID = ENTITAT.ID
                                 );
    
    COMMIT;
    END;

    --ENTIDADES EN SUBJECTES
   PROCEDURE C12_NO_EXISTE_ENTITAT_SUBJECTE IS
   BEGIN 
 
 
        INSERT INTO Z_C12_NO_EXISTE_ENTITAT_SUBJ (ID_ENTITAT_SINTAGMA, ID_SUBJECTE, NOM2, COGNOM_1, COGNOM_2, ALIES, NOM_NORMALITZAT, DATA_DEFUNCIO, IDIOMA_ID, DATA_DARRERA, DATA_BAIXA, ID_PRIORITAT, TIPUS_SUBJECTE_ID, AMBIT_ID)
               SELECT (SEQ_DM_ENTITAT.nextval) AS ID_ENTITAT_SINTAGMA, ENTITAT_TODOS.*
                FROM Z_C10_ENTITATS_CALIMA ENTITAT_TODOS
                     LEFT OUTER JOIN 
                        Z_C11_EXISTE_ENTITAT_SUBJECTE ENTITAT_EXISTEN
                     ON   ENTITAT_TODOS.ID_SUBJECTE = ENTITAT_EXISTEN.ID_SUBJECTE 
                WHERE ENTITAT_EXISTEN.ID_SUBJECTE IS NULL
                  AND NOT EXISTS (SELECT 1
                                  FROM Z_C12_NO_EXISTE_ENTITAT_SUBJ ANTIGUOS
                                  WHERE ANTIGUOS.ID_SUBJECTE = ENTITAT_TODOS.ID_SUBJECTE
                                 ); 

      COMMIT;
    END;
    
    --ENTIDADES DE CONTACTOS
    PROCEDURE C12BIS_NO_EXISTE_ENTITAT_CONT IS
    BEGIN 
    
        INSERT INTO Z_C12_NO_EXISTE_ENTITAT_CONT (ID_ENTITAT_SINTAGMA, ID_CONTACTE, NOM_ENTITAT, NOM_NORMALITZAT, DATA_DARRERA, DATA_BAIXA, DATA_ALTA)
           SELECT (SEQ_DM_ENTITAT.nextval) AS ID_ENTITAT_SINTAGMA, ENTITAT_TODOS.*
            FROM Z_C10BIS_ENTITAT_CONTACTE_CAL ENTITAT_TODOS
                 LEFT OUTER JOIN 
                    Z_C11_EXIST_ENTITAT_CONTACTE ENTITAT_EXISTEN
                 ON   ENTITAT_TODOS.ID_CONTACTE = ENTITAT_EXISTEN.ID_CONTACTE
            WHERE ENTITAT_EXISTEN.ID_CONTACTE IS NULL
              AND NOT EXISTS (SELECT 1
                              FROM Z_C12_NO_EXISTE_ENTITAT_CONT ANTIGUOS
                              WHERE ANTIGUOS.ID_CONTACTE = ENTITAT_TODOS.ID_CONTACTE
                             ); 
    
    COMMIT;
    END;
    
    PROCEDURE C18_ENTITATS_CALIMA IS
    BEGIN    
     INSERT INTO Z_C18_ENTITATS_CALIMA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
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
                         SELECT ID_ENTITAT_SINTAGMA AS ID,                  
                                ID_ENTITAT_SINTAGMA AS CODI, 
                                TRIM((TRIM(NOM2) || ' ' || TRIM(COGNOM_1) || ' ' || TRIM(COGNOM_2))) AS DESCRIPCIO, 
                                SYSDATE AS DATA_CREACIO,
                                NULL AS DATA_ESBORRAT,
                                NULL AS DATA_MODIFICACIO,
                                'MIGRACIO' AS USUARI_CREACIO,
                                NULL AS USUARI_ESBORRAT,
                                NULL AS USUARI_MODIFICACIO
                          FROM  Z_C12_NO_EXISTE_ENTITAT_SUBJ
                                UNION ALL
                          SELECT ID_ENTITAT_SINTAGMA AS ID, 
                                ID_ENTITAT_SINTAGMA AS CODI, 
                                NOM_ENTITAT AS DESCRIPCIO, 
                                SYSDATE AS DATA_CREACIO,
                                NULL AS DATA_ESBORRAT,
                                NULL AS DATA_MODIFICACIO,
                                'MIGRACIO' AS USUARI_CREACIO,
                                NULL AS USUARI_ESBORRAT,
                                NULL AS USUARI_MODIFICACIO
                           FROM  Z_C12_NO_EXISTE_ENTITAT_CONT 
                          ) NUEVAS
                         WHERE NOT EXISTS (SELECT 1
                                             FROM Z_C18_ENTITATS_CALIMA ANTIGUAS
                                             WHERE ANTIGUAS.ID = NUEVAS.ID
                                          );
    
    COMMIT;
    END;
        
    /* RELACION CONTACTES_ENTITATS*/    
    PROCEDURE C19_ENTITATS_CONTACTES IS
    BEGIN
    
            INSERT INTO Z_C19_CONTACTES_ENTITATS (ENTITAT_ID,CONTACTE_ID) 
                     SELECT ENTITAT_ID,
                               CONTACTE_ID
                        FROM (       
                        
                              SELECT SINTAGMA_ID AS ENTITAT_ID,
                                     ID_CONTACTE AS CONTACTE_ID
                              FROM Z_C11_EXIST_ENTITAT_CONTACTE
                                 UNION ALL
                              SELECT ID_ENTITAT_SINTAGMA AS ENTITAT_ID,
                                     ID_CONTACTE AS CONTACTE_ID
                                  FROM Z_C12_NO_EXISTE_ENTITAT_CONT
                            ) NUEVOS
                        WHERE NOT EXISTS (SELECT 1
                                          FROM Z_C19_CONTACTES_ENTITATS ANTIGUOS
                                          WHERE ANTIGUOS.ENTITAT_ID = NUEVOS.ENTITAT_ID 
                                           AND  ANTIGUOS.CONTACTE_ID = NUEVOS.CONTACTE_ID
                                         );
    
    COMMIT;
    END;
    
    
    PROCEDURE C20_DM_ENTITATS_CALIMA IS
    BEGIN
    
        INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
             SELECT ID,
                        CODI,
                        DESCRIPCIO,
                        DATA_CREACIO,
                        DATA_ESBORRAT,
                        DATA_MODIFICACIO,
                        USUARI_CREACIO,
                        USUARI_ESBORRAT,
                        USUARI_MODIFICACIO
                   FROM Z_C18_ENTITATS_CALIMA NUEVAS
                  WHERE NOT EXISTS (SELECT 1 
                                      FROM DM_ENTITAT ANTIGUAS
                                     WHERE  ANTIGUAS.ID = NUEVAS.ID
                                    );
    
    
    COMMIT;
    END;
    
    
    

    
    --Se buscan los CARREC que NO ESTÁN EN DM_CARREC y se les asigna  un nuevo ID ¿meterlos directamente en DM_CARREC)?
    --OJO DM_CARREC -> CREATE TABLE DM_CARREC AS SELECT * FROM DM_CARREC 
    PROCEDURE C21_NEW_CARREC IS
    BEGIN
            INSERT INTO DM_CARREC (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT  (SEQ_DM_CARREC.NEXTVAL) AS ID, 
                            TRIM(NEW_CARREC.CARREC)  AS DESCRIPCIO,
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MIGRACIO,
                            0,
                            'CALIMA',
                            'EXT_CONTACTES'
                    FROM (
                            SELECT Trim(calima.carrec)  AS CARREC
                            FROM Z_TMP_CALIMA_U_EXT_CONTACTES calima
                                LEFT OUTER JOIN 
                                        DM_CARREC carrec
                                on trim(calima.carrec) = trim(carrec.DESCRIPCIO)
							WHERE carrec.DESCRIPCIO IS NULL
                            GROUP BY trim(calima.carrec)					
                            ORDER BY 1
                    ) NEW_CARREC                    
                    WHERE NEW_CARREC.CARREC IS NOT NULL
                      AND NOT EXISTS (SELECT * 
                    				  FROM DM_CARREC ANTIGUOS
                    				  WHERE ANTIGUOS.DESCRIPCIO = TRIM(NEW_CARREC.CARREC)
                                     );
    
    COMMIT;
    END;
    
  
       --Se buscan los CARREC que NO ESTÁN EN DM_CARREC y se les asigna  un nuevo ID ¿meterlos directamente en DM_CARREC)?
    --OJO DM_CARREC -> CREATE TABLE DM_CARREC AS SELECT * FROM DM_CARREC 

    PROCEDURE C25_NEW_TRACTAMENT IS 
    BEGIN
            INSERT INTO DM_TRACTAMENT (ID, DESCRIPCIO, ABREUJADA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                 		SELECT  (SEQ_DM_TRACTAMENT.NEXTVAL) AS ID, 
                            NEW_TRACTAMENT.TRACTAMENT AS DESCRIPCIO,
                            NULL AS ABREUJADA,
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MIGRACIO                            
					FROM (
						SELECT Trim(calima.TRACTAMENT)  AS TRACTAMENT
						FROM Z_TMP_CALIMA_U_EXT_CONTACTES calima
						LEFT OUTER JOIN 
	  						DM_TRACTAMENT tractament
							on TRIM(calima.TRACTAMENT) = TRIM(tractament.DESCRIPCIO)
							WHERE tractament.DESCRIPCIO IS NULL
						GROUP BY trim(calima.TRACTAMENT)					
	    				ORDER BY 1
					) NEW_TRACTAMENT
                    WHERE NEW_TRACTAMENT.TRACTAMENT IS NOT NULL
                      AND NOT EXISTS (SELECT * 
                                      FROM DM_TRACTAMENT ANTIGUOS
                                      WHERE TRIM(ANTIGUOS.DESCRIPCIO) = TRIM(NEW_TRACTAMENT.TRACTAMENT)
                                     );
    
    COMMIT;
    END;
    
 

    
    -- SE DAN DE ALTA TODOS LOS CONTACTES
    --BUSCAMOS LOS CONTACTOS DE CALIMA QUE NO ESTÁN EN LA LISTA DE LOS QUE YA EXISTEN EN SINTAGMA
    PROCEDURE C30_TODOS_CONTACTES IS
    BEGIN
            INSERT INTO Z_C30_TODOS_CONTACTES (ID_CONTACTE_SINTAGMA, PRC, PART, NP, TRACTAMENT, TRACTAMENT_ID, NOM, NOM2, COGNOM_1, COGNOM_2, ALIES, DNI, IDIOMA, SEXE, DATA_NAIXE, DATA_DEFUNCIO, DATA_BAIXA, BAIXA_REGISTRE, VINC, SINTAGMA_SUBJECTE_ID, NC, SINTAGMA_CARREC_ID, CARREC, ORGANISME, DIRECCIO, POBLACIO, PROVINCIA, PAIS, CODI_POSTAL, TEL_FIX, TEL_MOBIL, TEL_FIX_CENTRALETA, TEL_ALTRES, FAX, TEL_VERMELL, DISTRICTE, EMAIL, CODI_ACTIV, ACTIVITAT, SECTOR, ADHOC, IND_NADAL, DATA_EFECTE_CARREC, DATA_DIMISSIO_CARREC, DATADARRERA, DATALTA, MOTIU, OBSERV)
               SELECT CONTACTES_TODOS.NC AS ID_CONTACTE_SINTAGMA,                
                            CONTACTES_TODOS.PRC, 
                            CONTACTES_TODOS.PART, 
                            CONTACTES_TODOS.NP, 
                            CONTACTES_TODOS.TRACTAMENT,
                            (SELECT ID FROM DM_TRACTAMENT WHERE DESCRIPCIO =  CONTACTES_TODOS.TRACTAMENT) AS TRACTAMENT_ID, 
                            CONTACTES_TODOS.NOM, 
                            CONTACTES_TODOS.NOM2, 
                            CONTACTES_TODOS.COGNOM_1, 
                            CONTACTES_TODOS.COGNOM_2, 
                            CONTACTES_TODOS.ALIES, 
                            CONTACTES_TODOS.DNI, 
                            CONTACTES_TODOS.IDIOMA, 
                            CONTACTES_TODOS.SEXE, 
                            CONTACTES_TODOS.DATA_NAIXE, 
                            CONTACTES_TODOS.DATA_DEFUNCIO, 
                            CONTACTES_TODOS.DATA_BAIXA, 
                            CONTACTES_TODOS.BAIXA_REGISTRE, 
                            CONTACTES_TODOS.VINC, 
                            NVL((SELECT SINTAGMA_ID FROM Z_C02_EXISTE_SUBJECTE_CALIMA WHERE ID_SUBJECTE = CONTACTES_TODOS.NP), CONTACTES_TODOS.NP) AS SINTAGMA_SUBJECTE_ID,                          
                            CONTACTES_TODOS.NC, 
                            (SELECT ID FROM DM_CARREC WHERE DESCRIPCIO = CONTACTES_TODOS.CARREC) AS SINTAGMA_CARREC_ID,
                            CONTACTES_TODOS.CARREC,                      
                            CONTACTES_TODOS.ORGANISME, 
                            CONTACTES_TODOS.DIRECCIO, 
                            CONTACTES_TODOS.POBLACIO, 
                            CONTACTES_TODOS.PROVINCIA, 
                            CONTACTES_TODOS.PAIS, 
                            CONTACTES_TODOS.CODI_POSTAL, 
                            CONTACTES_TODOS.TEL_FIX, 
                            CONTACTES_TODOS.TEL_MOBIL, 
                            CONTACTES_TODOS.TEL_FIX_CENTRALETA, 
                            CONTACTES_TODOS.TEL_ALTRES, 
                            CONTACTES_TODOS.FAX, 
                            CONTACTES_TODOS.TEL_VERMELL, 
                            CONTACTES_TODOS.DISTRICTE, 
                            CONTACTES_TODOS.EMAIL, 
                            CONTACTES_TODOS.CODI_ACTIV, 
                            CONTACTES_TODOS.ACTIVITAT, 
                            CONTACTES_TODOS.SECTOR, 
                            CONTACTES_TODOS.ADHOC, 
                            CONTACTES_TODOS.IND_NADAL, 
                            CONTACTES_TODOS.DATA_EFECTE_CARREC, 
                            CONTACTES_TODOS.DATA_DIMISSIO_CARREC, 
                            CONTACTES_TODOS.DATADARRERA, 
                            CONTACTES_TODOS.DATALTA, 
                            CONTACTES_TODOS.MOTIU, 
                            CONTACTES_TODOS.OBSERV
                FROM Z_TMP_CALIMA_U_EXT_CONTACTES CONTACTES_TODOS
               WHERE  DIRECCIO IS NOT NULL 
                 AND NOT EXISTS (SELECT 1 
                                  FROM Z_C30_TODOS_CONTACTES ANTIGUOS
	                                  WHERE ANTIGUOS.NC = CONTACTES_TODOS.NC
                                 );
     COMMIT;
    END;

    
    
   
   

   
   

   
   PROCEDURE C34_ADRECA_CALIMA IS   
    BEGIN
            INSERT INTO ADRECA (ID, CODI_MUNICIPI, MUNICIPI, CODI_PROVINCIA, PROVINCIA, CODI_PAIS, PAIS, CODI_CARRER, NOM_CARRER, LLETRA_INICI, LLETRA_FI, ESCALA, CODI_POSTAL, COORDENADA_X, COORDENADA_Y, SECCIO_CENSAL, ANY_CONST, NUMERO_INICI, NUMERO_FI, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, PIS, PORTA, BLOC, CODI_TIPUS_VIA, CODI_BARRI, BARRI, CODI_DISTRICTE, DISTRICTE)
					SELECT  (SEQ_ADRECA.NEXTVAL) AS ID, 
                            NULL AS CODI_MUNICIPI, 
                            NUEVOS.NEW_POBLACIO AS	MUNICIPI, 
                            NULL AS CODI_PROVINCIA, 
                            NUEVOS.NEW_PROVINCIA AS PROVINCIA, 
                            NULL AS CODI_PAIS, 
                            NUEVOS.NEW_PAIS AS PAIS, 
                            NULL AS CODI_CARRER, 
                            NVL(trim(NUEVOS.NEW_NOM_CARRER),'*')  AS NOM_CARRER,
                            NULL AS LLETRA_INICI, 
                            NULL AS LLETRA_FI, 
                            NULL AS ESCALA,
                            substr(NUEVOS.NEW_CODI_POSTAL,1,10) AS CODI_POSTAL, 
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
						FROM (
					          SELECT TRIM(NEW_ADRECA.NOM_CARRER) AS NEW_NOM_CARRER,
                                     TRIM(NEW_ADRECA.POBLACIO) AS NEW_POBLACIO,
						         	 TRIM(NEW_ADRECA.PROVINCIA) AS NEW_PROVINCIA,
						         	 TRIM(NEW_ADRECA.PAIS) AS NEW_PAIS,
						         	 TRIM(NEW_ADRECA.CODI_POSTAL) AS NEW_CODI_POSTAL
						      FROM (
                                    SELECT Trim(calima.DIRECCIO)  AS NOM_CARRER,
                                           TRIM(calima.POBLACIO) AS POBLACIO,
                                           TRIM(calima.PROVINCIA) AS PROVINCIA,
                                           TRIM(calima.PAIS) AS PAIS,
                                           TRIM(calima.CODI_POSTAL) AS CODI_POSTAL
    								FROM Z_C30_TODOS_CONTACTES calima
										LEFT OUTER JOIN 
					  						 ADRECA ADRECA
											 on FUNC_NORMALITZAR(calima.DIRECCIO) = FUNC_NORMALITZAR(ADRECA.NOM_CARRER)
                                            AND  NVL(TRIM(calima.POBLACIO),'*') = NVL(TRIM(ADRECA.PROVINCIA),'*')
                                            AND  NVL(TRIM(calima.PROVINCIA),'*') = NVL(TRIM(ADRECA.PROVINCIA),'*')
                                            AND  NVL(TRIM(calima.PAIS),'*') = NVL(TRIM(ADRECA.PAIS),'*')
                                            AND  NVL(TRIM(calima.CODI_POSTAL),'*') = NVL(TRIM(ADRECA.CODI_POSTAL),'*')
									WHERE ADRECA.NOM_CARRER IS NULL
									GROUP BY trim(calima.DIRECCIO),
                                             TRIM(calima.POBLACIO),
                                             TRIM(calima.PROVINCIA),
                                             TRIM(calima.PAIS),
                                             TRIM(calima.CODI_POSTAL)
            	    				ORDER BY 1
							 ) NEW_ADRECA
						) NUEVOS 
						WHERE NOT EXISTS (SELECT 1
						                  FROM  ADRECA ANTIGUOS
						                  WHERE  NVL(TRIM(ANTIGUOS.MUNICIPI),'*') = NVL(TRIM(NUEVOS.NEW_POBLACIO),'*')
						                    AND  NVL(TRIM(ANTIGUOS.PROVINCIA),'*')= NVL(TRIM(NUEVOS.NEW_PROVINCIA),'*')
						                    AND  NVL(ANTIGUOS.NOM_CARRER,'*')= NVL(trim(NUEVOS.NEW_NOM_CARRER),'*')
						                    AND  NVL(TRIM(ANTIGUOS.CODI_POSTAL),'*')= NVL(TRIM(substr(NUEVOS.NEW_CODI_POSTAL,1,10)),'*')
						                    AND  NVL(TRIM(ANTIGUOS.PAIS),'*')= NVL(TRIM(NUEVOS.NEW_PAIS),'*')
						                 );
                  
    COMMIT;
    END;
   
   
   
   
   PROCEDURE C35_ADRECA_CONTACTE IS
    BEGIN 
    INSERT INTO Z_C35_ADRECA_CONTACTE (ADRECA_ID, NOM_CARRER, ID_CONTACTE_SINTAGMA, DIRECCIO)
             SELECT TRIM(ADRECA.ID) AS ADRECA_ID, 
                    adreca.NOM_CARRER, 
                    Contactes.ID_CONTACTE_SINTAGMA AS ID_CONTACTE_SINTAGMA, 
                    Contactes.DIRECCIO
                FROM ADRECA ADRECA,
                     Z_C30_TODOS_CONTACTES Contactes
                WHERE TRIM(FUNC_NORMALITZAR(ADRECA.NOM_CARRER)) = TRIM(FUNC_NORMALITZAR(Contactes.DIRECCIO))                  
                  AND NOT EXISTS (SELECT 1
                                   FROM Z_C35_ADRECA_CONTACTE ANTIGUOS
                                   WHERE ANTIGUOS.ADRECA_ID  =TRIM(ADRECA.ID)
                                     AND ANTIGUOS.ID_CONTACTE_SINTAGMA = ID_CONTACTE_SINTAGMA
                                  ) ;
    
    /*
            INSERT INTO Z_C41_ADRECA_CONTACTE (ADRECA_ID, NOM_CARRER, ID_CONTACTE_SINTAGMA, DIRECCIO)
                        SELECT TRIM(ADRECA.ID) AS ADRECA_ID, adreca.NOM_CARRER, Contactes.ID_CONTACTE_SINTAGMA AS ID_CONTACTE_SINTAGMA, Contactes.DIRECCIO
                FROM ADRECA ADRECA,
                     Z_C21_CONTACTES_NOT_IN_SINTAGM Contactes
                WHERE TRIM(ADRECA.NOM_CARRER) = TRIM(Contactes.DIRECCIO)
                      AND TRIM(ADRECA.MUNICIPI) = TRIM(Contactes.POBLACIO)
                      AND TRIM( substr(ADRECA.CODI_POSTAL,1,10)) = TRIM(substr(Contactes.CODI_POSTAL,1,10))
                      AND TRIM(ADRECA.pais) = TRIM(Contactes.paiS);
                      
                      
                      
--                  AND NOT EXISTS (SELECT * 
--                  				  FROM Z_C41_ADRECA_CONTACTE ANTIGUOS
--                  				  WHERE ANTIGUOS.ADRECA_ID = ADRECA.ID
 */   
        /*
    
        INSERT INTO Z_C41_ADRECA_CONTACTE (ADRECA_ID, NOM_CARRER, ID_CONTACTE_SINTAGMA, DIRECCIO)
                        SELECT TRIM(ADRECA.ID) AS ADRECA_ID, adreca.NOM_CARRER, Contactes.ID_CONTACTE_SINTAGMA AS ID_CONTACTE_SINTAGMA, Contactes.DIRECCIO
                FROM ADRECA ADRECA,
                     Z_C21_CONTACTES_NOT_IN_SINTAGM Contactes
                WHERE TRIM(ADRECA.NOM_CARRER) = TRIM(Contactes.DIRECCIO)
                      AND TRIM(ADRECA.MUNICIPI) = TRIM(Contactes.POBLACIO)
                      AND TRIM(ADRECA.CODI_POSTAL) = TRIM(Contactes.CODI_POSTAL)
                      AND TRIM(NVL(ADRECA.pais,'*')) = TRIM(NVL(Contactes.pais,'*'));
--                  AND NOT EXISTS (SELECT * 
--                  				  FROM Z_C41_ADRECA_CONTACTE ANTIGUOS
--                  				  WHERE ANTIGUOS.ADRECA_ID = ADRECA.ID
--                                 );
*/
    COMMIT;
    END;
   
   /* Cogemos los contactos que tengan sujetos QUE EXISTAN */
   PROCEDURE C36_CONTACTE_CON_SUBJECTES IS
   BEGIN
         INSERT INTO Z_C36_CONTACTE_CON_SUBJECTES 
             SELECT  CONTACTES.ID_CONTACTE_SINTAGMA AS ID,
                (CASE WHEN PRC = 'S' THEN
                     1 
                ELSE
                     0
                END) AS ES_PRINCIPAL,
                CONTACTES.ORGANISME AS DEPARTAMENT,
                1 AS DADES_QUALITAT,
                CONTACTES.DATADARRERA AS DATA_DARRERA_ACTUALITZACIO,
                NVL(CONTACTES.DATALTA,TO_DATE('01/01/1970','dd/mm/yyyy')) AS DATA_CREACIO,                
                CONTACTES.DATA_BAIXA AS DATA_ESBORRAT,
                NULL AS DATA_MODIFICACIO,
                'MIGRACIO' AS USUARI_CREACIO,
                NULL AS USUARI_ESBORRAT,
                NULL AS USUARI_MODIFICACIO,
                (CASE WHEN SINTAGMA_CARREC_ID IS NOT NULL OR (SELECT ENTITAT_ID FROM Z_C19_CONTACTES_ENTITATS WHERE CONTACTE_ID = NC) IS NOT NULL THEN 
                           ConstProfesional
                 ELSE
                           ConstPersonal
                 END) AS TIPUS_CONTACTE_ID, 
                SINTAGMA_SUBJECTE_ID AS SUBJECTE_ID,
                (select id from adreca adreca where FUNC_NORMALITZAR(nom_carrer) = FUNC_NORMALITZAR(Direccio)
                      					           and ROWNUM = 1  ) as ADRECA_ID,      
                (SELECT ENTITAT_ID FROM Z_C19_CONTACTES_ENTITATS WHERE CONTACTE_ID = NC) AS ENTITAT_ID,
                NULL AS CONTACTE_ORIGEN_ID,
                ConstVISIBILITAT_PRIVADA AS VISIBILITAT_ID,
                ConstAMBIT_ALCALDIA AS AMBIT_ID,
                SINTAGMA_CARREC_ID AS CARREC_ID
             FROM Z_C30_TODOS_CONTACTES CONTACTES 
             WHERE  CONTACTES.NP IN (SELECT ID_Subjecte FROM Z_C04_IDSUBJECTE_SINTAGMA)
               AND NOT EXISTS (SELECT * 
                   			   FROM Z_C36_CONTACTE_CON_SUBJECTES NUEVOS
                			   WHERE NUEVOS.ID = CONTACTES.ID_CONTACTE_SINTAGMA);
             
       COMMIT;       
   END;  
   
/*   repetida con dm_entitats_calima
   PROCEDURE C40_DM_ENTITAT IS
   BEGIN
            INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                SELECT ID_ENTITAT_SINTAGMA AS ID,
                       ID_ENTITAT_SINTAGMA AS CODI,
                       TRIM(NVL(NOM2,'') || ' ' || NVL(COGNOM_1,'') || ' ' || NVL(COGNOM_2,'')) AS DESCRIPCIO,
                       NULL AS DATA_CREACIO, --NULL PORQUE YA EXISTE Y SE PONDRÁ LA NUEVA
                       NULL AS DATA_ESBORRAT,
                       DATA_DARRERA AS DATA_MODIFICACIO,
                       NULL AS USUARI_CREACIO,
                       NULL AS USUARI_ESBORRAT,
                       NULL AS USUARI_MODIFICACIO
                 FROM Z_C12_NO_EXISTE_ENTITAT_SUBJ ANTIGUOS
                 WHERE NOT EXISTS (SELECT * 
                                   FROM DM_ENTITAT NUEVOS 
                                   WHERE ANTIGUOS.ID_ENTITAT_SINTAGMA = NUEVOS.ID
                                  );
    COMMIT;
   END;
*/   

    /*Union ALL de los sujetos de tipo persona y los sujetos de tipo entitat que no existent en SINTAGMA.*/
   PROCEDURE C40_SUBJECTES_CALIMA IS
   BEGIN
        INSERT INTO Z_C40_SUBJECTES (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID)
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
                  IDIOMA_ID
        FROM (                  
                     SELECT ID_SUBJECTE_SINTAGMA AS ID,
                            NOM2 AS NOM,
                            COGNOM_1 AS COGNOM1,
                            COGNOM_2 AS COGNOM2,
                            ALIES,
                            DATA_DEFUNCIO,
                            0 AS ES_PROVISIONAL,
                            NOM_NORMALITZAT,
                            NULL AS MOTIU_BAIXA,
                            SYSDATE AS DATA_CREACIO,
                            NULL AS DATA_ESBORRAT,
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MODIFICACIO,
                            NULL AS TRACTAMENT_ID,
                            NULL as PRIORITAT_ID,
                            ConstSebjectePersona AS TIPUS_SUBJECTE_ID, 
                            ConstALCALDIA as AMBIT_ID, --alcaldia
                            NULL AS IDIOMA_ID
                    FROM    Z_C03_NO_EXISTE_SUBJECTE
         UNION
                SELECT ID_SUBJECTE AS ID, 
                            COGNOM_1 || ' ' || COGNOM_2 AS NOM,
                            NULL AS COGNOM1,
                            NOM2 AS COGNOM2,
                            ALIES,
                            DATA_DEFUNCIO,
                            0 AS ES_PROVISIONAL,
                            FUNC_NORMALITZAR(NOM2 || CogNom_1 || CogNom_2) AS NOM_NORMALITZAT,
                            NULL AS MOTIU_BAIXA,
                            SYSDATE AS DATA_CREACIO,   
                            NULL AS DATA_ESBORRAT,      
                            NULL AS DATA_MODIFICACIO,
                            'MIGRACIO' AS USUARI_CREACIO,
                            NULL AS USUARI_ESBORRAT,
                            NULL AS USUARI_MODIFICACIO,
                            NULL AS TRACTAMENT_ID,
                            NULL as PRIORITAT_ID,
                            ConstSebjecteEntitat AS TIPUS_SUBJECTE_ID, 
                            ConstALCALDIA as AMBIT_ID, --alcaldia                     
                            NULL AS IDIOMA_ID              
                    FROM Z_C05_SUBJ_ENTITATS_CALIMA           
            ) NUEVOS
            WHERE NOT EXISTS (SELECT 1 
                              FROM  Z_C40_SUBJECTES ANTIGUOS 
                              WHERE ANTIGUOS.ID = NUEVOS.ID
                             );
            
            
--            WHERE   NOT EXISTS (SELECT * 
--                                FROM SUBJECTE NUEVOS                                
--                                WHERE NUEVOS.ID = Z_C03_NO_EXISTE_SUBJECTE.ID_SUBJECTE_SINTAGMA);
   
   COMMIT;
   END;
   
   
   --en la c36 se pueden cruzar subjectes con contactes para sacar el tractamente
   --en la 37 se puede sacar el catálogo de carrec
   
   
   PROCEDURE C41_SUBJECTE IS
   BEGIN
   
    INSERT INTO SUBJECTE (ID, NOM, COGNOM1, COGNOM2, ALIES, DATA_DEFUNCIO, ES_PROVISIONAL, NOM_NORMALITZAT, MOTIU_BAIXA, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRACTAMENT_ID, PRIORITAT_ID, TIPUS_SUBJECTE_ID, AMBIT_ID, IDIOMA_ID)
          SELECT ID, 
                  NOM, 
                  COGNOM1, 
                  SUBSTR (COGNOM2,1,40),
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
                  IDIOMA_ID
        FROM Z_C40_SUBJECTES NUEVOS
        WHERE NOT EXISTS (SELECT 1 
                           FROM  SUBJECTE ANTIGUOS 
                          WHERE  ANTIGUOS.ID = NUEVOS.ID
                         );
        
   
   
   COMMIT;
   END;
 
 PROCEDURE C42_CONTACTE_CALIMA IS
    BEGIN
    INSERT INTO Z_C42_CONTACTE (ID, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID)
                SELECT ID AS ID,
                       ES_PRINCIPAL AS ES_PRINCIPAL,
                       SUBSTR(DEPARTAMENT,1,35) AS DEPARTAMENT,
                       DADES_QUALITAT AS DADES_QUALITAT,
                       TO_DATE(DATA_DARRERA_ACTUALITZACIO,'dd/mm/yyyy HH24:MI:SS') AS DATA_DARRERA_ACTUALITZACIO,
                       TO_DATE(DATA_CREACIO,'dd/mm/yyyy HH24:MI:SS') AS DATA_CREACIO,
                       (CASE WHEN DATA_ESBORRAT = 'NULL' THEN 
                                NULL
                        ELSE
                                TO_DATE(DATA_ESBORRAT,'dd/mm/yyyy HH24:MI:SS')
                        END) AS DATA_ESBORRAT,
                        (CASE WHEN DATA_MODIFICACIO='NULL' THEN
                                NULL
                        ELSE        
                                TO_DATE(DATA_MODIFICACIO,'dd/mm/yyyy HH24:MI:SS')
                        END) AS DATA_MODIFICACIO,
                        USUARI_CREACIO AS USUARI_CREACIO,
                        (CASE WHEN USUARI_ESBORRAT = 'NULL' THEN 
                                NULL
                        ELSE        
                                USUARI_ESBORRAT
                        END) AS USUARI_ESBORRAT,
                        (CASE WHEN USUARI_MODIFICACIO = 'NULL' THEN
                                NULL
                        ELSE 
                                USUARI_MODIFICACIO
                        END) AS USUARI_MODIFICACIO,                             
                        TIPUS_CONTACTE_ID AS TIPUS_CONTACTE_ID, 
                        SUBJECTE_ID AS SUBJECTE_ID, 
                        ADRECA_ID AS ADRECA_ID, 
                        ENTITAT_ID AS ENTITAT_ID, 
                        NULL AS CONTACTE_ORIGEN_ID, 
                        ConstVISIBILITAT_PRIVADA AS VISIBILITAT_ID, 
                        ConstAMBIT_ALCALDIA AS AMBIT_ID, 
                        CARREC_ID AS CARREC_ID                    
                  FROM Z_C36_CONTACTE_CON_SUBJECTES 
--                  WHERE ADRECA_ID IS NOT NULL AND SUBJECTE_ID IS NOT NULL;
                  WHERE NOT EXISTS (SELECT * 
                                    FROM Z_C42_CONTACTE NUEVOS
                                    WHERE NUEVOS.ID = Z_C36_CONTACTE_CON_SUBJECTES.ID);
   COMMIT;
   END;
    
    
    PROCEDURE C43_CONTACTE IS
    BEGIN
    INSERT INTO CONTACTE (ID, ES_PRINCIPAL, DEPARTAMENT, DADES_QUALITAT, DATA_DARRERA_ACTUALITZACIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TIPUS_CONTACTE_ID, SUBJECTE_ID, ADRECA_ID, ENTITAT_ID, CONTACTE_ORIGEN_ID, VISIBILITAT_ID, AMBIT_ID, CARREC_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL , TABLA_ORIGINAL)
                SELECT ID AS ID,
                       ES_PRINCIPAL AS ES_PRINCIPAL,
                       SUBSTR(DEPARTAMENT,1,35) AS DEPARTAMENT,
                       DADES_QUALITAT AS DADES_QUALITAT,
                       DATA_DARRERA_ACTUALITZACIO AS DATA_DARRERA_ACTUALITZACIO,
                       DATA_CREACIO AS DATA_CREACIO,
                       DATA_ESBORRAT AS DATA_ESBORRAT,
                        DATA_MODIFICACIO AS DATA_MODIFICACIO,
                        USUARI_CREACIO AS USUARI_CREACIO,
                        USUARI_ESBORRAT AS USUARI_ESBORRAT,
                        USUARI_MODIFICACIO AS USUARI_MODIFICACIO,                             
                        TIPUS_CONTACTE_ID AS TIPUS_CONTACTE_ID, 
                        SUBJECTE_ID AS SUBJECTE_ID, 
                        ADRECA_ID AS ADRECA_ID, 
                        ENTITAT_ID AS ENTITAT_ID, 
                        NULL AS CONTACTE_ORIGEN_ID, 
                        VISIBILITAT_ID AS VISIBILITAT_ID, 
                        AMBIT_ID AS AMBIT_ID, 
                        CARREC_ID AS CARREC_ID,
                        ID AS ID_ORIGINAL, 
                        'CALIMA' AS ESQUEMA_ORIGINAL , 
                        'CONTACTES' AS TABLA_ORIGINAL
                  FROM Z_C42_CONTACTE NUEVOS
--                  WHERE ADRECA_ID IS NOT NULL AND SUBJECTE_ID IS NOT NULL;
                  WHERE NOT EXISTS (SELECT * 
                                    FROM CONTACTE ANTIGUOS
                                    WHERE ANTIGUOS.ID = NUEVOS.ID
                                   );
   COMMIT;
   END;
  
   
   PROCEDURE C50_CORREUS_CONTACTES IS
            BEGIN
            
            INSERT INTO Z_C50_CORREUS_CONTACTES
                SELECT aux.ID_CONTACTE_SINTAGMA, aux.email
                FROM(                                                                         
                     select distinct  t.ID_CONTACTE_SINTAGMA,trim(regexp_substr(t.email, '[^;]+', 1, levels.column_value))  as email
                    from 
                        (SELECT ID_CONTACTE_SINTAGMA, email 
                         FROM Z_C30_TODOS_CONTACTES 
                         WHERE email IS NOT NULL AND email LIKE '%@%' and
                              DIRECCIO IS NOT NULL
                            AND NP IN (SELECT ID_Subjecte FROM Z_C04_IDSUBJECTE_SINTAGMA)
                        ) t,
                    table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(t.EMAIL, '[^;]+'))  + 1) as sys.OdciNumberList)) levels
                    order by ID_CONTACTE_SINTAGMA
                 ) aux
                 WHERE TRIM(aux.email) is not null;
--                   AND NOT EXISTS (SELECT * 
--                                  FROM Z_C50_CORREUS_CONTACTES NUEVOS
--                                  WHERE NUEVOS.ID_CONTACTE_SINTAGMA = AUX.ID_CONTACTE_SINTAGMA
--                                    AND NUEVOS.EMAIL = AUX.EMAIL);
                
            COMMIT;   
            
   END;
   
   
    PROCEDURE C51_CORREUS_PRINCIPALES IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT ID_CONTACTE_SINTAGMA, EMAIL FROM  Z_C50_CORREUS_CONTACTES ORDER BY ID_CONTACTE_SINTAGMA
        )
        LOOP
            
            IF c.ID_CONTACTE_SINTAGMA <> id_contacte_ant THEN
              id_contacte_ant:= c.ID_CONTACTE_SINTAGMA;
              INSERT INTO Z_C51_CORREUS_PRINCIPALES VALUES (c.ID_CONTACTE_SINTAGMA, c.email, 1);
            ELSE
              INSERT INTO Z_C51_CORREUS_PRINCIPALES VALUES (c.ID_CONTACTE_SINTAGMA, c.email, 0);           
            END IF;

        END LOOP;
        
        COMMIT;            
        
        END;
                
        
        PROCEDURE C52_CORREOS_CONTACTOS IS   
        
        BEGIN
         
           INSERT INTO  CONTACTE_CORREU (ID, CORREU_ELECTRONIC, ES_PRINCIPAL, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CONTACTE_ID)
                SELECT (SEQ_CONTACTE_CORREU.NEXTVAL) AS ID,
		                NUEVOS.correu AS CORREU_ELECTRONIC, 
		                NUEVOS.principal ES_PRINCIPAL, 
		                sysdate AS DATA_CREACIO, 
                        NULL AS DATA_ESBORRAT,
                        NULL AS DATA_MODIFICACIO,
		                'MIGRACIO' AS USUARI_CREACIO,
                        NULL AS USUARI_ESBORRAT,
                        NULL AS USUARI_MODIFICACIO,
		                NUEVOS.id_contacte AS CONTACTE_ID
                 FROM Z_C51_CORREUS_PRINCIPALES NUEVOS
                 WHERE NOT EXISTS(SELECT 1 
                                  FROM CONTACTE_CORREU  ANTIGUOS
                                  WHERE ANTIGUOS.id = NUEVOS.id_contacte
                                 );
                 
            COMMIT;
       -- MIRAR PORQUE HAY CONTACTOS QUE NO EXISTEN EN ORIGEN y SI EN Z_C51_CORREUS_PRINCIPALES
        
        END;  
   
       
          PROCEDURE C55_TELEFONS_NUMERICS is 
            BEGIN           
            
             INSERT INTO Z_C55_TELEFONS_NUMERICS
               SELECT ID_CONTACTE_SINTAGMA, 
                      TIPUS_TELEFON, 
                      TELEFON
                FROM (      
                         SELECT ID_CONTACTE_SINTAGMA,
                               CASE WHEN SUBSTR(TRIM(TEL_FIX),1,1)= '6' AND LENGTH(TRIM(REPLACE(TEL_FIX,' ','')))= 9 THEN 2
                                ELSE 1 
                               END AS TIPUS_TELEFON,
                               REPLACE(REPLACE(REPLACE(TRIM(TEL_FIX),'-',''),' ',''),'.','') AS TELEFON
                        FROM Z_C30_TODOS_CONTACTES C
                        WHERE TRIM(TEL_FIX) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TEL_FIX, ' +-.0123456789', ' '))) IS NULL AND TRIM(TEL_FIX) <> '.'
                          and c.DIRECCIO IS NOT NULL
                          AND c.NP IN (SELECT ID_Subjecte FROM Z_C04_IDSUBJECTE_SINTAGMA)
                                    
                     ) NUEVOS   
                 WHERE NOT EXISTS (SELECT 1
                                   FROM CONTACTE ANTIGUOS
                                   WHERE ANTIGUOS.ID = NUEVOS.ID_CONTACTE_SINTAGMA
                                  ); 
             
            
             INSERT INTO Z_C55_TELEFONS_NUMERICS (ID_CONTACTE_SINTAGMA, TIPUS_TELEFON, TELEFON)
                SELECT ID_CONTACTE_SINTAGMA, 
                      TIPUS_TELEFON, 
                      TELEFON
                FROM (
                         SELECT ID_CONTACTE_SINTAGMA,
                               CASE WHEN SUBSTR(TRIM(TEL_FIX_CENTRALETA),1,1)= '6' AND LENGTH(TRIM(REPLACE(TEL_FIX_CENTRALETA,' ','')))= 9 THEN 2
                                ELSE 1 
                               END AS TIPUS_TELEFON,
                               REPLACE(REPLACE(REPLACE(TRIM(TEL_FIX_CENTRALETA),'-',''),' ',''),'.','') AS TELEFON
                        FROM Z_C30_TODOS_CONTACTES C
                        WHERE TRIM(TEL_FIX_CENTRALETA) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TEL_FIX_CENTRALETA, ' +-.0123456789', ' '))) IS NULL AND TRIM(TEL_FIX_CENTRALETA) <> '.'
                          and c.DIRECCIO IS NOT NULL
                          AND c.NP IN (SELECT ID_Subjecte FROM Z_C04_IDSUBJECTE_SINTAGMA)
                     ) NUEVOS
                WHERE NOT EXISTS (SELECT 1
                                  FROM CONTACTE ANTIGUOS
                                  WHERE ANTIGUOS.ID = NUEVOS.ID_CONTACTE_SINTAGMA
                                 ); 
              
              COMMIT;                      
            
                INSERT INTO Z_C55_TELEFONS_NUMERICS (ID_CONTACTE_SINTAGMA, TIPUS_TELEFON, TELEFON)
                 SELECT ID_CONTACTE_SINTAGMA, 
                      TIPUS_TELEFON, 
                      TELEFON
                  FROM (
                         SELECT ID_CONTACTE_SINTAGMA,
                               CASE WHEN SUBSTR(TRIM(TEL_MOBIL),1,1)= '6' AND LENGTH(TRIM(REPLACE(TEL_MOBIL,' ','')))= 9 THEN 2
                                ELSE 1 
                               END AS TIPUS_TELEFON,
                               REPLACE(REPLACE(REPLACE(TRIM(TEL_MOBIL),'-',''),' ',''),'.','') AS TELEFON
                        FROM Z_C30_TODOS_CONTACTES C
                        WHERE TRIM(TEL_MOBIL) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TEL_MOBIL, ' +-.0123456789', ' '))) IS NULL AND TRIM(TEL_MOBIL) <> '.'
                          AND c.DIRECCIO IS NOT NULL
                          AND c.NP IN (SELECT ID_Subjecte FROM Z_C04_IDSUBJECTE_SINTAGMA)
                        ) NUEVOS
                  WHERE NOT EXISTS (SELECT 1
                                    FROM CONTACTE ANTIGUOS
                                    WHERE ANTIGUOS.ID = NUEVOS.ID_CONTACTE_SINTAGMA
                                   );                           

                 INSERT INTO Z_C55_TELEFONS_NUMERICS  (ID_CONTACTE_SINTAGMA, TIPUS_TELEFON, TELEFON)
                   SELECT ID_CONTACTE_SINTAGMA, 
                      TIPUS_TELEFON, 
                      TELEFON
                  FROM (
                         SELECT ID_CONTACTE_SINTAGMA,
                               CASE WHEN SUBSTR(TRIM(FAX),1,1)= '6' AND LENGTH(TRIM(REPLACE(FAX,' ','')))= 9 THEN 2
                                ELSE 1 
                               END AS TIPUS_TELEFON,
                               REPLACE(REPLACE(REPLACE(TRIM(FAX),'-',''),' ',''),'.','') AS TELEFON
                        FROM Z_C30_TODOS_CONTACTES C
                        WHERE TRIM(FAX) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(FAX, ' +-.0123456789', ' '))) IS NULL AND TRIM(FAX) <> '.'
                          AND c.DIRECCIO IS NOT NULL
                          AND c.NP IN (SELECT ID_Subjecte FROM Z_C04_IDSUBJECTE_SINTAGMA)
                      ) NUEVOS
                 WHERE NOT EXISTS (SELECT 1
                                   FROM CONTACTE ANTIGUOS
                                   WHERE ANTIGUOS.ID = NUEVOS.ID_CONTACTE_SINTAGMA
                                  );                           
                          
                             
                INSERT INTO Z_C55_TELEFONS_NUMERICS (ID_CONTACTE_SINTAGMA, TIPUS_TELEFON, TELEFON)
                 SELECT ID_CONTACTE_SINTAGMA,
                        CASE WHEN SUBSTR(TRIM(TEL_ALTRES),1,1)= '6' AND LENGTH(TRIM(REPLACE(TEL_ALTRES,' ','')))= 9 THEN 2
                             ELSE 1 
                       END AS TIPUS_TELEFON,
                       REPLACE(REPLACE(REPLACE(TRIM(TEL_ALTRES),'-',''),' ',''),'.','') AS TELEFON
                FROM Z_C30_TODOS_CONTACTES C
                WHERE TRIM(TEL_ALTRES) IS NOT NULL AND LENGTH(TRIM(TRANSLATE(TEL_ALTRES, ' +-.0123456789', ' '))) IS NULL AND TRIM(TEL_ALTRES) <> '.'
                  and c.DIRECCIO IS NOT NULL
                  AND c.NP IN (SELECT ID_Subjecte FROM Z_C04_IDSUBJECTE_SINTAGMA)
                  AND NOT EXISTS (SELECT 1 
                                  FROM Z_C55_TELEFONS_NUMERICS NUEVOS  
                                  WHERE C.ID_CONTACTE_SINTAGMA = NUEVOS.ID_CONTACTE_SINTAGMA 
                                    AND REPLACE(REPLACE(REPLACE(TRIM(C.TEL_ALTRES),'-',''),' ',''),'.','') = NUEVOS.TELEFON
                                 );
            
           COMMIT;
           
          END;


      PROCEDURE C56_TELEFON_PRINCIPAL IS
        
        id_contacte_ant number;
            
        BEGIN
          
        id_contacte_ant:=0;
          
        FOR c IN (
            SELECT ID_CONTACTE_SINTAGMA, 
                   TIPUS_TELEFON, 
                   TELEFON
              FROM  Z_C55_TELEFONS_NUMERICS NUEVOS
             WHERE NOT EXISTS (SELECT 1 
                               FROM Z_C56_TELEFONS_NUMERICS ANTIGUOS
                               WHERE NUEVOS.ID_CONTACTE_SINTAGMA = ANTIGUOS.ID_CONTACTE
                                 AND NUEVOS.TELEFON = ANTIGUOS.TELEFON
                                 AND NUEVOS.TIPUS_TELEFON = ANTIGUOS.TIPUS_TELEFON
                              )                                   
           ORDER BY ID_CONTACTE_SINTAGMA
        )
        LOOP
            
            IF c.ID_CONTACTE_SINTAGMA <> id_contacte_ant THEN
              id_contacte_ant:= c.ID_CONTACTE_SINTAGMA;
              INSERT INTO Z_C56_TELEFONS_NUMERICS VALUES (c.ID_CONTACTE_SINTAGMA, c.tipus_telefon,c.telefon, 1);
            ELSE
              INSERT INTO Z_C56_TELEFONS_NUMERICS VALUES (c.ID_CONTACTE_SINTAGMA, c.tipus_telefon,c.telefon, 0);           
            END IF;

        END LOOP;
        
        COMMIT;       
      
      END;


      PROCEDURE C57_CONTACTE_TELEFON is 
           
      BEGIN
        
           INSERT INTO CONTACTE_TELEFON (ID, NUMERO, ES_PRINCIPAL, DATA_CREACIO, USUARI_CREACIO, CONTACTE_ID, TIPUS_TELEFON_ID)
                    SELECT (SEQ_CONTACTE_TELEFON.NEXTVAL), 
                           NUEVOS.telefon, 
                           NUEVOS.principal, 
                           sysdate, 
                           'MIGRACIO', 
                           NUEVOS.id_contacte, 
                           NUEVOS.tipus_telefon
            FROM Z_C56_TELEFONS_NUMERICS NUEVOS
            WHERE EXISTS(SELECT * FROM CONTACTE WHERE ID = NUEVOS.id_contacte) 
                  AND NUEVOS.TELEFON IS NOT NULL   
                  AND NOT EXISTS(SELECT * 
                                 FROM CONTACTE_TELEFON ANTIGUOS
                                 WHERE ANTIGUOS.numero = NUEVOS.telefon 
                                   AND ANTIGUOS.TIPUS_TELEFON_ID = NUEVOS.tipus_telefon
                                   AND ANTIGUOS.contacte_id = NUEVOS.id_contacte
                                ) ;

       COMMIT;

      END;
       
       
   
   
   --Obtengo LAS Entidades (QUE NO ESTÁN REGISTRADAS EN DM_ENTITAT) únicas normalizadas de trucadas histórico y activas  y les asigno nº de secuencia. Se busca por Nom_Normalizado y se obtiene secuencia
   PROCEDURE C90_ENTITATS_TRUCADA IS
   BEGIN
  
            INSERT into Z_C90_ENTITAT_TRUCADA (ENTITAT_ID, ENTITAT, FECHA_CREACIO,ENTITAT_NORMALITZADA)                       
                SELECT SEQ_DM_ENTITAT.NEXTVAL AS ENTITAT_ID,
                        Group_Entitats.ENTITAT AS ENTITAT, 
                        SYSDATE AS Fecha_Creacio,
                        ENTITAT_NORMALITZADA AS ENTITAT_NORMALITZADA
                FROM ( 	            
                        SELECT  ENTITAT,                                 
                                FUNC_NORMALITZAR_ENTITAT(ENTITAT) AS ENTITAT_NORMALITZADA
                        FROM (
                                SELECT ORGANISME_ AS ENTITAT
                                  FROM Z_TMP_CALIMA_U_TRUC_ACTIVES 	
                                 WHERE ORGANISME_ IS NOT NULL
                                 GROUP BY ORGANISME_
                                    UNION ALL
                                SELECT ORGANISME_ AS ENTITAT
                                  FROM Z_TMP_CALIMA_U_HIST_TRUCADA
                                 WHERE ORGANISME_ IS NOT NULL
                                 GROUP BY ORGANISME_			   
                            ) Filtro
                        GROUP BY ENTITAT
                    )Group_Entitats     
                LEFT OUTER JOIN 
                    DM_ENTITAT
                    ON   FUNC_NORMALITZAR_ENTITAT(Group_Entitats.ENTITAT) = FUNC_NORMALITZAR_ENTITAT(DM_ENTITAT.DESCRIPCIO)
                WHERE DM_ENTITAT.DESCRIPCIO IS NULL
                  AND NOT EXISTS (SELECT 1 
                                  FROM Z_C90_ENTITAT_TRUCADA NUEVOS 
                                  WHERE FUNC_NORMALITZAR_ENTITAT(NUEVOS.ENTITAT) = FUNC_NORMALITZAR_ENTITAT(Group_Entitats.ENTITAT)
                                 );   
        COMMIT;         
   END;
   
   -- Las entidades de Histórico buscan en C90 y se inserta en DM_Entitat con el ID de C90 y la descripción de Histórico
   -- Posteriormente se hace lo mismo con las activas. 
   -- Nota : se inserta primero las de histórico ya que llevan más tiempo registradas y se supone (es histórico)
   
   
  PROCEDURE C91_DM_ENTITATS_TRUCADAS IS
   BEGIN
          INSERT INTO DM_ENTITAT (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
           SELECT C90.ENTITAT_ID AS ID, 
	                   C90.ENTITAT_ID AS CODI, 
	                   C90.ENTITAT AS DESCRIPCIO,
	                   SYSDATE AS DATA_CREACIO,
	                   NULL AS DATA_ESBORRAT,
	                   NULL AS DATA_MODIFICACIO,
	                   'MIGRACIO' AS USUARI_CREACIO,
	                   NULL AS USUARI_ESBORRAT,
	                   NULL AS USUARI_MODIFICACIO,
                       C90.ENTITAT_ID AS ID_ORIGINAL,
                       'CALIMA' AS ESQUEMA_ORIGINAL,
                       'TRUC_ACTIVES // HIST_TRUCADA' AS TABLA_ORIGINAL
	            FROM Z_C90_ENTITAT_TRUCADA C90;
                
   
   
   /*
        INSERT INTO DM_ENTITAT
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
	           SELECT C90.ENTITAT_ID AS ID, 
	                   C90.ENTITAT_ID AS CODI, 
	                   HIST.ORGANISME_ AS DESCRIPCIO,
	                   c90.FECHA_CREACIO AS DATA_CREACIO,
	                   NULL AS DATA_ESBORRAT,
	                   NULL AS DATA_MODIFICACIO,
	                   'MIGRACIO' AS USUARI_CREACIO,
	                   NULL AS USUARI_ESBORRAT,
	                   NULL AS USUARI_MODIFICACIO
	            FROM Z_TMP_CALIMA_U_HIST_TRUCADA HIST,
	                 Z_C90_ENTITAT_TRUCADA C90
	            WHERE C90.ENTITAT = ORGANISME_
	            	UNION ALL
	            SELECT C90.ENTITAT_ID AS ID, 
	                   C90.ENTITAT_ID AS CODI, 
	                   TRUC.ORGANISME_ AS DESCRIPCIO,
	                   c90.FECHA_CREACIO AS DATA_CREACIO,
	                   NULL AS DATA_ESBORRAT,
	                   NULL AS DATA_MODIFICACIO,
	                   'MIGRACIO' AS USUARI_CREACIO,
	                   NULL AS USUARI_ESBORRAT,
	                   NULL AS USUARI_MODIFICACIO
	            FROM Z_TMP_CALIMA_U_TRUC_ACTIVES TRUC,
	                 Z_C90_ENTITAT_TRUCADA C90
	            WHERE C90.ENTITAT = ORGANISME_	            
            ) TABLA_FINAL            
        WHERE NOT EXISTS (SELECT 1
                              FROM  DM_ENTITAT ANTIGUOS  
                              WHERE TABLA_FINAL.DESCRIPCIO = ANTIGUOS.DESCRIPCIO
                             )           
        GROUP BY ID,CODI,DESCRIPCIO, DATA_CREACIO,DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO;
*/
    COMMIT;
   END;
   
   PROCEDURE C92_TRUCADA_DESTINATARI IS
   BEGIN
   
    
   
        INSERT INTO Z_C92_TRUCADA_DESTINATARI
            SELECT SEQ_DM_DESTINATARI_PERSONA.NEXTVAL AS DESTINATARI_ID, 
                    Group_Destinataris.Destinatari AS Destinatari, 
                    Group_Destinataris.Fecha_Creacio
            FROM ( 	
            
	            SELECT  Destinatari, 
                        MIN(Fecha_Creacio) AS Fecha_Creacio
	            FROM (
	                    SELECT QUI AS Destinatari, min(TO_DATE(DARRERA_INTERV,'dd/mm/yyyy HH24:MI:SS')) AS Fecha_Creacio 
	                    FROM Z_TMP_CALIMA_U_TRUC_ACTIVES 	
	                    WHERE QUI IS NOT NULL
	                    GROUP BY QUI
	                        UNION
	                    SELECT QUI AS Destinatari,min(TO_DATE(DARRERA_INTERV,'dd/mm/yyyy HH24:MI:SS')) AS Fecha_Creacio	    
	                    FROM Z_TMP_CALIMA_U_HIST_TRUCADA
	                    WHERE QUI IS NOT NULL
	                    GROUP BY QUI			   
	                ) Filtro1
				GROUP BY Destinatari
            )Group_Destinataris     
         WHERE NOT EXISTS (SELECT 1 
                           FROM Z_C92_TRUCADA_DESTINATARI ANTIGUOS
                           WHERE ANTIGUOS.Destinatari = Group_Destinataris.Destinatari
                            AND ANTIGUOS.Fecha_Creacio = Group_Destinataris.Fecha_Creacio
                          );  
                           
--            LEFT OUTER JOIN 
--                DM_DESTINATARI_PERSONA
--                ON   Group_Destinataris.Destinatari = DM_DESTINATARI_PERSONA.DESCRIPCIO 
--            WHERE DM_DESTINATARI_PERSONA.DESCRIPCIO IS NULL;


--              AND NOT EXISTS (SELECT NULL
--                              FROM Z_C92_TRUCADA_DESTINATARI ANTIGUOS 
--                              WHERE Group_Destinataris.Destinatari = ANTIGUOS.Destinatari
--                            );
   
   COMMIT;
   END;
   
   PROCEDURE C93_INSERTAR_DM_DESTINATARI IS
   BEGIN
        INSERT INTO DM_DESTINATARI_PERSONA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                SELECT ID,                    
                   DESCRIPCIO,                   
                   DATA_CREACIO,
                   DATA_ESBORRAT,
                   DATA_MODIFICACIO,
                   USUARI_CREACIO,
                   USUARI_ESBORRAT,
                   USUARI_MODIFICACIO,
                   ID AS ID_ORIGINAL,
                   'CALIMA' AS ESQUEMA_ORIGINAL,
                   'HIST_TRUCADA' AS TABLA_ORIGINAL
                FROM (           
                    SELECT C92.DESTINATARI_ID AS ID,
                       HIST.QUI AS CODI,
	                   HIST.QUI AS DESCRIPCIO,
	                   c92.FECHA_CREACIO AS DATA_CREACIO,
	                   NULL AS DATA_ESBORRAT,
	                   NULL AS DATA_MODIFICACIO,
	                   'MIGRACIO' AS USUARI_CREACIO,
	                   NULL AS USUARI_ESBORRAT,
	                   NULL AS USUARI_MODIFICACIO
                    FROM Z_TMP_CALIMA_U_HIST_TRUCADA HIST,
                         Z_C92_TRUCADA_DESTINATARI C92
                    WHERE C92.DESTINATARI = QUI
                        UNION
                    SELECT C92.DESTINATARI_ID AS ID, 
                       TRUC.QUI AS CODI,
	                   TRUC.QUI AS DESCRIPCIO,
	                   C92.FECHA_CREACIO AS DATA_CREACIO,
	                   NULL AS DATA_ESBORRAT,
	                   NULL AS DATA_MODIFICACIO,
	                   'MIGRACIO' AS USUARI_CREACIO,
	                   NULL AS USUARI_ESBORRAT,
	                   NULL AS USUARI_MODIFICACIO
                    FROM Z_TMP_CALIMA_U_TRUC_ACTIVES TRUC,
                         Z_C92_TRUCADA_DESTINATARI C92
                    WHERE C92.DESTINATARI = QUI	            
                ) TABLA_FINAL
                WHERE NOT EXISTS ( SELECT NULL
                                     FROM  DM_DESTINATARI_PERSONA ANTIGUOS  
                                    WHERE TABLA_FINAL.ID = ANTIGUOS.ID
                                 );
--               GROUP BY ID,DESCRIPCIO, DATA_CREACIO,DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO;
   COMMIT;
   END;
   
          
   PROCEDURE C95_TRUCADAS_ACTIVES_CALIMA IS
   BEGIN
      INSERT INTO Z_C95_TRUCADAS_ACTIVES_CALIMA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID)
          SELECT N AS ID,
                 TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_REGISTRE,
                 NULL AS DATA_RESOLUCIO,
                (CASE WHEN TRIM(SUBSTR(NOM, LENGTH(NOM)-2)) = ',' THEN    --SI EL FINAL ES UNA COMA QUIERE DECIR QUE NO HAY APELLIDOS Y LO PRIMERO ES EL NOMBRE
                    trim(SUBSTR(NOM,1, INSTR(LOWER(NOM),',')-1)) --EN LA PARTE DE LOS APELLIDOS ESTÁ EL NOMBRE (SI LO ÚLTIMO ES ','
                 ELSE
                    TRIM(SUBSTR(NOM, INSTR(NOM,',')+1)) -- COGEMOS LO QUE VA DESPÙÉS DE LA COMA
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
                 NULL AS TELEFON_SECUNDARI,
                 ASSUMPTE AS DESCRIPCIO,
                 TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_CREACIO,
                 NULL AS DATA_ESBORRAT,
                 NULL AS DATA_MODIFICACIO,
                 USUARI_MODIFICACIO AS USUARI_CREACIO,
                 NULL AS USUARI_ESBORRAT,        
                 USUARI_MODIFICACIO AS USUARI_MODIFICACIO,
                 (SELECT ENTITAT_ID FROM Z_C90_ENTITAT_TRUCADA WHERE ENTITAT = ORGANISME_) AS ENTITAT_ID,
                  (CASE WHEN ESTAT='PAS' THEN 
                      ConstTRUCADAPAS
                    WHEN ESTAT='PEN' THEN   
                      ConstTRUECADAPEN
                    ELSE     
                      3
                END) AS ESTAT_TRUCADA_ID,     
                (SELECT ID FROM DM_DESTINATARI_PERSONA WHERE DESCRIPCIO= QUI) AS DESTINATARI_PERSONA_ID,
                NULL AS CONTACTE_ID,
                (CASE WHEN E_S='E' THEN 
                    ConstENTRADA
                 ELSE 
                    ConstSALIDA
                END) AS SENTIT_ID
               FROM Z_TMP_CALIMA_U_TRUC_ACTIVES NUEVOS
       WHERE NOT EXISTS (SELECT NULL
                              FROM Z_C95_TRUCADAS_ACTIVES_CALIMA ANTIGUOS 
                              WHERE NUEVOS.N = ANTIGUOS.ID
                        );
   
   COMMIT;
   END;
   
   PROCEDURE C96_TRUCADAS_HISTORIC_CALIMA IS
   BEGIN
   
        INSERT INTO Z_C96_TRUCADAS_HISTORIC_CALIMA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID)
                 SELECT N AS ID,
                        TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_REGISTRE,
                        TO_DATE(DARRERA_INTERV,'dd/mm/yyyy HH24:MI:SS') AS DATA_RESOLUCIO,
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
                        NVL(SUBSTR(TEL_CONTACTAT,1,40),'*') AS TELEFON,
                        NVL(SUBSTR(TEL_FIX_ALTRES,1,40),'*') AS TELEFON_SECUNDARI,
                        ASSUMPTE AS DESCRIPCIO,
                        TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_CREACIO,
                        NULL AS DATA_ESBORRAT,
                        NULL AS DATA_MODIFICACIO,
                        'MIGRACIO' AS USUARI_CREACIO,
                        NULL AS USUARI_ESBORRAT,        
                        NULL AS USUARI_MODIFICACIO,
                        (SELECT ENTITAT_ID FROM Z_C90_ENTITAT_TRUCADA WHERE ENTITAT = ORGANISME_) AS ENTITAT_ID,
                        (CASE 
                            WHEN ESTAT='PAS' THEN 
                              ConstTRUCADAPAS
                            WHEN ESTAT='PEN' THEN   
                              ConstTRUECADAPEN
                            ELSE     
                              NULL
                        END) AS ESTAT_TRUCADA_ID,     
                       (SELECT ID FROM DM_DESTINATARI_PERSONA WHERE DESCRIPCIO= QUI) AS DESTINATARI_PERSONA_ID,
                       NULL AS CONTACTE_ID,
                       (CASE WHEN E_S='E' THEN 
                            ConstENTRADA
                        ELSE 
                            ConstSALIDA
                        END) AS SENTIT_ID
                       FROM Z_TMP_CALIMA_U_HIST_TRUCADA NUEVOS
                      WHERE NOT EXISTS (SELECT 1
                                        FROM Z_C96_TRUCADAS_HISTORIC_CALIMA ANTIGUOS 
                                        WHERE NUEVOS.N = ANTIGUOS.ID
                                       );
   
   COMMIT;
   END;
   
   PROCEDURE C97_TRUCADAS IS
   BEGIN
        INSERT INTO TRUCADA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    SELECT ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL
                    FROM (
                          SELECT ID,
                                 DATA_REGISTRE,
                                 TO_DATE(DATA_RESOLUCIO,'dd/mm/yyyy HH24:MI:SS') AS DATA_RESOLUCIO,
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
                                 ID AS ID_ORIGINAL, 
                                 'CALIMA' AS ESQUEMA_ORIGINAL, 
                                 'TRUC_ACTIVES' AS TABLA_ORIGINAL
                            FROM Z_C95_TRUCADAS_ACTIVES_CALIMA 
                                UNION ALL 
                          SELECT ID,
                                 DATA_REGISTRE,
                                 DATA_RESOLUCIO,
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
                                 ID AS ID_ORIGINAL, 
                                 'CALIMA' AS ESQUEMA_ORIGINAL, 
                                 'HIST_TRUCADA' AS TABLA_ORIGINAL
                            FROM Z_C96_TRUCADAS_HISTORIC_CALIMA 
                         ) NUEVOS
                         WHERE NOT EXISTS (SELECT 1
                                             FROM TRUCADA ANTIGUOS
                                            WHERE ANTIGUOS.ID = NUEVOS.ID
                                           ); 
   
   
   COMMIT;
   END;
   
   PROCEDURE C98_HIST_TRUCADAS IS
   BEGIN
     INSERT INTO HISTORIC_TRUCADA (ID, DESCRIPCIO, SENTIT_ID, TELEFON, DATA_REGISTRE, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRUCADA_ID, RAO_ID, ESTAT_TRUCADA_ID)
          SELECT N AS ID,
                 ASSUMPTE AS DESCRIPCIO,
                  (CASE WHEN E_S='E' THEN 
                        2
                   ELSE 
                        1
                    END) AS SENTIT_ID,
                SUBSTR(TEL_CONTACTAT,1,20) AS TELEFON,
                TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_REGISTRE,
                TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_CREACIO,
                NULL AS DATA_ESBORRAT,
                NULL AS DATA_MODIFICACIO,
                'MIGRACIO' AS USUARI_CREACIO,
                NULL AS USUARI_ESBORRAT,
                NULL AS USUARI_MODIFICACIO,
                N AS TRUCADA_ID,
                (CASE WHEN ESTAT='PAS' OR ESTAT='PEN' THEN
                   ConstRao_Altres
                ELSE
                    NULL                
                END) AS RAO_ID,
                 (CASE 
                WHEN ESTAT='PAS' THEN 
                  2
                WHEN ESTAT='PEN' THEN   
                  1
                ELSE     
                  NULL
                END) AS ESTAT_TRUCADA_ID
          FROM Z_TMP_CALIMA_U_HIST_TRUCADA NUEVOS
         WHERE ESTAT = 'PEN' OR ESTAT ='PAS'
           AND NOT EXISTS (SELECT 1
                             FROM HISTORIC_TRUCADA ANTIGUOS
                            WHERE NUEVOS.N = ANTIGUOS.ID
                          );
   
   
   
   COMMIT;
   END;
   
   
   /*
   PROCEDURE C96_TRUCADAS IS
   BEGIN
   
           INSERT INTO TRUCADA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID)
                  SELECT ID,
                         DATA_REGISTRE,
                         DATA_RESOLUCIO,
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
                         SENTIT_ID
                    FROM Z_C95_TRUCADAS_ACTIVES NUEVOS
                   WHERE NOT EXISTS (SELECT 1 
                                       FROM  TRUCADA ANTIGUOS
                                      WHERE  ANTIGUOS.ID = NUEVOS.ID
                                    );
   COMMIT;
   END;
   
   
   
   
   PROCEDURE C96_TRUCADAS_HISTORIC IS   
   BEGIN
   
   
   --A) LAS DEL HISTÓRICO HAY QUE METERLAS EN TRUCADAS
  INSERT INTO TRUCADA (ID, DATA_REGISTRE, DATA_RESOLUCIO, NOM, COGNOM1, COGNOM2, CARREC, TELEFON, TELEFON_SECUNDARI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ENTITAT_ID, ESTAT_TRUCADA_ID, DESTINATARI_PERSONA_ID, CONTACTE_ID, SENTIT_ID)
         SELECT N AS ID,
                TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_REGISTRE,
                TO_DATE(DARRERA_INTERV,'dd/mm/yyyy HH24:MI:SS') AS DATA_RESOLUCIO,
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
                NVL(SUBSTR(TEL_CONTACTAT,1,40),'*') AS TELEFON,
                NVL(SUBSTR(TEL_FIX_ALTRES,1,40),'*') AS TELEFON_SECUNDARI,
                ASSUMPTE AS DESCRIPCIO,
                TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_CREACIO,
                NULL AS DATA_ESBORRAT,
                NULL AS DATA_MODIFICACIO,
                'MIGRACIO' AS USUARI_CREACIO,
                NULL AS USUARI_ESBORRAT,        
                NULL AS USUARI_MODIFICACIO,
                (SELECT ENTITAT_ID FROM Z_C90_ENTITAT_TRUCADA WHERE ENTITAT = ORGANISME_) AS ENTITAT_ID,
                (CASE 
                    WHEN ESTAT='PAS' THEN 
                      ConstTRUCADAPAS
                    WHEN ESTAT='PEN' THEN   
                      ConstTRUECADAPEN
                    ELSE     
                      NULL
                END) AS ESTAT_TRUCADA_ID,     
               (SELECT ID FROM DM_DESTINATARI_PERSONA WHERE DESCRIPCIO= QUI) AS DESTINATARI_PERSONA_ID,
               NULL AS CONTACTE_ID,
               (CASE WHEN E_S='E' THEN 
                    ConstENTRADA
                ELSE 
                    ConstSALIDA
                END) AS SENTIT_ID
               FROM Z_TMP_CALIMA_U_HIST_TRUCADA NUEVOS
              WHERE NOT EXISTS (SELECT 1
                                FROM TRUCADA ANTIGUOS 
                                WHERE NUEVOS.N = ANTIGUOS.ID
                               );
   
   
   
   
   --B) MIGRAMOS A LA TABLA DE HISTORICO
        INSERT INTO HISTORIC_TRUCADA (ID, DESCRIPCIO, SENTIT_ID, TELEFON, DATA_REGISTRE, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, TRUCADA_ID, RAO_ID, ESTAT_TRUCADA_ID)
          SELECT N AS ID,
                 ASSUMPTE AS DESCRIPCIO,
                  (CASE WHEN E_S='E' THEN 
                        2
                   ELSE 
                        1
                    END) AS SENTIT_ID,
                SUBSTR(TEL_CONTACTAT,1,20) AS TELEFON,
                TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_REGISTRE,
                TO_DATE(REGISTRE,'dd/mm/yyyy HH24:MI:SS') AS DATA_CREACIO,
                NULL AS DATA_ESBORRAT,
                NULL AS DATA_MODIFICACIO,
                'MIGRACIO' AS USUARI_CREACIO,
                NULL AS USUARI_ESBORRAT,
                NULL AS USUARI_MODIFICACIO,
                N AS TRUCADA_ID,
                NULL AS RAO_ID,
                 (CASE 
                WHEN ESTAT='PAS' THEN 
                  2
                WHEN ESTAT='PEN' THEN   
                  1
                ELSE     
                  NULL
                END) AS ESTAT_TRUCADA_ID
          FROM Z_TMP_CALIMA_U_HIST_TRUCADA NUEVOS
         WHERE ESTAT = 'PEN' OR ESTAT ='PAS'
           AND NOT EXISTS (SELECT 1
                             FROM HISTORIC_TRUCADA ANTIGUOS
                            WHERE NUEVOS.N = ANTIGUOS.ID
                          );
    

   COMMIT;     
   END;     
   */
   --ADRECA

    /* BORRAMOS LOS DATOS DE TODAS LAS TABLAS */
    PROCEDURE RESETEATOR_TABLAS IS
    BEGIN

        DELETE FROM Z_C96_TRUCADAS_HISTORIC_CALIMA;
        DELETE FROM Z_C95_TRUCADAS_ACTIVES_CALIMA;
        DELETE FROM Z_C92_TRUCADA_DESTINATARI;        
        

        DELETE FROM Z_C90_ENTITAT_TRUCADA;
        
        DELETE FROM Z_C56_TELEFONS_NUMERICS;
        DELETE FROM Z_C55_TELEFONS_NUMERICS;
        

        DELETE FROM Z_C51_CORREUS_PRINCIPALES;
        DELETE FROM Z_C50_CORREUS_CONTACTES;
    
        
        DELETE FROM Z_C42_CONTACTE;
        DELETE FROM Z_C40_SUBJECTES;
        
    
        DELETE FROM Z_C36_CONTACTE_CON_SUBJECTES ;   --C35_INSERT_CONTACTE_NO_EXIST 

        DELETE FROM Z_C35_ADRECA_CONTACTE;


        DELETE FROM Z_C30_TODOS_CONTACTES; --C30_TODOS_CONTACTES        
        
--        DELETE FROM Z_C21_CONTACTES_NOT_IN_SINTAGM;
--        DELETE FROM Z_C20_CONTACTES_EXIST_SINTAGMA;
        DELETE FROM Z_C19_CONTACTES_ENTITATS;
        DELETE FROM Z_C18_ENTITATS_CALIMA;
        
        DELETE FROM Z_C12_NO_EXISTE_ENTITAT_CONT;
        DELETE FROM Z_C11_EXIST_ENTITAT_CONTACTE;
        DELETE FROM Z_C10BIS_ENTITAT_CONTACTE_CAL;

        DELETE FROM Z_C12_NO_EXISTE_ENTITAT_SUBJ;
        DELETE FROM Z_C11_EXISTE_ENTITAT_SUBJECTE;
        DELETE FROM Z_C10_ENTITATS_CALIMA;

        
        
        DELETE FROM Z_C05_SUBJ_ENTITATS_CALIMA;
        DELETE FROM Z_C04_IDSUBJECTE_SINTAGMA;
        DELETE FROM Z_C03_NO_EXISTE_SUBJECTE;
        DELETE FROM Z_C02_EXISTE_SUBJECTE_CALIMA;
        DELETE FROM Z_C01_SUBJECTE_CALIMA;   
        
        DELETE FROM DM_ESTAT_TRUCADA;
        DELETE FROM DM_RAO;
        
        
        
    END;

END A_02_CALIMA_CONTACTES_SINTAGMA;

/
