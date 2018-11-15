--------------------------------------------------------
--  Ref Constraints for Table A1_TITULAR_DINS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_DINS" ADD CONSTRAINT "A1_FKTITULAR_DI811638" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_ASPECTE" ("ID") ENABLE;
