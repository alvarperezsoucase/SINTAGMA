--------------------------------------------------------
--  DDL for View VIEW_CERCA_CONTACTES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_CONTACTES" ("RESULT_ID", "RESULT_NOM_COMPLET_SUBJECTE", "RESULT_TIPUS", "RESULT_DEPARTAMENT", "RESULT_ENTITAT", "RESULT_TELEFON_PRINCIPAL", "RESULT_AMBIT_ID", "FILTER_NOM_COMPLET_SUBJECTE", "FILTER_ENTITAT", "FILTER_NUMERO_TELEFON", "FILTER_DATA_ACTUALITZACIO", "FILTER_CARREC", "FILTER_AMBIT_ID", "FILTER_CODI_AMBIT", "FILTER_CODI_VISIBILITAT", "FILTER_DATA_FI_VIGENCIA_CARREC") AS 
  SELECT con.ID AS result_id,
          vsub.result_nom_complet AS result_nom_complet_subjecte,
          tipuscon.descripcio AS result_tipus,
          con.departament AS result_departament,
          vent.result_entitat AS result_entitat,
          contel.numero AS result_telefon_principal,
          con.ambit_id AS result_ambit_id,
          vsub.filter_nom_complet AS filter_nom_complet_subjecte,
          vent.ID AS filter_entitat, contel.numero AS filter_numero_telefon,
          con.data_darrera_actualitzacio AS filter_data_actualitzacio,
          con.carrec_id AS filter_carrec, con.ambit_id AS filter_ambit_id,
          amb.codi AS filter_codi_ambit, vis.codi AS filter_codi_visibilitat,
          con.DATA_FI_VIGENCIA_CARREC AS filter_data_fi_vigencia_carrec
     FROM contacte con INNER JOIN dm_tipus_contacte tipuscon
          ON tipuscon.ID = con.tipus_contacte_id
          LEFT OUTER JOIN view_dm_entitat vent ON vent.ID = con.entitat_id
          INNER JOIN view_subjecte vsub ON vsub.ID = con.subjecte_id
          LEFT OUTER JOIN contacte_telefon contel
          ON contel.contacte_id = con.ID AND contel.es_principal = 1
          INNER JOIN dm_ambit amb ON amb.ID = con.ambit_id
          INNER JOIN dm_visibilitat vis ON vis.ID = con.visibilitat_id
    WHERE con.data_esborrat IS NULL
;
