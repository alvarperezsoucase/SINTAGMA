--------------------------------------------------------
--  Constraints for Table A1_RASTRE_ACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" MODIFY ("ACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" MODIFY ("RASTRE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" MODIFY ("ID" NOT NULL ENABLE);
