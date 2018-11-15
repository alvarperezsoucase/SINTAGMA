--------------------------------------------------------
--  DDL for View VIEW_CERCA_ACTES_DESPESES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_ACTES_DESPESES" ("RESULT_ID", "RESULT_TITOL", "RESULT_NOM_ACTE", "RESULT_PROVEIDOR", "RESULT_TIPUS_SERVEI", "FILTER_TITOL", "FILTER_NOM_ACTE", "FILTER_PROVEIDOR_ID", "FILTER_TIPUS_SERVEI_ID", "FILTER_DATA_PETICIO") AS 
  SELECT
	-- Columns to display in frontend
	com.id AS result_id,
	com.titol AS result_titol, 
	acte.titol AS result_nom_acte,
	dmp.descripcio AS result_proveidor,
	dmts.descripcio AS result_tipus_servei,
	
	-- Columns from which to filter the search results
	FN_CONVERT_TO_VN (com.titol) AS filter_titol, 
	FN_CONVERT_TO_VN (acte.titol) AS filter_nom_acte,
	dmp.id AS filter_proveidor_id,
	dmts.id AS filter_tipus_servei_id,
	com.data_peticio AS filter_data_peticio
FROM COMANDA com
	INNER JOIN ACTE acte ON acte.ID = com.ACTE_ID
	INNER JOIN DM_TIPUS_SERVEI dmts ON dmts.ID = com.TIPUS_SERVEI_ID
	INNER JOIN DM_PROVEIDOR dmp ON dmp.ID = dmts.PROVEIDOR_ID
WHERE 1=1
	AND com.data_esborrat IS NULL
	
;
