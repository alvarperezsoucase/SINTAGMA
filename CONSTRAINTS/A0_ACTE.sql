--------------------------------------------------------
--  Constraints for Table A0_ACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_ACTE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("ESTAT_GESTIO_ESPAIS_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("ESTAT_GESTIO_INVITACIO_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("ESTAT_ACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("PETICIONARI_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("PRESIDENT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("SECTOR_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("CATEGORIA_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("TIPUS_ACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("ELEMENT_PRINCIPAL_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("DATA_ENTRADA" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("TITOL" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ACTE" MODIFY ("ID" NOT NULL ENABLE);
