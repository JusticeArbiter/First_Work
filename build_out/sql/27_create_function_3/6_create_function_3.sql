CREATE FUNCTION functest_A_2(text[]) RETURNS int LANGUAGE 'sql'  AS 'SELECT $1[0]::int';
