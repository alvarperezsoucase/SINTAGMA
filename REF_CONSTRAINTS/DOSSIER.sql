--------------------------------------------------------
--  Ref Constraints for Table DOSSIER
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DOSSIER" ADD CONSTRAINT "FKDOSSIER189288" FOREIGN KEY ("PREFIX_ANY_ID")
	  REFERENCES "SINTAGMA_U"."DM_PREFIX_ANY" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."DOSSIER" ADD CONSTRAINT "FKDOSSIER281181" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."ASPECTE" ("ID") ENABLE;
