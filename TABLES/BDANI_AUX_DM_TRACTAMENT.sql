--------------------------------------------------------
--  DDL for Table BDANI_AUX_DM_TRACTAMENT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."BDANI_AUX_DM_TRACTAMENT" 
   (	"ID" VARCHAR2(5 BYTE), 
	"CODI" VARCHAR2(5 BYTE), 
	"DESCRIPCIO" VARCHAR2(40 BYTE), 
	"ABREUJADA" VARCHAR2(20 BYTE), 
	"DATA_CREACIO" DATE, 
	"DATA_MODIFICACIO" DATE, 
	"DATA_ESBORRAT" DATE, 
	"USUARI_CREACIO" CHAR(8 BYTE), 
	"USUARI_MODIFICACIO" CHAR(1 BYTE), 
	"USUARI_BAIXA" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
