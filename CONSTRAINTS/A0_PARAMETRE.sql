--------------------------------------------------------
--  Constraints for Table A0_PARAMETRE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_PARAMETRE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_PARAMETRE" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_PARAMETRE" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_PARAMETRE" MODIFY ("VALOR" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_PARAMETRE" MODIFY ("CLAU" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_PARAMETRE" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_PARAMETRE" ADD CONSTRAINT "A0_FKPARAMETRE" UNIQUE ("CLAU")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
