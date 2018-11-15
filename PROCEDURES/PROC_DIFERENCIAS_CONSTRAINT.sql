--------------------------------------------------------
--  DDL for Procedure PROC_DIFERENCIAS_CONSTRAINT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."PROC_DIFERENCIAS_CONSTRAINT" AS 
            V_TablasSINTAGMA VARCHAR2(4000);            
            SQL_AUX VARCHAR2(4000);            
            total 						integer;      
            prefijo varchar2(3);
BEGIN
    V_TablasSINTAGMA := 'ACCIO''' || ',' || '''ACOMPANYANT''' || ',' || '''ACTE''' || ',' || '''ADRECA''' || ',' || '''AGENDA_DELEGACIO''' || ',' || '''ANNEX_ACTE''' || ',' || '''ANNEX_ASPECTE''' || ',' || '''ANNEX_REGISTRE''' || ',' || '''ASPECTE''' || ',' || '''CLASSIFICACIO_ARXIU''' || ',' || '''COMANDA''' || ',' || '''COMENTARI''' || ',' || '''CONTACTE''' || ',' || '''CONTACTE_CLASSIFICACIO''' || ',' || '''CONTACTE_CONSENTIMENT''' || ',' || '''CONTACTE_CORREU''' || ',' || '''CONTACTE_TELEFON''' || ',' || '''CONT_ACCESS_OBSE''' || ',' || '''CONVIDAT''' || ',' || '''CONVIDAT_ACOMPANYANT''' || ',' || '''CONVIDAT_CORREU''' || ',' || '''CONVIDAT_OBSEQUI''' || ',' || '''CONVIDAT_TELEFON''' || ',' || '''CONVIDAT_ZONA''' || ',' || '''DADES_HISTORIC''' || ',' || '''DM_AFECTA_AGENDA''' || ',' || '''DM_AMBIT''' || ',' || '''DM_ARTICLE''' || ',' || '''DM_BARRI''' || ',' || '''DM_CARREC''' || ',' || '''DM_CATALEG_DOCUMENT''' || ',' || '''DM_CATEGORIA''' || ',' || '''DM_CLASSIFICACIO''' || ',' || '''DM_CONF_FUN_VISUALS''' || ',' || '''DM_CONTRACTE''' || ',' || '''DM_DECISIO_AGENDA''' || ',' || '''DM_DECISIO_ASSISTENCIA''' || ',' || '''DM_DESTINATARI_PERSONA''' || ',' || '''DM_DESTI_DELEGACIO''' || ',' || '''DM_DISTRICTE''' || ',' || '''DM_ENTITAT''' || ',' || '''DM_ESPAI''' || ',' || '''DM_ESPECIFIC''' || ',' || '''DM_ESTAT_ACTE''' || ',' || '''DM_ESTAT_COMANDA''' || ',' || '''DM_ESTAT_CONFIRMACIO''' || ',' || '''DM_ESTAT_ELEMENT''' || ',' || '''DM_ESTAT_GESTIO_ESPAIS''' || ',' || '''DM_ESTAT_GESTIO_INVITACIO''' || ',' || '''DM_ESTAT_TRUCADA''' || ',' || '''DM_IDIOMA''' || ',' || '''DM_INICIATIVA_RESPOSTA''' || ',' || '''DM_LLOC''' || ',' || '''DM_OBSEQUI''' || ',' || '''DM_ORIGEN_ELEMENT''' || ',' || '''DM_PAS_ACCIO''' || ',' || '''DM_PETICIONARI''' || ',' || '''DM_PLANTILLA_ESPAI''' || ',' || '''DM_PREFIX''' || ',' || '''DM_PREFIX_ANY''' || ',' || '''DM_PRESIDENT''' || ',' || '''DM_PRIORITAT''' || ',' || '''DM_PRIORITAT_ELEMENT''' || ',' || '''DM_PROVEIDOR''' || ',' || '''DM_RAO''' || ',' || '''DM_SECTOR''' || ',' || '''DM_SENTIT_TRUCADA''' || ',' || '''DM_SERIE''' || ',' || '''DM_SUBTIPUS_ACCIO''' || ',' || '''DM_TIPOLOGIA_CLASSIFICACIO''' || ',' || '''DM_TIPOLOGIA_OBSEQUI''' || ',' || '''DM_TIPUS_ACCIO''' || ',' || '''DM_TIPUS_ACTE''' || ',' || '''DM_TIPUS_AGENDA''' || ',' || '''DM_TIPUS_AMBIT''' || ',' || '''DM_TIPUS_ARG''' || ',' || '''DM_TIPUS_CONTACTE''' || ',' || '''DM_TIPUS_DATA''' || ',' || '''DM_TIPUS_ELEMENT''' || ',' || '''DM_TIPUS_SERVEI''' || ',' || '''DM_TIPUS_SUBJECTE''' || ',' || '''DM_TIPUS_SUPORT''' || ',' || '''DM_TIPUS_TELEFON''' || ',' || '''DM_TIPUS_TEMA''' || ',' || '''DM_TIPUS_VIA_INVITACIO''' || ',' || '''DM_TIPUS_VIA_RESPOSTA''' || ',' || '''DM_TRACTAMENT''' || ',' || '''DM_VISIBILITAT''' || ',' || '''DOCUMENT''' || ',' || '''DOCUMENT_BAIXA_SUBJECTE''' || ',' || '''DOSSIER''' || ',' || '''ELEMENTS_RELACIONATS''' || ',' || '''ELEMENT_PRINCIPAL''' || ',' || '''ELEMENT_SECUNDARI''' || ',' || '''ENTRADA_AGENDA''' || ',' || '''ESPAI_ACTE''' || ',' || '''ESPAI_ACTE_CONFIG''' || ',' || '''HISTORIC_TRUCADA''' || ',' || '''OBSEQUI_ENTREGAT''' || ',' || '''OBSEQUI_INVENTARI''' || ',' || '''PERSONA_RELACIONADA''' || ',' || '''RASTRE''' || ',' || '''REGISTRE''' || ',' || '''SUBJECTE''' || ',' || '''TITULAR_DINS''' || ',' || '''TITULAR_FORA''' || ',' || '''TITULAR_FORA_CORREU''' || ',' || '''TITULAR_FORA_TELEFON''' || ',' || '''TRANSICIO_TRAMITACIO''' || ',' || '''TRUCADA''' || ',' || '''TRUCADA_ELEMENT_PRINCIPAL''' || ',' || '''TRUCADA_TEMA''' || ',' || '''ZONA';
    
    DELETE FROM Z_Z_CONSTRAINTS_SINTAGMA;
    DELETE FROM Z_Z_CONSTRAINTS_A1;
    DELETE FROM Z_Z_CONSTRAINTS_A0;
    DELETE FROM Z_Z_CONSTRAINTS_ERRORES;
    
    DBMS_OUTPUT.PUT_LINE('BORRADO');
    COMMIT;
    --METEMOS 
        DBMS_OUTPUT.PUT_LINE('LLEGA1');
        SQL_AUX :=    'INSERT INTO Z_Z_CONSTRAINTS_SINTAGMA (TABLA,ESQUEMA, TABLA_SINTAGMA, TOTAL_CONSTRAINT) 
                              SELECT TABLA,
                                     ESQUEMA, 
                                     TABLA_SINTAGMA, 
                                     TOTAL_CONSTRAINT
                                FROM (     
                                          SELECT DISTINCT a.table_name AS tabla, 
                                                 NULL AS ESQUEMA,
                                                 a.table_name AS TABLA_SINTAGMA,
                                                 COUNT (*)  OVER (PARTITION BY a.table_name ORDER BY a.table_name ASC ) AS TOTAL_CONSTRAINT
                                            FROM ALL_CONS_COLUMNS A, ALL_CONSTRAINTS C  
                                           WHERE A.CONSTRAINT_NAME = C.CONSTRAINT_NAME 
                                             AND a.table_name IN (''' || V_TablasSINTAGMA || ''') 
                                             AND C.CONSTRAINT_TYPE = ''R''
                                             AND c.owner = ''SINTAGMA_U''
                                        ORDER BY a.table_name
                                       ) TABLAS_ORDENADAS ';
                            
--                   DBMS_OUTPUT.PUT_LINE(SQL_AUX);                          
                    EXECUTE IMMEDIATE  SQL_AUX;
                    DBMS_OUTPUT.PUT_LINE('PASA2');                 
                   
                 COMMIT;
             
                      INSERT INTO Z_Z_CONSTRAINTS_A0 (TABLA,ESQUEMA, TABLA_SINTAGMA, TOTAL_CONSTRAINT) 
                              SELECT DISTINCT a.table_name AS tabla,                               
                                     'A0_' AS ESQUEMA,
                                     REPLACE(a.table_name,'A0_','') AS TABLA_SINTAGMA,                                     
						             COUNT (*)  OVER (PARTITION BY a.table_name ORDER BY a.table_name ASC ) AS TOTAL_CONSTRAINT
							    FROM ALL_CONS_COLUMNS A, ALL_CONSTRAINTS C  
							   WHERE A.CONSTRAINT_NAME = C.CONSTRAINT_NAME 
							     AND a.table_name LIKE 'A0_%' 
							     AND C.CONSTRAINT_TYPE = 'R'
							     AND c.owner = 'SINTAGMA_U'
							ORDER BY a.table_name;
                COMMIT;
    
    
                      INSERT INTO Z_Z_CONSTRAINTS_A1 (TABLA,ESQUEMA, TABLA_SINTAGMA, TOTAL_CONSTRAINT) 
                              SELECT DISTINCT a.table_name AS tabla,         
                                     'A1_' AS ESQUEMA,
                                     REPLACE(a.table_name,'A1_','') AS TABLA_SINTAGMA, 
						             COUNT (*)  OVER (PARTITION BY a.table_name ORDER BY a.table_name ASC ) AS TOTAL_CONSTRAINT
							    FROM ALL_CONS_COLUMNS A, ALL_CONSTRAINTS C  
							   WHERE A.CONSTRAINT_NAME = C.CONSTRAINT_NAME 
							     AND a.table_name LIKE 'A1_%' 
							     AND C.CONSTRAINT_TYPE = 'R'
							     AND c.owner = 'SINTAGMA_U'
							ORDER BY a.table_name;
                COMMIT;

            ------------------------------------------------------------------------------------------------
            -- INSERTAMOS EN Z_Z_CONSTRAINTS_ERRORES LAS DIFERENCIAS QUE VAMOS ENCONTRANDO :
            
-- 1) DIFERENCIAS SINTAGMA // A0_X
/*
                INSERT INTO Z_Z_CONSTRAINTS_ERRORES 
                                SELECT  SINTAGMA.TABLA AS TABLA,
                                        SINTAGMA.ESQUEMA AS ESQUEMA,
                                        SINTAGMA.TABLA_SINTAGMA AS TABLA_SINTAGMA,
                                        SINTAGMA.TOTAL_CONSTRAINT AS TOTAL_CONSTRAINT,
                                        A0.TABLA AS TABLA_1,
                                        A0.ESQUEMA AS ESQUEMA_1,
                                        A0.TABLA_SINTAGMA AS TABLA_SINTAGMA_1,
                                        A0.TOTAL_CONSTRAINT AS TOTAL_CONSTRAINT_1
                                FROM Z_Z_CONSTRAINTS_SINTAGMA SINTAGMA
                                FULL OUTER JOIN  Z_Z_CONSTRAINTS_A0 A0
                                    ON SINTAGMA.TABLA_SINTAGMA = A0.TABLA_SINTAGMA
                                WHERE SINTAGMA.TABLA_SINTAGMA IS NULL
                                   OR A0.TABLA_SINTAGMA IS NULL
                                   OR A0.TOTAL_CONSTRAINT<>SINTAGMA.TOTAL_CONSTRAINT;
*/
                        INSERT INTO Z_Z_CONSTRAINTS_ERRORES (SINTAGMA_TABLA, SINTAGMA_ESQUEMA, SINTAGMA_TABLA_SINTAGMA, SINTAGMA_TOTAL_CONSTRAINT, A0_TABLA, A0_ESQUEMA, A0_TABLA_SINTAGMA, A0_TOTAL_CONSTRAINT,A1_TABLA, A1_ESQUEMA, A1_TABLA_SINTAGMA, A1_TOTAL_CONSTRAINT) 
                                    SELECT  SINTAGMA.TABLA AS SINTAGMA_TABLA,
                                            SINTAGMA.ESQUEMA AS SINTAGMA_ESQUEMA,
                                            SINTAGMA.TABLA_SINTAGMA AS SINTAGMA_TABLA_SINTAGMA,
                                            SINTAGMA.TOTAL_CONSTRAINT AS SINTAGMA_TOTAL_CONSTRAINT,
                                            A0.TABLA AS A0_TABLA,
                                            A0.ESQUEMA AS A0_ESQUEMA,
                                            A0.TABLA_SINTAGMA AS A0_TABLA_SINTAGMA,
                                            A0.TOTAL_CONSTRAINT AS A0_TOTAL_CONSTRAINT,
                                            FUNC_NULOS_STRING() AS A1_TABLA,
                                            FUNC_NULOS_STRING() AS A1_ESQUEMA,
                                            FUNC_NULOS_STRING() AS A1_TABLA_SINTAGMA,
                                            FUNC_NULOS_STRING() AS A1_TOTAL_CONSTRAINT
                                    FROM Z_Z_CONSTRAINTS_SINTAGMA SINTAGMA
                                    FULL OUTER JOIN  Z_Z_CONSTRAINTS_A0 A0
                                    ON SINTAGMA.TABLA_SINTAGMA = A0.TABLA_SINTAGMA
                                    WHERE SINTAGMA.TABLA_SINTAGMA IS NULL
                                    OR A0.TABLA_SINTAGMA IS NULL
                                    OR A0.TOTAL_CONSTRAINT<>SINTAGMA.TOTAL_CONSTRAINT;

              COMMIT;
              
-- 2) DIFERENCIAS SINTAGMA // A1_X
/*
                INSERT INTO Z_Z_CONSTRAINTS_ERRORES 
                                SELECT  SINTAGMA.TABLA AS TABLA,
                                        SINTAGMA.ESQUEMA AS ESQUEMA,
                                        SINTAGMA.TABLA_SINTAGMA AS TABLA_SINTAGMA,
                                        SINTAGMA.TOTAL_CONSTRAINT AS TOTAL_CONSTRAINT,
                                        A1.TABLA AS TABLA_1,
                                        A1.ESQUEMA AS ESQUEMA_1,
                                        A1.TABLA_SINTAGMA AS TABLA_SINTAGMA_1,
                                        A1.TOTAL_CONSTRAINT AS TOTAL_CONSTRAINT_1
                                FROM Z_Z_CONSTRAINTS_SINTAGMA SINTAGMA
                                FULL OUTER JOIN  Z_Z_CONSTRAINTS_A1 A1
                                    ON SINTAGMA.TABLA_SINTAGMA = A1.TABLA_SINTAGMA
                                WHERE SINTAGMA.TABLA_SINTAGMA IS NULL
                                   OR A1.TABLA_SINTAGMA IS NULL
                                   OR A1.TOTAL_CONSTRAINT<>SINTAGMA.TOTAL_CONSTRAINT;
*/

                        INSERT INTO Z_Z_CONSTRAINTS_ERRORES (SINTAGMA_TABLA, SINTAGMA_ESQUEMA, SINTAGMA_TABLA_SINTAGMA, SINTAGMA_TOTAL_CONSTRAINT, A0_TABLA, A0_ESQUEMA, A0_TABLA_SINTAGMA, A0_TOTAL_CONSTRAINT,A1_TABLA, A1_ESQUEMA, A1_TABLA_SINTAGMA, A1_TOTAL_CONSTRAINT)
                                    SELECT  SINTAGMA.TABLA AS SINTAGMA_TABLA,
                                            SINTAGMA.ESQUEMA AS SINTAGMA_ESQUEMA,
                                            SINTAGMA.TABLA_SINTAGMA AS SINTAGMA_TABLA_SINTAGMA,
                                            SINTAGMA.TOTAL_CONSTRAINT AS SINTAGMA_TOTAL_CONSTRAINT,
                                            FUNC_NULOS_STRING() AS A0_TABLA,
                                            FUNC_NULOS_STRING() AS A0_ESQUEMA,
                                            FUNC_NULOS_STRING() AS A0_TABLA_SINTAGMA,
                                            FUNC_NULOS_STRING() AS A0_TOTAL_CONSTRAINT,
                                            A1.TABLA AS A1_TABLA,
                                            A1.ESQUEMA AS A1_ESQUEMA,
                                            A1.TABLA_SINTAGMA AS A1_TABLA_SINTAGMA,
                                            A1.TOTAL_CONSTRAINT AS A1_TOTAL_CONSTRAINT
                                    FROM Z_Z_CONSTRAINTS_SINTAGMA SINTAGMA
                                    FULL OUTER JOIN  Z_Z_CONSTRAINTS_A1 A1
                                    ON SINTAGMA.TABLA_SINTAGMA = A1.TABLA_SINTAGMA
                                    WHERE SINTAGMA.TABLA_SINTAGMA IS NULL
                                    OR A1.TABLA_SINTAGMA IS NULL
                                    OR A1.TOTAL_CONSTRAINT<>SINTAGMA.TOTAL_CONSTRAINT;

              COMMIT;
              
 -- 2) DIFERENCIAS A0_X // A1_X             
                    INSERT INTO Z_Z_CONSTRAINTS_ERRORES (SINTAGMA_TABLA, SINTAGMA_ESQUEMA, SINTAGMA_TABLA_SINTAGMA, SINTAGMA_TOTAL_CONSTRAINT, A0_TABLA, A0_ESQUEMA, A0_TABLA_SINTAGMA, A0_TOTAL_CONSTRAINT,A1_TABLA, A1_ESQUEMA, A1_TABLA_SINTAGMA, A1_TOTAL_CONSTRAINT)
                                SELECT  NULL AS SINTAGMA_TABLA,
                                        NULL AS SINTAGMA_ESQUEMA,
                                        NULL AS SINTAGMA_TABLA_SINTAGMA,
                                        NULL AS SINTAGMA_TOTAL_CONSTRAINT,
                                        A0.TABLA AS TABLA,
                                        A0.ESQUEMA AS ESQUEMA,
                                        A0.TABLA_SINTAGMA AS TABLA_SINTAGMA,
                                        A0.TOTAL_CONSTRAINT AS TOTAL_CONSTRAINT,
                                        A1.TABLA AS TABLA_1,
                                        A1.ESQUEMA AS ESQUEMA_1,
                                        A1.TABLA_SINTAGMA AS TABLA_SINTAGMA_1,
                                        A1.TOTAL_CONSTRAINT AS TOTAL_CONSTRAINT_1
                                FROM Z_Z_CONSTRAINTS_A0 A0
                                FULL OUTER JOIN  Z_Z_CONSTRAINTS_A1 A1
                                    ON A0.TABLA_SINTAGMA = A1.TABLA_SINTAGMA
                                WHERE A0.TABLA_SINTAGMA IS NULL
                                   OR A1.TABLA_SINTAGMA IS NULL
                                   OR A1.TOTAL_CONSTRAINT<>A0.TOTAL_CONSTRAINT;

              COMMIT;

        
    COMMIT;    

  
  

END PROC_DIFERENCIAS_CONSTRAINT;

/
