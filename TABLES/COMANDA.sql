--------------------------------------------------------
--  DDL for Table COMANDA
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."COMANDA" 
   (	"ID" NUMBER(10,0), 
	"DATA_PETICIO" TIMESTAMP (0), 
	"TITOL" VARCHAR2(100 BYTE), 
	"COST_APROXIMAT" NUMBER(19,4), 
	"COMENTARIS" VARCHAR2(4000 BYTE), 
	"VALORACIO" NUMBER(10,0), 
	"COST_REAL" NUMBER(19,4), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"TIPUS_SERVEI_ID" NUMBER(10,0), 
	"ACTE_ID" NUMBER(10,0), 
	"ESTAT_COMANDA_ID" NUMBER(10,0), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"NOM_TECNIC_RESPONSABLE" VARCHAR2(50 BYTE), 
	"MATRICULA_TECNIC_RESPONSABLE" VARCHAR2(50 BYTE), 
	"CODI_CONTRACTE" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;