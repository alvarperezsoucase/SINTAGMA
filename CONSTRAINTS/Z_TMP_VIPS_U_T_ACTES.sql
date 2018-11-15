--------------------------------------------------------
--  Constraints for Table Z_TMP_VIPS_U_T_ACTES
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_T_ACTES" MODIFY ("CODI" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_T_ACTES" ADD CONSTRAINT "PK_T_ACTES" PRIMARY KEY ("CODI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;
