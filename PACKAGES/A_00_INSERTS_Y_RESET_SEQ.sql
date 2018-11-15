--------------------------------------------------------
--  DDL for Package A_00_INSERTS_Y_RESET_SEQ
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."A_00_INSERTS_Y_RESET_SEQ" AS 

        ConstUsuari_CREACIO varchar2(8) := 'MIGRACIO';

PROCEDURE DM_TIPUS_TELEFON;

PROCEDURE DM_TIPUS_SUBJECTE;

PROCEDURE DM_AMBIT;

PROCEDURE DM_CONF_FUN_VISUALS;

PROCEDURE DM_PRIORITAT;

PROCEDURE DM_TIPOLOGIA_OBSEQUI;

PROCEDURE DM_OBSEQUI;

PROCEDURE DM_VISIBILITAT;

PROCEDURE DM_TIPUS_CONTACTE;

PROCEDURE DM_IDIOMA;

PROCEDURE DM_TIPOLOGIA_CLASSIFICACIO;

PROCEDURE DM_SENTIT_TRUCADA;

PROCEDURE DM_AFECTA_AGENDA;

PROCEDURE DM_TIPUS_AMBIT;

PROCEDURE DM_BARRI;

PROCEDURE DM_SECTOR;

PROCEDURE DM_DECISIO_ASSISTENCIA;

PROCEDURE DM_RAO;

PROCEDURE DM_ARTICLE;

--------------------------------------------------------
-- TRUCADA
--------------------------------------------------------

PROCEDURE DM_ESTAT_TRUCADA;

--------------------------------------------------------
-- ACTES
--------------------------------------------------------

PROCEDURE DM_ESTAT_CONFIRMACIO;

PROCEDURE DM_TIPUS_VIA_INVITACIO;

PROCEDURE DM_INICIATIVA_RESPOSTA;

PROCEDURE DM_TIPUS_VIA_RESPOSTA;

PROCEDURE DM_ESTAT_GESTIO_INVITACIO;

