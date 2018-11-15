--------------------------------------------------------
--  Ref Constraints for Table A1_DM_OBSEQUI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_OBSEQUI" ADD CONSTRAINT "A1_FKDM_OBSEQUI01" FOREIGN KEY ("TIPOLOGIA_OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_TIPOLOGIA_OBSEQUI" ("ID") ENABLE;
