--------------------------------------------------------
--  Ref Constraints for Table ASPECTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."ASPECTE" ADD CONSTRAINT "FKASPECTE57560" FOREIGN KEY ("TIPUS_TEMA_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPUS_TEMA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."ASPECTE" ADD CONSTRAINT "FKASPECTE695500" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
