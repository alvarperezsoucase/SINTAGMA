--------------------------------------------------------
--  DDL for Table Z_SG118_CONVIDAT_FINAL
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SG118_CONVIDAT_FINAL" 
   (	"ID" NUMBER(10,0), 
	"TRACTAMENT" VARCHAR2(20 BYTE), 
	"NOM" VARCHAR2(50 BYTE), 
	"COGNOM1" VARCHAR2(50 BYTE), 
	"COGNOM2" VARCHAR2(50 BYTE), 
	"TIPUS_CONTACTE" VARCHAR2(20 BYTE), 
	"ENTITAT" VARCHAR2(100 BYTE), 
	"DEPARTAMENT" VARCHAR2(100 BYTE), 
	"CARREC" VARCHAR2(100 BYTE), 
	"NOM_CARRER" VARCHAR2(1000 BYTE), 
	"CODI_CARRER" VARCHAR2(10 BYTE), 
	"PIS" VARCHAR2(22 BYTE), 
	"PORTA" VARCHAR2(22 BYTE), 
	"LLETRA_INICI" VARCHAR2(10 BYTE), 
	"LLETRA_FI" VARCHAR2(10 BYTE), 
	"ESCALA" VARCHAR2(10 BYTE), 
	"BLOC" VARCHAR2(22 BYTE), 
	"CODI_POSTAL" VARCHAR2(10 BYTE), 
	"COORDENADA_X" VARCHAR2(25 BYTE), 
	"COORDENADA_Y" VARCHAR2(25 BYTE), 
	"SECCIO_CENSAL" VARCHAR2(25 BYTE), 
	"ANY_CONST" VARCHAR2(4 BYTE), 
	"NUMERO_INICI" NUMBER(10,0), 
	"NUMERO_FI" NUMBER(10,0), 
	"DATA_ENVIAMENT_INVITACIO" TIMESTAMP (0), 
	"ES_CONFIRMA_RECEPCIO_INVITACIO" NUMBER(1,0), 
	"CODI_ACUS_REBUT" NUMBER(10,0), 
	"DATA_ACUS_REBUT" TIMESTAMP (0), 
	"DATA_CONFIRMACIO" TIMESTAMP (0), 
	"NOM_PERSONA_DELEGA" VARCHAR2(150 BYTE), 
	"CARREC_PERSONA_DELEGA" VARCHAR2(22 BYTE), 
	"ENTITAT_PERSONA_DELEGA" VARCHAR2(22 BYTE), 
	"OBSERVACIONS" VARCHAR2(4000 BYTE), 
	"DATA_ACTUALITZACIO_ASSISTENCIA" TIMESTAMP (0), 
	"CODI_CLASSIFICACIO" VARCHAR2(50 BYTE), 
	"NOM_CLASSIFICACIO" VARCHAR2(100 BYTE), 
	"DATA_CREACIO" TIMESTAMP (0), 
	"DATA_ESBORRAT" TIMESTAMP (0), 
	"DATA_MODIFICACIO" TIMESTAMP (0), 
	"USUARI_CREACIO" VARCHAR2(50 BYTE), 
	"USUARI_ESBORRAT" VARCHAR2(50 BYTE), 
	"USUARI_MODIFICACIO" VARCHAR2(50 BYTE), 
	"CONTACTE_ID" NUMBER(10,0), 
	"ACTE_ID" NUMBER(10,0), 
	"ESTAT_CONFIRMACIO_ID" NUMBER(10,0), 
	"TIPUS_VIA_INVITACIO_ID" NUMBER(10,0), 
	"INICIATIVA_RESPOSTA_ID" NUMBER(10,0), 
	"TIPUS_VIA_RESPOSTA_ID" NUMBER(10,0), 
	"PRIORITAT" VARCHAR2(50 BYTE), 
	"CODI_MUNICIPI" VARCHAR2(10 BYTE), 
	"MUNICIPI" VARCHAR2(50 BYTE), 
	"CODI_PROVINCIA" VARCHAR2(10 BYTE), 
	"PROVINCIA" VARCHAR2(50 BYTE), 
	"CODI_PAIS" VARCHAR2(10 BYTE), 
	"PAIS" VARCHAR2(50 BYTE), 
	"CODI_TIPUS_VIA" VARCHAR2(10 BYTE), 
	"CODI_BARRI" VARCHAR2(10 BYTE), 
	"BARRI" VARCHAR2(100 BYTE), 
	"CODI_DISTRICTE" VARCHAR2(10 BYTE), 
	"DISTRICTE" VARCHAR2(100 BYTE), 
	"ID_ORIGINAL" VARCHAR2(30 BYTE), 
	"ESQUEMA_ORIGINAL" VARCHAR2(30 BYTE), 
	"TABLA_ORIGINAL" VARCHAR2(30 BYTE), 
	"DECISIO_ASSISTENCIA_ID" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
