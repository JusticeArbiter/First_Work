prepare q as select array_to_string(array_agg(repeat('x',2*n)),E'\n') as "ab   c", array_to_string(array_agg(repeat('y',20-2*n)),E'\n') as "a  bc" from generate_series(1,10) as n(n) group by n>1 ;
