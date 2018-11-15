--------------------------------------------------------
--  DDL for Table Z_SB999_SUBJECTE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SB999_SUBJECTE" 
   (	"ID" NUMBER(*,0), 
	"NOM" VARCHAR2(4000 BYTE), 
	"COGNOM1" VARCHAR2(35 BYTE), 
	"COGNOM2" VARCHAR2(35 BYTE), 
	"ALIES" VARCHAR2(35 BYTE), 
	"DATA_DEFUNCIO" DATE, 
	"NOM_NORMALITZAT" VARCHAR2(4000 BYTE), 
	"MOTIU_BAIXA" VARCHAR2(4000 BYTE), 
	"DATA_CREACIO" DATE, 
	"DATA_ESBORRAT" DATE, 
	"DATA_MODIFICACIO" DATE, 
	"USUARI_CREACIO" VARCHAR2(4000 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(8 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(10 BYTE), 
	"TRACTAMENT_ID" NUMBER, 
	"PRIORITAT_ID" NUMBER, 
	"TIPUS_SUBJECTE_ID" NUMBER, 
	"AMBIT_ID" NUMBER, 
	"IDIOMA_ID" VARCHAR2(4000 BYTE), 
	"ID_ORIGINAL" NUMBER(10,0), 
	"ESQUEMA_ORIGINAL" CHAR(6 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(12 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
