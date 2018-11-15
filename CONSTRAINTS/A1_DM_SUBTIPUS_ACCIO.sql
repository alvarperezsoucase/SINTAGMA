--------------------------------------------------------
--  Constraints for Table A1_DM_SUBTIPUS_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" MODIFY ("DESCRIPCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" MODIFY ("TIPUS_ACCIO_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" MODIFY ("AMBIT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" MODIFY ("CODI" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" ADD CONSTRAINT "A1_FKDM_SUBTIPUS_ACCIO" UNIQUE ("CODI", "AMBIT_ID", "TIPUS_ACCIO_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
