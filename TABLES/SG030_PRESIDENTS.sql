--------------------------------------------------------
--  DDL for Table SG030_PRESIDENTS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."SG030_PRESIDENTS" 
   (	"ID" NUMBER, 
	"PRESIDENT" VARCHAR2(255 BYTE), 
	"COLNUM" NUMBER, 
	"DATA_ESBORRAT" DATE, 
	"ID_ORIGINAL" NUMBER, 
	"ESQUEMA_ORIGINAL" CHAR(4 BYTE), 
	"TABLA_ORIGINAL" CHAR(10 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
