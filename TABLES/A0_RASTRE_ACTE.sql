--------------------------------------------------------
--  DDL for Table A0_RASTRE_ACTE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A0_RASTRE_ACTE" 
   (	"ID" NUMBER(10,0), 
	"RASTRE_ID" NUMBER(10,0), 
	"ACTE_ID" NUMBER(10,0), 
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
