--------------------------------------------------------
--  DDL for Table Z_E162_ACCIONS_PART2
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_E162_ACCIONS_PART2" 
   (	"ACCION_ID" NUMBER(38,0), 
	"NOM_USUARI_ACCIO" VARCHAR2(201 BYTE), 
	"MATRICULA_USUARI_ACCIO" VARCHAR2(25 BYTE), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"INSTALACIOID" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
