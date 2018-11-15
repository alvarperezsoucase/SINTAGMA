--------------------------------------------------------
--  DDL for View VIEW_CERCA_TEMES_GLOBAL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_TEMES_GLOBAL" ("RESULT_ID", "RESULT_ASPECTE_ID", "RESULT_TIPUS_TEMA", "RESULT_EXTRACTE", "RESULT_USUARI_ASSENTAMENT", "RESULT_DATA_ASSENTAMENT", "RESULT_DATA_ASS_ORDERBY", "RESULT_ELEMENT_PRINCIPAL_ID", "RESULT_EP_ASPECTE_ID", "RESULT_MATRICULA_RESPONSABLE", "RESULT_CODI_ESTAT_EP", "FILTER_TIPUS_TEMA_ID", "FILTER_ASPECTE_ID", "FILTER_EXTRACTE", "FILTER_ELEMENT_PRINCIPAL_ID", "FILTER_DATA_INICI_ACTE", "FILTER_DATA_FI_ACTE", "FILTER_SENTIT_ID", "FILTER_DATA_ASSENTAMENT", "FILTER_USUARI_ASSENTAMENT") AS 
  SELECT
		-- Columns to display in frontend
		EP.ID AS RESULT_ID,
		ASP.ID AS RESULT_ASPECTE_ID,
		TIPUS.CODI AS RESULT_TIPUS_TEMA,
		ASP.DESCRIPCIO AS RESULT_EXTRACTE,
		ASP.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'DD/MM/YYYY' ) AS RESULT_DATA_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'YYYY/MM/DD' ) AS RESULT_DATA_ASS_ORDERBY,
		NULL AS RESULT_ELEMENT_PRINCIPAL_ID,
		NULL AS RESULT_EP_ASPECTE_ID,
		EP.MATRICULA_USUARI_RESPONSABLE AS RESULT_MATRICULA_RESPONSABLE,
		EEP.CODI AS RESULT_CODI_ESTAT_EP,
		-- Columns from which to filter the search results
		TIPUS.ID AS FILTER_TIPUS_TEMA_ID,
		ASP.ID AS FILTER_ASPECTE_ID,
		FN_CONVERT_TO_VN(ASP.DESCRIPCIO) AS FILTER_EXTRACTE,
		NULL AS FILTER_ELEMENT_PRINCIPAL_ID,
		EA.DATA_INICI_ACTE AS FILTER_DATA_INICI_ACTE,
		EA.DATA_FI_ACTE AS FILTER_DATA_FI_ACTE,
		EP.ORIGEN_ID AS FILTER_SENTIT_ID,
		ASP.DATA_ASSENTAMENT AS FILTER_DATA_ASSENTAMENT,
		FN_CONVERT_TO_VN(ASP.USUARI_ASSENTAMENT) AS FILTER_USUARI_ASSENTAMENT
	FROM
		ELEMENT_PRINCIPAL EP
	INNER JOIN ASPECTE ASP ON
		ASP.ID = EP.ASPECTE_ID
	INNER JOIN DM_TIPUS_TEMA TIPUS ON
		TIPUS.ID = ASP.TIPUS_TEMA_ID
	LEFT OUTER JOIN ENTRADA_AGENDA EA ON
		EA.ELEMENT_PRINCIPAL_ID = EP.ID
	INNER JOIN DM_ESTAT_ELEMENT EEP ON
		EEP.ID = EP.ESTAT_ELEMENT_PRINCIPAL_ID
	WHERE
		1 = 1
		AND EP.DATA_ESBORRAT IS NULL
		AND ASP.DATA_ESBORRAT IS NULL
UNION SELECT
		-- Columns to display in frontend
		ES.ID AS RESULT_ID,
		ASP.ID AS RESULT_ASPECTE_ID,
		TIPUS.CODI AS RESULT_TIPUS_TEMA,
		ASP.DESCRIPCIO AS RESULT_EXTRACTE,
		ASP.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'DD/MM/YYYY' ) AS RESULT_DATA_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'YYYY/MM/DD' ) AS RESULT_DATA_ASS_ORDERBY,
		ES.ELEMENT_PRINCIPAL_ID AS RESULT_ELEMENT_PRINCIPAL_ID,
		EP.ASPECTE_ID AS RESULT_EP_ASPECTE_ID,
		NULL AS RESULT_MATRICULA_RESPONSABLE,
		NULL AS RESULT_CODI_ESTAT_EP,
		-- Columns from which to filter the search results
		TIPUS.ID AS FILTER_TIPUS_TEMA_ID,
		ASP.ID AS FILTER_ASPECTE_ID,
		FN_CONVERT_TO_VN(ASP.DESCRIPCIO) AS FILTER_EXTRACTE,
		ES.ELEMENT_PRINCIPAL_ID AS FILTER_ELEMENT_PRINCIPAL_ID,
		NULL AS FILTER_DATA_INICI_ACTE,
		NULL AS FILTER_DATA_FI_ACTE,
		ES.ORIGEN_ID AS FILTER_SENTIT_ID,
		ASP.DATA_ASSENTAMENT AS FILTER_DATA_ASSENTAMENT,
		FN_CONVERT_TO_VN(ASP.USUARI_ASSENTAMENT) AS FILTER_USUARI_ASSENTAMENT
	FROM
		ELEMENT_SECUNDARI ES
	INNER JOIN ASPECTE ASP ON
		ASP.ID = ES.ASPECTE_ID
	INNER JOIN DM_TIPUS_TEMA TIPUS ON
		TIPUS.ID = ASP.TIPUS_TEMA_ID
	INNER JOIN ELEMENT_PRINCIPAL EP ON
		EP.ID = ES.ELEMENT_PRINCIPAL_ID
	WHERE
		1 = 1
		AND ES.DATA_ESBORRAT IS NULL
		AND ASP.DATA_ESBORRAT IS NULL
