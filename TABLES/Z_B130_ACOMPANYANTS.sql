--------------------------------------------------------
--  DDL for Table Z_B130_ACOMPANYANTS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_B130_ACOMPANYANTS" 
   (	"N_VIP" NUMBER(10,0), 
	"TRACTAMENT_A" VARCHAR2(5 BYTE), 
	"NOM_A" VARCHAR2(15 BYTE), 
	"COGNOM_A_1" VARCHAR2(35 BYTE), 
	"COGNOM_A_2" VARCHAR2(35 BYTE), 
	"DATA_ALTA" DATE, 
	"DATA_MODIF" DATE, 
	"DATA_BAIXA" DATE, 
	"USU_ALTA" VARCHAR2(10 BYTE), 
	"USU_MODIF" VARCHAR2(10 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
