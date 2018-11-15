--------------------------------------------------------
--  Ref Constraints for Table A1_DADES_HISTORIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DADES_HISTORIC" ADD CONSTRAINT "A1_FKDADES_HIST01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_CONTACTE" ("ID") ENABLE;
