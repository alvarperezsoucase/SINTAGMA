--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_ACCIO" ADD CONSTRAINT "FKDM_TIPUS_A470625" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
