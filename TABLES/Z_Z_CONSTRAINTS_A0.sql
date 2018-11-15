--------------------------------------------------------
--  DDL for Table Z_Z_CONSTRAINTS_A0
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_Z_CONSTRAINTS_A0" 
   (	"TABLA" VARCHAR2(30 BYTE), 
	"ESQUEMA" CHAR(3 BYTE), 
	"TABLA_SINTAGMA" VARCHAR2(30 BYTE), 
	"TOTAL_CONSTRAINT" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;