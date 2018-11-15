--------------------------------------------------------
--  Ref Constraints for Table A1_DM_CATALEG_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_CATALEG_DOCUMENT" ADD CONSTRAINT "A1_FKDM_CATALEG772201" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
