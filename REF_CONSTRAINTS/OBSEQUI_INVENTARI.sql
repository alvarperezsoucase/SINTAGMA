--------------------------------------------------------
--  Ref Constraints for Table OBSEQUI_INVENTARI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."OBSEQUI_INVENTARI" ADD CONSTRAINT "FKINVENTARI01" FOREIGN KEY ("OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."DM_OBSEQUI" ("ID") ENABLE;
