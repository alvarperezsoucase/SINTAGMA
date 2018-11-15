--------------------------------------------------------
--  Constraints for Table A0_DOCUMENT_BAIXA_SUBJECTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DOCUMENT_BAIXA_SUBJECTE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DOCUMENT_BAIXA_SUBJECTE" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DOCUMENT_BAIXA_SUBJECTE" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DOCUMENT_BAIXA_SUBJECTE" MODIFY ("DOCUMENT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DOCUMENT_BAIXA_SUBJECTE" MODIFY ("SUBJECTE_ID" NOT NULL ENABLE);
