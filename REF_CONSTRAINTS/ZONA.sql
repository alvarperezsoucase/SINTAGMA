--------------------------------------------------------
--  Ref Constraints for Table ZONA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."ZONA" ADD CONSTRAINT "FKCOLOR1" FOREIGN KEY ("COLOR_ID")
	  REFERENCES "SINTAGMA_U"."DM_COLOR" ("ID") ENABLE;
