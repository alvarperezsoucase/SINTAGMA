--------------------------------------------------------
--  DDL for Table OBSEQUI_INVENTARI
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."OBSEQUI_INVENTARI" 
   (	"ID" NUMBER(10,0), 
	"QUANTITAT" NUMBER(10,0), 
	"DATA_CREACIO" TIMESTAMP (7), 
	"DATA_ESBORRAT" TIMESTAMP (7), 
	"DATA_MODIFICACIO" TIMESTAMP (7), 
	"USUARI_CREACIO" VARCHAR2(10 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(10 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(10 BYTE), 
	"OBSEQUI_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
