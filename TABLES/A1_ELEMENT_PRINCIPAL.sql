--------------------------------------------------------
--  DDL for Table A1_ELEMENT_PRINCIPAL
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" 
   (	"ID" NUMBER(10,0), 
	"NUMERO_REGISTRE" NUMBER(10,0), 
	"ES_RELACIO_ENTRADA" NUMBER(1,0), 
	"DATA_RELACIO_ENTRADA" TIMESTAMP (0), 
	"ES_VALIDAT_RE" NUMBER(1,0), 
	"DATA_REGISTRE_GENERAL" TIMESTAMP (0), 
	"DATA_INICI_SEGUIMENT" TIMESTAMP (0), 
	"DATA_FI_SEGUIMENT" TIMESTAMP (0), 
	"NOM_USUARI_RESPONSABLE" VARCHAR2(100 BYTE), 
	"MATRICULA_USUARI_RESPONSABLE" VARCHAR2(10 BYTE), 
	"DATA_DOCUMENT" TIMESTAMP (0), 
	"DATA_TERMINI" TIMESTAMP (0), 
	"DATA_RESPOSTA" TIMESTAMP (0), 
	"DATA_RESOLUCIO" TIMESTAMP (0), 
	"NOM_ACTE" VARCHAR2(1050 BYTE), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"AFECTA_AGENDA_ID" NUMBER(10,0), 
	"ORIGEN_ID" NUMBER(10,0), 
	"PRIORITAT_ID" NUMBER(10,0), 
	"TIPUS_ELEMENT_ID" NUMBER(10,0), 
	"ASPECTE_ID" NUMBER(10,0), 
	"DOSSIER_ID" NUMBER(10,0), 
	"ESTAT_ELEMENT_PRINCIPAL_ID" NUMBER(10,0), 
	"TIPUS_SUPORT_ID" NUMBER(10,0), 
	"TIPUS_AMBIT_ID" NUMBER(10,0), 
	"TIPUS_ARG_ID" NUMBER(10,0), 
	"PREFIX_ID" NUMBER(10,0), 
	"NUMERO_REGISTRE_GENERAL_ID" NUMBER(10,0), 
	"ELEMENT_PRINCIPAL_ORIGEN_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"INSTALACIOID" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
