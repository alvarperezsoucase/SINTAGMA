--------------------------------------------------------
--  Ref Constraints for Table A0_DM_TIPUS_AGENDA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_AGENDA" ADD CONSTRAINT "A0_FKDM_TIPUS_A563939" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
