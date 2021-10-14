SELECT DISTINCT typtype, typoutput  FROM pg_type AS p1  WHERE p1.typtype not in ('b', 'd', 'p')  ORDER BY 1;
