--------------------------------------------------------
--  DDL for Table Z_SD999_CONTACTES
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SD999_CONTACTES" 
   (	"ID" NUMBER(38,0), 
	"ES_PRINCIPAL" NUMBER, 
	"DEPARTAMENT" VARCHAR2(35 BYTE), 
	"DADES_QUALITAT" NUMBER, 
	"DATA_DARRERA_ACTUALITZACIO" DATE, 
	"DATA_CREACIO" DATE, 
	"DATA_ESBORRAT" DATE, 
	"DATA_MODIFICACIO" DATE, 
	"USUARI_CREACIO" VARCHAR2(4000 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(4000 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(25 BYTE), 
	"TIPUS_CONTACTE_ID" NUMBER, 
	"SUBJECTE_ID" NUMBER, 
	"ADRECA_ID" NUMBER, 
	"ENTITAT_ID" NUMBER, 
	"CONTACTE_ORIGEN_ID" VARCHAR2(4000 BYTE), 
	"VISIBILITAT_ID" NUMBER, 
	"AMBIT_ID" NUMBER, 
	"CARREC_ID" NUMBER, 
	"ID_ORIGINAL" NUMBER(38,0), 
	"ESQUEMA_ORIGINAL" CHAR(7 BYTE), 
	"TABLA_ORIGINAL" CHAR(9 BYTE), 
	"DATA_FI_VIGENCIA_CARREC" VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
