--------------------------------------------------------
--  DDL for Table Z_T_RP_PLANTILLES_BCK
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_RP_PLANTILLES_BCK" 
   (	"PLANTILLAID" NUMBER(38,0), 
	"INSTALACIOID" NUMBER(38,0), 
	"DESCRIPCIO" VARCHAR2(512 BYTE), 
	"NOMFITXER" VARCHAR2(100 BYTE), 
	"NUMCOPIES" NUMBER(3,0), 
	"ESEDITABLE" CHAR(1 BYTE), 
	"ESARXIVABLE" CHAR(1 BYTE), 
	"TIPUSPLANTILLAID" NUMBER(38,0), 
	"ENTITATDOCUMENTUMID" VARCHAR2(64 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
