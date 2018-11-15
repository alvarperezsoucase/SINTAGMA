--------------------------------------------------------
--  Ref Constraints for Table A1_ZONA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_ZONA" ADD CONSTRAINT "A1_FKZONA544016" FOREIGN KEY ("ESPAI_ACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_ESPAI_ACTE" ("ID") ENABLE;
