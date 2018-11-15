--------------------------------------------------------
--  DDL for Table A0_DADES_HISTORIC
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" 
   (	"ID" NUMBER(10,0), 
	"TAULA" VARCHAR2(25 BYTE), 
	"CAMP" VARCHAR2(50 BYTE), 
	"VALOR" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(10 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(10 BYTE), 
	"USUARI_CREACIO" VARCHAR2(10 BYTE), 
	"DATA_MODIFICACIO" TIMESTAMP (7), 
	"DATA_ESBORRAT" TIMESTAMP (7), 
	"DATA_CREACIO" TIMESTAMP (7), 
	"CONTACTE_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
