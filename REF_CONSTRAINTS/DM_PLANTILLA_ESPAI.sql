--------------------------------------------------------
--  Ref Constraints for Table DM_PLANTILLA_ESPAI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_PLANTILLA_ESPAI" ADD CONSTRAINT "FKDM_PLANTIL403231" FOREIGN KEY ("ESPAI_ID")
	  REFERENCES "SINTAGMA_U"."DM_ESPAI" ("ID") ENABLE;
