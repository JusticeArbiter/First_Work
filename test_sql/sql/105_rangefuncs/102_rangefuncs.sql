CREATE FUNCTION getfoo5(int) RETURNS setof foo AS 'SELECT * FROM foo WHERE fooid = $1;' LANGUAGE SQL;
