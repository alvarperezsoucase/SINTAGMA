--------------------------------------------------------
--  Ref Constraints for Table A0_DM_CATALEG_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" ADD CONSTRAINT "A0_FKDM_CATALEG772201" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
