--------------------------------------------------------
--  Ref Constraints for Table DM_TIPUS_TEMA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_TIPUS_TEMA" ADD CONSTRAINT "FKDM_TIPUS_T526482" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
