--------------------------------------------------------
--  DDL for Procedure PROC_ACTIVA_TODO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."PROC_ACTIVA_TODO" AS 
BEGIN
FOR c IN
  (SELECT c.owner, c.table_name, c.constraint_name
   FROM user_constraints c, user_tables t
   WHERE c.table_name = t.table_name
   AND c.status = 'DISABLED'
   ORDER BY c.constraint_type)
  LOOP
    dbms_utility.exec_ddl_statement('alter table "' || c.owner || '"."' || c.table_name || '" enable constraint ' || c.constraint_name);
  END LOOP;
END PROC_ACTIVA_TODO;

/
