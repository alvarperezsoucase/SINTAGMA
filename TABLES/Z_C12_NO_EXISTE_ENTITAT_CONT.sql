--------------------------------------------------------
--  DDL for Table Z_C12_NO_EXISTE_ENTITAT_CONT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_C12_NO_EXISTE_ENTITAT_CONT" 
   (	"ID_ENTITAT_SINTAGMA" NUMBER, 
	"ID_CONTACTE" VARCHAR2(100 BYTE), 
	"NOM_ENTITAT" VARCHAR2(100 BYTE), 
	"NOM_NORMALITZAT" VARCHAR2(4000 BYTE), 
	"DATA_DARRERA" DATE, 
	"DATA_BAIXA" DATE, 
	"DATA_ALTA" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;