--------------------------------------------------------
--  Ref Constraints for Table ENTRADA_AGENDA_AMBIT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."ENTRADA_AGENDA_AMBIT" ADD CONSTRAINT "FKENT_AGE_AMBIT0001" FOREIGN KEY ("ENTRADA_AGENDA_ID")
	  REFERENCES "SINTAGMA_U"."ENTRADA_AGENDA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."ENTRADA_AGENDA_AMBIT" ADD CONSTRAINT "FKENT_AGE_AMBIT0002" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
