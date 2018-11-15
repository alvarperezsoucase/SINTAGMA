--------------------------------------------------------
--  Ref Constraints for Table A0_CONVIDAT_TELEFON
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" ADD CONSTRAINT "A0_FKCONVIDAT_T805471" FOREIGN KEY ("CONVIDAT_ID")
	  REFERENCES "SINTAGMA_U"."A0_CONVIDAT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" ADD CONSTRAINT "A0_FKCONVIDAT_T858558" FOREIGN KEY ("TIPUS_TELEFON_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TIPUS_TELEFON" ("ID") ENABLE;