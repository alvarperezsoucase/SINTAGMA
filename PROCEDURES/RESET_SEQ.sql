--------------------------------------------------------
--  DDL for Procedure RESET_SEQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."RESET_SEQ" ( p_seq_name in varchar2 )
is
    l_val number;
begin
    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by -' || l_val || 
                                                          ' minvalue 0';

    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by 1 minvalue 0';
end;

/
