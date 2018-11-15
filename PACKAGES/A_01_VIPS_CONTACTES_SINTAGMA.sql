--------------------------------------------------------
--  DDL for Package A_01_VIPS_CONTACTES_SINTAGMA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."A_01_VIPS_CONTACTES_SINTAGMA" AS 

ConstTelefonFix CONSTANT integer:=1; --Fijo
      ConstTelefonMobil CONSTANT integer:=2; --M�vil
      ConstTelefonFax CONSTANT integer:=3;  --Fax

      ConstSubjectePersona CONSTANT integer:=1; 
      ConstSubjecteEntitat CONSTANT integer:=2; 

      ConstContactePersonal CONSTANT integer:=1; 
      ConstContacteProfesional CONSTANT integer:=2; 

      ConstAMBIT_ALCALDIA CONSTANT integer:=1; 
      ConstAMBIT_PROTOCOL CONSTANT integer:=2; 
      
      ConstVISIBILITAT_PUBLICA CONSTANT integer:=1; 
      ConstVISIBILITAT_PRIVADA CONSTANT integer:=2; 
      ConstVISIBILITAT_ALCALDIA CONSTANT integer:=3; 
      
      ConstTipologia CONSTANT integer:=1; 


       PROCEDURE RESETEATOR_TABLAS;       
--       PROCEDURE RESETEATOR_SECUENCIAS;
--     PROCEDURE NYAPA_CLASSIFICACIONS;


       PROCEDURE B01_CONTACTOS_ACTIVOS;
       PROCEDURE B02_CONTACTOS_VIPS;
       PROCEDURE B03_CONTACTES_ID;
       PROCEDURE B04_SUBJECTES_ID;
       PROCEDURE B05_CONTACTES_SIN_GENER;
       
     
       PROCEDURE B30_TRACTAMENTS;
     
      
     

       PROCEDURE B50_CARRECS;
       PROCEDURE B51_CARRECS_CONTACTES_REL;
       PROCEDURE B52_CARRECS_CONTACTES_NULL;
       PROCEDURE B53_CARRECS_CONTACTES;
       PROCEDURE B55_DM_CARREC;       

       PROCEDURE B60_ENTITATS;
       PROCEDURE B61_ENTITATS_CODI_NULL;
       PROCEDURE B65_DM_ENTITATS;
       PROCEDURE B66_ENTITATS_CONTACTES;
       
       PROCEDURE B70_SUBJECTES_DIFUNTS;
       PROCEDURE B71_SUBJECTES_AMB_PRIORITAT;
       PROCEDURE B72_SUBJECTES_VIPS; 
       PROCEDURE B73_SUBJECTE_CONTACTE;
       PROCEDURE B78_SUBJECTES;
       
       
       PROCEDURE B80_ADRECA_CONTACTE;
       PROCEDURE B81_ADRECA_SUBJECTE;
       PROCEDURE B82_DM_ADRECA;
       
       PROCEDURE B90_CONTACTES_PRINCIPALS;
       PROCEDURE B91_DATA_ACT_CONTACTE;
       PROCEDURE B92_TIPUS_CONTACTES;
       PROCEDURE B93_CONTACTES_CONTACTES;
       PROCEDURE B94_CONTACTES_SUBJECTES;
       PROCEDURE B95_CONTACTES;
       
       PROCEDURE B100_CORREUS_CONTACTES;
       PROCEDURE B101_CORREUS_PRINCIPALS;
       PROCEDURE B102_CORREUS_CONTACTES;

       PROCEDURE B110_TELEFONS_NUMERICS;
       PROCEDURE B111_TELEFON_PRINCIPAL;
       PROCEDURE B112_CONTACTE_TELEFON;
       
       PROCEDURE B120_CLASSIFICACIO;
       PROCEDURE B121_CLASSIF_CONTACTE;

       PROCEDURE B130_ACOMPANYANTS_VIPS;

END A_01_VIPS_CONTACTES_SINTAGMA;

/