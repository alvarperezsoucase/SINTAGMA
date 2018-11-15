--------------------------------------------------------
--  DDL for Index A0_FKDM_TIPUS_ARG
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_TIPUS_ARG" ON "SINTAGMA_U"."A0_DM_TIPUS_ARG" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
