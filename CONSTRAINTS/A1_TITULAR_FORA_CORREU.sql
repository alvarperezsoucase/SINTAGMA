--------------------------------------------------------
--  Constraints for Table A1_TITULAR_FORA_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA_CORREU" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA_CORREU" MODIFY ("TITULAR_FORA_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA_CORREU" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA_CORREU" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA_CORREU" MODIFY ("CORREU_ELECTRONIC" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA_CORREU" MODIFY ("ID" NOT NULL ENABLE);