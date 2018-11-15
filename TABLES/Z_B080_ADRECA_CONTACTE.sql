--------------------------------------------------------
--  DDL for Table Z_B080_ADRECA_CONTACTE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_B080_ADRECA_CONTACTE" 
   (	"ID_ADRECA" NUMBER(*,0), 
	"ID_CONTACTE" NUMBER(*,0), 
	"ADRECA" VARCHAR2(100 BYTE), 
	"MUNICIPI" VARCHAR2(30 BYTE), 
	"CP" VARCHAR2(10 BYTE), 
	"PROVINCIA" VARCHAR2(30 BYTE), 
	"PAIS" VARCHAR2(30 BYTE), 
	"USU_ALTA" VARCHAR2(10 BYTE), 
	"DATA_ALTA" DATE, 
	"USU_MODI" VARCHAR2(10 BYTE), 
	"DATA_MODI" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
