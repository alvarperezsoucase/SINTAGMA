--------------------------------------------------------
--  Ref Constraints for Table A0_DM_TIPUS_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_ELEMENT" ADD CONSTRAINT "A0_FKDM_TIPUS_E835726" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
