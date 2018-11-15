--------------------------------------------------------
--  Ref Constraints for Table A0_PERSONA_RELACIONADA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_PERSONA_RELACIONADA" ADD CONSTRAINT "A0_FKPERSONA_REL01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_CONTACTE" ("ID") ENABLE;
