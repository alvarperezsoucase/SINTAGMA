--------------------------------------------------------
--  Ref Constraints for Table A0_DM_PRIORITAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT" ADD CONSTRAINT "A0_FKDM_PRIORITAT01" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
