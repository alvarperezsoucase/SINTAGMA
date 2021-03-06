--------------------------------------------------------
--  DDL for Table Z_TMP_CALIMA_U_HIST_TRUCADA
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_TMP_CALIMA_U_HIST_TRUCADA" 
   (	"ESTAT" VARCHAR2(100 BYTE), 
	"INT" VARCHAR2(100 BYTE), 
	"N" VARCHAR2(100 BYTE), 
	"QUI" VARCHAR2(100 BYTE), 
	"E_S" VARCHAR2(100 BYTE), 
	"DARRERA_INTERV" VARCHAR2(100 BYTE), 
	"NOM" VARCHAR2(100 BYTE), 
	"NOM2" VARCHAR2(100 BYTE), 
	"COGNOM_1" VARCHAR2(100 BYTE), 
	"COGNOM_2" VARCHAR2(100 BYTE), 
	"CARREC" VARCHAR2(100 BYTE), 
	"ORGANISME_" VARCHAR2(100 BYTE), 
	"E_S3" VARCHAR2(100 BYTE), 
	"REGISTRE" VARCHAR2(100 BYTE), 
	"ASSUMPTE" VARCHAR2(100 BYTE), 
	"COMENTARI" VARCHAR2(100 BYTE), 
	"TEL_CONTACTAT" VARCHAR2(100 BYTE), 
	"TEL_FIX_DIRECTE" VARCHAR2(100 BYTE), 
	"TEL_FIX_ALTRES" VARCHAR2(100 BYTE), 
	"TEL_MOBIL" VARCHAR2(100 BYTE), 
	"TEL_FIX_CENTRALITA" VARCHAR2(100 BYTE), 
	"TEL_VERMELL" VARCHAR2(100 BYTE), 
	"TEL_PARTICULAR" VARCHAR2(100 BYTE), 
	"TEL_COTXE" VARCHAR2(100 BYTE), 
	"SENTIT_FALLIT" VARCHAR2(100 BYTE), 
	"DATA_FALLIT" VARCHAR2(100 BYTE), 
	"CAUSA_FALLIT" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
