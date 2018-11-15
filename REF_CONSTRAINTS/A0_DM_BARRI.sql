--------------------------------------------------------
--  Ref Constraints for Table A0_DM_BARRI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_BARRI" ADD CONSTRAINT "A0_FKDM_BARRI01" FOREIGN KEY ("DISTRICTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_DISTRICTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_BARRI" ADD CONSTRAINT "A0_FKDM_BARRI948924" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
