--------------------------------------------------------
--  Ref Constraints for Table A1_DM_LLOC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_LLOC" ADD CONSTRAINT "A1_FKDM_LLOC112985" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
