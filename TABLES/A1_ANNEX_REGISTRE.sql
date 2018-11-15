--------------------------------------------------------
--  DDL for Table A1_ANNEX_REGISTRE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A1_ANNEX_REGISTRE" 
   (	"ID" NUMBER(10,0), 
	"TITOL" VARCHAR2(100 BYTE), 
	"COMENTARI" VARCHAR2(4000 BYTE), 
	"ES_CARPETA_ALCALDE" NUMBER(1,0), 
	"REGISTRE_ID" NUMBER(10,0), 
	"DOCUMENT_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
