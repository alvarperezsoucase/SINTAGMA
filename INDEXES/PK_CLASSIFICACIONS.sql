--------------------------------------------------------
--  DDL for Index PK_CLASSIFICACIONS
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."PK_CLASSIFICACIONS" ON "SINTAGMA_U"."Z_TMP_VIPS_U_CLASSIF" ("CODI") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
