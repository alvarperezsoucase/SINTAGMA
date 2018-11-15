--------------------------------------------------------
--  Ref Constraints for Table CONVIDAT_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."CONVIDAT_CORREU" ADD CONSTRAINT "FKCONVIDAT_C759264" FOREIGN KEY ("CONVIDAT_ID")
	  REFERENCES "SINTAGMA_U"."CONVIDAT" ("ID") ENABLE;
