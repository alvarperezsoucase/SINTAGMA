--------------------------------------------------------
--  DDL for Package G_06_ACTES_SIAP
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."G_06_ACTES_SIAP" AS 

   /* TODO enter package declarations (types, exceptions, methods etc) here */ 
   ConstClassificacio CONSTANT integer:=20000; --Inicio 5962


   ConstCarrec CONSTANT integer:=20000; --Inicio 5962
   ConstTractament CONSTANT integer:=300; --105
   ConstEntitat CONSTANT integer:=2000000; -- 1001446 entitat  
   ConstEntitatTrucada CONSTANT integer:=2000000; -- 1527860 entitat  
   ConstAdreca CONSTANT integer:=50000; --25786
   ConstSubjecte CONSTANT integer:=2000000; --1018039
   ConstContacte CONSTANT integer:=1000000;  --376853
   ConstContacteCorreu CONSTANT integer:=1000000; -- 15565
   ConstContacteTelefon CONSTANT integer:=50000; --31066
   
   ConstALCALDIA CONSTANT integer:=1; 
   ConstPROTOCOL CONSTANT integer:=2;    
      
   ConstPersonal CONSTANT integer:=1; 
   ConstProfesional CONSTANT integer:=2; 
   
   ConstSebjectePersona CONSTANT integer:=1; 
   ConstSebjecteEntitat CONSTANT integer:=2; 
   
   ConstVisibilitatPublica CONSTANT integer:=1; -- Pública
   ConstVisibilitatPrivada CONSTANT integer:=2; -- Privada
   ConstVisibilitatAlcaldia CONSTANT integer:=3; -- Alcaldía
   
   
   PROCEDURE RESETEATOR_TABLAS;
   
   
   PROCEDURE G001_YA_EXISTS_CLASIFFICACIO;
   PROCEDURE G002_NUEVOS_CLASSIFICACIO;  
   
   --CREA TABLA DE RELACION SIAP SINTAGMA DE CLASSIFIOCACIONES Y ADEMÁS INSERTA EN EL DM LOS DATOS DE LA TABLA G002_NUEVOS_CLASSIFICACIO
   PROCEDURE G003_CLASSIF_SIAP_SINTAGMA;
   
   --CATÁLOGOS FIJOS
   PROCEDURE G010_ESTAT_CONFIRMACIO;
   PROCEDURE G011_TIPUS_VIA_INVITACIO;
   PROCEDURE G012_INICIATIVA_RESPOSTA;
   PROCEDURE G013_TIPUS_VIA_RESPOSTA;

    --CATALOGO TIPO ACTE
    PROCEDURE G020_TIPUS_ACTE_SIAP;
    PROCEDURE G021_TIPUS_ACTE_VIPS;
    PROCEDURE G022_TIPUS_ACTE_SIAP_VIPS;
    PROCEDURE G023_TIPUS_ACTE_RESTANTES;
    PROCEDURE G024_DM_TIPUS_ACTE;

   --CATÁLOGOS SIAP
   PROCEDURE G040_SECTORS;   
   PROCEDURE G041_CATEGORIAS;

   
   PROCEDURE G043_PRESIDENT;
   PROCEDURE G044_PETICIONARI;
   PROCEDURE G045_ESTAT_ACTE;
   PROCEDURE G046_GESTIO_INVITACIO;
   PROCEDURE G047_GESTIO_ESPAIS;
   
   
   PROCEDURE G100_ACTES_SIAP;
   PROCEDURE G110_ACTES_ORGA;
   PROCEDURE G115_CONVIDAT_ORGA;
   
   
   

END G_06_ACTES_SIAP;

/
