--------------------------------------------------------
--  Ref Constraints for Table PERSONA_RELACIONADA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" ADD CONSTRAINT "FKPERSONA_REL01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."CONTACTE" ("ID") ENABLE;
