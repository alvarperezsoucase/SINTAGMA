--------------------------------------------------------
--  DDL for Index A0_FKDM_SERIE
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_SERIE" ON "SINTAGMA_U"."A0_DM_SERIE" ("ID", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
