--------------------------------------------------------
--  DDL for Table Z_SC999_DM_ENTITAT_CONTACTE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SC999_DM_ENTITAT_CONTACTE" 
   (	"ID" NUMBER(*,0), 
	"CODI" VARCHAR2(4000 BYTE), 
	"DESCRIPCIO" VARCHAR2(100 BYTE), 
	"DATA_CREACIO" DATE, 
	"DATA_ESBORRAT" DATE, 
	"DATA_MODIFICACIO" DATE, 
	"USUARI_CREACIO" VARCHAR2(4000 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(4000 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(4000 BYTE), 
	"ID_ORIGINAL" VARCHAR2(100 BYTE), 
	"ESQUEMA_ORIGINAL" CHAR(6 BYTE), 
	"TABLA_ORIGINAL" CHAR(13 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
