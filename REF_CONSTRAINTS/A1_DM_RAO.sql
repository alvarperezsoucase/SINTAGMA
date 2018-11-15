--------------------------------------------------------
--  Ref Constraints for Table A1_DM_RAO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_RAO" ADD CONSTRAINT "A1_FKDM_RAO01" FOREIGN KEY ("ESTAT_TRUCADA_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_ESTAT_TRUCADA" ("ID") ENABLE;
