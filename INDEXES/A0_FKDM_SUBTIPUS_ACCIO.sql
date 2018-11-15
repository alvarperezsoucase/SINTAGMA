--------------------------------------------------------
--  DDL for Index A0_FKDM_SUBTIPUS_ACCIO
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_SUBTIPUS_ACCIO" ON "SINTAGMA_U"."A0_DM_SUBTIPUS_ACCIO" ("CODI", "AMBIT_ID", "TIPUS_ACCIO_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
