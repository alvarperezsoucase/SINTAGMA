--------------------------------------------------------
--  DDL for Table Z_SE140_ELEMENT_PRINCIPAL
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SE140_ELEMENT_PRINCIPAL" 
   (	"ID" NUMBER(38,0), 
	"NUMERO_REGISTRE" NUMBER(38,0), 
	"ES_RELACIO_ENTRADA" CHAR(1 BYTE), 
	"DATA_RELACIO_ENTRADA" DATE, 
	"ES_VALIDAT_RE" NUMBER, 
	"DATA_REGISTRE_GENERAL" DATE, 
	"DATA_INICI_SEGUIMENT" DATE, 
	"DATA_FI_SEGUIMENT" DATE, 
	"NOM_USUARI_RESPONSABLE" VARCHAR2(50 BYTE), 
	"MATRICULA_USUARI_RESPONSABLE" VARCHAR2(10 BYTE), 
	"DATA_DOCUMENT" DATE, 
	"DATA_TERMINI" DATE, 
	"DATA_RESPOSTA" DATE, 
	"DATA_RESOLUCIO" DATE, 
	"NOM_ACTE" VARCHAR2(1024 BYTE), 
	"DATA_CREACIO" DATE, 
	"DATA_MODIFICACIO" TIMESTAMP (9), 
	"DATA_ESBORRAT" TIMESTAMP (9), 
	"USUARI_CREACIO" VARCHAR2(4000 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(4000 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(4000 BYTE), 
	"AFECTA_AGENDA_ID" NUMBER, 
	"ORIGEN_ID" NUMBER, 
	"PRIORITAT_ID" NUMBER, 
	"TIPUS_ELEMENT_ID" NUMBER, 
	"ASPECTE_ID" NUMBER(38,0), 
	"DOSSIER_ID" NUMBER, 
	"ESTAT_ELEMENT_PRINCIPAL_ID" NUMBER, 
	"TIPUS_SUPORT_ID" NUMBER, 
	"TIPUS_AMBIT_ID" NUMBER, 
	"TIPUS_ARG_ID" NUMBER, 
	"PREFIX_ID" NUMBER, 
	"NUMERO_REGISTRE_GENERAL_ID" VARCHAR2(4000 BYTE), 
	"ELEMENT_PRINCIPAL_ORIGEN_ID" VARCHAR2(4000 BYTE), 
	"ID_ORIGINAL" NUMBER(38,0), 
	"ESQUEMA_ORIGINAL" CHAR(7 BYTE), 
	"TABLA_ORIGINAL" CHAR(17 BYTE), 
	"INSTALACIOID" NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;