--------------------------------------------------------
--  Ref Constraints for Table A0_DM_DESTI_DELEGACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_DESTI_DELEGACIO" ADD CONSTRAINT "A0_FKDM_DESTI_D256754" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
