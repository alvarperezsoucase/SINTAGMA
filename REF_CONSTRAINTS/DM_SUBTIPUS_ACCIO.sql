--------------------------------------------------------
--  Ref Constraints for Table DM_SUBTIPUS_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_SUBTIPUS_ACCIO" ADD CONSTRAINT "FKDM_SUBTIPU252151" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."DM_SUBTIPUS_ACCIO" ADD CONSTRAINT "FKDM_SUBTIPU602859" FOREIGN KEY ("TIPUS_ACCIO_ID")
	  REFERENCES "SINTAGMA_U"."DM_TIPUS_ACCIO" ("ID") ENABLE;
