--------------------------------------------------------
--  DDL for Table Z_T_SIAP_VIPS_CLASSIFICACIO
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_SIAP_VIPS_CLASSIFICACIO" 
   (	"ID" NUMBER, 
	"IDVIP" NUMBER, 
	"IDCLASSIFICACIO" NUMBER, 
	"ORDRE" NUMBER, 
	"IDCARREC" NUMBER, 
	"IDENTITAT" NUMBER, 
	"IDADRECA" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
