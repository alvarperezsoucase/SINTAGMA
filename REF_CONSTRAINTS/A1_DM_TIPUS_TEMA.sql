--------------------------------------------------------
--  Ref Constraints for Table A1_DM_TIPUS_TEMA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPUS_TEMA" ADD CONSTRAINT "A1_FKDM_TIPUS_T526482" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
