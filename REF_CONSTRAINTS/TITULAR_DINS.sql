--------------------------------------------------------
--  Ref Constraints for Table TITULAR_DINS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."TITULAR_DINS" ADD CONSTRAINT "FKTITULAR_DI811638" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."ASPECTE" ("ID") ENABLE;
