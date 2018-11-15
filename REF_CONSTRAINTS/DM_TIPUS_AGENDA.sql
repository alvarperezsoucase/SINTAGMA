--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_AGENDA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_AGENDA" ADD CONSTRAINT "FKDM_TIPUS_A563939" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
