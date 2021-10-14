CREATE AGGREGATE testagg3(int2) (SFUNC = int2_sum, STYPE = int8);
