--------------------------------------------------------
--  DDL for Table BDANI_TB_ENTITAT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."BDANI_TB_ENTITAT" 
   (	"ID" NUMBER(*,0), 
	"CODI" VARCHAR2(5 BYTE), 
	"ENTITAT" VARCHAR2(108 BYTE), 
	"ENTITAT_NORM" VARCHAR2(80 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
