--------------------------------------------------------
--  Constraints for Table A0_ELEMENT_SECUNDARI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("NUMERO_REGISTRE_GENERAL_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("PREFIX_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("ORIGEN_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("TIPUS_SUPORT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("ELEMENT_PRINCIPAL_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("ASPECTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("ES_VALIDAT_RE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("ES_RELACIO_ENTRADA" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_ELEMENT_SECUNDARI" MODIFY ("ID" NOT NULL ENABLE);