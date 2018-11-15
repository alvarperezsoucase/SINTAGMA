--------------------------------------------------------
--  DDL for Table A1_ELEMENT_SECUNDARI
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."A1_ELEMENT_SECUNDARI" 
   (	"ID" NUMBER(10,0), 
	"NUMERO_REGISTRE" NUMBER(10,0), 
	"ES_RELACIO_ENTRADA" NUMBER(1,0), 
	"DATA_RELACIO_ENTRADA" TIMESTAMP (0), 
	"ES_VALIDAT_RE" NUMBER(1,0), 
	"DATA_REGISTRE_GENERAL" TIMESTAMP (0), 
	"DATA_DOCUMENT" TIMESTAMP (0), 
	"COMENTARIS" VARCHAR2(4000 BYTE), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"ASPECTE_ID" NUMBER(10,0), 
	"ELEMENT_PRINCIPAL_ID" NUMBER(10,0), 
	"TIPUS_SUPORT_ID" NUMBER(10,0), 
	"ORIGEN_ID" NUMBER(10,0), 
	"PREFIX_ID" NUMBER(10,0), 
	"NUMERO_REGISTRE_GENERAL_ID" NUMBER(10,0), 
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
