--------------------------------------------------------
--  Ref Constraints for Table A0_DM_OBSEQUI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_OBSEQUI" ADD CONSTRAINT "A0_FKDM_OBSEQUI01" FOREIGN KEY ("TIPOLOGIA_OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TIPOLOGIA_OBSEQUI" ("ID") ENABLE;
