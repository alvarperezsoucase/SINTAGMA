--------------------------------------------------------
--  Ref Constraints for Table A0_DM_SUBTIPUS_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_SUBTIPUS_ACCIO" ADD CONSTRAINT "A0_FKDM_SUBTIPU252151" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_SUBTIPUS_ACCIO" ADD CONSTRAINT "A0_FKDM_SUBTIPU602859" FOREIGN KEY ("TIPUS_ACCIO_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TIPUS_ACCIO" ("ID") ENABLE;