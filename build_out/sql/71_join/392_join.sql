explain (verbose, costs off)  select * from int4_tbl i left join  lateral (select * from int2_tbl j where i.f1 = j.f1) k on true;
