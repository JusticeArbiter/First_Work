insert into btree_tall_tbl (id, t)  select g, repeat('x', 100) from generate_series(1, 500) g;
