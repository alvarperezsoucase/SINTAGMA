--------------------------------------------------------
--  DDL for Package A0_04_CONTACTES_RISPLUS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."A0_04_CONTACTES_RISPLUS" AS 

  ConstALCALDIA CONSTANT integer:=1; 
   ConstPROTOCOL CONSTANT integer:=2;    
      
   ConstContactePersonal CONSTANT integer:=1; 
   ConstContacteProfesional CONSTANT integer:=2; 
   
   ConstSebjectePersona CONSTANT integer:=1; 
   ConstSebjecteEntitat CONSTANT integer:=2; 
   
   ConstVisibilitatPublica CONSTANT integer:=1; -- P�blica
   ConstVisibilitatPrivada CONSTANT integer:=2; -- Privada
   ConstVisibilitatAlcaldia CONSTANT integer:=3; -- Alcald�a
   
      ConstNO CONSTANT integer:=0; 
   ConstSI CONSTANT integer:=1; 
   
   ConstTelefonFix CONSTANT integer:=1; --Fijo
   ConstTelefonMobil CONSTANT integer:=2; --M�vil
   ConstTelefonFax CONSTANT integer:=3;  --Fax
   
   

    PROCEDURE RESETEATOR_TABLAS;
    --PROCEDURE RESETEATOR_SECUENCIAS;


    PROCEDURE SD01_EXTRAER_TRACTAMENT;
    PROCEDURE SD02_DM_TRACTAMENTS;
    
    PROCEDURE SD03_EXTRAER_CARREC;
    PROCEDURE SD04_DM_CARREC;
    
    PROCEDURE SD10_ENTITAT_EXISTENTES;
    PROCEDURE ERR_CONTACTES_EMPRESA_NULL;
    PROCEDURE SD11_A_ENTITAT_NO_EXISTENTES;
    PROCEDURE SD11_B_ENTITAT_NO_EXISTENTES;
    
    PROCEDURE SD14_DM_ENTITAT;
    
    PROCEDURE SD15_ENTITAT_CONTACTES;
    
    
  
    PROCEDURE SD20_SUBJECTES_PERSONAS_UNICOS;
--    PROCEDURE D21_SUBJECTES_PERSONAS_CONTAC;
    
    PROCEDURE SD22_SUBJECTES_ENTITATS_UNICS;
--    PROCEDURE D23_SUBJECTE_ENTITAT_CONTACTE;
    
    PROCEDURE SD24_SUBJECTES_CARREC_UNIC;
--    PROCEDURE D25_SUBJECTE_CARREC_CONTACTE;
    
    
    PROCEDURE SD26_SUBJECTES_UNION;
    PROCEDURE SD27_SUBJECTES_RISPLUS;
    PROCEDURE SD28_ERR_SUBJECTE;
    
--    PROCEDURE ERROR_SUBJECTES_NULL;
    
    

    --procedure D25_SUBJECTES;

   PROCEDURE SD30_CONTACTES_SUBJECTES;
   
   PROCEDURE SD40_ADRECA_UNICAS;
   PROCEDURE ERR_ADRECA_RISPLUS;
   PROCEDURE SD41_ADRECA_CONTACTE;
   PROCEDURE SD42_AUX_ADRECA;
   PROCEDURE SD43_ERR_ADRECA;
   

   PROCEDURE SD50_AUX_CONTACTES;
   PROCEDURE SD55_ERR_CONTACTES;
   
   
   PROCEDURE SD60_CORREUS_CONTACTES;
   PROCEDURE SD61_CORREUS_PRINCIPALES;
   PROCEDURE SD62_CORREOS_CONTACTOS;
   
   PROCEDURE SD070_TELEFONS_FIXE;
   PROCEDURE SD071_TELEFONS_MOBIL;
   
   /*
   PROCEDURE SD70_TELEFONS_NUMERICS;
   PROCEDURE SD71_TELEFON_PRINCIPAL;
   PROCEDURE SD72_CONTACTE_TELEFON;
*/

END A0_04_CONTACTES_RISPLUS;

/
