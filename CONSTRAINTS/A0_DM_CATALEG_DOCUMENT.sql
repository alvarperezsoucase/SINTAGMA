--------------------------------------------------------
--  Constraints for Table A0_DM_CATALEG_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" MODIFY ("AMBIT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" MODIFY ("DESCRIPCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" ADD CONSTRAINT "A0_FKDM_CATALEG_DOCUMENT" UNIQUE ("DESCRIPCIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;