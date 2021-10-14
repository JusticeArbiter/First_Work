CREATE AGGREGATE testagg1(int2) (SFUNC = int2_sum, STYPE = int8);
