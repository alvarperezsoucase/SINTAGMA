--------------------------------------------------------
--  DDL for Table A0_DM_ORIGEN_ELEMENT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A0_DM_ORIGEN_ELEMENT" 
   (	"ID" NUMBER(10,0), 
	"CODI" VARCHAR2(50 BYTE), 
	"DESCRIPCIO" VARCHAR2(50 BYTE), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"AMBIT_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"INSTALACIOID" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
