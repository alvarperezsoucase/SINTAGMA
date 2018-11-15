--------------------------------------------------------
--  DDL for Table Z_SD026_SUBJECTES_UNION
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SD026_SUBJECTES_UNION" 
   (	"ID" NUMBER(*,0), 
	"NOM" VARCHAR2(100 BYTE), 
	"COGNOM1" VARCHAR2(4000 BYTE), 
	"COGNOM2" VARCHAR2(4000 BYTE), 
	"NOM_NORMALITZAT" VARCHAR2(4000 BYTE), 
	"NOMALITZAT_CONTACTE" VARCHAR2(4000 BYTE), 
	"TRACTAMENT" VARCHAR2(50 BYTE), 
	"DATA_MODIFICACIO" DATE, 
	"USUARI_MODIFICACIO" VARCHAR2(25 BYTE), 
	"TIPUS_SUBJECTE_ID" NUMBER, 
	"ID_ORIGINAL" NUMBER, 
	"ESQUEMA_ORIGINAL" CHAR(7 BYTE), 
	"TABLA_ORIGINAL" CHAR(9 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
