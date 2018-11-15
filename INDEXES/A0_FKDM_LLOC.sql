--------------------------------------------------------
--  DDL for Index A0_FKDM_LLOC
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_LLOC" ON "SINTAGMA_U"."A0_DM_LLOC" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
