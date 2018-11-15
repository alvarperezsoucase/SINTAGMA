--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_SUPORT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_SUPORT" ADD CONSTRAINT "FKDM_TIPUS_S980283" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
