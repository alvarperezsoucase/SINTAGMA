--------------------------------------------------------
--  Ref Constraints for Table A0_ELEMENTS_RELACIONATS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_ELEMENTS_RELACIONATS" ADD CONSTRAINT "A0_FKELEMENTS_R413766" FOREIGN KEY ("ELEMENT_PRINCIPAL2")
	  REFERENCES "SINTAGMA_U"."A0_ELEMENT_PRINCIPAL" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENTS_RELACIONATS" ADD CONSTRAINT "A0_FKELEMENTS_R413767" FOREIGN KEY ("ELEMENT_PRINCIPAL1")
	  REFERENCES "SINTAGMA_U"."A0_ELEMENT_PRINCIPAL" ("ID") ENABLE;
