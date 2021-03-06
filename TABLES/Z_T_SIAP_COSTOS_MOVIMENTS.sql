--------------------------------------------------------
--  DDL for Table Z_T_SIAP_COSTOS_MOVIMENTS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_SIAP_COSTOS_MOVIMENTS" 
   (	"ID" NUMBER, 
	"DATA" DATE, 
	"CODITIPUS" VARCHAR2(3 BYTE), 
	"RECEPTOR" VARCHAR2(255 BYTE), 
	"CONCEPTE" VARCHAR2(255 BYTE), 
	"REFDOC" VARCHAR2(50 BYTE), 
	"IMPORT" NUMBER(15,2), 
	"JUSTIFICAT" VARCHAR2(1 BYTE), 
	"ENTITAT" VARCHAR2(1 BYTE), 
	"REFERENT" VARCHAR2(255 BYTE), 
	"REGULARITZAT" VARCHAR2(1 BYTE), 
	"IDTIPUS_ACTE" NUMBER, 
	"SENTIT" VARCHAR2(1 BYTE), 
	"TIPUS_ACTE" VARCHAR2(255 BYTE), 
	"IMPORT_SIGNE" NUMBER(15,2), 
	"HISTORIC" VARCHAR2(1 BYTE), 
	"IDMOTIU" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
