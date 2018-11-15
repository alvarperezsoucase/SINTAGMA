--------------------------------------------------------
--  Ref Constraints for Table DM_LLOC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_LLOC" ADD CONSTRAINT "FKDM_LLOC112985" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
