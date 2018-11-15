--------------------------------------------------------
--  Ref Constraints for Table A1_DM_CLASSIFICACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_CLASSIFICACIO" ADD CONSTRAINT "A1_FKDM_CLASSIF01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_DM_CLASSIFICACIO" ADD CONSTRAINT "A1_FKDM_CLASSIF02" FOREIGN KEY ("TIPOLOGIA_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_TIPOLOGIA_CLASSIFICACIO" ("ID") ENABLE;
