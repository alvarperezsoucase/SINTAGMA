--------------------------------------------------------
--  Ref Constraints for Table A1_DM_TIPUS_SERVEI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPUS_SERVEI" ADD CONSTRAINT "A1_FKDM_TIPUS_S536825" FOREIGN KEY ("CONTRACTE_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_CONTRACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_DM_TIPUS_SERVEI" ADD CONSTRAINT "A1_FKDM_TIPUS_S621794" FOREIGN KEY ("PROVEIDOR_ID")
	  REFERENCES "SINTAGMA_U"."A1_DM_PROVEIDOR" ("ID") ENABLE;