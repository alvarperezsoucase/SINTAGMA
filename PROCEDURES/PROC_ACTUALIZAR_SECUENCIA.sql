--------------------------------------------------------
--  DDL for Procedure PROC_ACTUALIZAR_SECUENCIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."PROC_ACTUALIZAR_SECUENCIA" (Prefijo varchar2, TABLA in varchar2 )AS 
--    PREFIJO varchar2(30);
    MAX_SEQ number;
    TABLA_FROM varchar2(30);
    sql_aux varchar2(2000);
BEGIN
--      PREFIJO := 'A1_';
      
      TABLA_FROM := (PREFIJO || TABLA);
      
      
      sql_aux  := 'SELECT MAX(ID) FROM ' || TABLA_FROM;
      
      DBMS_OUTPUT.PUT_LINE('sql_aux   ---> ' || sql_aux  );
      
      EXECUTE IMMEDIATE sql_aux  INTO MAX_SEQ;
      
      
      DBMS_OUTPUT.PUT_LINE('MAX_SEQ   ---> ' || MAX_SEQ  );
      
      IF (MAX_SEQ IS NOT NULL) THEN 
                SET_SEQ(PREFIJO || 'SEQ_' || TABLA,MAX_SEQ);
      END IF;

  NULL;
END PROC_ACTUALIZAR_SECUENCIA;

/*
    PREFIJO VARCHAR2(3);
    MAX_SEQ number;
    TABLA_FROM varchar2(30);
    SQL_AUX  varchar2(4000);
BEGIN
      PREFIJO := 'A1_';
    
--      PREFIJO_AUX := TRIM(PREFIJO);

      
      TABLA_FROM := (PREFIJO || TRIM(TABLA));
      
      DBMS_OUTPUT.PUT_LINE('TABLA ---> ' || TABLA_FROM );
      
      SQL_AUX  := 'SELECT MAX(ID) FROM ' || TABLA_FROM  || ' INTO MAX_SEQ;';
      
       DBMS_OUTPUT.PUT_LINE('SQL ---> ' || SQL_AUX);
      
      EXECUTE IMMEDIATE SQL_AUX;
--        EXECUTE IMMEDIATE 'SELECT MAX(ID) FROM ' || TABLA_FROM  INTO MAX_SEQ;
      
      DBMS_OUTPUT.PUT_LINE('MAX_SEQ ---> ' || MAX_SEQ);
      
      IF (MAX_SEQ IS NOT NULL) THEN 
           DBMS_OUTPUT.PUT_LINE('LLEGA4 --->' || PREFIJO || 'SEQ_' || TRIM(TABLA));
                SET_SEQ(PREFIJO || 'SEQ_' || TRIM(TABLA), MAX_SEQ);
                DBMS_OUTPUT.PUT_LINE('LLEGA5');
      END IF;

  NULL;
END PROC_ACTUALIZAR_SECUENCIA;
*/

/
