--------------------------------------------------------
--  Ref Constraints for Table A1_DM_ESPECIFIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_ESPECIFIC" ADD CONSTRAINT "A1_FKDM_ESPECIF772201" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
