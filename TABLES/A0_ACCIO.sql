--------------------------------------------------------
--  DDL for Table A0_ACCIO
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A0_ACCIO" 
   (	"ID" NUMBER(10,0), 
	"RESPOSTA" VARCHAR2(1000 BYTE), 
	"NOM_USUARI_ACCIO" VARCHAR2(100 BYTE), 
	"MATRICULA_USUARI_ACCIO" VARCHAR2(50 BYTE), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"SUBTIPUS_ACCIO_ID" NUMBER(10,0), 
	"ASPECTE_ID" NUMBER(10,0), 
	"ELEMENT_PRINCIPAL_ID" NUMBER(10,0), 
	"AMBIT_DESTI_ID" NUMBER(10,0), 
	"PAS_ACCIO_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"INSTALACIOID" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
