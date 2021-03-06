--------------------------------------------------------
--  Ref Constraints for Table COMANDA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."COMANDA" ADD CONSTRAINT "FKCOMANDA114314" FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."ACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."COMANDA" ADD CONSTRAINT "FKCOMANDA657374" FOREIGN KEY ("TIPUS_SERVEI_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPUS_SERVEI" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."COMANDA" ADD CONSTRAINT "FKCOMANDA778890" FOREIGN KEY ("ESTAT_COMANDA_ID")
	  REFERENCES "SINTAGMA_U"."DM_ESTAT_COMANDA" ("ID") ENABLE;
