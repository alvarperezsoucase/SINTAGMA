--------------------------------------------------------
--  Ref Constraints for Table A1_AGENDA_DELEGACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" ADD CONSTRAINT "A1_FKAGENDA_DEL409051" FOREIGN KEY ("ENTRADA_AGENDA_ID")
	  REFERENCES "SINTAGMA_U"."A1_ENTRADA_AGENDA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" ADD CONSTRAINT "A1_FKAGENDA_DEL891825" FOREIGN KEY ("DESTI_DELEGACIO_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_DESTI_DELEGACIO" ("ID") ENABLE;
