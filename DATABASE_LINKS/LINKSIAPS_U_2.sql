--------------------------------------------------------
--  DDL for DB Link LINKSIAPS_U_2
--------------------------------------------------------

  CREATE DATABASE LINK "LINKSIAPS_U_2"
   CONNECT TO "SIAP_U" IDENTIFIED BY VALUES ':1'
   USING 'corde1.imi.bcn:1541/CORDE1';
