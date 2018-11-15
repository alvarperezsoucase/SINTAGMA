--------------------------------------------------------
--  Ref Constraints for Table A0_OBSEQUI_INVENTARI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_OBSEQUI_INVENTARI" ADD CONSTRAINT "A0_FKINVENTARI01" FOREIGN KEY ("OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_OBSEQUI" ("ID") ENABLE;
