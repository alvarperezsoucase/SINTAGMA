--------------------------------------------------------
--  Ref Constraints for Table DM_PAS_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_PAS_ACCIO" ADD CONSTRAINT "FKDM_PAS_ACC332958" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."DM_PAS_ACCIO" ADD CONSTRAINT "FKDM_PAS_ACC433894" FOREIGN KEY ("TIPUS_ACCIO_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPUS_ACCIO" ("ID") ENABLE;
