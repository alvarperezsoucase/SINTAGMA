--------------------------------------------------------
--  Ref Constraints for Table CONTACTE_CORREU
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."CONTACTE_CORREU" ADD CONSTRAINT "FKCONTACTE_CO01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."CONTACTE" ("ID") ENABLE;
