--------------------------------------------------------
--  Ref Constraints for Table A0_CONTACTE_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE_CORREU" ADD CONSTRAINT "A0_FKCONTACTE_CO01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_CONTACTE" ("ID") ENABLE;
