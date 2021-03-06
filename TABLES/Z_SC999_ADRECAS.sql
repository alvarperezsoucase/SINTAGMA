--------------------------------------------------------
--  DDL for Table Z_SC999_ADRECAS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SC999_ADRECAS" 
   (	"ADRECA_ID" NUMBER(*,0), 
	"ID_CONTACTE" VARCHAR2(100 BYTE), 
	"DIRECCIO" VARCHAR2(100 BYTE), 
	"POBLACIO" VARCHAR2(100 BYTE), 
	"PROVINCIA" VARCHAR2(100 BYTE), 
	"PAIS" VARCHAR2(100 BYTE), 
	"CODI_POSTAL" VARCHAR2(100 BYTE), 
	"DATA_CREACIO" VARCHAR2(100 BYTE), 
	"DATA_ESBORRAT" VARCHAR2(100 BYTE), 
	"DATA_MODIFICACIO" VARCHAR2(100 BYTE), 
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
