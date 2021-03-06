--------------------------------------------------------
--  Constraints for Table A0_DM_PAS_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("TIPUS_ACCIO_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("DESCRIPCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("ORDRE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("AMBIT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("CODI" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PAS_ACCIO" ADD CONSTRAINT "A0_IX_UNIQUE" UNIQUE ("CODI", "TIPUS_ACCIO_ID", "AMBIT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
