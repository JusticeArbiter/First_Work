WITH q AS (SELECT 'foo' AS x)  SELECT x, x IS OF (unknown) as is_unknown FROM q;
