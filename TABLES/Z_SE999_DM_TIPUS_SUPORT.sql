--------------------------------------------------------
--  DDL for Table Z_SE999_DM_TIPUS_SUPORT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SE999_DM_TIPUS_SUPORT" 
   (	"ID" NUMBER(38,0), 
	"CODI" NUMBER(38,0), 
	"DESCRIPCIO" VARCHAR2(50 BYTE), 
	"DATA_CREACIO" DATE, 
	"DATA_MODIFICACIO" TIMESTAMP (9), 
	"DATA_ESBORRAT" TIMESTAMP (9), 
	"USUARI_CREACIO" VARCHAR2(4000 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(4000 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(4000 BYTE), 
	"AMBIT_ID" NUMBER, 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"INSTALACIOID" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
