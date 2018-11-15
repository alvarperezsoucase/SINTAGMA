--------------------------------------------------------
--  DDL for Table Z_B004_SUBJECTES_ID
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_B004_SUBJECTES_ID" 
   (	"ID_CONTACTE" NUMBER(*,0), 
	"COGNOM1" VARCHAR2(35 BYTE), 
	"COGNOM2" VARCHAR2(35 BYTE), 
	"ALIES_VIPS" VARCHAR2(35 BYTE), 
	"N_VIP" NUMBER(10,0), 
	"N_PRELACIO" NUMBER(4,0), 
	"TRACTAMENT" VARCHAR2(5 BYTE), 
	"COGNOMS" VARCHAR2(35 BYTE), 
	"NOM" VARCHAR2(15 BYTE), 
	"CARREC" VARCHAR2(40 BYTE), 
	"ENTITAT" VARCHAR2(35 BYTE), 
	"ADRECA_P" VARCHAR2(100 BYTE), 
	"MUNICIPI_P" VARCHAR2(30 BYTE), 
	"PROVINCIA_P" VARCHAR2(30 BYTE), 
	"PAIS_P" VARCHAR2(30 BYTE), 
	"CP_P" VARCHAR2(10 BYTE), 
	"ADRECA_O" VARCHAR2(35 BYTE), 
	"MUNICIPI_O" VARCHAR2(30 BYTE), 
	"PROVINCIA_O" VARCHAR2(30 BYTE), 
	"PAIS_O" VARCHAR2(30 BYTE), 
	"CP_O" VARCHAR2(10 BYTE), 
	"TELEFON1" VARCHAR2(14 BYTE), 
	"TELEFON2" VARCHAR2(14 BYTE), 
	"TELEFON_MOBIL" VARCHAR2(14 BYTE), 
	"FAX" VARCHAR2(14 BYTE), 
	"INTERNET" VARCHAR2(99 BYTE), 
	"DIA_SANT" NUMBER(2,0), 
	"MES_SANT" NUMBER(2,0), 
	"DATA_CUMPLE" DATE, 
	"TRACTAMENT_A" VARCHAR2(5 BYTE), 
	"EN_CALIDAD_DE_A" VARCHAR2(35 BYTE), 
	"COGNOMS_A" VARCHAR2(35 BYTE), 
	"NOM_A" VARCHAR2(15 BYTE), 
	"DIA_SANT_A" NUMBER(2,0), 
	"MES_SANT_A" NUMBER(2,0), 
	"DATA_CUMPLE_A" DATE, 
	"USU_ALTA" VARCHAR2(10 BYTE), 
	"DATA_ALTA" DATE, 
	"USU_MODIF" VARCHAR2(10 BYTE), 
	"DATA_MODIF" DATE, 
	"DATA_BAIXA" DATE, 
	"MOTIU_BAIXA" VARCHAR2(35 BYTE), 
	"OBSERVACIONS" VARCHAR2(800 BYTE), 
	"ENTITAT_O" VARCHAR2(35 BYTE), 
	"DEPART_O" VARCHAR2(35 BYTE), 
	"CARREC_O" VARCHAR2(35 BYTE), 
	"FELICITAR" VARCHAR2(1 BYTE), 
	"TELEFON_P" VARCHAR2(14 BYTE), 
	"DIA_CUMPLE" NUMBER(2,0), 
	"MES_CUMPLE" NUMBER(2,0), 
	"ANY_CUMPLE" NUMBER(4,0), 
	"DIA_CUMPLE_A" NUMBER(2,0), 
	"MES_CUMPLE_A" NUMBER(2,0), 
	"ANY_CUMPLE_A" NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;