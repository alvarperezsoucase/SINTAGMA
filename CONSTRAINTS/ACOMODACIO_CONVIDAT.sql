--------------------------------------------------------
--  Constraints for Table ACOMODACIO_CONVIDAT
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" MODIFY ("USUARI_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" MODIFY ("DATA_CREACIO" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" MODIFY ("TIPUS_ACOMODACIO_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" MODIFY ("CONVIDAT_ID" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."ACOMODACIO_CONVIDAT" MODIFY ("ID" NOT NULL ENABLE);