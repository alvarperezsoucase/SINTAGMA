--------------------------------------------------------
--  DDL for View VIEW_DM_CLASSIFICACIO_ACTE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_DM_CLASSIFICACIO_ACTE" ("RESULT_ID", "RESULT_CODI_CLASSIFICACIO", "RESULT_NOM_CLASSIFICACIO", "FILTER_CLASSIFICACIO", "FILTER_ACTE") AS 
  SELECT ROWNUM AS RESULT_ID, RESULT_CODI_CLASSIFICACIO, RESULT_NOM_CLASSIFICACIO, FILTER_CLASSIFICACIO, FILTER_ACTE FROM (
SELECT
        C.CODI_CLASSIFICACIO AS RESULT_CODI_CLASSIFICACIO,
        C.NOM_CLASSIFICACIO AS RESULT_NOM_CLASSIFICACIO,
        MAX(fn_convert_to_vn (C.CODI_CLASSIFICACIO || ' ' || C.NOM_CLASSIFICACIO)) AS FILTER_CLASSIFICACIO,
        MAX(C.ACTE_ID) AS FILTER_ACTE
FROM CONVIDAT C
GROUP BY C.ACTE_ID, C.CODI_CLASSIFICACIO, C.NOM_CLASSIFICACIO )
;