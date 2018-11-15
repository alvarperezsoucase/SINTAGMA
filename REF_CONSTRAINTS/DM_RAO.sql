--------------------------------------------------------
--  Ref Constraints for Table DM_RAO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DM_RAO" ADD CONSTRAINT "FKDM_RAO01" FOREIGN KEY ("ESTAT_TRUCADA_ID")
	  REFERENCES "SINTAGMA_U"."DM_ESTAT_TRUCADA" ("ID") ENABLE;
