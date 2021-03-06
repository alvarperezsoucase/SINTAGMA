--------------------------------------------------------
--  DDL for Table Z_T_RP_NAVEGACIONS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_RP_NAVEGACIONS" 
   (	"NAVEGACIOID" NUMBER(38,0), 
	"CODIPANTALLAORIGEN" VARCHAR2(100 BYTE), 
	"ACCIOSORTIDA" VARCHAR2(100 BYTE), 
	"CODIPANTALLADESTI" VARCHAR2(100 BYTE), 
	"MODEOBERTURA" VARCHAR2(50 BYTE), 
	"ESPASSENPARAMS" CHAR(1 BYTE), 
	"TIPUSENTITATPASSAT" VARCHAR2(50 BYTE), 
	"PARAMPASSAT" VARCHAR2(100 BYTE), 
	"CALTANCAR" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
