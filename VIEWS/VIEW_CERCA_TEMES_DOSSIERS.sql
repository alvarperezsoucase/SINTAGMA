--------------------------------------------------------
--  DDL for View VIEW_CERCA_TEMES_DOSSIERS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_TEMES_DOSSIERS" ("RESULT_ID", "RESULT_ASPECTE_ID", "RESULT_NUMERO_REGISTRE", "RESULT_TITOL", "RESULT_DATA_ASSENTAMENT", "RESULT_DATA_ASS_ORDERBY", "RESULT_USUARI_ASSENTAMENT", "FILTER_ASPECTE_ID", "FILTER_NUMERO_REGISTRE", "FILTER_TITOL", "FILTER_DATA_ASSENTAMENT", "FILTER_USUARI_ASSENTAMENT", "FILTER_SERIE", "FILTER_ESPECIFIC", "FILTER_DATA_ARXIU") AS 
  SELECT
	-- Columns to display in frontend
	D.ID AS RESULT_ID,
	ASP.ID AS RESULT_ASPECTE_ID, -- N�mero d'element
	D.NUMERO_REGISTRE AS RESULT_NUMERO_REGISTRE,
	ASP.DESCRIPCIO AS RESULT_TITOL,
	TO_CHAR( ASP.DATA_ASSENTAMENT, 'DD/MM/YYYY' ) AS RESULT_DATA_ASSENTAMENT,
	TO_CHAR( ASP.DATA_ASSENTAMENT, 'YYYY/MM/DD' ) AS RESULT_DATA_ASS_ORDERBY,
	ASP.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
	-- Columns from which to filter the search results
	ASP.ID AS FILTER_ASPECTE_ID, -- N�mero d'element
	D.NUMERO_REGISTRE AS FILTER_NUMERO_REGISTRE,
	ASP.DESCRIPCIO AS FILTER_TITOL,
	ASP.DATA_ASSENTAMENT AS FILTER_DATA_ASSENTAMENT,
	ASP.USUARI_ASSENTAMENT AS FILTER_USUARI_ASSENTAMENT,
	SER.DESCRIPCIO AS FILTER_SERIE,
	ESP.DESCRIPCIO AS FILTER_ESPECIFIC,
	CA.DATA_ARXIU AS FILTER_DATA_ARXIU
FROM DOSSIER D
	INNER JOIN ASPECTE ASP ON ASP.ID = D.ASPECTE_ID
	LEFT OUTER JOIN CLASSIFICACIO_ARXIU CA ON CA.ASPECTE_ID = D.ASPECTE_ID
	LEFT OUTER JOIN DM_SERIE SER ON SER.ID = CA.SERIE_ID
	LEFT OUTER JOIN DM_ESPECIFIC ESP ON ESP.ID = CA.ESPECIFIC_ID
WHERE 1=1
	AND D.DATA_ESBORRAT IS NULL
	AND ASP.DATA_ESBORRAT IS NULL
;
