--------------------------------------------------------
--  DDL for View VIEW_CERCA_CONTACTE_TRUCADA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_CERCA_CONTACTE_TRUCADA" ("RESULT_ID", "RESULT_NOM_SUBJECTE", "RESULT_COGNOM1_SUBJECTE", "RESULT_COGNOM2_SUBJECTE", "RESULT_ENTITAT_ID", "RESULT_ENTITAT", "RESULT_DEPARTAMENT", "RESULT_CARREC", "RESULT_TIPUS_VIA", "RESULT_NOM_CARRER", "RESULT_NUMERO_INICI", "RESULT_NUMERO_FI", "RESULT_ESCALA", "RESULT_PIS", "RESULT_PORTA", "RESULT_BARRI", "RESULT_DISTRICTE", "RESULT_MUNICIPI", "RESULT_CODI_POSTAL", "RESULT_PROVINCIA", "RESULT_PAIS", "RESULT_NUMERO_PRINCIPAL", "RESULT_CORREU_PRINCIPAL", "FILTER_ID") AS 
  SELECT
          -- Columns to display in frontend
          con.ID AS result_id, vsub.result_nom AS result_nom_subjecte,
          vsub.result_cognom1 AS result_cognom1_subjecte,
          vsub.result_cognom2 AS result_cognom2_subjecte,
          vent.ID AS result_entitat_id, vent.result_entitat AS result_entitat,
          con.departament AS result_departament,
          vcarr.result_carrec AS result_carrec,
          adreca.codi_tipus_via AS result_tipus_via,
          adreca.nom_carrer AS result_nom_carrer,
          adreca.numero_inici AS result_numero_inici,
          adreca.numero_fi AS result_numero_fi,
          adreca.escala AS result_escala, adreca.pis AS result_pis,
          adreca.porta AS result_porta, adreca.barri AS result_barri,
          adreca.districte AS result_districte,
          adreca.municipi AS result_municipi,
          adreca.codi_postal AS result_codi_postal,
          adreca.provincia AS result_provincia, adreca.pais AS result_pais,
          contel.numero AS result_numero_principal,
          concorr.correu_electronic AS result_correu_principal,
          
          -- Columns from which to filter the search results
          con.ID AS filter_id
     FROM contacte con INNER JOIN dm_tipus_contacte tipuscon
          ON tipuscon.ID = con.tipus_contacte_id
          LEFT OUTER JOIN view_dm_entitat vent ON vent.ID = con.entitat_id
          INNER JOIN view_subjecte vsub ON vsub.ID = con.subjecte_id
          INNER JOIN dm_ambit amb ON amb.ID = con.ambit_id
          LEFT OUTER JOIN view_dm_carrec vcarr ON vcarr.ID = con.carrec_id
          INNER JOIN adreca adreca ON con.adreca_id = adreca.ID
          LEFT OUTER JOIN contacte_telefon contel
          ON contel.contacte_id = con.ID AND contel.es_principal = 1
          LEFT OUTER JOIN contacte_correu concorr
          ON concorr.contacte_id = con.ID AND concorr.es_principal = 1
    WHERE con.data_esborrat IS NULL 
;
