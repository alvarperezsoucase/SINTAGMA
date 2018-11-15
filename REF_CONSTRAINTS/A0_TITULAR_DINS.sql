--------------------------------------------------------
--  Ref Constraints for Table A0_TITULAR_DINS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_TITULAR_DINS" ADD CONSTRAINT "A0_FKTITULAR_DI811638" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_ASPECTE" ("ID") ENABLE;
