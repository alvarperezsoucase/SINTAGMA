--------------------------------------------------------
--  Constraints for Table A1_TITULAR_FORA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" MODIFY ("ASPECTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" MODIFY ("NOM_CARRER" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" MODIFY ("TIPUS_CONTACTE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" MODIFY ("NOM" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA" MODIFY ("ID" NOT NULL ENABLE);
