--------------------------------------------------------
--  DDL for Table Z_SB999_DM_TRACTAMENT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SB999_DM_TRACTAMENT" 
   (	"ID" NUMBER(*,0), 
	"DESCRIPCIO" VARCHAR2(40 BYTE), 
	"DATA_CREACIO" DATE, 
	"DATA_MODIFICACIO" VARCHAR2(4000 BYTE), 
	"DATA_ESBORRAT" VARCHAR2(4000 BYTE), 
	"USUARI_CREACIO" VARCHAR2(4000 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(4000 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(4000 BYTE), 
	"ABREUJADA" VARCHAR2(20 BYTE), 
	"ID_ORIGINAL" VARCHAR2(5 BYTE), 
	"ESQUEMA_ORIGINAL" CHAR(6 BYTE), 
	"TABLA_ORIGINAL" CHAR(11 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
