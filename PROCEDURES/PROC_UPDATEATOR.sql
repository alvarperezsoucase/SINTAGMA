--------------------------------------------------------
--  DDL for Procedure PROC_UPDATEATOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."PROC_UPDATEATOR" (TABLA_ORIGEN IN VARCHAR2, CAMPO_ORIGEN IN VARCHAR2, TABLA_DESTINO IN VARCHAR2, CAMPO_DESTINO IN VARCHAR2) AS
   SQL_AUX VARCHAR2(4000);
BEGIN




SQL_AUX := 'update ' || TABLA_DESTINO || ' m';
SQL_AUX := SQL_AUX || ' set m.' || CAMPO_DESTINO ||'=(';
SQL_AUX := SQL_AUX || ' select a.' || CAMPO_DESTINO || ' from ' || TABLA_ORIGEN || ' a';
SQL_AUX := SQL_AUX || ' where m.ID=a.ID';
SQL_AUX := SQL_AUX || ')';
SQL_AUX := SQL_AUX || ' where m.ID in(';
SQL_AUX := SQL_AUX || ' select a2.ID from ' || TABLA_ORIGEN ||  ' a2';
SQL_AUX := SQL_AUX || ' where m.ID=a2.ID';

EXECUTE IMMEDIATE SQL_AUX;

  
END PROC_UPDATEATOR;

/
