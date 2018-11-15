--------------------------------------------------------
--  Ref Constraints for Table DM_PRIORITAT_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_PRIORITAT_ELEMENT" ADD CONSTRAINT "FKDM_PRIORIT739647" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."DM_AMBIT" ("ID") ENABLE;
