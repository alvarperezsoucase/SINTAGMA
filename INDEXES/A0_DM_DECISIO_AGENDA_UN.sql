--------------------------------------------------------
--  DDL for Index A0_DM_DECISIO_AGENDA_UN
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_DM_DECISIO_AGENDA_UN" ON "SINTAGMA_U"."A0_DM_DECISIO_AGENDA" ("AMBIT_ID", "CODI", "AFECTA_AGENDA_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
