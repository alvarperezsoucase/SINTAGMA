--------------------------------------------------------
--  Ref Constraints for Table DM_PREFIX
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_PREFIX" ADD CONSTRAINT "FKDM_PREFIX837097" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
