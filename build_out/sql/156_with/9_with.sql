WITH RECURSIVE t(n) AS (  SELECT 1  UNION  SELECT 10-n FROM t)  SELECT * FROM t;
