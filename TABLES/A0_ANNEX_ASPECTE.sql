--------------------------------------------------------
--  DDL for Table A0_ANNEX_ASPECTE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A0_ANNEX_ASPECTE" 
   (	"ID" NUMBER(10,0), 
	"TITOL" VARCHAR2(100 BYTE), 
	"COMENTARI" VARCHAR2(4000 BYTE), 
	"ES_CARPETA_ALCALDE" NUMBER(1,0), 
	"ASPECTE_ID" NUMBER(10,0), 
	"DOCUMENT_ID" NUMBER(10,0), 
	"TIPUS_SUPORT_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;