--------------------------------------------------------
--  Constraints for Table Z_TMP_VIPS_U_ORGA_UBICACIO
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."Z_TMP_VIPS_U_ORGA_UBICACIO" ADD CONSTRAINT "PK_ORGA_UBICACIO" PRIMARY KEY ("N_ORGA_ACTE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
