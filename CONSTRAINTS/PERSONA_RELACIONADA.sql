--------------------------------------------------------
--  Constraints for Table PERSONA_RELACIONADA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" MODIFY ("CONTACTE_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" MODIFY ("COGNOM1" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" MODIFY ("NOM" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" MODIFY ("VINCULACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."PERSONA_RELACIONADA" MODIFY ("ID" NOT NULL ENABLE);
