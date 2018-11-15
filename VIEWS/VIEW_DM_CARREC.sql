--------------------------------------------------------
--  DDL for View VIEW_DM_CARREC
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_DM_CARREC" ("ID", "RESULT_CARREC", "FILTER_CARREC") AS 
  SELECT carr.ID, carr.descripcio AS result_carrec,
          fn_convert_to_vn (carr.descripcio) AS filter_carrec
     FROM dm_carrec carr 
;
