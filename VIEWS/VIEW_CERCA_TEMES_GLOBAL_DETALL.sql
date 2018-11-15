--------------------------------------------------------
--  DDL for View VIEW_CERCA_TEMES_GLOBAL_DETALL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_TEMES_GLOBAL_DETALL" ("RESULT_NOM_TITULAR_FORA", "RESULT_COGNOM1_TITULAR_FORA", "RESULT_COGNOM2_TITULAR_FORA", "RESULT_ENTITAT_TITULAR_FORA", "RESULT_DATA_INICI_ACTE", "RESULT_DATA_FI_ACTE", "RESULT_DATA_ASSENTAMENT", "RESULT_USUARI_ASSENTAMENT", "RESULT_SENTIT", "FILTER_ASPECTE_ID") AS 
  SELECT
	-- Columns to display in frontend
	fora.NOM AS RESULT_NOM_TITULAR_FORA,
	fora.COGNOM1 AS RESULT_COGNOM1_TITULAR_FORA,
	fora.COGNOM2 AS RESULT_COGNOM2_TITULAR_FORA,
	fora.ENTITAT AS RESULT_ENTITAT_TITULAR_FORA,
	FN_CONVERT_TO_VN(TO_CHAR(ea.DATA_INICI_ACTE,'DD/MM/YYYY')) AS RESULT_DATA_INICI_ACTE,
	FN_CONVERT_TO_VN(TO_CHAR(ea.DATA_FI_ACTE,'DD/MM/YYYY')) AS RESULT_DATA_FI_ACTE,
	FN_CONVERT_TO_VN(TO_CHAR(asp.DATA_ASSENTAMENT,'DD/MM/YYYY')) AS RESULT_DATA_ASSENTAMENT,
	asp.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
	orig.DESCRIPCIO AS RESULT_SENTIT,
	-- Columns from which to filter the search results
	asp.ID AS FILTER_ASPECTE_ID
FROM ELEMENT_PRINCIPAL ep
	INNER JOIN ASPECTE asp ON asp.ID = ep.ASPECTE_ID
	INNER JOIN DM_ORIGEN_ELEMENT orig ON orig.ID = ep.ORIGEN_ID
	LEFT OUTER JOIN TITULAR_FORA fora ON fora.ASPECTE_ID = asp.ID
	LEFT OUTER JOIN ENTRADA_AGENDA ea ON ea.ELEMENT_PRINCIPAL_ID = ep.ID
UNION
SELECT
	-- Columns to display in frontend
	fora.NOM AS RESULT_NOM_TITULAR_FORA,
	fora.COGNOM1 AS RESULT_COGNOM1_TITULAR_FORA,
	fora.COGNOM2 AS RESULT_COGNOM2_TITULAR_FORA,
	fora.ENTITAT AS RESULT_ENTITAT_TITULAR_FORA,
	NULL AS RESULT_DATA_INICI_ACTE,
	NULL AS RESULT_DATA_FI_ACTE,
	FN_CONVERT_TO_VN(TO_CHAR(asp.DATA_ASSENTAMENT,'DD/MM/YYYY')) AS RESULT_DATA_ASSENTAMENT,
	asp.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
	orig.DESCRIPCIO AS RESULT_SENTIT,
	-- Columns from which to filter the search results
	asp.ID AS FILTER_ASPECTE_ID
FROM ELEMENT_SECUNDARI es
	INNER JOIN ASPECTE asp ON asp.ID = es.ASPECTE_ID
	INNER JOIN DM_ORIGEN_ELEMENT orig ON orig.ID = es.ORIGEN_ID
	LEFT OUTER JOIN TITULAR_FORA fora ON fora.ASPECTE_ID = asp.ID
UNION
SELECT
	-- Columns to display in frontend
	NULL AS RESULT_NOM_TITULAR_FORA,
	NULL AS RESULT_COGNOM1_TITULAR_FORA,
	NULL AS RESULT_COGNOM2_TITULAR_FORA,
	NULL AS RESULT_ENTITAT_TITULAR_FORA,
	NULL AS RESULT_DATA_INICI_ACTE,
	NULL AS RESULT_DATA_FI_ACTE,
	FN_CONVERT_TO_VN(TO_CHAR(asp.DATA_ASSENTAMENT,'DD/MM/YYYY')) AS RESULT_DATA_ASSENTAMENT,
	asp.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
	NULL AS RESULT_SENTIT,
	-- Columns from which to filter the search results
	asp.ID AS FILTER_ASPECTE_ID
FROM DOSSIER d
	INNER JOIN ASPECTE asp ON asp.ID = d.ASPECTE_ID
UNION
SELECT
	-- Columns to display in frontend
	NULL AS RESULT_NOM_TITULAR_FORA,
	NULL AS RESULT_COGNOM1_TITULAR_FORA,
	NULL AS RESULT_COGNOM2_TITULAR_FORA,
	NULL AS RESULT_ENTITAT_TITULAR_FORA,
	NULL AS RESULT_DATA_INICI_ACTE,
	NULL AS RESULT_DATA_FI_ACTE,
	FN_CONVERT_TO_VN(TO_CHAR(asp.DATA_ASSENTAMENT,'DD/MM/YYYY')) AS RESULT_DATA_ASSENTAMENT,
	asp.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
	NULL AS RESULT_SENTIT,
	-- Columns from which to filter the search results
	asp.ID AS FILTER_ASPECTE_ID
FROM ACCIO a
	INNER JOIN ASPECTE asp ON asp.ID = a.ASPECTE_ID
	
;
