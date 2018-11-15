--------------------------------------------------------
--  Ref Constraints for Table AGENDA_DELEGACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."AGENDA_DELEGACIO" ADD CONSTRAINT "FKAGENDA_DEL409051" FOREIGN KEY ("ENTRADA_AGENDA_ID")
	  REFERENCES "SINTAGMA_U"."ENTRADA_AGENDA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."AGENDA_DELEGACIO" ADD CONSTRAINT "FKAGENDA_DEL891825" FOREIGN KEY ("DESTI_DELEGACIO_ID")
	  REFERENCES "SINTAGMA_U"."DM_DESTI_DELEGACIO" ("ID") ENABLE;
