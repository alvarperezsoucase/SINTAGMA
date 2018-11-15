--------------------------------------------------------
--  Ref Constraints for Table ANNEX_INCIDENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."ANNEX_INCIDENT" ADD CONSTRAINT "FKANNEX_INC01" FOREIGN KEY ("TIPUS_SUPORT_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPUS_SUPORT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."ANNEX_INCIDENT" ADD CONSTRAINT "FKANNEX_INC02" FOREIGN KEY ("INCIDENT_ID")
	  REFERENCES "SINTAGMA_U"."INCIDENTS_ACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."ANNEX_INCIDENT" ADD CONSTRAINT "FKANNEX_INC03" FOREIGN KEY ("DOCUMENT_ID")
	  REFERENCES "SINTAGMA_U"."DOCUMENT" ("ID") ENABLE;
