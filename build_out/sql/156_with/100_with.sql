WITH RECURSIVE outermost(x) AS (  SELECT 1  UNION (WITH innermost as (SELECT 2)  SELECT * FROM outermost  UNION SELECT * FROM innermost)  )  SELECT * FROM outermost;
