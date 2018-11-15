--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_ARG
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_ARG" ADD CONSTRAINT "FKDM_TIPUS_A982617" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
