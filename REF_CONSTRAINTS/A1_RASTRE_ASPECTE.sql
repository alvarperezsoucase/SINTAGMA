--------------------------------------------------------
--  Ref Constraints for Table A1_RASTRE_ASPECTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" ADD CONSTRAINT "A1_FKRASTRE_ASPECTE561971" FOREIGN KEY ("RASTRE_ID")
	  REFERENCES "SINTAGMA_U"."A1_RASTRE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_RASTRE_ASPECTE" ADD CONSTRAINT "A1_FKRASTRE_ASPECTE561972" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_ASPECTE" ("ID") ENABLE;