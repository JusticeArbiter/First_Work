CREATE FUNCTION mvtest_func()  RETURNS void AS $$  BEGIN  CREATE MATERIALIZED VIEW mvtest1 AS SELECT 1 AS x;  CREATE MATERIALIZED VIEW mvtest2 AS SELECT 1 AS x WITH NO DATA;  END;  $$ LANGUAGE plpgsql;