--------------------------------------------------------
--  Ref Constraints for Table A1_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DOCUMENT" ADD CONSTRAINT "A1_FKDOCUMENT01" FOREIGN KEY ("CATALEG_DOCUMENT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_CATALEG_DOCUMENT" ("ID") ENABLE;
