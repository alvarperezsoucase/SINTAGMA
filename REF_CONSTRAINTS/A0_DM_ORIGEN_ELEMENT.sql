--------------------------------------------------------
--  Ref Constraints for Table A0_DM_ORIGEN_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_ORIGEN_ELEMENT" ADD CONSTRAINT "A0_FKDM_ORIGEN_960643" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