UNION SELECT
		-- Columns to display in frontend
		D.ID AS RESULT_ID,
		ASP.ID AS RESULT_ASPECTE_ID,
		TIPUS.CODI AS RESULT_TIPUS_TEMA,
		ASP.DESCRIPCIO AS RESULT_EXTRACTE,
		ASP.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'DD/MM/YYYY' ) AS RESULT_DATA_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'YYYY/MM/DD' ) AS RESULT_DATA_ASS_ORDERBY,
		NULL AS RESULT_ELEMENT_PRINCIPAL_ID,
		NULL AS RESULT_EP_ASPECTE_ID,
		NULL AS RESULT_MATRICULA_RESPONSABLE,
		NULL AS RESULT_CODI_ESTAT_EP,
		-- Columns from which to filter the search results
		TIPUS.ID AS FILTER_TIPUS_TEMA_ID,
		ASP.ID AS FILTER_ASPECTE_ID,
		FN_CONVERT_TO_VN(ASP.DESCRIPCIO) AS FILTER_EXTRACTE,
		NULL AS FILTER_ELEMENT_PRINCIPAL_ID,
		NULL AS FILTER_DATA_INICI_ACTE,
		NULL AS FILTER_DATA_FI_ACTE,
		NULL AS FILTER_SENTIT_ID,
		ASP.DATA_ASSENTAMENT AS FILTER_DATA_ASSENTAMENT,
		FN_CONVERT_TO_VN(ASP.USUARI_ASSENTAMENT) AS FILTER_USUARI_ASSENTAMENT
	FROM
		DOSSIER D
	INNER JOIN ASPECTE ASP ON
		ASP.ID = D.ASPECTE_ID
	INNER JOIN DM_TIPUS_TEMA TIPUS ON
		TIPUS.ID = ASP.TIPUS_TEMA_ID
	WHERE
		1 = 1
		AND D.DATA_ESBORRAT IS NULL
		AND ASP.DATA_ESBORRAT IS NULL
UNION SELECT
		-- Columns to display in frontend
		A.ID AS RESULT_ID,
		ASP.ID AS RESULT_ASPECTE_ID,
		TIPUS.CODI AS RESULT_TIPUS_TEMA,
		ASP.DESCRIPCIO AS RESULT_EXTRACTE,
		ASP.USUARI_ASSENTAMENT AS RESULT_USUARI_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'DD/MM/YYYY' ) AS RESULT_DATA_ASSENTAMENT,
		TO_CHAR( ASP.DATA_ASSENTAMENT, 'YYYY/MM/DD' ) AS RESULT_DATA_ASS_ORDERBY,
		A.ELEMENT_PRINCIPAL_ID AS RESULT_ELEMENT_PRINCIPAL_ID,
		EP.ASPECTE_ID AS RESULT_EP_ASPECTE_ID,
		NULL AS RESULT_MATRICULA_RESPONSABLE,
		NULL AS RESULT_CODI_ESTAT_EP,
		-- Columns from which to filter the search results
		TIPUS.ID AS FILTER_TIPUS_TEMA_ID,
		ASP.ID AS FILTER_ASPECTE_ID,
		FN_CONVERT_TO_VN(ASP.DESCRIPCIO) AS FILTER_EXTRACTE,
		A.ELEMENT_PRINCIPAL_ID AS FILTER_ELEMENT_PRINCIPAL_ID,
		NULL AS FILTER_DATA_INICI_ACTE,
		NULL AS FILTER_DATA_FI_ACTE,
		NULL AS FILTER_SENTIT_ID,
		ASP.DATA_ASSENTAMENT AS FILTER_DATA_ASSENTAMENT,
		FN_CONVERT_TO_VN(ASP.USUARI_ASSENTAMENT) AS FILTER_USUARI_ASSENTAMENT
	FROM
		ACCIO A
	INNER JOIN ASPECTE ASP ON
		ASP.ID = A.ASPECTE_ID
	INNER JOIN DM_TIPUS_TEMA TIPUS ON
		TIPUS.ID = ASP.TIPUS_TEMA_ID
	INNER JOIN ELEMENT_PRINCIPAL EP ON
		EP.ID = A.ELEMENT_PRINCIPAL_ID
	WHERE
		1 = 1
		AND A.DATA_ESBORRAT IS NULL
		AND ASP.DATA_ESBORRAT IS NULL
;
