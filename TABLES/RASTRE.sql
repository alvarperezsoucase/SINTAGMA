--------------------------------------------------------
--  DDL for Table RASTRE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."RASTRE" 
   (	"ID" NUMBER(10,0), 
	"TIPUS_ACCIO" VARCHAR2(50 BYTE), 
	"ACCIO" VARCHAR2(50 BYTE), 
	"DATA_INICI" TIMESTAMP (0), 
	"DATA_FI" TIMESTAMP (0), 
	"RESPONSABLE" VARCHAR2(50 BYTE), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"TIPUS_RASTRE" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;