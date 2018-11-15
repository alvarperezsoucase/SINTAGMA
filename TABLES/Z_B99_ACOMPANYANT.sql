--------------------------------------------------------
--  DDL for Table Z_B99_ACOMPANYANT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_B99_ACOMPANYANT" 
   (	"ID" NUMBER(10,0), 
	"NOM" VARCHAR2(20 BYTE), 
	"COGNOM1" VARCHAR2(40 BYTE), 
	"COGNOM2" VARCHAR2(40 BYTE), 
	"DATA_CREACIO" TIMESTAMP (7), 
	"DATA_ESBORRAT" TIMESTAMP (7), 
	"DATA_MODIFICACIO" TIMESTAMP (7), 
	"USUARI_CREACIO" VARCHAR2(10 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(10 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(10 BYTE), 
	"TRACTAMENT_ID" NUMBER(10,0), 
	"CONTACTE_ID" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
