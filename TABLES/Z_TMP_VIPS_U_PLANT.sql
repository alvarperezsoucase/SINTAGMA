--------------------------------------------------------
--  DDL for Table Z_TMP_VIPS_U_PLANT
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_PLANT" 
   (	"CODI" VARCHAR2(5 BYTE), 
	"DESCRIPCIO" VARCHAR2(35 BYTE), 
	"TIPUS" VARCHAR2(2 BYTE), 
	"NOM_PLANT" VARCHAR2(12 BYTE), 
	"COPIES" NUMBER(2,0), 
	"EDITABLE" VARCHAR2(1 BYTE), 
	"ARXIVABLE" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "T_SINTAGMA" ;
