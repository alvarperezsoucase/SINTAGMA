--------------------------------------------------------
--  Ref Constraints for Table A1_COMANDA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_COMANDA" ADD CONSTRAINT "A1_FKCOMANDA114314" FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_ACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_COMANDA" ADD CONSTRAINT "A1_FKCOMANDA657374" FOREIGN KEY ("TIPUS_SERVEI_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_TIPUS_SERVEI" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_COMANDA" ADD CONSTRAINT "A1_FKCOMANDA778890" FOREIGN KEY ("ESTAT_COMANDA_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_ESTAT_COMANDA" ("ID") ENABLE;
