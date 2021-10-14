select f1,g from int4_tbl a cross join (select a.f1 as g) ss;
