--------------------------------------------------------
--  DDL for Index A0_FKDM_TIPUS_DATA
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_TIPUS_DATA" ON "SINTAGMA_U"."A0_DM_TIPUS_DATA" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
