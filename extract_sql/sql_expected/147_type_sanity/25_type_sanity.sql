SELECT DISTINCT typtype, typreceive  FROM pg_type AS p1  WHERE p1.typtype not in ('b', 'p')  ORDER BY 1;
