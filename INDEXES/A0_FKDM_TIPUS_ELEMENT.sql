--------------------------------------------------------
--  DDL for Index A0_FKDM_TIPUS_ELEMENT
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_TIPUS_ELEMENT" ON "SINTAGMA_U"."A0_DM_TIPUS_ELEMENT" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
