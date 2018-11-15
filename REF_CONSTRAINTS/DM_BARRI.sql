--------------------------------------------------------
--  Ref Constraints for Table DM_BARRI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_BARRI" ADD CONSTRAINT "FKDM_BARRI01" FOREIGN KEY ("DISTRICTE_ID")
	  REFERENCES "SINTAGMA_U"."DM_DISTRICTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."DM_BARRI" ADD CONSTRAINT "FKDM_BARRI948924" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
