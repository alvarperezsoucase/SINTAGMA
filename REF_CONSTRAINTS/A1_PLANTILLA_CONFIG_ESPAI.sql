--------------------------------------------------------
--  Ref Constraints for Table A1_PLANTILLA_CONFIG_ESPAI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_PLANTILLA_CONFIG_ESPAI" ADD CONSTRAINT "A1_FKPLANTILLA_348577" FOREIGN KEY ("PLANTILLA_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_PLANTILLA_ESPAI" ("ID") ENABLE;
