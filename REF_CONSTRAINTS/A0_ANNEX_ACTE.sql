--------------------------------------------------------
--  Ref Constraints for Table A0_ANNEX_ACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_ANNEX_ACTE" ADD CONSTRAINT "A0_FKANNEX_ACTE323460" FOREIGN KEY ("ACTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_ACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_ANNEX_ACTE" ADD CONSTRAINT "A0_FKANNEX_ACTE352641" FOREIGN KEY ("DOCUMENT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DOCUMENT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_ANNEX_ACTE" ADD CONSTRAINT "A0_FKANNEX_ACTE670688" FOREIGN KEY ("TIPUS_SUPORT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TIPUS_SUPORT" ("ID") ENABLE;
