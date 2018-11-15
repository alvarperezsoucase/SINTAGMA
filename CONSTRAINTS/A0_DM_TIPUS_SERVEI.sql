--------------------------------------------------------
--  Constraints for Table A0_DM_TIPUS_SERVEI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" MODIFY ("CONTRACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" MODIFY ("PROVEIDOR_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" MODIFY ("DESCRIPCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" ADD CONSTRAINT "A0_FKDM_TIPUS_SERVEI" UNIQUE ("DESCRIPCIO", "PROVEIDOR_ID", "CONTRACTE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
