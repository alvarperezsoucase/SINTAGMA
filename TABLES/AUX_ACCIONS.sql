--------------------------------------------------------
--  DDL for Table AUX_ACCIONS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."AUX_ACCIONS" 
   (	"ASPECTEID" NUMBER(38,0), 
	"ACCIOORIGEN" NUMBER(38,0), 
	"DATAINICI" DATE, 
	"SUBTIPUSACCIOID" NUMBER(38,0), 
	"COMENTARI" VARCHAR2(4000 BYTE), 
	"PRIORITATID" NUMBER(38,0), 
	"DATATERMINI" DATE, 
	"ESPERARESPOSTA" CHAR(1 BYTE), 
	"RESPOSTA" VARCHAR2(4000 BYTE), 
	"DATAFINALITZACIO" DATE, 
	"ACCIOREGISTRESECUNDARIS" NUMBER(38,0), 
	"ESASSABENTAT" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
