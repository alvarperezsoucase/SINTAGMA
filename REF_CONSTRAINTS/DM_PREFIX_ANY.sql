--------------------------------------------------------
--  Ref Constraints for Table DM_PREFIX_ANY
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_PREFIX_ANY" ADD CONSTRAINT "FKDM_PREFIX_824530" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
