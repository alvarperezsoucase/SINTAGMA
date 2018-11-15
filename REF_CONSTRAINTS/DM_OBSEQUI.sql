--------------------------------------------------------
--  Ref Constraints for Table DM_OBSEQUI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_OBSEQUI" ADD CONSTRAINT "FKDM_OBSEQUI01" FOREIGN KEY ("TIPOLOGIA_OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPOLOGIA_OBSEQUI" ("ID") ENABLE;
