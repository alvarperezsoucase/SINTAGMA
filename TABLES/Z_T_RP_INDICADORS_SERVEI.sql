--------------------------------------------------------
--  DDL for Table Z_T_RP_INDICADORS_SERVEI
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_T_RP_INDICADORS_SERVEI" 
   (	"DATA" DATE, 
	"INSTALACIOID" NUMBER(38,0), 
	"NOM" VARCHAR2(100 BYTE), 
	"DESCRIPCIO" VARCHAR2(250 BYTE), 
	"Q_USUARIS" NUMBER, 
	"Q_ELEM_P" NUMBER, 
	"Q_ACCIONS" NUMBER, 
	"Q_ANNEXOS" NUMBER, 
	"Q_ELEM_S" NUMBER, 
	"ESPAI" NUMBER, 
	"M_I" CHAR(2 BYTE), 
	"REPOSITORIDIR" VARCHAR2(512 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
