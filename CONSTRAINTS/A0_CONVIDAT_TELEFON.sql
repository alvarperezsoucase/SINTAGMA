--------------------------------------------------------
--  Constraints for Table A0_CONVIDAT_TELEFON
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" MODIFY ("TIPUS_TELEFON_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" MODIFY ("CONVIDAT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" MODIFY ("NUMERO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_CONVIDAT_TELEFON" MODIFY ("ID" NOT NULL ENABLE);
