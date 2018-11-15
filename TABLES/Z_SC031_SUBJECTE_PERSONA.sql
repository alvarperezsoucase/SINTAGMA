--------------------------------------------------------
--  DDL for Table Z_SC031_SUBJECTE_PERSONA
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SC031_SUBJECTE_PERSONA" 
   (	"ID_SUBJECTE" VARCHAR2(100 BYTE), 
	"NC" VARCHAR2(100 BYTE), 
	"NOM" VARCHAR2(100 BYTE), 
	"COGNOM1" VARCHAR2(100 BYTE), 
	"COGNOM2" VARCHAR2(100 BYTE), 
	"ALIES" VARCHAR2(100 BYTE), 
	"DATA_DEFUNCIO" VARCHAR2(100 BYTE), 
	"ES_PROVISIONAL" NUMBER, 
	"NOM_NORMALITZAT" VARCHAR2(4000 BYTE), 
	"MOTIU_BAIXA" VARCHAR2(4000 BYTE), 
	"DATA_CREACIO" DATE, 
	"DATA_ESBORRAT" DATE, 
	"DATA_MODIFICACIO" DATE, 
	"USUARI_CREACIO" VARCHAR2(4000 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(4000 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(4000 BYTE), 
	"TRACTAMENT_ID" NUMBER, 
	"PRIORITAT_ID" VARCHAR2(4000 BYTE), 
	"TIPUS_SUBJECTE_ID" NUMBER, 
	"AMBIT_ID" NUMBER, 
	"IDIOMA_ID" NUMBER, 
	"ARTICLE_ID" VARCHAR2(4000 BYTE), 
	"ID_ORIGINAL" VARCHAR2(100 BYTE), 
	"ESQUEMA_ORIGINAL" CHAR(6 BYTE), 
	"TABLA_ORIGINAL" CHAR(27 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
