--------------------------------------------------------
--  Constraints for Table Z_TMP_VIPS_U_TECNIC
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_TECNIC" ADD CONSTRAINT "PK_TECNIC" PRIMARY KEY ("CODIGO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
