--------------------------------------------------------
--  DDL for View VIEW_DM_ENTITAT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_DM_ENTITAT" ("ID", "RESULT_ENTITAT", "FILTER_ENTITAT") AS 
  SELECT
ent.ID,
ent.descripcio AS result_entitat,
fn_convert_to_vn (ent.descripcio) AS filter_entitat
FROM dm_entitat ent

;
