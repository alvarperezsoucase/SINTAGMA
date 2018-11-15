--------------------------------------------------------
--  Ref Constraints for Table A1_CONTACTE_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CORREU" ADD CONSTRAINT "A1_FKCONTACTE_CO01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONTACTE" ("ID") ENABLE;
