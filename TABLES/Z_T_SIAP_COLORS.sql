--------------------------------------------------------
--  DDL for Table Z_T_SIAP_COLORS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_SIAP_COLORS" 
   (	"ID" NUMBER, 
	"CONTROL_NAME" VARCHAR2(50 BYTE), 
	"DESCRIPCIO" VARCHAR2(150 BYTE), 
	"COLOR" NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
