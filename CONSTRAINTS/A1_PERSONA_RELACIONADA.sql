--------------------------------------------------------
--  Constraints for Table A1_PERSONA_RELACIONADA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" MODIFY ("CONTACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" MODIFY ("COGNOM1" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" MODIFY ("NOM" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" MODIFY ("VINCULACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_PERSONA_RELACIONADA" MODIFY ("ID" NOT NULL ENABLE);