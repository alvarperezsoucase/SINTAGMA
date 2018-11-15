--------------------------------------------------------
--  Ref Constraints for Table ACOMODACIO_CONVIDAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" ADD CONSTRAINT "FKCONVIDAT1" FOREIGN KEY ("CONVIDAT_ID")
	  REFERENCES "SINTAGMA_U"."CONVIDAT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" ADD CONSTRAINT "FKDM_TIPUS_ACOMODACIO1" FOREIGN KEY ("TIPUS_ACOMODACIO_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPUS_ACOMODACIO" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" ADD CONSTRAINT "FKESPAI_ACTE_CONFIG1" FOREIGN KEY ("SEIENT_ID")
	  REFERENCES "SINTAGMA_U"."ESPAI_ACTE_CONFIG" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" ADD CONSTRAINT "FKZONA2" FOREIGN KEY ("ZONA_ID")
	  REFERENCES "SINTAGMA_U"."ZONA" ("ID") ENABLE;