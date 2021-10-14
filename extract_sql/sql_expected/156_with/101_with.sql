WITH RECURSIVE outermost(x) AS (  WITH innermost as (SELECT 2 FROM outermost)  SELECT * FROM innermost  UNION SELECT * from outermost  )  SELECT * FROM outermost;
