--------------------------------------------------------
--  Ref Constraints for Table A1_DM_DISTRICTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_DISTRICTE" ADD CONSTRAINT "A1_FKDM_DISTRIC824155" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
