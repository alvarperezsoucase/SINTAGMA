--------------------------------------------------------
--  Constraints for Table Z_TMP_VIPS_U_CLASSIF_VIP
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_CLASSIF_VIP" MODIFY ("CLASSIF" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_CLASSIF_VIP" MODIFY ("N_VIP" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_CLASSIF_VIP" ADD CONSTRAINT "PK_CLASSIF_VIP" PRIMARY KEY ("N_VIP", "CLASSIF")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "T_SINTAGMA"  ENABLE;