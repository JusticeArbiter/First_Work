SELECT a, b FROM collate_test3 WHERE a < 4 INTERSECT SELECT a, b FROM collate_test3 WHERE a > 1 ORDER BY 2;
