select * from (values(1)) x(lb),  lateral (select lb from int4_tbl) y(lbcopy);
