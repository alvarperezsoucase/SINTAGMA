--------------------------------------------------------
--  Ref Constraints for Table A1_DM_BARRI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_BARRI" ADD CONSTRAINT "A1_FKDM_BARRI01" FOREIGN KEY ("DISTRICTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_DISTRICTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_DM_BARRI" ADD CONSTRAINT "A1_FKDM_BARRI948924" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
