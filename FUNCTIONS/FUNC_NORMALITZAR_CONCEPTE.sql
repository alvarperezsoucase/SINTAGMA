--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR_CONCEPTE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR_CONCEPTE" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
    AUX VARCHAR2(200);
BEGIN


    Aux :=Campo;
    
    Aux :=UPPER(Aux);    

    Aux :=REPLACE(Aux,'0','');
    Aux :=REPLACE(Aux,'1','');
    Aux :=REPLACE(Aux,'2','');
    Aux :=REPLACE(Aux,'3','');
    Aux :=REPLACE(Aux,'4','');
    Aux :=REPLACE(Aux,'5','');
    Aux :=REPLACE(Aux,'6','');
    Aux :=REPLACE(Aux,'7','');
    Aux :=REPLACE(Aux,'8','');
    Aux :=REPLACE(Aux,'9','');
    Aux :=REPLACE(Aux,'-','');
    Aux :=REPLACE(Aux,'.','');
    Aux :=REPLACE(Aux,'/','');
    Aux :=REPLACE(Aux,'*','');
    Aux :=REPLACE(Aux,':','');
    Aux :=REPLACE(Aux,'+','');
    

    
--  	Aux :=REPLACE(Aux,'barcelona','BARCELONA');
    

   
    --de 5
--    Aux :=REPLACE(Aux,'(terr','(TERR');
--    Aux :=REPLACE(Aux,'(pre)','(PRE)');    
--    Aux :=REPLACE(Aux,'(uab)','((UAB)');    
--    Aux :=REPLACE(Aux,'(upc)','(UPC)');
--    Aux :=REPLACE(Aux,'(uni)','(UNI)');
--    Aux :=REPLACE(Aux,'ajunt','AJUNT');
--    Aux :=REPLACE(Aux,'alcal','ALCAL');
--    Aux :=REPLACE(Aux,'angls','ANGLS');
--    Aux :=REPLACE(Aux,'despt','DESPT');
--    Aux :=REPLACE(Aux,'direc','DIREC');
--    Aux :=REPLACE(Aux,'dsptx','DSPTX');
--    Aux :=REPLACE(Aux,'esade','ESADE'); 
--    Aux :=REPLACE(Aux,'feina','FEINA'); 
--    Aux :=REPLACE(Aux,'geren','GEREN');    
--    Aux :=REPLACE(Aux,'mallo','MALLO');
--    Aux :=REPLACE(Aux,'marta','MARTA');
--    Aux :=REPLACE(Aux,'nuria','NURIA');
--    Aux :=REPLACE(Aux,'proto','PROTO');
--    Aux :=REPLACE(Aux,'quiro','QUIRO');
--    Aux :=REPLACE(Aux,'secre','SECRE');
--    Aux :=REPLACE(Aux,'sgrup','SGRUP');
    
    --de 4   
    
--    Aux :=REPLACE(Aux,'ajun','AJUN');    
--    Aux :=REPLACE(Aux,'banc','BANC');
--    Aux :=REPLACE(Aux,'casa','CASA');
--    Aux :=REPLACE(Aux,'cent','CENT');
--    Aux :=REPLACE(Aux,'cóns','CONS');
--    Aux :=REPLACE(Aux,'desp','DESP');
--    Aux :=REPLACE(Aux,'dptx','DPTX');
--    Aux :=REPLACE(Aux,'diba','DIBA');
--    Aux :=REPLACE(Aux,'dona','DONA');
--    Aux :=REPLACE(Aux,'erro','ERRO');
    Aux :=REPLACE(Aux,'exte','EXTE');
--    Aux :=REPLACE(Aux,'fill','FILL');  
--    Aux :=REPLACE(Aux,'matí','MATI');      
    Aux :=REPLACE(Aux,'part','PART');
--    Aux :=REPLACE(Aux,'pare','PARE');
--    Aux :=REPLACE(Aux,'prem','PREM');
--    Aux :=REPLACE(Aux,'secr','SECR');        
--    Aux :=REPLACE(Aux,'tots','TOTS');        
--    Aux :=REPLACE(Aux,'vice','VICE');   
    
    --de 3
    
--    Aux :=REPLACE(Aux,'adm','ADM');
--    Aux :=REPLACE(Aux,'aju','AJU');
--    Aux :=REPLACE(Aux,'cas','CAS');
--    Aux :=REPLACE(Aux,'ciu','CIU');
--    Aux :=REPLACE(Aux,'cen','CEN');
--    Aux :=REPLACE(Aux,'deg','DEG');
--    Aux :=REPLACE(Aux,'des','DES');
    Aux :=REPLACE(Aux,'etx','EXT'); 
--    Aux :=REPLACE(Aux,'eva','EVA');
--    Aux :=REPLACE(Aux,'ext','EXT');    
--    Aux :=REPLACE(Aux,'fei','FEI');
--    Aux :=REPLACE(Aux,'gab','GAB');
--    Aux :=REPLACE(Aux,'gen','GEN');   
--    Aux :=REPLACE(Aux,'man','MAN');
    Aux :=REPLACE(Aux,'par','PART');
--    Aux :=REPLACE(Aux,'psc','PSC');
--    Aux :=REPLACE(Aux,'pro','PRO');
--    Aux :=REPLACE(Aux,'sec','SEC');
--    Aux :=REPLACE(Aux,'seu','SEU');   
--    Aux :=REPLACE(Aux,'tel','TEL');  
--    Aux :=REPLACE(Aux,'uab','UAB');  
        
   
   
--    Aux :=REPLACE(Aux,'of','OF');
    Aux :=REPLACE(Aux,'pa','PART');
--    Aux :=REPLACE(Aux,'se','SE');
--    Aux :=REPLACE(Aux,'ex','EXT');
    
   Aux :=REPLACE(Aux,' p','PART');
--   Aux :=REPLACE(Aux,' c','C');
--   Aux :=REPLACE(Aux,' t','T');
   
   Aux :=REPLACE(Aux,' ','');
   
   Aux :=REPLACE(Aux,CHR(160),''); --C2A0
   Aux :=TRIM(AUX);
   
   
    RETURN AUX;

END FUNC_NORMALITZAR_CONCEPTE;

/
