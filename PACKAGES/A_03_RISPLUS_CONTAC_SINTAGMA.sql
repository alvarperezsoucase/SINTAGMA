--------------------------------------------------------
--  DDL for Package A_03_RISPLUS_CONTAC_SINTAGMA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."A_03_RISPLUS_CONTAC_SINTAGMA" AS 

ConstALCALDIA CONSTANT integer:=1; 
   ConstPROTOCOL CONSTANT integer:=2;    
      
   ConstPersonal CONSTANT integer:=1; 
   ConstProfesional CONSTANT integer:=2; 
   
   ConstSebjectePersona CONSTANT integer:=1; 
   ConstSebjecteEntitat CONSTANT integer:=2; 
   
   ConstVisibilitatPublica CONSTANT integer:=1; -- P�blica
   ConstVisibilitatPrivada CONSTANT integer:=2; -- Privada
   ConstVisibilitatAlcaldia CONSTANT integer:=3; -- Alcald�a
   
   

    PROCEDURE RESETEATOR_TABLAS;
    --PROCEDURE RESETEATOR_SECUENCIAS;


    PROCEDURE D01_EXTRAER_TRACTAMENT;
    PROCEDURE D02_DM_TRACTAMENTS;
    
    PROCEDURE D03_EXTRAER_CARREC;
    PROCEDURE D04_DM_CARREC;
    
    PROCEDURE D10_ENTITAT_EXISTENTES;
    PROCEDURE ERR_CONTACTES_EMPRESA_NULL;
    PROCEDURE D11_A_ENTITAT_NO_EXISTENTES;
    PROCEDURE D11_B_ENTITAT_NO_EXISTENTES;
    PROCEDURE D15_ENTITAT_CONTACTES;
    
    
  
    PROCEDURE D20_SUBJECTES_PERSONAS_UNICOS;
--    PROCEDURE D21_SUBJECTES_PERSONAS_CONTAC;
    
    PROCEDURE D22_SUBJECTES_ENTITATS_UNICS;
--    PROCEDURE D23_SUBJECTE_ENTITAT_CONTACTE;
    
    PROCEDURE D24_SUBJECTES_CARREC_UNIC;
--    PROCEDURE D25_SUBJECTE_CARREC_CONTACTE;
    
    
    PROCEDURE D26_SUBJECTES_UNION;
    PROCEDURE D27_SUBJECTES_RISPLUS;
    
--    PROCEDURE ERROR_SUBJECTES_NULL;
    
    

    --procedure D25_SUBJECTES;

   PROCEDURE D30_CONTACTES_SUBJECTES;
   
   PROCEDURE D40_ADRECA_UNICAS;
   PROCEDURE ERR_ADRECA_RISPLUS;
   PROCEDURE D41_ADRECA_CONTACTE;
   PROCEDURE D42_AUX_ADRECA;
   

   PROCEDURE D50_AUX_CONTACTES;
   
   
   PROCEDURE D60_CORREUS_CONTACTES;
   PROCEDURE D61_CORREUS_PRINCIPALES;
   PROCEDURE D62_CORREOS_CONTACTOS;
   
   PROCEDURE D70_TELEFONS_NUMERICS;
   PROCEDURE D71_TELEFON_PRINCIPAL;
   PROCEDURE D72_CONTACTE_TELEFON;


END A_03_RISPLUS_CONTAC_SINTAGMA;

/
