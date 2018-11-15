--------------------------------------------------------
--  Ref Constraints for Table A1_DM_PREFIX
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_PREFIX" ADD CONSTRAINT "A1_FKDM_PREFIX837097" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
