--------------------------------------------------------
--  Ref Constraints for Table A1_DM_ORIGEN_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_ORIGEN_ELEMENT" ADD CONSTRAINT "A1_FKDM_ORIGEN_960643" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
