SELECT * FROM  (SELECT 1 AS t, (random()*3)::int AS x  UNION  SELECT 2 AS t, 4 AS x) ss  WHERE x > 3;
