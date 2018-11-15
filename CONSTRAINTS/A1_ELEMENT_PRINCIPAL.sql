--------------------------------------------------------
--  Constraints for Table A1_ELEMENT_PRINCIPAL
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("PREFIX_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("TIPUS_SUPORT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("ESTAT_ELEMENT_PRINCIPAL_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("ASPECTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("ORIGEN_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("AFECTA_AGENDA_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("ES_VALIDAT_RE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("ES_RELACIO_ENTRADA" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ELEMENT_PRINCIPAL" MODIFY ("ID" NOT NULL ENABLE);
