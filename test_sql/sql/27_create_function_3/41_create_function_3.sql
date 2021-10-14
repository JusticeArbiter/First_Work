CREATE FUNCTION functext_F_1(int) RETURNS bool LANGUAGE 'sql'  AS 'SELECT $1 > 50';
