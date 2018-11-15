--------------------------------------------------------
--  DDL for Table TITULAR_FORA
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."TITULAR_FORA" 
   (	"ID" NUMBER(10,0), 
	"NOM" VARCHAR2(50 BYTE), 
	"COGNOM1" VARCHAR2(50 BYTE), 
	"COGNOM2" VARCHAR2(50 BYTE), 
	"TIPUS_CONTACTE" VARCHAR2(20 BYTE), 
	"ENTITAT" VARCHAR2(100 BYTE), 
	"DEPARTAMENT" VARCHAR2(100 BYTE), 
	"CARREC" VARCHAR2(50 BYTE), 
	"DATA_VIGENCIA_CARREC" TIMESTAMP (0), 
	"NOM_CARRER" VARCHAR2(1000 BYTE), 
	"CODI_CARRER" VARCHAR2(10 BYTE), 
	"NUMERO_INICI" NUMBER(10,0), 
	"LLETRA_INICI" VARCHAR2(10 BYTE), 
	"NUMERO_FI" NUMBER(10,0), 
	"LLETRA_FI" VARCHAR2(10 BYTE), 
	"PIS" VARCHAR2(20 BYTE) DEFAULT '[TEST]', 
	"PORTA" VARCHAR2(20 BYTE), 
	"ESCALA" VARCHAR2(10 BYTE), 
	"BLOC" VARCHAR2(20 BYTE), 
	"CODI_POSTAL" VARCHAR2(10 BYTE), 
	"COORDENADA_X" VARCHAR2(25 BYTE), 
	"COORDENADA_Y" VARCHAR2(25 BYTE), 
	"SECCIO_CENSAL" VARCHAR2(25 BYTE), 
	"ANY_CONST" VARCHAR2(4 BYTE), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"ASPECTE_ID" NUMBER(10,0), 
	"CONTACTE_ID" NUMBER(10,0), 
	"CODI_MUNICIPI" VARCHAR2(10 BYTE), 
	"MUNICIPI" VARCHAR2(50 BYTE), 
	"CODI_PROVINCIA" VARCHAR2(10 BYTE), 
	"PROVINCIA" VARCHAR2(50 BYTE), 
	"CODI_PAIS" VARCHAR2(10 BYTE), 
	"PAIS" VARCHAR2(50 BYTE), 
	"CODI_TIPUS_VIA" VARCHAR2(10 BYTE), 
	"CODI_BARRI" VARCHAR2(10 BYTE), 
	"BARRI" VARCHAR2(100 BYTE), 
	"DISTRICTE" VARCHAR2(100 BYTE), 
	"CODI_DISTRICTE" VARCHAR2(10 BYTE), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TRACTAMENT_ID" NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
