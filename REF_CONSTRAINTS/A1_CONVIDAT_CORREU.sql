--------------------------------------------------------
--  Ref Constraints for Table A1_CONVIDAT_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT_CORREU" ADD CONSTRAINT "A1_FKCONVIDAT_C759264" FOREIGN KEY ("CONVIDAT_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONVIDAT" ("ID") ENABLE;
