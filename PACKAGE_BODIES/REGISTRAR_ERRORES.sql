--------------------------------------------------------
--  DDL for Package Body REGISTRAR_ERRORES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."REGISTRAR_ERRORES" AS

    
  PROCEDURE CONTACTES_SIN_GENER IS
  BEGIN
  
    INSERT INTO ERR_CONTACTES_SIN_GENER (N_VIP, CLASSIF, N_PRELACIO, CARREC, ENTITAT, ADRECA, MUNICIPI, CP, PROVINCIA, PAIS, TELEFON1, TELEFON2, TELEFON_MOBIL, FAX, INTERNET, DEPART, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, DESCRIPCION_ERR)
         SELECT 
                N_VIP, 
                CLASSIF, 
                N_PRELACIO, 
                CARREC, 
                ENTITAT, 
                ADRECA, 
                MUNICIPI, 
                CP, 
                PROVINCIA, 
                PAIS, 
                TELEFON1, 
                TELEFON2, 
                TELEFON_MOBIL, 
                FAX, 
                INTERNET, 
                DEPART, 
                'VIPS_U' AS ESQUEMA_ORIGINAL,
                'VIPS'AS TABLA_ORIGINAL,
                'VIPS QUE NO TIENEN GENER COMO CLASSIF ' AS DESCRIPCION_ERR
            FROM Z_SB005_CONTACTES_SIN_GENER NUEVOS
           WHERE NOT EXISTS (SELECT 1 
                               FROM Z_SB005_CONTACTES_SIN_GENER ANTIGUOS
                               WHERE NUEVOS.N_VIP = ANTIGUOS.N_VIP
                             );
  COMMIT;
  END;

  PROCEDURE SUBJECTES_NOMBRES_REPETIDOS AS
  BEGIN
    
    DELETE FROM  ERR_SUBJECTE_NOMS_REP;
    
    INSERT INTO ERR_SUBJECTE_NOMS_REP
                SELECT * 
                  FROM SUBJECTE
                 WHERE NOM_NORMALITZAT IN (
                                            SELECT NOM_NORMALITZAT 
                                            FROM A1_SUBJECTE
                                            GROUP BY NOM_NORMALITZAT
                                            HAVING count(NOM_NORMALITZAT)>1
                						  )	
                ORDER BY NOM_NORMALITZAT;	

  COMMIT;  
  END;


  /* CONTACTES DE CALIMA CUYO NP NO ESTÁ EN PERSONES  */
  PROCEDURE CONTACTES_SIN_SUBJECTE_CALIMA IS
  BEGIN
  
      INSERT INTO ERR_CONTACTES_SIN_SUBJECTES
            SELECT NP,
		       NOM2,
		       COGNOM_1,
		       COGNOM_2,
		       'CALIMA' AS ESQUEMA_ORIGINAL,
		       'CONTACTES' AS TABLA_ORIGINAL,
		       'CONTACTES CUYO NP NO ESTÁ EN EXT_PERSONES' AS ERR_DESCRIPCION
		  FROM Z_TMP_CALIMA_U_EXT_CONTACTES 
		 WHERE NP NOT IN (SELECT N_P 
		                    FROM Z_TMP_CALIMA_U_EXT_PERSONES);
  
  
  COMMIT;
  END;
  


  PROCEDURE ENTIDADES_DESCRIPCION_REPE IS
  BEGIN
    --Entidades que aparecen con la misma descripción pero distinto codi.
    --Se aplica LimpiarChars como BONUS TRACK (sin aplicarlo también aparecen repes)
    INSERT INTO ERR_ENTITAT_DESCR_REPE 
        SELECT * 
          FROM DM_ENTITAT
		 WHERE limpiarchars(DESCRIPCIO) IN (
                    SELECT limpiarchars(DESCRIPCIO)
                    FROM DM_ENTITAT  
                    GROUP BY limpiarchars(DESCRIPCIO)
                    HAVING count(limpiarchars(DESCRIPCIO))>1
	  	       )        
           AND NOT EXISTS (SELECT 1
                             FROM ERR_ENTITAT_DESCR_REPE ANTIGUOS
                            WHERE ANTIGUOS.ID =  DM_ENTITAT.ID
                          );  
    COMMIT;
  END;
  
  --TELEFONOS
  PROCEDURE TELEFONOS_ERRORES IS
  BEGIN
  
        INSERT INTO ERR_TELEFONOS 
                SELECT NUEVOS.ID_CONTACTE AS ID_CONTACTE,
                       N_VIP,
                	   NUEVOS.TELEFON AS TELEFON,
                       'TELEFON1' AS CAMPO,
                       'VIPS_U' AS ESQUEMA,
                       'CLASSIF_VIPS' AS TABLA                       
                FROM (	   
                       SELECT DISTINCT ID_CONTACTE,
                              N_VIP AS N_VIP,
                              TELEFON1 AS TELEFON 
                       FROM Z_SB003_CONTACTES_ID C
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TELEFON1))=0 
                     ) NUEVOS;
     COMMIT;
     
            INSERT INTO ERR_TELEFONOS 
                SELECT NUEVOS.ID_CONTACTE AS ID_CONTACTE,
                       N_VIP,
                	   NUEVOS.TELEFON AS TELEFON,
                       'TELEFON2' AS CAMPO,
                       'VIPS_U' AS ESQUEMA,
                       'CLASSIF_VIPS' AS TABLA                       
                FROM (	   
                       SELECT DISTINCT ID_CONTACTE,
                              N_VIP AS N_VIP,
                              TELEFON2 AS TELEFON 
                       FROM Z_SB003_CONTACTES_ID C
                       WHERE FUNC_ES_NUMERICO(FUNC_NORMALITZAR_TFN(TELEFON2))=0 
                     ) NUEVOS;
  
    
  
  COMMIT;
  END;
  
  
  PROCEDURE ABREUJADA_NULL IS
  BEGIN
  
        INSERT INTO ERR_ABREUJADA_NULL
              SELECT * 
                FROM DM_TRACTAMENT
              WHERE ABREUJADA IS NULL;  
  
  COMMIT;
  END;
  
  
  --risplus
  PROCEDURE ELEMENTS_SUPPORTID_NULL IS
  BEGIN
  
  
    INSERT INTO ERR_ELEMENTS_PR_SUPPORT_NULL 
        SELECT * 
          FROM Z_T_RP_ELEMENTS
         WHERE TIPUSSUPORTID IS NULL
           AND TIPUS ='ElementPrincipal';
  
  COMMIT;
  END;
  
  --RISPLUS
  PROCEDURE ELEMENTS_NUMREGPREFIX_NULL IS
  BEGIN
      INSERT INTO ERR_ELEMENTS_NUMREGPREFIX_NULL
        SELECT * 
          FROM Z_T_RP_ELEMENTS
         WHERE NUMEROREGISTREPREFIXID IS NULL
           AND TIPUS ='ElementPrincipal';
  
  
  COMMIT;
  END;
  
  PROCEDURE VIPS_DISTINROS_SIAP_VIP IS
  BEGIN
  
      		INSERT INTO ERR_NOMBRES_DISTINTOS_SIAP_VIP (ID_SIAP,NOM_SIAP,COGNOMS_SIAP, ID_VIPS, NOM_VIPS, COGNOMS_VIPS,ERROR)
	    SELECT ID_SIAP,
	    	   NOM_SIAP,
	    	   COGNOMS_SIAP, 
	    	   ID_VIPS, 
	    	   NOM_VIPS, 
	    	   COGNOMS_VIPS,
	    	   'MISMO ID DISTINTA PERSONA EN SIAP Y VIPS' AS ERROR	    	   
	     FROM (   
				SELECT SIAP.ID AS ID_SIAP, 
				       SIAP.NOM AS NOM_SIAP, 
				       SIAP.COGNOMS AS COGNOMS_SIAP, 
				       VIPS.N_VIP AS ID_VIPS, 
				       VIPS.NOM AS NOM_VIPS, 
				       VIPS.COGNOMS AS COGNOMS_VIPS				       
				FROM Z_T_SIAP_VIPS SIAP,
				     Z_TMP_VIPS_U_VIPS VIPS
				WHERE VIPS.N_VIP = SIAP.ID  
				  AND FUNC_NORMALITZAR(VIPS.NOM || VIPS.COGNOMS ) <> FUNC_NORMALITZAR(SIAP.NOM || SIAP.COGNOMS)
			  ) VIPS_NOMBRES_DISTINTOS 
		WHERE NOT EXISTS (SELECT 1
							FROM ERR_NOMBRES_DISTINTOS_SIAP_VIP ANTIGUOS
							WHERE ANTIGUOS.ID_SIAP = VIPS_NOMBRES_DISTINTOS.ID_SIAP
						 );


  
  
  
  COMMIT;
  END;








PROCEDURE RESETEATOR_TABLAS IS
BEGIN

  DELETE FROM ERR_ENTITAT_DESCR_REPE;  
  DELETE FROM ERR_SUBJECTE_NOMS_REP;
  DELETE FROM ERR_CONTACTES_SIN_GENER;
  
  DELETE FROM ERR_CONTACTES_SIN_SUBJECTES;

COMMIT;
END;


END REGISTRAR_ERRORES;

/
