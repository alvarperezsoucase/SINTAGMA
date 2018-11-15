--------------------------------------------------------
--  Ref Constraints for Table A1_PERSONA_RELACIONADA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" ADD CONSTRAINT "A1_FKPERSONA_REL01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONTACTE" ("ID") ENABLE;
