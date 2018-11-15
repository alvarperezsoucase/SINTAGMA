--------------------------------------------------------
--  DDL for Package Z_PRE_CONVIDATS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."Z_PRE_CONVIDATS" AS 

  ConstALCALDIA CONSTANT integer:=1; 
   ConstPROTOCOL CONSTANT integer:=2;    
      
   ConstPersonal CONSTANT integer:=1; 
   ConstProfesional CONSTANT integer:=2; 
   
   ConstSebjectePersona CONSTANT integer:=1; 
   ConstSebjecteEntitat CONSTANT integer:=2; 
   
   ConstVisibilitatPublica CONSTANT integer:=1; -- P�blica
   ConstVisibilitatPrivada CONSTANT integer:=2; -- Privada
   ConstVisibilitatAlcaldia CONSTANT integer:=3; -- Alcald�a
   
   ConstTelefonFix CONSTANT integer:=1; --Fijo
   ConstTelefonMobil CONSTANT integer:=2; --M�vil
   ConstTelefonFax CONSTANT integer:=3;  --Fax
   
   Const_SI_ASISTIR CONSTANT integer:=1; --S� ASISTIR
   Const_LLENO CONSTANT integer:=2; --S� ASISTIR
   
   PROCEDURE RESETEATOR_TABLAS;
   
   
   PROCEDURE G001_YA_EXISTS_CLASIFFICACIO;
   PROCEDURE G002_NUEVOS_CLASSIFICACIO;  
   
   --CREA TABLA DE RELACION SIAP SINTAGMA DE CLASSIFIOCACIONES Y ADEM�S INSERTA EN EL DM LOS DATOS DE LA TABLA G002_NUEVOS_CLASSIFICACIO
   PROCEDURE G003_CLASSIF_SIAP_SINTAGMA;
   
   --CAT�LOGOS FIJOS
--EN A_00   PROCEDURE G010_ESTAT_CONFIRMACIO;
--EN A_00   PROCEDURE G011_TIPUS_VIA_INVITACIO;
--EN A_00   PROCEDURE G012_INICIATIVA_RESPOSTA;
--EN A_00   PROCEDURE G013_TIPUS_VIA_RESPOSTA;

    --CATALOGO TIPO ACTE
    PROCEDURE G020_TIPUS_ACTE_SIAP;
    PROCEDURE G021_TIPUS_ACTE_VIPS;
    PROCEDURE G022_TIPUS_ACTE_SIAP_VIPS;
    PROCEDURE G023_TIPUS_ACTE_RESTANTES;
    PROCEDURE G024_DM_TIPUS_ACTE;

   --CAT�LOGOS SIAP
   PROCEDURE G040_SECTORS;   
   PROCEDURE G041_CATEGORIAS;

   
   PROCEDURE G043_PRESIDENT;
   PROCEDURE G044_PETICIONARI;
   PROCEDURE G045_ESTAT_ACTE;
--EN A_00   PROCEDURE G046_GESTIO_INVITACIO;
--   PROCEDURE G047_GESTIO_ESPAIS;
   
   PROCEDURE G90_ELEMENT_PRINCIPALS;
   
   PROCEDURE G100_ACTES_SIAP;
   PROCEDURE G110_ACTES_ORGA;
   PROCEDURE G115_CONVIDAT_ORGA;


END Z_PRE_CONVIDATS;

/
