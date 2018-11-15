--------------------------------------------------------
--  Ref Constraints for Table A1_CONTACTE_CLASSIFICACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CLASSIFICACIO" ADD CONSTRAINT "A1_FKCONTACTE_CL01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONTACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_CLASSIFICACIO" ADD CONSTRAINT "A1_FKCONTACTE_CL02" FOREIGN KEY ("CLASSIFICACIO_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_CLASSIFICACIO" ("ID") ENABLE;
