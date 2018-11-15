--------------------------------------------------------
--  DDL for Package S_04_ACTES_SIAP
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."S_04_ACTES_SIAP" AS 

   ConstALCALDIA CONSTANT integer:=1; 
   ConstPROTOCOL CONSTANT integer:=2;    
      
   ConstPersonal CONSTANT integer:=1; 
   ConstProfesional CONSTANT integer:=2; 
   
   ConstSebjectePersona CONSTANT integer:=1; 
   ConstSebjecteEntitat CONSTANT integer:=2; 
   
   ConstVisibilitatPublica CONSTANT integer:=1; -- Pública
   ConstVisibilitatPrivada CONSTANT integer:=2; -- Privada
   ConstVisibilitatAlcaldia CONSTANT integer:=3; -- Alcaldía
   
   ConstTelefonFix CONSTANT integer:=1; --Fijo
   ConstTelefonMobil CONSTANT integer:=2; --Móvil
   ConstTelefonFax CONSTANT integer:=3;  --Fax
   
   Const_SI_ASISTIR CONSTANT integer:=1; --SÍ ASISTIR
   Const_LLENO CONSTANT integer:=2; --SÍ ASISTIR
   
   ConstInstalacioAlcaldia CONSTANT integer :=30; -- Corresponde a ámbito Alcaldia  
   ConstTipologia CONSTANT integer :=1;
   
--   ConstCODI_ASPECTE CONSTANT varchar2(5) :='EP';
     ConstID_ELEM_PRINCIPAL CONSTANT integer :=1; /* en vez ir por codi, usamos el ID 'puro' auqnue sea secuencia supongo que siempre será 1*/
   
   
   PROCEDURE RESETEATOR_TABLAS;
   
   
   PROCEDURE SG001_YA_EXISTS_CLASIFFICACIO;
   PROCEDURE SG002_NUEVOS_CLASSIFICACIO;  
   
   --CREA TABLA DE RELACION SIAP SINTAGMA DE CLASSIFIOCACIONES Y ADEMÁS INSERTA EN EL DM LOS DATOS DE LA TABLA G002_NUEVOS_CLASSIFICACIO
   PROCEDURE SG003_CLASSIF_SIAP_SINTAGMA;
   PROCEDURE Z_SG004_UPDATE_DESCRIP_SINTAG;  /*HAY clasificaciones en sintagma que tienen un '*' pero que en SIAP tienen la descripción. Hacemos un UPDATE de estas descripciones*/
   PROCEDURE Z_SG005_DM_CLASSIFICACIO;
   --CATÁLOGOS FIJOS
--EN A_00   PROCEDURE SG010_ESTAT_CONFIRMACIO;
--EN A_00   PROCEDURE SG011_TIPUS_VIA_INVITACIO;
--EN A_00   PROCEDURE SG012_INICIATIVA_RESPOSTA;
--EN A_00   PROCEDURE SG013_TIPUS_VIA_RESPOSTA;

    PROCEDURE SG010_ENTITAT_SIAP;
    PROCEDURE SG011_UPDATE_CODI_SINTAGMA;
    
    
    
    
    PROCEDURE SG012_LLOC_SIAP;
    --CATALOGO TIPO ACTE
    PROCEDURE SG020_TIPUS_ACTE_SIAP;
    PROCEDURE SG021_TIPUS_ACTE_VIPS;
    PROCEDURE SG022_TIPUS_ACTE_SIAP_VIPS;
    PROCEDURE SG023_TIPUS_ACTE_RESTANTES;
    PROCEDURE SG024_DM_TIPUS_ACTE;

    PROCEDURE SG030_PRESIDENTS;
    PROCEDURE SG031_DM_PRESIDENT;

   --CATÁLOGOS SIAP
   PROCEDURE SG040_SECTORS;   
   PROCEDURE SG041_CATEGORIAS;

   
--   PROCEDURE SG043_PRESIDENT;
   PROCEDURE SG044_PETICIONARI;
--   PROCEDURE SG045_ESTAT_ACTE;
--EN A_00   PROCEDURE SG046_GESTIO_INVITACIO;
--   PROCEDURE SG047_GESTIO_ESPAIS;
  
  
  PROCEDURE SG090_ASPECTES_SIAP;
   
--   PROCEDURE SG90_ELEMENT_PRINCIPALS;
   
   PROCEDURE SG100_ACTES_SIAP;
   PROCEDURE SG110_ACTES_ORGA;
   PROCEDURE SG115_CONVIDAT_ORGA;


END S_04_ACTES_SIAP;

/
