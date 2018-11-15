--------------------------------------------------------
--  Constraints for Table A1_CONVIDAT_OBSEQUI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT_OBSEQUI" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT_OBSEQUI" MODIFY ("CONVIDAT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT_OBSEQUI" MODIFY ("OBSEQUI_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT_OBSEQUI" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT_OBSEQUI" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_CONVIDAT_OBSEQUI" MODIFY ("ID" NOT NULL ENABLE);