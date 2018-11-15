--------------------------------------------------------
--  Ref Constraints for Table A0_PLANTILLA_CONFIG_ESPAI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_PLANTILLA_CONFIG_ESPAI" ADD CONSTRAINT "A0_FKPLANTILLA_348577" FOREIGN KEY ("PLANTILLA_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_PLANTILLA_ESPAI" ("ID") ENABLE;
