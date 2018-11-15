--------------------------------------------------------
--  Ref Constraints for Table A1_DM_PRIORITAT_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_PRIORITAT_ELEMENT" ADD CONSTRAINT "A1_FKDM_PRIORIT739647" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_AMBIT" ("ID") ENABLE;
