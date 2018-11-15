--------------------------------------------------------
--  Ref Constraints for Table A0_DM_RAO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_RAO" ADD CONSTRAINT "A0_FKDM_RAO01" FOREIGN KEY ("ESTAT_TRUCADA_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_ESTAT_TRUCADA" ("ID") ENABLE;
