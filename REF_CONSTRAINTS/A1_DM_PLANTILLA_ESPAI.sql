--------------------------------------------------------
--  Ref Constraints for Table A1_DM_PLANTILLA_ESPAI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_PLANTILLA_ESPAI" ADD CONSTRAINT "A1_FKDM_PLANTIL403231" FOREIGN KEY ("ESPAI_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_ESPAI" ("ID") ENABLE;
