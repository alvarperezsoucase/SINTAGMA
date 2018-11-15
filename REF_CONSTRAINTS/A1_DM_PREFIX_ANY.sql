--------------------------------------------------------
--  Ref Constraints for Table A1_DM_PREFIX_ANY
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_PREFIX_ANY" ADD CONSTRAINT "A1_FKDM_PREFIX_824530" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
