--------------------------------------------------------
--  Ref Constraints for Table A0_DM_TIPUS_DATA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_DATA" ADD CONSTRAINT "A0_FKDM_TIPUS_D6766" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
