--------------------------------------------------------
--  DDL for Table A0_PLANTILLA_CONFIG_ESPAI
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A0_PLANTILLA_CONFIG_ESPAI" 
   (	"ID" NUMBER(10,0), 
	"FILA" NUMBER(10,0), 
	"COLUMNA" NUMBER(10,0), 
	"ES_HABILITAT" NUMBER(1,0), 
	"PLANTILLA_ID" NUMBER(10,0), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
