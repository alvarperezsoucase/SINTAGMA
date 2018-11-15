--------------------------------------------------------
--  Ref Constraints for Table DM_CONF_FUN_VISUALS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_CONF_FUN_VISUALS" ADD CONSTRAINT "FKDM_FUNVIS01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
