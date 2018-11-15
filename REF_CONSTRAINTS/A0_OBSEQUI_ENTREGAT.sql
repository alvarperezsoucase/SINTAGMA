--------------------------------------------------------
--  Ref Constraints for Table A0_OBSEQUI_ENTREGAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_OBSEQUI_ENTREGAT" ADD CONSTRAINT "A0_FKOBSEQUI_EN611806" FOREIGN KEY ("OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_OBSEQUI" ("ID") ENABLE;
