--------------------------------------------------------
--  DDL for Index UK_DM_TIPUS_ARG
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."UK_DM_TIPUS_ARG" ON "SINTAGMA_U"."DM_TIPUS_ARG" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
