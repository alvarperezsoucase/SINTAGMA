--------------------------------------------------------
--  DDL for Index A0_FKDM_ESPECIFIC
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_ESPECIFIC" ON "SINTAGMA_U"."A0_DM_ESPECIFIC" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
