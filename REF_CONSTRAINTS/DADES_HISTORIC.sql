--------------------------------------------------------
--  Ref Constraints for Table DADES_HISTORIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."DADES_HISTORIC" ADD CONSTRAINT "FKDADES_HIST01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."CONTACTE" ("ID") ENABLE;
