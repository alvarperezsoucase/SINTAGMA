--------------------------------------------------------
--  DDL for DB Link LINKVIPS_U
--------------------------------------------------------

  CREATE DATABASE LINK "LINKVIPS_U"
   CONNECT TO "VIPS_U" IDENTIFIED BY VALUES ':1'
   USING '01-VIPS';
