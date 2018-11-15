--------------------------------------------------------
--  Constraints for Table Z_TMP_VIPS_U_PLANT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_PLANT" ADD CONSTRAINT "PK_PLANT" PRIMARY KEY ("CODI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
