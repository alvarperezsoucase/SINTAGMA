--------------------------------------------------------
--  Ref Constraints for Table DM_CLASSIFICACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_CLASSIFICACIO" ADD CONSTRAINT "FKDM_CLASSIF01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."DM_CLASSIFICACIO" ADD CONSTRAINT "FKDM_CLASSIF02" FOREIGN KEY ("TIPOLOGIA_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPOLOGIA_CLASSIFICACIO" ("ID") ENABLE;