--------------------------------------------------------
--  Ref Constraints for Table A0_DM_TIPOLOGIA_CLASSIFICACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPOLOGIA_CLASSIFICACIO" ADD CONSTRAINT "A0_FKDM_TIPOLOG01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
