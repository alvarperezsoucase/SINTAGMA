--------------------------------------------------------
--  DDL for Procedure SET_SEQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."SET_SEQ" ( p_seq_name in varchar2, p_num_seq in number )
is
    l_val number;
    aux_val number;

begin
    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    aux_val:= p_num_seq - l_val;
    
    execute immediate
    'alter sequence ' || p_seq_name || ' increment by ' || aux_val || 
                                                          ' minvalue 0';
                                                                                                                    

    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by 1 minvalue 0';
end;

/
