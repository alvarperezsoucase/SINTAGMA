--------------------------------------------------------
--  Ref Constraints for Table PLANTILLA_CONFIG_ESPAI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."PLANTILLA_CONFIG_ESPAI" ADD CONSTRAINT "FKPLANTILLA_348577" FOREIGN KEY ("PLANTILLA_ID")
	  REFERENCES "SINTAGMA_U"."DM_PLANTILLA_ESPAI" ("ID") ENABLE;
