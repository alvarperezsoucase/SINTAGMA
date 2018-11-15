--------------------------------------------------------
--  DDL for Function FUNC_PARTICION_RISPLUS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_PARTICION_RISPLUS" (InstalacioID IN number) RETURN NUMBER AS 

    PARTICION number;
BEGIN
   
   SELECT AMBIT.PARTICION_ID into PARTICION 
     FROM Z_F002_INSTALACIO_AMBIT_PART AMBIT 
     WHERE AMBIT.INSTALACIOID = InstalacioID;   

   RETURN PARTICION;
  
END FUNC_PARTICION_RISPLUS;

/
