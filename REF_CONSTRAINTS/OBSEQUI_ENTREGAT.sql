--------------------------------------------------------
--  Ref Constraints for Table OBSEQUI_ENTREGAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."OBSEQUI_ENTREGAT" ADD CONSTRAINT "FKOBSEQUI_EN611806" FOREIGN KEY ("OBSEQUI_ID")
	  REFERENCES "SINTAGMA_U"."DM_OBSEQUI" ("ID") ENABLE;
