--------------------------------------------------------
--  Ref Constraints for Table CLASSIFICACIO_ARXIU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."CLASSIFICACIO_ARXIU" ADD CONSTRAINT "FKCLASSIFICA172830" FOREIGN KEY ("ESPECIFIC_ID")
	  REFERENCES "SINTAGMA_U"."DM_ESPECIFIC" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."CLASSIFICACIO_ARXIU" ADD CONSTRAINT "FKCLASSIFICA601394" FOREIGN KEY ("SERIE_ID")
	  REFERENCES "SINTAGMA_U"."DM_SERIE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."CLASSIFICACIO_ARXIU" ADD CONSTRAINT "FKCLASSIFICA822831" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."ASPECTE" ("ID") ENABLE;
