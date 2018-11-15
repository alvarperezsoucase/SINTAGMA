--------------------------------------------------------
--  Ref Constraints for Table DM_DESTI_DELEGACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_DESTI_DELEGACIO" ADD CONSTRAINT "FKDM_DESTI_D256754" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
