select * from  int8_tbl x left join (select q1,coalesce(q2,0) q2 from int8_tbl) y on x.q2 = y.q1,  lateral (select x.q1,y.q1,y.q2) v(xq1,yq1,yq2);
