--------------------------------------------------------
--  Ref Constraints for Table DM_TIPOLOGIA_CLASSIFICACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPOLOGIA_CLASSIFICACIO" ADD CONSTRAINT "FKDM_TIPOLOG01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
