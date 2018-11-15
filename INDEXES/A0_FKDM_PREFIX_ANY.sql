--------------------------------------------------------
--  DDL for Index A0_FKDM_PREFIX_ANY
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_PREFIX_ANY" ON "SINTAGMA_U"."A0_DM_PREFIX_ANY" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
