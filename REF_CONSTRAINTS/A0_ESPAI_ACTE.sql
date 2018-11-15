--------------------------------------------------------
--  Ref Constraints for Table A0_ESPAI_ACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_ESPAI_ACTE" ADD CONSTRAINT "A0_FKESPAI_ACTE376237" FOREIGN KEY ("PLANTILLA_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_PLANTILLA_ESPAI" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_ESPAI_ACTE" ADD CONSTRAINT "A0_FKESPAI_ACTE423341" FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_ACTE" ("ID") ENABLE;
