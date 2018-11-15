--------------------------------------------------------
--  DDL for View VIEW_CERCA_ACTES_ANTERIORS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_ACTES_ANTERIORS" ("RESULT_ID", "RESULT_ACTE", "FILTER_ACTE") AS 
  SELECT acte.ID AS RESULT_ID,
          acte.ID || ' ' || acte.TITOL AS RESULT_ACTE,
          fn_convert_to_vn (acte.ID || ' ' || acte.TITOL
                           ) AS FILTER_ACTE
     FROM ACTE acte
;
