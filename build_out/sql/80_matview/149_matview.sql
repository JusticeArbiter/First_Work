CREATE MATERIALIZED VIEW mv2 AS SELECT * FROM mv1  WHERE col1 = (SELECT LEAST(col1) FROM mv1) WITH NO DATA;