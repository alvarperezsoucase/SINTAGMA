--------------------------------------------------------
--  Ref Constraints for Table A1_DM_TIPUS_ARG
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPUS_ARG" ADD CONSTRAINT "A1_FKDM_TIPUS_A982617" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
