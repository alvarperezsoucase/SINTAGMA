--------------------------------------------------------
--  Constraints for Table A1_ADRECA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A1_ADRECA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A1_ADRECA" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ADRECA" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ADRECA" MODIFY ("NOM_CARRER" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A1_ADRECA" MODIFY ("ID" NOT NULL ENABLE);
