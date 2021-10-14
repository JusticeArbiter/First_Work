CREATE VIEW tv AS SELECT type, sum(amt) AS totamt FROM t GROUP BY type;
