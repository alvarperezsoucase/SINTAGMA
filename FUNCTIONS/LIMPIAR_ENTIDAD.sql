--------------------------------------------------------
--  DDL for Function LIMPIAR_ENTIDAD
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."LIMPIAR_ENTIDAD" (campo in varchar2) RETURN VARCHAR2 is 
    Aux VARCHAR2(32527);
BEGIN
  
  Aux := Lower(trim(Campo));
  --Hay que quitar antes el S.A. ya que LimpiarChars quita los puntos
  Aux := REPLACE(Aux, 's.a.','');
  Aux := REPLACE(Aux, 's.l.','');
  
  Aux := REPLACE(Aux,' de ','');
  
  --SI LOS ÚLTIMOS 3 CARACTERES SON 'SA' (OJO, SIN ESPACIO EN EL RESULTADO FINAL, COGEMOS LOS 3 ÚLTIMOS PERO SE TRUNCAN A 2 GRACIAS AL ESPACIO) LO TOMAMOS COMO SOCIEDAD ANÓNIMA
  --      EJ: 'PANASONIC SA'--> TRIM(' SA') -> 'SA' (ES SOCIEDAD ANÓNIMA)
  --      EJ: 'SUPERCASA' ---> TRIM('ASA') -> 'ASA' (NO ES SOCIEDAD ANÓNIMA)                                                                                                                         
  AUX := REPLACE(TRIM(SUBSTR(Aux, LENGTH(Aux)-2)), ' sa','');
  
  
  
  Aux:= LIMPIARCHARS(Aux);
  
  RETURN Aux;
  
END LIMPIAR_ENTIDAD;

/
