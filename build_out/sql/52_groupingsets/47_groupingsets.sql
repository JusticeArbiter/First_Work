select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum  from gstest2 group by cube (a,b) order by rsum, a, b;
