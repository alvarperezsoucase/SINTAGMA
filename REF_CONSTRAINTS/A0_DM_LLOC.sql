--------------------------------------------------------
--  Ref Constraints for Table A0_DM_LLOC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_LLOC" ADD CONSTRAINT "A0_FKDM_LLOC112985" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
