--------------------------------------------------------
--  Ref Constraints for Table A1_DM_PRIORITAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_PRIORITAT" ADD CONSTRAINT "A1_FKDM_PRIORITAT01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
