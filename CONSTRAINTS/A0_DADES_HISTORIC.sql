--------------------------------------------------------
--  Constraints for Table A0_DADES_HISTORIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" MODIFY ("CONTACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" MODIFY ("VALOR" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" MODIFY ("CAMP" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" MODIFY ("TAULA" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_DADES_HISTORIC" MODIFY ("ID" NOT NULL ENABLE);