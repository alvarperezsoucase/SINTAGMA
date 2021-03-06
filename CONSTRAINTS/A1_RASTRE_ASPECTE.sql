--------------------------------------------------------
--  Constraints for Table A1_RASTRE_ASPECTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" MODIFY ("ASPECTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" MODIFY ("RASTRE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" MODIFY ("ID" NOT NULL ENABLE);
