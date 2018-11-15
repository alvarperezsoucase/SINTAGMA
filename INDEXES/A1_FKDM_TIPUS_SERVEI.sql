--------------------------------------------------------
--  DDL for Index A1_FKDM_TIPUS_SERVEI
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A1_FKDM_TIPUS_SERVEI" ON "SINTAGMA_U"."A1_DM_TIPUS_SERVEI" ("DESCRIPCIO", "PROVEIDOR_ID", "CONTRACTE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
