--------------------------------------------------------
--  Ref Constraints for Table RASTRE_ACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."RASTRE_ACTE" ADD CONSTRAINT "FKRASTRE_ACTE561971" FOREIGN KEY ("RASTRE_ID")
	  REFERENCES "SINTAGMA_U"."RASTRE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."RASTRE_ACTE" ADD CONSTRAINT "FKRASTRE_ACTE561972" FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."ACTE" ("ID") ENABLE;
