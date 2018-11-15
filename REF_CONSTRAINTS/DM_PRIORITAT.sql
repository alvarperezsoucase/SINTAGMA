--------------------------------------------------------
--  Ref Constraints for Table DM_PRIORITAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_PRIORITAT" ADD CONSTRAINT "FKDM_PRIORITAT01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
