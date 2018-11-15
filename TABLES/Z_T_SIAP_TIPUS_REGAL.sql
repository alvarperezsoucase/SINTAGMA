--------------------------------------------------------
--  DDL for Table Z_T_SIAP_TIPUS_REGAL
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_SIAP_TIPUS_REGAL" 
   (	"ID" NUMBER, 
	"TIPUS_REGAL" VARCHAR2(255 BYTE), 
	"ORDRE" NUMBER, 
	"OBSOLET" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
