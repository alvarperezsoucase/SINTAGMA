--------------------------------------------------------
--  Ref Constraints for Table A0_DM_DISTRICTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_DISTRICTE" ADD CONSTRAINT "A0_FKDM_DISTRIC824155" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
