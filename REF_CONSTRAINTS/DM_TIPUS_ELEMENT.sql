--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_ELEMENT" ADD CONSTRAINT "FKDM_TIPUS_E835726" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
