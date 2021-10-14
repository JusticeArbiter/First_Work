explain (costs off)  select * from int8_tbl a,  int8_tbl x left join lateral (select a.q1 from int4_tbl y) ss(z)  on x.q2 = ss.z;
