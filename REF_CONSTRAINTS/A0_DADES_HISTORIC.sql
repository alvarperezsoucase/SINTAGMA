--------------------------------------------------------
--  Ref Constraints for Table A0_DADES_HISTORIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" ADD CONSTRAINT "A0_FKDADES_HIST01" FOREIGN KEY ("CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_CONTACTE" ("ID") ENABLE;
