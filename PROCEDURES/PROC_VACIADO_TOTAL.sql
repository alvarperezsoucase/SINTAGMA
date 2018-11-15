--------------------------------------------------------
--  DDL for Procedure PROC_VACIADO_TOTAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."PROC_VACIADO_TOTAL" AS 
        TYPE ARRAY_TABLAS IS VARRAY(1000) OF VARCHAR2(100);
             Tabla ARRAY_TABLAS;
        total integer;      
        prefijo varchar2(3);     
BEGIN

        prefijo :='A1_';
        
                  Tabla := ARRAY_TABLAS('ACCIO',
                                        'ACOMPANYANT',
                                        'ACTE',
                                        'ADRECA',
                                        'AGENDA_DELEGACIO',
                                        'ANNEX_ACTE',
                                        'ANNEX_ASPECTE',
                                        'ANNEX_INCIDENT',
                                        'ANNEX_REGISTRE',
                                        'ASPECTE',
                                        'CLASSIFICACIO_ARXIU',
                                        'COMANDA',
                                        'COMENTARI',
                                        'COMENTARI_ACTE',
                                        'COMENTARI_ASPECTE',
                                        'CONTACTE',
                                        'CONTACTE_CLASSIFICACIO',
                                        'CONTACTE_CONSENTIMENT',
                                        'CONTACTE_CORREU',
                                        'CONTACTE_TELEFON',
                                        'CONVIDAT',
                                        'CONVIDAT_ACOMPANYANT',
                                        'CONVIDAT_CORREU',
                                        'CONVIDAT_OBSEQUI',
                                        'CONVIDAT_TELEFON',
                                        'CONVIDAT_ZONA',
                                        'DADES_HISTORIC',
                                        'DM_AFECTA_AGENDA',
                                        'DM_AMBIT',
                                        'DM_ARTICLE',
                                        'DM_BARRI',
                                        'DM_CARREC',
                                        'DM_CATALEG_DOCUMENT',
                                        'DM_CATEGORIA',
                                        'DM_CLASSIFICACIO',
                                        'DM_CONF_FUN_VISUALS',
                                        'DM_CONTRACTE',
                                        'DM_DECISIO_AGENDA',
                                        'DM_DECISIO_ASSISTENCIA',
                                        'DM_DESTINATARI_PERSONA',
                                        'DM_DESTI_DELEGACIO',
                                        'DM_DISTRICTE',
                                        'DM_ENTITAT',
                                        'DM_ESPAI',
                                        'DM_ESPECIFIC',
                                        'DM_ESTAT_ACTE',
                                        'DM_ESTAT_COMANDA',
                                        'DM_ESTAT_CONFIRMACIO',
                                        'DM_ESTAT_ELEMENT',
                                        'DM_ESTAT_GESTIO_ESPAIS',
                                        'DM_ESTAT_GESTIO_INVITACIO',
                                        'DM_ESTAT_TRUCADA',
                                        'DM_IDIOMA',
                                        'DM_INICIATIVA_RESPOSTA',
                                        'DM_LLOC',
                                        'DM_OBSEQUI',
                                        'DM_ORIGEN_ELEMENT',
                                        'DM_PAS_ACCIO',
                                        'DM_PETICIONARI',
                                        'DM_PLANTILLA_ESPAI',
                                        'DM_PREFIX',
                                        'DM_PREFIX_ANY',
                                        'DM_PRESIDENT',
                                        'DM_PRIORITAT',
                                        'DM_PRIORITAT_ELEMENT',
                                        'DM_PROVEIDOR',
                                        'DM_RAO',
                                        'DM_SECTOR',
                                        'DM_SENTIT_TRUCADA',
                                        'DM_SERIE',
                                        'DM_SUBTIPUS_ACCIO',
                                        'DM_TIPOLOGIA_CLASSIFICACIO',
                                        'DM_TIPOLOGIA_OBSEQUI',
                                        'DM_TIPUS_ACCIO',
                                        'DM_TIPUS_ACTE',
                                        'DM_TIPUS_AGENDA',
                                        'DM_TIPUS_AMBIT',
                                        'DM_TIPUS_ARG',
                                        'DM_TIPUS_CONTACTE',
                                        'DM_TIPUS_DATA',
                                        'DM_TIPUS_ELEMENT',
                                        'DM_TIPUS_SERVEI',
                                        'DM_TIPUS_SUBJECTE',
                                        'DM_TIPUS_SUPORT',
                                        'DM_TIPUS_TELEFON',
                                        'DM_TIPUS_TEMA',
                                        'DM_TIPUS_VIA_INVITACIO',
                                        'DM_TIPUS_VIA_RESPOSTA',
                                        'DM_TRACTAMENT',
                                        'DM_VISIBILITAT',
                                        'DOCUMENT',
                                        'DOCUMENT_BAIXA_SUBJECTE',
                                        'DOSSIER',
                                        'ELEMENTS_RELACIONATS',
                                        'ELEMENT_PRINCIPAL',
                                        'ELEMENT_SECUNDARI',
                                        'ENTRADA_AGENDA',
                                        'ESPAI_ACTE',
                                        'ESPAI_ACTE_CONFIG',
                                        'HISTORIC_TRUCADA',
                                        'INCIDENTS_ACTE',
                                        'MANTENIMENT_DM',
                                        'OBSEQUI_ENTREGAT',
                                        'OBSEQUI_INVENTARI',
                                        'PARAMETRE',
                                        'PERSONA_RELACIONADA',
                                        'PLANTILLA',
                                        'PLANTILLA_CONFIG_ESPAI',
                                        'RASTRE',
                                        'RASTRE_ACTE',
                                        'RASTRE_ASPECTE',
                                        'REGISTRE',
                                        'SUBJECTE',
                                        'SUBJECTES_ARTICLE',
                                        'TITULAR_DINS',
                                        'TITULAR_FORA',
                                        'TITULAR_FORA_CORREU',
                                        'TITULAR_FORA_TELEFON',
                                        'TRANSICIO_TRAMITACIO',
                                        'TRUCADA',
                                        'TRUCADA_ELEMENT_PRINCIPAL',
                                        'TRUCADA_TEMA',
                                        'ZONA'
                                        );

/*desactiva*/
FOR c IN
  (SELECT c.owner, c.table_name, c.constraint_name
   FROM user_constraints c, user_tables t
   WHERE c.table_name = t.table_name
   AND c.status = 'ENABLED'
   AND NOT (t.iot_type IS NOT NULL AND c.constraint_type = 'P')
   ORDER BY c.constraint_type DESC)
  LOOP
    dbms_utility.exec_ddl_statement('alter table "' || c.owner || '"."' || c.table_name || '" disable constraint ' || c.constraint_name);
  END LOOP;
/*vaciamos tablas del array*/            
            total := Tabla.count;            
             FOR i in 1 .. total LOOP
            
                    EXECUTE IMMEDIATE ' TRUNCATE TABLE ' || PREFIJO || Tabla(i);
            
             END LOOP;     
/*activa*/             
  FOR c IN
  (SELECT c.owner, c.table_name, c.constraint_name
   FROM user_constraints c, user_tables t
   WHERE c.table_name = t.table_name
   AND c.status = 'DISABLED'
   ORDER BY c.constraint_type)
  LOOP
    dbms_utility.exec_ddl_statement('alter table "' || c.owner || '"."' || c.table_name || '" enable constraint ' || c.constraint_name);
  END LOOP;

             
             
             
            

  NULL;
END PROC_VACIADO_TOTAL;

/
