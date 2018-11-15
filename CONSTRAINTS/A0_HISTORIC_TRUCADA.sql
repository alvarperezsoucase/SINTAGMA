--------------------------------------------------------
--  Constraints for Table A0_HISTORIC_TRUCADA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_HISTORIC_TRUCADA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_HISTORIC_TRUCADA" MODIFY ("ESTAT_TRUCADA_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_HISTORIC_TRUCADA" MODIFY ("TRUCADA_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_HISTORIC_TRUCADA" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_HISTORIC_TRUCADA" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_HISTORIC_TRUCADA" MODIFY ("DATA_REGISTRE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_HISTORIC_TRUCADA" MODIFY ("ID" NOT NULL ENABLE);