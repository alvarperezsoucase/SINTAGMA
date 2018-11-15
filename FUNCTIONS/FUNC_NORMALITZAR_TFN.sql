--------------------------------------------------------
--  DDL for Function FUNC_NORMALITZAR_TFN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FUNC_NORMALITZAR_TFN" (Campo IN VARCHAR2) RETURN VARCHAR2 AS 
AUX VARCHAR2(500);
BEGIN


    Aux :=Campo;
    
    Aux :=Lower(Aux);    

    
    Aux :=TRIM(AUX);    
    
  	Aux :=REPLACE(Aux,'barcelona','');
    
--	Aux :=REPLACE(Aux,' ','');
    Aux :=REPLACE(Aux,'-','');
    Aux :=REPLACE(Aux,'.','');
    Aux :=REPLACE(Aux,'/','');
    Aux :=REPLACE(Aux,'*','');
    Aux :=REPLACE(Aux,':','');
    
    --de 12
--    Aux :=REPLACE(Aux,'(particular).','');    
    
    
    --de 7
--    Aux :=REPLACE(Aux,'partic.','');
--    Aux :=REPLACE(Aux,'privat.','');
    --de 6
--    Aux :=REPLACE(Aux,'parti.','');
--    Aux :=REPLACE(Aux,'privat','');
    --de 5
    Aux :=REPLACE(Aux,'(terr','');
    Aux :=REPLACE(Aux,'(pre)','');    
    Aux :=REPLACE(Aux,'(uab)','');    
    Aux :=REPLACE(Aux,'(upc)','');
    Aux :=REPLACE(Aux,'(uni)','');
    Aux :=REPLACE(Aux,'ajunt','');
    Aux :=REPLACE(Aux,'alcal','');
    Aux :=REPLACE(Aux,'angls','');
    Aux :=REPLACE(Aux,'despt','');
    Aux :=REPLACE(Aux,'direc','');
    Aux :=REPLACE(Aux,'dsptx','');
    Aux :=REPLACE(Aux,'esade',''); 
    Aux :=REPLACE(Aux,'feina',''); 
    Aux :=REPLACE(Aux,'geren','');    
    Aux :=REPLACE(Aux,'mallo','');
    Aux :=REPLACE(Aux,'marta','');
    Aux :=REPLACE(Aux,'nuria','');    
    Aux :=REPLACE(Aux,'proto','');
    Aux :=REPLACE(Aux,'quiro','');
    Aux :=REPLACE(Aux,'secre','');
    Aux :=REPLACE(Aux,'sgrup','');
    
    --de 4   
    
    Aux :=REPLACE(Aux,'ajun','');    
    Aux :=REPLACE(Aux,'banc','');
    Aux :=REPLACE(Aux,'casa','');
    Aux :=REPLACE(Aux,'cent','');
    Aux :=REPLACE(Aux,'cóns','');
    Aux :=REPLACE(Aux,'desp','');
    Aux :=REPLACE(Aux,'dptx','');
    Aux :=REPLACE(Aux,'diba','');
    Aux :=REPLACE(Aux,'dona','');
    Aux :=REPLACE(Aux,'erro','');
    Aux :=REPLACE(Aux,'exte','');
    Aux :=REPLACE(Aux,'fill','');  
    Aux :=REPLACE(Aux,'matí','');      
    Aux :=REPLACE(Aux,'part','');
    Aux :=REPLACE(Aux,'pare','');
    Aux :=REPLACE(Aux,'prem','');
    Aux :=REPLACE(Aux,'secr','');        
    Aux :=REPLACE(Aux,'tots','');        
    Aux :=REPLACE(Aux,'vice','');   
    
    --de 3
    
    Aux :=REPLACE(Aux,'adm','');
    Aux :=REPLACE(Aux,'aju','');
    Aux :=REPLACE(Aux,'cas','');
    Aux :=REPLACE(Aux,'ciu','');
    Aux :=REPLACE(Aux,'cen','');
    Aux :=REPLACE(Aux,'deg','');
    Aux :=REPLACE(Aux,'des','');
    Aux :=REPLACE(Aux,'etx',''); 
    Aux :=REPLACE(Aux,'eva','');
    Aux :=REPLACE(Aux,'ext','');    
    Aux :=REPLACE(Aux,'fei','');
    Aux :=REPLACE(Aux,'gab','');
    Aux :=REPLACE(Aux,'gen','');   
    Aux :=REPLACE(Aux,'man','');
    Aux :=REPLACE(Aux,'par','');
    Aux :=REPLACE(Aux,'psc','');
    Aux :=REPLACE(Aux,'pro','');
    Aux :=REPLACE(Aux,'sec','');
    Aux :=REPLACE(Aux,'seu','');   
    Aux :=REPLACE(Aux,'tel','');  
    Aux :=REPLACE(Aux,'uab','');  
        
   
   
    Aux :=REPLACE(Aux,'of','');
    Aux :=REPLACE(Aux,'pa','');
    Aux :=REPLACE(Aux,'se','');
    Aux :=REPLACE(Aux,'ex','');
    
   Aux :=REPLACE(Aux,' p','');
   Aux :=REPLACE(Aux,' c','');
   Aux :=REPLACE(Aux,' t','');
   
   Aux :=REPLACE(Aux,' ','');
   
   Aux :=REPLACE(Aux,CHR(160),''); --C2A0
   Aux :=TRIM(AUX);
   
   
    RETURN AUX;
END FUNC_NORMALITZAR_TFN;

/
