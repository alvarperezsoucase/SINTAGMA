--------------------------------------------------------
--  DDL for Function FN_CONVERT_TO_VN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SINTAGMA_U"."FN_CONVERT_TO_VN" (
    STRINPUT IN VARCHAR2
)
RETURN VARCHAR2
IS
    STRCONVERT VARCHAR2(32527);
BEGIN
STRCONVERT := TRANSLATE(
	REPLACE(REPLACE(REPLACE(UPPER(TRIM(STRINPUT)),'  ',' ~'),'~ '),'~'),
	'аю?ц?Aд????б?????пих?к?й?????млоI?ср?ужт?????O?????зы?UэU?????щ????',
	'AAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY'
);
RETURN STRCONVERT;
END;

/
