--------------------------------------------------------
--  Ref Constraints for Table A1_CONVIDAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT156941" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONTACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT297469" FOREIGN KEY ("ESTAT_CONFIRMACIO_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_ESTAT_CONFIRMACIO" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT350170" FOREIGN KEY ("TIPUS_VIA_INVITACIO_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_TIPUS_VIA_INVITACIO" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT377638" FOREIGN KEY ("TIPUS_VIA_RESPOSTA_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_TIPUS_VIA_RESPOSTA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT535871" FOREIGN KEY ("INICIATIVA_RESPOSTA_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_INICIATIVA_RESPOSTA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT658217" FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_ACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT658517" FOREIGN KEY ("DECISIO_ASSISTENCIA_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_DECISIO_ASSISTENCIA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT" ADD CONSTRAINT "A1_FKCONVIDAT714461" FOREIGN KEY ("CONTACTE_CLASSIFICACIO_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONTACTE_CLASSIFICACIO" ("ID") ENABLE;
