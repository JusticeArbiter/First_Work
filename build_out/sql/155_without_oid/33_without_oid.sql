CREATE TABLE create_table_test2 WITH OIDS AS  SELECT a + b AS c1, a - b AS c2 FROM create_table_test;
