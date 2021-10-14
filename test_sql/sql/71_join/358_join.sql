select *, (select r from (select q1 as q2) x, (select q2 as r) y) from int8_tbl;
