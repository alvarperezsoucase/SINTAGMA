--------------------------------------------------------
--  Constraints for Table A0_DM_PRIORITAT_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" MODIFY ("AMBIT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" MODIFY ("DESCRIPCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" ADD CONSTRAINT "A0_FKDM_PRIORITAT_ELEMENT" UNIQUE ("DESCRIPCIO", "AMBIT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;