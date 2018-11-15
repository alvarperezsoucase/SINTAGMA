--------------------------------------------------------
--  Ref Constraints for Table A0_DM_TIPUS_AMBIT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_AMBIT" ADD CONSTRAINT "A0_FKDM_TIPUS_A173671" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
