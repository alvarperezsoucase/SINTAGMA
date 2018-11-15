--------------------------------------------------------
--  DDL for Index A1_FKDM_ESPECIFIC
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A1_FKDM_ESPECIFIC" ON "SINTAGMA_U"."A1_DM_ESPECIFIC" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
