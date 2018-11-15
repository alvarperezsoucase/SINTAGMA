--------------------------------------------------------
--  Ref Constraints for Table A0_DM_PREFIX
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_PREFIX" ADD CONSTRAINT "A0_FKDM_PREFIX837097" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
