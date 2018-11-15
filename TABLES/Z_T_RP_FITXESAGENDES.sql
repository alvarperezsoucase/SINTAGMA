--------------------------------------------------------
--  DDL for Table Z_T_RP_FITXESAGENDES
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_RP_FITXESAGENDES" 
   (	"FITXAAGENDAID" NUMBER(38,0), 
	"AFECTAAGENDA" CHAR(1 BYTE), 
	"DATAINICI" DATE, 
	"DATAFINAL" DATE, 
	"LLOCID" NUMBER(38,0), 
	"ADRECA" VARCHAR2(1024 BYTE), 
	"DISTRICTEID" NUMBER(38,0), 
	"TITULARID" NUMBER(38,0), 
	"DECISIOID" NUMBER(38,0), 
	"DELEGACIOID" NUMBER(38,0), 
	"ACOMPANYANTS" VARCHAR2(2048 BYTE), 
	"VALORACIO" VARCHAR2(4000 BYTE), 
	"ASSISTENTS" VARCHAR2(2048 BYTE), 
	"ASPECTEID" NUMBER(38,0), 
	"DATAASSENTAMENT" DATE, 
	"ASSUMPTE" VARCHAR2(1024 BYTE), 
	"INSTALACIOID" NUMBER(38,0), 
	"DELEGACIOAMP" VARCHAR2(200 BYTE), 
	"DATAACTE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;