--------------------------------------------------------
--  Ref Constraints for Table A1_OBSEQUI_ENTREGAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_OBSEQUI_ENTREGAT" ADD CONSTRAINT "A1_FKOBSEQUI_EN611806" FOREIGN KEY ("OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_OBSEQUI" ("ID") ENABLE;
