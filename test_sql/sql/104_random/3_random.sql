SELECT count(*) AS random INTO RANDOM_TBL  FROM onek WHERE random() < 1.0/10;
