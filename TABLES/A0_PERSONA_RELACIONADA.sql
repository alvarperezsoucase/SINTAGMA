--------------------------------------------------------
--  DDL for Table A0_PERSONA_RELACIONADA
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A0_PERSONA_RELACIONADA" 
   (	"ID" NUMBER(10,0), 
	"VINCULACIO" VARCHAR2(50 BYTE), 
	"NOM" VARCHAR2(25 BYTE), 
	"COGNOM1" VARCHAR2(25 BYTE), 
	"COGNOM2" VARCHAR2(25 BYTE), 
	"CORREU_ELECTRONIC" VARCHAR2(50 BYTE), 
	"TELEFON" VARCHAR2(15 BYTE), 
	"OBSERVACIONS" VARCHAR2(200 BYTE), 
	"DATA_CREACIO" TIMESTAMP (7), 
	"DATA_ESBORRAT" TIMESTAMP (7), 
	"DATA_MODIFICACIO" TIMESTAMP (7), 
	"USUARI_CREACIO" VARCHAR2(10 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(10 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(10 BYTE), 
	"CONTACTE_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
