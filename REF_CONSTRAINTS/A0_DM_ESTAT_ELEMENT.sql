--------------------------------------------------------
--  Ref Constraints for Table A0_DM_ESTAT_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_ESTAT_ELEMENT" ADD CONSTRAINT "A0_FKDM_ESTAT_E718849" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
