--------------------------------------------------------
--  DDL for View VIEW_ACTES_CONVIDATS_SELECCIO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_ACTES_CONVIDATS_SELECCIO" ("RESULT_ID", "RESULT_CLASSIFICACIO", "RESULT_PRIORITAT", "RESULT_ENTITAT", "RESULT_NOM_COMPLET", "FILTER_CLASSIFICACIO", "FILTER_PRIORITAT", "FILTER_ENTITAT", "FILTER_NOM_COMPLET", "FILTER_SUBJECTE", "FILTER_CONTACTE") AS 
  SELECT
	con_class.ID AS RESULT_ID,
	v_dm_class.RESULT_CLASSIFICACIO AS RESULT_CLASSIFICACIO,
	dm_prio.DESCRIPCIO AS RESULT_PRIORITAT,
	v_dm_enti.RESULT_ENTITAT AS RESULT_ENTITAT,
	v_subj.RESULT_NOM_COMPLET AS RESULT_NOM_COMPLET,
	v_dm_class.ID AS FILTER_CLASSIFICACIO,
	dm_prio.ID AS FILTER_PRIORITAT,
	v_dm_enti.ID AS FILTER_ENTITAT,
	v_subj.FILTER_NOM_COMPLET AS FILTER_NOM_COMPLET,
	subj.ID AS FILTER_SUBJECTE,
	con_class.CONTACTE_ID AS FILTER_CONTACTE
FROM 
	CONTACTE con
	INNER JOIN CONTACTE_CLASSIFICACIO con_class ON con_class.CONTACTE_ID = con.ID
	INNER JOIN VIEW_DM_CLASSIFICACIO v_dm_class ON v_dm_class.ID = con_class.CLASSIFICACIO_ID
	INNER JOIN VIEW_SUBJECTE v_subj ON v_subj.ID = con.SUBJECTE_ID
	INNER JOIN SUBJECTE subj ON subj.ID = con.SUBJECTE_ID
	LEFT OUTER JOIN DM_PRIORITAT dm_prio ON dm_prio.ID = subj.PRIORITAT_ID
	LEFT OUTER JOIN VIEW_DM_ENTITAT v_dm_enti ON v_dm_enti.ID = con.ENTITAT_ID
WHERE 
	con.DATA_ESBORRAT IS NULL AND
	(con.AMBIT_ID = 2 OR con.VISIBILITAT_ID = 3)
	AND (con_class.DATA_FI_VIGENCIA IS NULL OR con_class.DATA_FI_VIGENCIA >= SYSDATE) AND con_class.DATA_ESBORRAT IS NULL
;