SELECT '' AS two, d1 AS "timestamp", abstime(d1) AS abstime  FROM TIMESTAMP_TBL WHERE NOT isfinite(d1);
