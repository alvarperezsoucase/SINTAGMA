--------------------------------------------------------
--  DDL for Table BDANI_TB_CLASSIF_CONTACTE
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."BDANI_TB_CLASSIF_CONTACTE" 
   (	"ID_CONTACTE" NUMBER(*,0), 
	"CLASSIF" VARCHAR2(5 BYTE), 
	"N_PRELACIO" NUMBER(4,0), 
	"ID_CLASSIFICACIO" NUMBER(10,0), 
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