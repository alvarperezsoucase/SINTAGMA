--------------------------------------------------------
--  Ref Constraints for Table A0_CONVIDAT_OBSEQUI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_OBSEQUI" ADD CONSTRAINT "A0_FKOBSEQUI_CO122479" FOREIGN KEY ("CONVIDAT_ID")
	  REFERENCES "SINTAGMA_U"."A0_CONVIDAT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_OBSEQUI" ADD CONSTRAINT "A0_FKOBSEQUI_CO472489" FOREIGN KEY ("OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_OBSEQUI" ("ID") ENABLE;
