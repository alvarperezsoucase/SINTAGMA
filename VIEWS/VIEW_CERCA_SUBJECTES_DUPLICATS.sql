--------------------------------------------------------
--  DDL for View VIEW_CERCA_SUBJECTES_DUPLICATS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_SUBJECTES_DUPLICATS" ("RESULT_ID", "RESULT_TRACTAMENT", "RESULT_NOM", "RESULT_COGNOM1", "RESULT_COGNOM2", "RESULT_ALIES", "RESULT_TRACTAMENT_ID", "RESULT_PRIORITAT_ID", "RESULT_TIPUS_SUBJECTE_ID", "RESULT_IDIOMA_ID", "RESULT_AMBIT_ID", "FILTER_TIPUS_SUBJECTE_ID", "FILTER_NOM", "FILTER_COGNOM1", "FILTER_COGNOM2", "FILTER_AMBIT_ID") AS 
  SELECT
	-- Columns to display in frontend
	sub.ID AS result_id, trac.descripcio AS result_tractament,
	vsub.result_nom AS result_nom,
	vsub.result_cognom1 AS result_cognom1,
	vsub.result_cognom2 AS result_cognom2,
	vsub.result_alies AS result_alies,
	sub.tractament_id AS result_tractament_id,
	sub.prioritat_id AS result_prioritat_id,
	sub.tipus_subjecte_id AS result_tipus_subjecte_id,
	sub.idioma_id AS result_idioma_id,
	sub.ambit_id AS result_ambit_id,
	
	-- Columns from which to filter the search results
	sub.tipus_subjecte_id AS filter_tipus_subjecte_id,
	vsub.filter_nom AS filter_nom,
	vsub.filter_cognom1 AS filter_cognom1,
	vsub.filter_cognom2 AS filter_cognom2,
	sub.ambit_id AS filter_ambit_id
FROM subjecte sub
	INNER JOIN view_subjecte vsub ON vsub.ID = sub.ID
	LEFT OUTER JOIN dm_tractament trac ON trac.ID = sub.tractament_id
WHERE 1=1
	AND sub.data_esborrat IS NULL

;
