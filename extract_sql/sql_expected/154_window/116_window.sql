SELECT VAR_POP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n);