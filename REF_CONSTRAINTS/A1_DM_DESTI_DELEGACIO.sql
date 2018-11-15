--------------------------------------------------------
--  Ref Constraints for Table A1_DM_DESTI_DELEGACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_DESTI_DELEGACIO" ADD CONSTRAINT "A1_FKDM_DESTI_D256754" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
