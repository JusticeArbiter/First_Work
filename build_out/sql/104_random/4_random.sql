INSERT INTO RANDOM_TBL (random)  SELECT count(*)  FROM onek WHERE random() < 1.0/10;
