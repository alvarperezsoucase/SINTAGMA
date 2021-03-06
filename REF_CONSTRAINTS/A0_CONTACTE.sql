--------------------------------------------------------
--  Ref Constraints for Table A0_CONTACTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE01" FOREIGN KEY ("CARREC_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_CARREC" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE02" FOREIGN KEY ("CONTACTE_ORIGEN_ID")
	  REFERENCES "SINTAGMA_U"."A0_CONTACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE03" FOREIGN KEY ("SUBJECTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_SUBJECTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE04" FOREIGN KEY ("ADRECA_ID")
	  REFERENCES "SINTAGMA_U"."A0_ADRECA" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE05" FOREIGN KEY ("TIPUS_CONTACTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_TIPUS_CONTACTE" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE06" FOREIGN KEY ("AMBIT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_AMBIT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE07" FOREIGN KEY ("ENTITAT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_ENTITAT" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_CONTACTE" ADD CONSTRAINT "A0_FKCONTACTE08" FOREIGN KEY ("VISIBILITAT_ID")
	  REFERENCES "SINTAGMA_U"."A0_DM_VISIBILITAT" ("ID") ENABLE;
