--------------------------------------------------------
--  Ref Constraints for Table A0_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DOCUMENT" ADD CONSTRAINT "A0_FKDOCUMENT01" FOREIGN KEY ("CATALEG_DOCUMENT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_CATALEG_DOCUMENT" ("ID") ENABLE;
