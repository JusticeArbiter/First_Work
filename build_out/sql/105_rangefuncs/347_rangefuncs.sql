SELECT *,  lower(CASE WHEN id = 2 THEN (regexp_matches(str, '^0*([1-9]\d+)$'))[1]  ELSE str  END)  FROM  (VALUES (1,''), (2,'0000000049404'), (3,'FROM 10000000876')) v(id, str);
