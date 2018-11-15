--------------------------------------------------------
--  Ref Constraints for Table A0_CONVIDAT_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_CORREU" ADD CONSTRAINT "A0_FKCONVIDAT_C759264" FOREIGN KEY ("CONVIDAT_ID")
	  REFERENCES "SINTAGMA_U"."A0_CONVIDAT" ("ID") ENABLE;
