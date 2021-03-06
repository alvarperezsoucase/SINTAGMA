--------------------------------------------------------
--  Ref Constraints for Table A1_CONTACTE_TELEFON
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_TELEFON" ADD CONSTRAINT "A1_FKCONTACTE_TEL01" FOREIGN KEY ("TIPUS_TELEFON_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_TIPUS_TELEFON" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONTACTE_TELEFON" ADD CONSTRAINT "A1_FKCONTACTE_TEL02" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONTACTE" ("ID") ENABLE;
