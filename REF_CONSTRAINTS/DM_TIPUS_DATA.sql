--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_DATA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_DATA" ADD CONSTRAINT "FKDM_TIPUS_D6766" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
