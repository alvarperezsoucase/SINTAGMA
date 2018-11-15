--------------------------------------------------------
--  Ref Constraints for Table DM_SERIE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_SERIE" ADD CONSTRAINT "FKDM_SERIE767678" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
