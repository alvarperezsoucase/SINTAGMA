--------------------------------------------------------
--  Ref Constraints for Table DM_DISTRICTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_DISTRICTE" ADD CONSTRAINT "FKDM_DISTRIC824155" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
