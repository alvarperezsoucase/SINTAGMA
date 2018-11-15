--------------------------------------------------------
--  Ref Constraints for Table A1_DM_CONF_FUN_VISUALS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_CONF_FUN_VISUALS" ADD CONSTRAINT "A1_FKDM_FUNVIS01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
