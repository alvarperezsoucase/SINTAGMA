--------------------------------------------------------
--  Ref Constraints for Table A0_COMENTARI_ASPECTE
--------------------------------------------------------

  ALTER TABLE "SINTAGMA_U"."A0_COMENTARI_ASPECTE" ADD CONSTRAINT "A0_FKCOMENTARI_ASPECTE376237" FOREIGN KEY ("COMENTARI_ID")
	  REFERENCES "SINTAGMA_U"."A0_COMENTARI" ("ID") ENABLE;
  ALTER TABLE "SINTAGMA_U"."A0_COMENTARI_ASPECTE" ADD CONSTRAINT "A0_FKCOMENTARI_ASPECTE423341" FOREIGN KEY ("ASPECTE_ID")
	  REFERENCES "SINTAGMA_U"."A0_ASPECTE" ("ID") ENABLE;
