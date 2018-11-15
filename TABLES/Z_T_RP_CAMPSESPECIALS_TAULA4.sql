--------------------------------------------------------
--  DDL for Table Z_T_RP_CAMPSESPECIALS_TAULA4
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_RP_CAMPSESPECIALS_TAULA4" 
   (	"TAULA4ID" NUMBER(38,0), 
	"NOM" VARCHAR2(100 BYTE), 
	"INSTALACIOID" NUMBER(38,0), 
	"TAULA3ID" NUMBER(38,0), 
	"ESVALORDEFECTE" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
