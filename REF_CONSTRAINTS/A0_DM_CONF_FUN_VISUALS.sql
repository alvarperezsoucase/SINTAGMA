--------------------------------------------------------
--  Ref Constraints for Table A0_DM_CONF_FUN_VISUALS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_CONF_FUN_VISUALS" ADD CONSTRAINT "A0_FKDM_FUNVIS01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
