--------------------------------------------------------
--  DDL for View VIEW_DM_CLASSIFICACIO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "SINTAGMA_U"."VIEW_DM_CLASSIFICACIO" ("ID", "RESULT_CLASSIFICACIO", "FILTER_CLASSIFICACIO") AS 
  SELECT clas.ID,
          clas.codi || ' ' || clas.descripcio AS result_classificacio,
          fn_convert_to_vn (clas.codi || ' ' || clas.descripcio
                           ) AS filter_classificacio
     FROM dm_classificacio clas 
;
