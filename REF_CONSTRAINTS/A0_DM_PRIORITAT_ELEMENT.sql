--------------------------------------------------------
--  Ref Constraints for Table A0_DM_PRIORITAT_ELEMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_PRIORITAT_ELEMENT" ADD CONSTRAINT "A0_FKDM_PRIORIT739647" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
