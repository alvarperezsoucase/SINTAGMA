--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_AMBIT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_AMBIT" ADD CONSTRAINT "FKDM_TIPUS_A173671" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
