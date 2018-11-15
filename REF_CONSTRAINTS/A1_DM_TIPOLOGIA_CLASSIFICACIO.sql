--------------------------------------------------------
--  Ref Constraints for Table A1_DM_TIPOLOGIA_CLASSIFICACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPOLOGIA_CLASSIFICACIO" ADD CONSTRAINT "A1_FKDM_TIPOLOG01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
