WITH RECURSIVE foo(i) AS  (SELECT i FROM (VALUES(1),(2)) t(i)  UNION ALL  SELECT (i+1)::numeric(10,0) FROM foo WHERE i < 10)  SELECT * FROM foo;
