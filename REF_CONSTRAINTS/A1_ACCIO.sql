--------------------------------------------------------
--  Ref Constraints for Table A1_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_ACCIO" ADD CONSTRAINT "A1_FKACCIO171138" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_ASPECTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_ACCIO" ADD CONSTRAINT "A1_FKACCIO382248" FOREIGN KEY ("PAS_ACCIO_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_PAS_ACCIO" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_ACCIO" ADD CONSTRAINT "A1_FKACCIO632433" FOREIGN KEY ("ELEMENT_PRINCIPAL_ID")
	  REFERENCES "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_ACCIO" ADD CONSTRAINT "A1_FKACCIO838514" FOREIGN KEY ("SUBTIPUS_ACCIO_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_SUBTIPUS_ACCIO" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_ACCIO" ADD CONSTRAINT "A1_FKACCIO96718" FOREIGN KEY ("AMBIT_DESTI_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;