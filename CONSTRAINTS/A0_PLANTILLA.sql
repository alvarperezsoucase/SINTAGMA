--------------------------------------------------------
--  Constraints for Table A0_PLANTILLA
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_PLANTILLA" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "T_SINTAGMA"  ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_PLANTILLA" MODIFY ("CODI" NOT NULL ENABLE);
  ALTER TABLE "SINTAGMA_U"."A0_PLANTILLA" MODIFY ("ID" NOT NULL ENABLE);
