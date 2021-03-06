--------------------------------------------------------
--  Constraints for Table ELEMENT_SECUNDARI
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("NUMERO_REGISTRE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("PREFIX_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("ORIGEN_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("ELEMENT_PRINCIPAL_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("ASPECTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("ES_VALIDAT_RE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("ES_RELACIO_ENTRADA" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ELEMENT_SECUNDARI" ADD CONSTRAINT "ES_ASPECTE_UNIQUE" UNIQUE ("ASPECTE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
