--------------------------------------------------------
--  DDL for Index A0_FKDM_DESTI_DELEGACIO
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_DESTI_DELEGACIO" ON "SINTAGMA_U"."A0_DM_DESTI_DELEGACIO" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
