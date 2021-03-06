--------------------------------------------------------
--  Constraints for Table A1_DOCUMENT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_DOCUMENT" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_DOCUMENT" MODIFY ("CATALEG_DOCUMENT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DOCUMENT" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DOCUMENT" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_DOCUMENT" MODIFY ("ID" NOT NULL ENABLE);
