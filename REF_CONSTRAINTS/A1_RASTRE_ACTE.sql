--------------------------------------------------------
--  Ref Constraints for Table A1_RASTRE_ACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" ADD CONSTRAINT "A1_FKRASTRE_ACTE561971" FOREIGN KEY ("RASTRE_ID")
	  REFERENCES "SINTAGMA_U"."A1_RASTRE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ACTE" ADD CONSTRAINT "A1_FKRASTRE_ACTE561972" FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_ACTE" ("ID") ENABLE;
