--------------------------------------------------------
--  DDL for Table ERR_ELEMENTS_PR_SUPPORT_NULL
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."ERR_ELEMENTS_PR_SUPPORT_NULL" 
   (	"ASPECTEID" NUMBER(38,0), 
	"ACCIOID" NUMBER(38,0), 
	"ESENTRADA" CHAR(1 BYTE), 
	"NUMEROREGISTREPREFIXID" NUMBER(38,0), 
	"DATAASSENTAMENT" DATE, 
	"NUMREGISTREGENERAL" VARCHAR2(50 BYTE), 
	"DATAENTRADAREGISTREGENERAL" DATE, 
	"EXTRACTE" VARCHAR2(1024 BYTE), 
	"TIPUSSUPORTID" NUMBER(38,0), 
	"DATADOCUMENT" DATE, 
	"COMENTARIS" VARCHAR2(4000 BYTE), 
	"NUMEROREGISTRESUFIX" VARCHAR2(100 BYTE), 
	"ESTAACTIU" CHAR(1 BYTE), 
	"TITULARFORAID" NUMBER(38,0), 
	"TITULARDINSID" NUMBER(38,0), 
	"TIPUS" VARCHAR2(50 BYTE), 
	"BLOQUEJARPER" NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
