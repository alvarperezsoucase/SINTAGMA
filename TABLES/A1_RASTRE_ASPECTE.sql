--------------------------------------------------------
--  DDL for Table A1_RASTRE_ASPECTE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" 
   (	"ID" NUMBER(10,0), 
	"RASTRE_ID" NUMBER(10,0), 
	"ASPECTE_ID" NUMBER(10,0), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
