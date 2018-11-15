--------------------------------------------------------
--  Ref Constraints for Table DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DOCUMENT" ADD CONSTRAINT "FKDOCUMENT01" FOREIGN KEY ("CATALEG_DOCUMENT_ID")
	  REFERENCES "SINTAGMA_U"."DM_CATALEG_DOCUMENT" ("ID") ENABLE;
