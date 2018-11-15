--------------------------------------------------------
--  Ref Constraints for Table A1_DM_ESTAT_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_ESTAT_ELEMENT" ADD CONSTRAINT "A1_FKDM_ESTAT_E718849" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
