--------------------------------------------------------
--  DDL for Table Z_T_RC_AREES
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_RC_AREES" 
   (	"ID_RIS" VARCHAR2(10 BYTE), 
	"AMBF" VARCHAR2(4 BYTE), 
	"CODIGO" VARCHAR2(2 BYTE), 
	"DESCRIPCION" VARCHAR2(60 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
