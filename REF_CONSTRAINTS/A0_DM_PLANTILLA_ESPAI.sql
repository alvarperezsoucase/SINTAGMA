--------------------------------------------------------
--  Ref Constraints for Table A0_DM_PLANTILLA_ESPAI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_PLANTILLA_ESPAI" ADD CONSTRAINT "A0_FKDM_PLANTIL403231" FOREIGN KEY ("ESPAI_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_ESPAI" ("ID") ENABLE;
