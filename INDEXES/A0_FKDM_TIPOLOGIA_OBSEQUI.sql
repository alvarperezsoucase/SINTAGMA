--------------------------------------------------------
--  DDL for Index A0_FKDM_TIPOLOGIA_OBSEQUI
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_TIPOLOGIA_OBSEQUI" ON "SINTAGMA_U"."A0_DM_TIPOLOGIA_OBSEQUI" ("DESCRIPCIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA" ;
