--------------------------------------------------------
--  Ref Constraints for Table MANTENIMENT_DM
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."MANTENIMENT_DM" ADD FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
