--------------------------------------------------------
--  Constraints for Table Z_TMP_VIPS_U_VIPS_ACTES
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_VIPS_ACTES" MODIFY ("ACTE" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_VIPS_ACTES" MODIFY ("N_VIP" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_VIPS_ACTES" ADD CONSTRAINT "PK_VIPS_ACTES" PRIMARY KEY ("N_VIP", "ACTE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;