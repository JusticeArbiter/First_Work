explain (costs off)  select count(*) from tenk1 a cross join lateral generate_series(1,two) g;
