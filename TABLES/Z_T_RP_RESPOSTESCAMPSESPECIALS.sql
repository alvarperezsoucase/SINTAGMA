--------------------------------------------------------
--  DDL for Table Z_T_RP_RESPOSTESCAMPSESPECIALS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_RP_RESPOSTESCAMPSESPECIALS" 
   (	"RESPOSTACAMPSESPECIALSID" NUMBER(38,0), 
	"ASPECTEID" NUMBER(38,0), 
	"RESPOSTACAMPA" VARCHAR2(100 BYTE), 
	"RESPOSTACAMPB" VARCHAR2(100 BYTE), 
	"RESPOSTACAMPC" VARCHAR2(100 BYTE), 
	"INFORMACIOADICIONAL" VARCHAR2(100 BYTE), 
	"RESPOSTACAMPDATAD" DATE, 
	"RESPOSTACAMPDATAE" DATE, 
	"RESPOSTACAMPF" NUMBER(38,0), 
	"RESPOSTACAMPG" NUMBER(38,0), 
	"RESPOSTACAMPH" NUMBER(38,0), 
	"RESPOSTACAMPI" NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
