--------------------------------------------------------
--  Ref Constraints for Table A1_DM_TIPUS_SUPORT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPUS_SUPORT" ADD CONSTRAINT "A1_FKDM_TIPUS_S980283" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
