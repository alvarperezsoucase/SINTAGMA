--------------------------------------------------------
--  Ref Constraints for Table A0_ASPECTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_ASPECTE" ADD CONSTRAINT "A0_FKASPECTE57560" FOREIGN KEY ("TIPUS_TEMA_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TIPUS_TEMA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_ASPECTE" ADD CONSTRAINT "A0_FKASPECTE695500" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
