CREATE AGGREGATE testagg2(int2) (SFUNC = int2_sum, STYPE = int8);
