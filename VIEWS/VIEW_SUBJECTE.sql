--------------------------------------------------------
--  DDL for View VIEW_SUBJECTE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_SUBJECTE" ("ID", "RESULT_NOM", "RESULT_COGNOM1", "RESULT_COGNOM2", "RESULT_NOM_COMPLET", "RESULT_TIPUS_SUBJECTE", "RESULT_ALIES", "RESULT_ARTICLE", "FILTER_NOM", "FILTER_COGNOM1", "FILTER_COGNOM2", "FILTER_NOM_COMPLET", "FILTER_TIPUS_SUBJECTE") AS 
  SELECT sub.ID, sub.nom AS result_nom, sub.cognom1 AS result_cognom1,
          sub.cognom2 AS result_cognom2,
             sub.nom
          || ' '
          || sub.cognom1
          || ' '
          || sub.cognom2 AS result_nom_complet,
          tsub.descripcio AS result_tipus_subjecte, sub.alies AS result_alies,
          art.DESCRIPCIO AS result_article,
          fn_convert_to_vn (sub.nom) AS filter_nom,
          fn_convert_to_vn (sub.cognom1) AS filter_cognom1,
          fn_convert_to_vn (sub.cognom2) AS filter_cognom2,
          fn_convert_to_vn (sub.nom || ' ' || sub.cognom1 || ' '
                            || sub.cognom2
                           ) AS filter_nom_complet,
          sub.tipus_subjecte_id AS filter_tipus_subjecte
     FROM subjecte sub INNER JOIN dm_tipus_subjecte tsub
          ON tsub.ID = sub.tipus_subjecte_id 
          LEFT OUTER JOIN DM_ARTICLE art ON art.id = sub.ARTICLE_ID 
     WHERE sub.DATA_DEFUNCIO IS NULL
     	  AND sub.DATA_ESBORRAT IS NULL
;
