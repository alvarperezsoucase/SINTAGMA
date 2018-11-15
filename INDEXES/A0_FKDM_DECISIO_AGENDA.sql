--------------------------------------------------------
--  DDL for Index A0_FKDM_DECISIO_AGENDA
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_DECISIO_AGENDA" ON "SINTAGMA_U"."A0_DM_DECISIO_AGENDA" ("DESCRIPCIO", "AMBIT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
