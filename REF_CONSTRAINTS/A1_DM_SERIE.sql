--------------------------------------------------------
--  Ref Constraints for Table A1_DM_SERIE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_SERIE" ADD CONSTRAINT "A1_FKDM_SERIE767678" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
