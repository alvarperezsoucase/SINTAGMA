--------------------------------------------------------
--  Constraints for Table A1_CONTACTE_CONSENTIMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CONSENTIMENT" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CONSENTIMENT" MODIFY ("CONTACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CONSENTIMENT" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CONSENTIMENT" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CONSENTIMENT" MODIFY ("DATA_CONSENTIMENT" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CONSENTIMENT" MODIFY ("ID" NOT NULL ENABLE);