PROCEDURE DM_ESTAT_GESTIO_ESPAIS;

  /* 
  
  DROP SEQUENCE AUX_SEQ_CONTACTE;
CREATE SEQUENCE AUX_SEQ_CONTACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;
DROP SEQUENCE SEQ_CONTACTE;
CREATE SEQUENCE SEQ_CONTACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_CONTACTE_CORREU;
CREATE SEQUENCE SEQ_CONTACTE_CORREU MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_ACOMPANYANT;
CREATE SEQUENCE SEQ_ACOMPANYANT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_TRACTAMENT;
CREATE SEQUENCE SEQ_DM_TRACTAMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_CONTACTE_TELEFON;
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

DROP SEQUENCE SEQ_SUBJECTE;
CREATE SEQUENCE SEQ_SUBJECTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_DESTINATARI_PERSONA;
CREATE SEQUENCE SEQ_DM_DESTINATARI_PERSONA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

------- TEMAS
DROP SEQUENCE SEQ_DM_TIPUS_TEMA;
CREATE SEQUENCE SEQ_DM_TIPUS_TEMA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_TIPUS_ACCIO;
CREATE SEQUENCE SEQ_DM_TIPUS_ACCIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_PRIORITAT_ELEMENT;
CREATE SEQUENCE SEQ_DM_PRIORITAT_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_SERIE_SUBSERIE;
CREATE SEQUENCE SEQ_SERIE_SUBSERIE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_ESTAT_ELEMENT;
CREATE SEQUENCE SEQ_DM_ESTAT_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_PAS_ACCIO;
CREATE SEQUENCE SEQ_DM_PAS_ACCIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_TIPUS_AGENDA;
CREATE SEQUENCE SEQ_DM_TIPUS_AGENDA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_ORIGEN_ELEMENT;
CREATE SEQUENCE SEQ_DM_ORIGEN_ELEMENT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_TIPUS_DATA;
CREATE SEQUENCE SEQ_DM_TIPUS_DATA MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_TITULAR_DINS;
CREATE SEQUENCE SEQ_TITULAR_DINS MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DOSSIER;
CREATE SEQUENCE SEQ_DOSSIER MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_AGENDA_DELEGACIO;
CREATE SEQUENCE SEQ_AGENDA_DELEGACIO MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DOSSIER;
CREATE SEQUENCE SEQ_DOSSIER MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_REGISTRE;
CREATE SEQUENCE SEQ_REGISTRE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

-----------------------------------------------------

DROP SEQUENCE SEQ_DM_TIPUS_ACTE;
CREATE SEQUENCE SEQ_DM_TIPUS_ACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_DM_ESTAT_ACTE;
CREATE SEQUENCE SEQ_DM_ESTAT_ACTE MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_CONVIDAT;
CREATE SEQUENCE SEQ_CONVIDAT MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

DROP SEQUENCE SEQ_CONVIDAT_CORREU;
CREATE SEQUENCE SEQ_CONVIDAT_CORREU MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;



 DELETE FROM ACCIO;
 DELETE FROM ACOMPANYANT;
 DELETE FROM ACTE;
 
 DELETE FROM AGENDA_DELEGACIO;
 DELETE FROM ANNEX_ACTE;
 DELETE FROM ANNEX_ASPECTE;
 DELETE FROM ANNEX_REGISTRE;
 DELETE FROM ASPECTE;
 DELETE FROM CLASSIFICACIO_ARXIU;
 DELETE FROM COMANDA;
 DELETE FROM COMENTARI;
 
 DELETE FROM CONTACTE_CLASSIFICACIO;
 DELETE FROM CONTACTE_CONSENTIMENT;
 DELETE FROM CONTACTE_CORREU;
 DELETE FROM CONTACTE_TELEFON;
 DELETE FROM CONVIDAT;
 DELETE FROM CONVIDAT_ACOMPANYANT;
 DELETE FROM CONVIDAT_CORREU;
 DELETE FROM CONVIDAT_OBSEQUI;
 DELETE FROM CONVIDAT_TELEFON;
 DELETE FROM CONVIDAT_ZONA;
 DELETE FROM DADES_HISTORIC;
 DELETE FROM DM_AFECTA_AGENDA;
 
 DELETE FROM DM_ARTICLE;
 DELETE FROM DM_BARRI;
 
 DELETE FROM DM_CATALEG_DOCUMENT;
 DELETE FROM DM_CATEGORIA;
 DELETE FROM DM_CLASSIFICACIO;
 DELETE FROM DM_CONTRACTE;
 DELETE FROM DM_DECISIO_AGENDA;
 DELETE FROM DM_DESTINATARI_PERSONA;
 DELETE FROM DM_DESTI_DELEGACIO;
 DELETE FROM DM_DISTRICTE;
 
 DELETE FROM DM_ESPAI;
 DELETE FROM DM_ESPECIFIC;
 DELETE FROM DM_ESTAT_ACTE;
 DELETE FROM DM_ESTAT_COMANDA;
 DELETE FROM DM_ESTAT_CONFIRMACIO;
 DELETE FROM DM_ESTAT_ELEMENT;
 DELETE FROM DM_ESTAT_GESTIO_ESPAIS;
 DELETE FROM DM_ESTAT_GESTIO_INVITACIO;
 DELETE FROM DM_ESTAT_TRUCADA;
 DELETE FROM DM_IDIOMA;
 DELETE FROM DM_INICIATIVA_RESPOSTA;
 DELETE FROM DM_LLOC;
 DELETE FROM DM_OBSEQUI;
 DELETE FROM DM_ORIGEN_ELEMENT;
 DELETE FROM DM_PAS_ACCIO;
 DELETE FROM DM_PETICIONARI;
 DELETE FROM DM_PLANTILLA_ESPAI;
 DELETE FROM DM_PREFIX;
 DELETE FROM DM_PREFIX_ANY;
 DELETE FROM DM_PRESIDENT;
 DELETE FROM DM_PRIORITAT;
 DELETE FROM DM_PRIORITAT_ELEMENT;
 DELETE FROM DM_PROVEIDOR;
 DELETE FROM DM_RAO;
 DELETE FROM DM_SECTOR;
 DELETE FROM DM_SENTIT_TRUCADA;
 DELETE FROM DM_SERIE;
 DELETE FROM DM_SUBTIPUS_ACCIO;
 DELETE FROM DM_TIPOLOGIA_CLASSIFICACIO;
 DELETE FROM DM_TIPOLOGIA_OBSEQUI;
 DELETE FROM DM_TIPUS_ACCIO;
 DELETE FROM DM_TIPUS_ACTE;
 DELETE FROM DM_TIPUS_AGENDA;
 DELETE FROM DM_TIPUS_AMBIT;
 DELETE FROM DM_TIPUS_ARG;
 
 DELETE FROM DM_TIPUS_DATA;
 DELETE FROM DM_TIPUS_ELEMENT;
 DELETE FROM DM_TIPUS_SERVEI;
 
 DELETE FROM DM_TIPUS_SUPORT;
 DELETE FROM DM_TIPUS_TELEFON;
 DELETE FROM DM_TIPUS_TEMA;
 DELETE FROM DM_TIPUS_VIA_INVITACIO;
 DELETE FROM DM_TIPUS_VIA_RESPOSTA;
 
 
 DELETE FROM DOCUMENT;
 DELETE FROM DOCUMENT_BAIXA_SUBJECTE;
 DELETE FROM DOSSIER;
 DELETE FROM ELEMENTS_RELACIONATS;
 DELETE FROM ELEMENT_PRINCIPAL;
 DELETE FROM ELEMENT_SECUNDARI;
 DELETE FROM ENTRADA_AGENDA;
 DELETE FROM ESPAI_ACTE;
 DELETE FROM ESPAI_ACTE_CONFIG;
 DELETE FROM HISTORIC_TRUCADA;
 DELETE FROM MANTENIMENT_DM;
 DELETE FROM OBSEQUI_ENTREGAT;
 DELETE FROM OBSEQUI_INVENTARI;
 DELETE FROM PARAMETRE;
 DELETE FROM PERSONA_RELACIONADA;
 DELETE FROM PLANTILLA_CONFIG_ESPAI;
 DELETE FROM RASTRE;
 DELETE FROM REGISTRE;
 
 DELETE FROM TITULAR_DINS;
 DELETE FROM TITULAR_FORA;
 DELETE FROM TITULAR_FORA_CORREU;
 DELETE FROM TITULAR_FORA_TELEFON;
 DELETE FROM TRANSICIO_TRAMITACIO;
 DELETE FROM TRUCADA;
 DELETE FROM TRUCADA_ELEMENT_PRINCIPAL;
 DELETE FROM TRUCADA_TEMA;
 DELETE FROM ZONA;
 
 DELETE FROM CONTACTE;
 
 DELETE FROM SUBJECTE;
 
 DELETE FROM ADRECA;
 DELETE FROM DM_TIPUS_CONTACTE;
 DELETE FROM DM_VISIBILITAT;
 DELETE FROM DM_ENTITAT;
 DELETE FROM DM_CARREC;
 DELETE FROM DM_AMBIT;
 
 DELETE FROM DM_TRACTAMENT;
DELETE FROM DM_TIPUS_SUBJECTE;
 
 
INSERT INTO DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'TELEFON FIX',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'TELEFON MOBIL',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'FAX',SYSDATE,null,null,'MIGRACIO',null,null);


INSERT INTO DM_TIPUS_SUBJECTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'PERSONA',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPUS_SUBJECTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'ENTITAT',SYSDATE,null,null,'MIGRACIO',null,null);


INSERT INTO DM_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI) VALUES  (1,'Alcaldia',SYSDATE,null,null,'MIGRACIO',null,null,'A');
INSERT INTO DM_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI) VALUES  (2,'Protocol',SYSDATE,null,null,'MIGRACIO',null,null,'B');



INSERT INTO DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (1, 'PRIORITAT1', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
INSERT INTO DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (2, 'PRIORITAT2', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
INSERT INTO DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (3, 'PRIORITAT3', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);
INSERT INTO DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) VALUES (4, 'PRIORITAT4', SYSDATE, NULL, NULL, 'MIGRACIO', NULL, NULL, 2);


INSERT INTO DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'JOCS FLORALS',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'MEDALLES',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'CONCERTS',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (4,'OBJECTES VARIS',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (5,'FOTOS i VIDEO',SYSDATE,null,null,'MIGRACIO',null,null);

INSERT INTO DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (5,'FOTOS PAPER - NO',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (4,'FOTOS PAPER - SI',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (3,'CD -  NO',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (2,'CD -  SI',1,SYSDATE,null,null,'MIGRACIO',null,null,5);
INSERT INTO DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID) VALUES (6,'CD - SI (FOTOS i VIDEO)',1,SYSDATE,null,null,'MIGRACIO',null,null,5);


INSERT INTO DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (1,'P�blica',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (2,'Privada',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (3,'Alcaldia',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (4,'Protocolo',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES (5,'Gabinet',SYSDATE,null,null,'MIGRACIO',null,null);

INSERT INTO DM_TIPUS_CONTACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (1,'Personal',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_TIPUS_CONTACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (2,'Profesional',SYSDATE,null,null,'MIGRACIO',null,null);




INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (1,'Castell�',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (2,'Angl�s',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (3,'Catal�',SYSDATE,null,null,'MIGRACIO',null,null);
INSERT INTO DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO) VALUES  (4,'Franc�s',SYSDATE,null,null,'MIGRACIO',null,null);


INSERT INTO DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values (1,'TIPUS1',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);
INSERT INTO DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values(2,'TIPUS2',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);
INSERT INTO DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values(3,'TIPUS3',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);
INSERT INTO DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID) values(4,'TIPUS4',SYSDATE,NULL,NULL,'MIGRACIO',NULL,NULL,2);

Insert into DM_SENTIT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO) values ('2','ENTRADA',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null);
Insert into DM_SENTIT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO) values ('1','SORTIDA',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null);

Insert into DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI) values ('2','PASSADA',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null,'PASSADA');
Insert into DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI) values ('3','PREVISTA',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null,'PREVISTA');
Insert into DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI) values ('1','PENDENT',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,null,'PENDENT');


Insert into DM_AFECTA_AGENDA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,AMBIT_ID) values ('0','NO',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,NULL,1);
Insert into DM_AFECTA_AGENDA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,AMBIT_ID) values ('1','S�',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,NULL,1);


--Insert into DM_AFECTA_AGENDA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,AMBIT_ID) values ('0','NO',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,NULL,1);
--Insert into DM_AFECTA_AGENDA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,AMBIT_ID) values ('1','S�',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,NULL,1);


INSERT INTO DM_TIPUS_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)VALUES(1, 'TIPO ALCALDIA',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,NULL,1, '', '', '');

INSERT INTO SINTAGMA_U.DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARIO_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) VALUES(0, 'SENSE DEFINIR',to_timestamp(Sysdate,'DD/MM/RRRR HH24:MI:SS'),null,null,'MIGRACIO',null,NULL,1, '', '', '');


  
  
  */ 

END A_00_INSERTS_Y_RESET_SEQ;

/
