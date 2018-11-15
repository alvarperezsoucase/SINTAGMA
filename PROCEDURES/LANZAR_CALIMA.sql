--------------------------------------------------------
--  DDL for Procedure LANZAR_CALIMA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SINTAGMA_U"."LANZAR_CALIMA" AS 
BEGIN
  NULL;
  
   ConstDestPersona CONSTANT integer:=0;
   ConstCarrec CONSTANT integer:=10000; --Inicio 5962
   ConstTractament CONSTANT integer:=200; --105
   ConstEntitat CONSTANT integer:=1500000; -- 1001446 entitat                                            
   ConstAdreca CONSTANT integer:=30000; --25786
   ConstSubjecte CONSTANT integer:=1500000; --1018039
   ConstContacte CONSTANT integer:=500000;  --376853
   ConstContacteCorreu CONSTANT integer:=20000; -- 15565
   ConstContacteTelefon CONSTANT integer:=35000; --31066
--   ConstEntitatTruc CONSTANT integer:=5000;    
   

   
    
   /*DELETES DE TODO */
--   PROCEDURE RESETEATOR_TABLAS;
--   PROCEDURE RESETEATOR_SECUENCIAS;
   
MIGRACIO_CALIMA.C01_EXTRAER_SUBJECTES_PERSONAS;          
MIGRACIO_CALIMA.C02_EXISTE_SUBJECTE;    
MIGRACIO_CALIMA.C03_NO_EXISTE_SUBJECTE;
MIGRACIO_CALIMA.C04_SUJETOS_CALIMA_REL_VIPS;
MIGRACIO_CALIMA.C10_EXTRAER_ENTITAT;    
MIGRACIO_CALIMA.C11_EXISTE_ENTITAT;    
MIGRACIO_CALIMA.C12_NO_EXISTE_ENTITAT;
MIGRACIO_CALIMA.C13_INSERT_NEW_ENTITAT;
MIGRACIO_CALIMA.C15_INSERT_NEW_CARREC; 
MIGRACIO_CALIMA.C16_INSERT_NEW_TRACTAMENT;

MIGRACIO_CALIMA.C20_CONTACTES_IN_SINTAGMA;    
MIGRACIO_CALIMA.C21_CONTACTES_NOT_IN_SINTAGMA;
MIGRACIO_CALIMA.C31_INSERTS_SUBJECTE_NO_EXISTE;
MIGRACIO_CALIMA.C33_INSERT_ENTITAT_NO_EXISTE;
MIGRACIO_CALIMA.C34_INSERT_ADRECA;
MIGRACIO_CALIMA.C35_ADRECA_CONTACTE;
MIGRACIO_CALIMA.C35BIS_INSERT_CONTACTE_NOEXIST;
MIGRACIO_CALIMA.C40_AUX_SUBJECTE;
MIGRACIO_CALIMA.C42_AUX_CONTACTE;
MIGRACIO_CALIMA.C50_CORREUS_CONTACTES;
MIGRACIO_CALIMA.C51_CORREUS_PRINCIPALES;
MIGRACIO_CALIMA.C52_CORREOS_CONTACTOS;
MIGRACIO_CALIMA.C55_TELEFONS_NUMERICS;
MIGRACIO_CALIMA.C56_TELEFON_PRINCIPAL;
MIGRACIO_CALIMA.C57_CONTACTE_TELEFON;
MIGRACIO_CALIMA.C90_ENTITATS_TRUCADA;
MIGRACIO_CALIMA.C91_INSERTAR_DM_ENTITAT;
MIGRACIO_CALIMA.C92_TRUCADA_DESTINATARI;
MIGRACIO_CALIMA.C93_INSERTAR_DM_DESTINATARI;
MIGRACIO_CALIMA.C95_TRUCADAS;
MIGRACIO_CALIMA.C96_HIST_TRUCADAS;
  
END LANZAR_CALIMA;

/