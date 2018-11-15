--------------------------------------------------------
--  Constraints for Table A0_DM_AFECTA_AGENDA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" MODIFY ("CODI" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" MODIFY ("AMBIT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" MODIFY ("DESCRIPCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" ADD CONSTRAINT "A0_FKDM_AFECTA_AGENDA" UNIQUE ("DESCRIPCIO", "AMBIT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_AFECTA_AGENDA" ADD CONSTRAINT "A0_DM_AFECTA_AGENDA_UN" UNIQUE ("AMBIT_ID", "CODI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
