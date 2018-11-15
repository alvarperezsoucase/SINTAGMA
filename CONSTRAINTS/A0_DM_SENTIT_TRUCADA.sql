--------------------------------------------------------
--  Constraints for Table A0_DM_SENTIT_TRUCADA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_SENTIT_TRUCADA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_SENTIT_TRUCADA" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_SENTIT_TRUCADA" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_SENTIT_TRUCADA" MODIFY ("DESCRIPCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_SENTIT_TRUCADA" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_SENTIT_TRUCADA" ADD CONSTRAINT "A0_FKDM_SENTIT_TRUCADA" UNIQUE ("DESCRIPCIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
