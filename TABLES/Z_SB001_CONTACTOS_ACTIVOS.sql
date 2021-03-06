--------------------------------------------------------
--  DDL for Table Z_SB001_CONTACTOS_ACTIVOS
--------------------------------------------------------

  CREATE TABLE "SINTAGMA_U"."Z_SB001_CONTACTOS_ACTIVOS" 
   (	"ID_CONTACTE" NUMBER(*,0), 
	"N_VIP" NUMBER(10,0), 
	"CONTACTE_NORMALIZADO" VARCHAR2(4000 BYTE), 
	"CARREC" VARCHAR2(4000 BYTE), 
	"ENTITAT" VARCHAR2(4000 BYTE), 
	"MUNICIPI" VARCHAR2(4000 BYTE), 
	"ADRECA" VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
