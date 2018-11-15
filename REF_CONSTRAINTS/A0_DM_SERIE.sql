--------------------------------------------------------
--  Ref Constraints for Table A0_DM_SERIE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_SERIE" ADD CONSTRAINT "A0_FKDM_SERIE767678" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
