--------------------------------------------------------
--  DDL for Package REGISTRAR_ERRORES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SINTAGMA_U"."REGISTRAR_ERRORES" AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  
  PROCEDURE RESETEATOR_TABLAS;
    
  PROCEDURE CONTACTES_SIN_GENER;  
    
  --Subjectes que aparecen más de una vez con el mismo nombre normalizado y que tienen más de un registro no dado de alta.
  --(si hay 3 registros por ejemplo, 2 están dados de alta y uno de baja) -> aparece
  --(si hay 2 registros y uno de baja y otro de alta) -> no aparece
  PROCEDURE SUBJECTES_NOMBRES_REPETIDOS; 

  --CONTACTES DE CALIMA CUYO NP NO ESTÁ EN PERSONES
  PROCEDURE CONTACTES_SIN_SUBJECTE_CALIMA;


  --Entidades con descipción repetida    
  PROCEDURE ENTIDADES_DESCRIPCION_REPE;

  --TELEFONOS CON ERRORES
  PROCEDURE TELEFONOS_ERRORES;  

  PROCEDURE ABREUJADA_NULL;  

  --¡¡OJO! SACAR SUBJECETES CON MAS DE 1 CONTACTO?

-- CALIMA (SUBJECTES DE TIPO ENTIDAD SIN CONTATO)
/*
 SELECT (N_P) as ID_SUBJECTE, 
                    (SELECT NC FROM Z_TMP_CALIMA_U_EXT_CONTACTES CONTACTES WHERE CONTACTES.NP = N_P AND ROWNUM=1) AS NC ,
                    NOM2 || ' ' || COGNOM_1, 
                    NULL , 
                    COGNOM_2, 
                    ALIES, 
                    LimpiarChars(NOM2 || CogNom_1 || CogNom_2) AS NOM_NORMALITZAT,
                    RIP AS DATA_DEFUNCIO,                    
                    NULL AS IDIOMA_ID,                    
                    DATADARRERA AS DATA_DARRERA,
                    DATA_BAIXA AS DATA_BAIXA,                    
                    NULL as ID_PRIORITAT,
                    2 AS TIPUS_SUBJECTE_ID, 
                    1 as AMBIT_ID --alcaldia
            FROM Z_TMP_CALIMA_U_EXT_PERSONES  PRINCIPAL
            WHERE  PRINCIPAL.SEXE IS NULL AND (nom2 IS NULL AND (COGNOM_1 IS NOT NULL OR COGNOM_2 IS NOT NULL))
*/            


   --RISPLUS
   --ELEMENTOS_PRINCIPALES QUE TIENEN IDTIPUSSUPORT A NULL ç(ES OBLIGATORIO)
    PROCEDURE ELEMENTS_SUPPORTID_NULL;
    
    PROCEDURE ELEMENTS_NUMREGPREFIX_NULL;

    PROCEDURE VIPS_DISTINROS_SIAP_VIP;

END REGISTRAR_ERRORES;

/
