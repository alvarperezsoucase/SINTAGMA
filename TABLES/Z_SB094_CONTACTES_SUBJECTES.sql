--------------------------------------------------------
--  DDL for Table Z_SB094_CONTACTES_SUBJECTES
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SB094_CONTACTES_SUBJECTES" 
   (	"ID" NUMBER(*,0), 
	"ES_PRINCIPAL" VARCHAR2(1 BYTE), 
	"CARREC_ID" NUMBER, 
	"DEPARTAMENT" VARCHAR2(4000 BYTE), 
	"DADES_QUALITAT" NUMBER, 
	"DATA_DARRERA_ACTUALITZACIO" DATE, 
	"DATA_CREACIO" DATE, 
	"DATA_MODIFICACIO" DATE, 
	"DATA_ESBORRAT" TIMESTAMP (7), 
	"USUARI_CREACIO" VARCHAR2(10 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(10 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(10 BYTE), 
	"TIPUS_CONTACTE_ID" NUMBER, 
	"SUBJECTE_ID" NUMBER, 
	"ADRECA_ID" NUMBER, 
	"ENTITAT_ID" NUMBER, 
	"VISIBILITAT_ID" NUMBER, 
	"AMBIT_ID" NUMBER, 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" CHAR(4 BYTE), 
	"TABLA_ORIGINAL" CHAR(6 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
