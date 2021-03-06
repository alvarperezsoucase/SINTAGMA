--------------------------------------------------------
--  Constraints for Table A1_REGISTRE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_REGISTRE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_REGISTRE" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_REGISTRE" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_REGISTRE" MODIFY ("ID" NOT NULL ENABLE);
