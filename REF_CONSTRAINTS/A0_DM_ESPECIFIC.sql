--------------------------------------------------------
--  Ref Constraints for Table A0_DM_ESPECIFIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_ESPECIFIC" ADD CONSTRAINT "A0_FKDM_ESPECIF772201" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
