--------------------------------------------------------
--  Ref Constraints for Table DM_CATALEG_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_CATALEG_DOCUMENT" ADD CONSTRAINT "FKDM_CATALEG772201" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
