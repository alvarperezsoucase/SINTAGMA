--------------------------------------------------------
--  Ref Constraints for Table A0_SUBJECTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_SUBJECTE" ADD CONSTRAINT "A0_FKSUBJECTE01" FOREIGN KEY ("TRACTAMENT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TRACTAMENT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_SUBJECTE" ADD CONSTRAINT "A0_FKSUBJECTE02" FOREIGN KEY ("IDIOMA_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_IDIOMA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_SUBJECTE" ADD CONSTRAINT "A0_FKSUBJECTE03" FOREIGN KEY ("TIPUS_SUBJECTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TIPUS_SUBJECTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_SUBJECTE" ADD CONSTRAINT "A0_FKSUBJECTE04" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_SUBJECTE" ADD CONSTRAINT "A0_FKSUBJECTE05" FOREIGN KEY ("PRIORITAT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_PRIORITAT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_SUBJECTE" ADD CONSTRAINT "A0_FKSUBJECTE06" FOREIGN KEY ("ARTICLE_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_ARTICLE" ("ID") ENABLE;
