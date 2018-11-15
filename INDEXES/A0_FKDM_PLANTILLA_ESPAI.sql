--------------------------------------------------------
--  DDL for Index A0_FKDM_PLANTILLA_ESPAI
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_PLANTILLA_ESPAI" ON "SINTAGMA_U"."A0_DM_PLANTILLA_ESPAI" ("DESCRIPCIO", "ESPAI_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
