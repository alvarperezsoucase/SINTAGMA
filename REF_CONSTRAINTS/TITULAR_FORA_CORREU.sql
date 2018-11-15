--------------------------------------------------------
--  Ref Constraints for Table TITULAR_FORA_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."TITULAR_FORA_CORREU" ADD CONSTRAINT "FKTITULAR_FO509608" FOREIGN KEY ("TITULAR_FORA_ID")
	  REFERENCES "SINTAGMA_U"."TITULAR_FORA" ("ID") ENABLE;
