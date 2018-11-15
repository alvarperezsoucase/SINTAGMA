--------------------------------------------------------
--  DDL for Index A0_FKDM_TIPUS_SERVEI
--------------------------------------------------------

  CREATE UNIQUE INDEX "SINTAGMA_U"."A0_FKDM_TIPUS_SERVEI" ON "SINTAGMA_U"."A0_DM_TIPUS_SERVEI" ("DESCRIPCIO", "PROVEIDOR_ID", "CONTRACTE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA" ;
