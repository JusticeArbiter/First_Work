CREATE FUNCTION testfunc2(int) RETURNS int AS 'select 3 * $1;' LANGUAGE sql;
