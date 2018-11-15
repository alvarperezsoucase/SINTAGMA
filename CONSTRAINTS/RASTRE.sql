--------------------------------------------------------
--  Constraints for Table RASTRE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("TIPUS_RASTRE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."RASTRE" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("RESPONSABLE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("DATA_INICI" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("ACCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("TIPUS_ACCIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."RASTRE" MODIFY ("ID" NOT NULL ENABLE);
