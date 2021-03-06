--------------------------------------------------------
--  Constraints for Table A1_AGENDA_DELEGACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" MODIFY ("ENTRADA_AGENDA_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" MODIFY ("DESTI_DELEGACIO_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_AGENDA_DELEGACIO" MODIFY ("ID" NOT NULL ENABLE);
