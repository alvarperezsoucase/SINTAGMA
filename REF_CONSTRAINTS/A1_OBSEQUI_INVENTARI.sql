--------------------------------------------------------
--  Ref Constraints for Table A1_OBSEQUI_INVENTARI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_OBSEQUI_INVENTARI" ADD CONSTRAINT "A1_FKINVENTARI01" FOREIGN KEY ("OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_OBSEQUI" ("ID") ENABLE;
