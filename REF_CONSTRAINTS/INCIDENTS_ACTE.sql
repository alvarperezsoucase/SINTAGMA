--------------------------------------------------------
--  Ref Constraints for Table INCIDENTS_ACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."INCIDENTS_ACTE" ADD FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."ACTE" ("ID") ENABLE;
