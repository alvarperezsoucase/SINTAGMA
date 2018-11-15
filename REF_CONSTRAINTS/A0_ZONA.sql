--------------------------------------------------------
--  Ref Constraints for Table A0_ZONA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_ZONA" ADD CONSTRAINT "A0_FKZONA544016" FOREIGN KEY ("ESPAI_ACTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_ESPAI_ACTE" ("ID") ENABLE;
