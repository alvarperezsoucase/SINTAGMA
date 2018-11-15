--------------------------------------------------------
--  Ref Constraints for Table A1_DM_TIPUS_ACCIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPUS_ACCIO" ADD CONSTRAINT "A1_FKDM_TIPUS_A470625" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
