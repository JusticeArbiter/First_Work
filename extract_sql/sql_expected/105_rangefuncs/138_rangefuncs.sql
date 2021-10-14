CREATE FUNCTION getfoo9(int) RETURNS foo AS 'DECLARE footup foo%ROWTYPE; BEGIN SELECT * into footup FROM foo WHERE fooid = $1; RETURN footup; END;' LANGUAGE plpgsql;
