CREATE FUNCTION leak(integer,integer) RETURNS boolean  AS $$begin return $1 < $2; end$$  LANGUAGE plpgsql immutable;
