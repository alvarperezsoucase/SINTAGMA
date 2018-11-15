--------------------------------------------------------
--  Ref Constraints for Table A1_TITULAR_FORA_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_TITULAR_FORA_CORREU" ADD CONSTRAINT "A1_FKTITULAR_FO509608" FOREIGN KEY ("TITULAR_FORA_ID")
	  REFERENCES "SINTAGMA_U"."A1_TITULAR_FORA" ("ID") ENABLE;
