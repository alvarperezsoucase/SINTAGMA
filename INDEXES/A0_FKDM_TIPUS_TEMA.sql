--------------------------------------------------------
--  DDL for Index A0_FKDM_TIPUS_TEMA
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_TIPUS_TEMA" ON "SINTAGMA_U"."A0_DM_TIPUS_TEMA" ("CODI", "DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
