CREATE FUNCTION functext_C_3(int) RETURNS bool LANGUAGE 'sql'  SECURITY INVOKER AS 'SELECT $1 < 0';