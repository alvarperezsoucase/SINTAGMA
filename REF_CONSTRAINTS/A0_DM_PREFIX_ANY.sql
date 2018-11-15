--------------------------------------------------------
--  Ref Constraints for Table A0_DM_PREFIX_ANY
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_PREFIX_ANY" ADD CONSTRAINT "A0_FKDM_PREFIX_824530" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
