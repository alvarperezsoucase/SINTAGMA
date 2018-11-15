--------------------------------------------------------
--  DDL for View VIEW_CERCA_TRUCADES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_TRUCADES" ("RESULT_ID", "RESULT_NOM_COMPLET", "RESULT_ENTITAT", "RESULT_ESTAT", "RESULT_CODI", "RESULT_SENTIT", "RESULT_TELEFON", "RESULT_DATA_ENTRADA", "RESULT_DATA_ENTRADA_ORDERBY", "RESULT_HORA_ENTRADA", "RESULT_DESCRIPCIO", "FILTER_NOM_COMPLET", "FILTER_ENTITAT", "FILTER_ESTAT", "FILTER_CODI", "FILTER_SENTIT", "FILTER_TELEFON", "FILTER_DATA_ENTRADA", "FILTER_HORA_ENTRADA") AS 
  SELECT
t.ID AS result_id,
t.nom || ' ' || t.cognom1 || ' ' || t.cognom2 AS result_nom_complet,
vent.result_entitat AS result_entitat,
et.descripcio AS result_estat,
dp.descripcio AS result_codi,
st.descripcio AS result_sentit,
t.telefon AS result_telefon,
fn_convert_to_vn (TO_CHAR (t.data_registre,'DD/MM/YYYY') ) AS result_data_entrada,
fn_convert_to_vn (TO_CHAR (t.data_registre,'YYYY/MM/DD') ) AS result_data_entrada_orderby,
fn_convert_to_vn (TO_CHAR (t.data_registre,'HH24:mi') ) AS result_hora_entrada,
t.descripcio AS result_descripcio,
fn_convert_to_vn (t.nom || ' ' || t.cognom1 || ' ' || t.cognom2 ) AS filter_nom_complet,
vent.ID AS filter_entitat,
t.estat_trucada_id AS filter_estat,
t.destinatari_persona_id AS filter_codi,
t.sentit_id AS filter_sentit,
t.telefon AS filter_telefon,
fn_convert_to_vn (TO_CHAR (t.data_registre,'DD/MM/YYYY') ) AS filter_data_entrada,
fn_convert_to_vn (TO_CHAR (t.data_registre,'HH24:mi') ) AS filter_hora_entrada
FROM trucada t
LEFT OUTER JOIN view_dm_entitat vent ON vent.ID = t.entitat_id
INNER JOIN dm_estat_trucada et ON et.ID = t.estat_trucada_id
INNER JOIN dm_destinatari_persona dp ON dp.ID = t.destinatari_persona_id
INNER JOIN dm_sentit_trucada st ON st.ID = t.sentit_id
WHERE 1 = 1
AND t.usuari_esborrat IS NULL
ORDER BY result_data_entrada_orderby desc, result_hora_entrada desc

;
