--------------------------------------------------------
--  Constraints for Table Z_TMP_VIPS_U_LLOCS
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_LLOCS" ADD CONSTRAINT "PK_LLOCS" PRIMARY KEY ("CODI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
