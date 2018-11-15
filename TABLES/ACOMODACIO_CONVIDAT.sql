--------------------------------------------------------
--  DDL for Table ACOMODACIO_CONVIDAT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" 
   (	"ID" NUMBER(10,0), 
	"SEIENT_ID" NUMBER(10,0), 
	"ZONA_ID" NUMBER(10,0), 
	"CONVIDAT_ID" NUMBER(10,0), 
	"TIPUS_ACOMODACIO_ID" NUMBER(10,0), 
	"DATA_CREACIO" TIMESTAMP (6), 
	"DATA_MODIFICACIO" TIMESTAMP (6), 
	"DATA_ESBORRAT" TIMESTAMP (6), 
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
