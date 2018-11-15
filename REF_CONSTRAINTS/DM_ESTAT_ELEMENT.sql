--------------------------------------------------------
--  Ref Constraints for Table DM_ESTAT_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_ESTAT_ELEMENT" ADD CONSTRAINT "FKDM_ESTAT_E718849" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
