--------------------------------------------------------
--  DDL for View VIEW_PERSONA_RELACIONADA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_PERSONA_RELACIONADA" ("ID", "CONTACTE_ID", "RESULT_NOM_COMPLET", "FILTER_NOM_COMPLET") AS 
  SELECT pr.ID, pr.contacte_id,
          pr.nom || ' ' || pr.cognom1 || ' '
          || pr.cognom2 AS result_nom_complet,
          fn_convert_to_vn (pr.nom || ' ' || pr.cognom1 || ' ' || pr.cognom2
                           ) AS filter_nom_complet
     FROM persona_relacionada pr
     WHERE pr.DATA_ESBORRAT IS null 
;
