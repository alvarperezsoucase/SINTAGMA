--------------------------------------------------------
--  Ref Constraints for Table DM_ESPECIFIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_ESPECIFIC" ADD CONSTRAINT "FKDM_ESPECIF772201" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
