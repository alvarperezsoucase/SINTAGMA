--------------------------------------------------------
--  Ref Constraints for Table DM_ORIGEN_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_ORIGEN_ELEMENT" ADD CONSTRAINT "FKDM_ORIGEN_960643" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
