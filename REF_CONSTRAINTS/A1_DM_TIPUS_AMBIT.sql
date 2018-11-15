--------------------------------------------------------
--  Ref Constraints for Table A1_DM_TIPUS_AMBIT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPUS_AMBIT" ADD CONSTRAINT "A1_FKDM_TIPUS_A173671" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
