CREATE VIEW vw_getfoo AS SELECT * FROM getfoo5(1) WITH ORDINALITY AS t1(a,b,c,o);
