CREATE FUNCTION functext_F_2(int) RETURNS bool LANGUAGE 'sql'  CALLED ON NULL INPUT AS 'SELECT $1 = 50';
