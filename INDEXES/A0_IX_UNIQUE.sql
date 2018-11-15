--------------------------------------------------------
--  DDL for Index A0_IX_UNIQUE
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_IX_UNIQUE" ON "SINTAGMA_U"."A0_DM_PAS_ACCIO" ("CODI", "TIPUS_ACCIO_ID", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
