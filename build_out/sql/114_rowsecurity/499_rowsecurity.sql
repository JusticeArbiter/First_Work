INSERT INTO copy_t (SELECT x, md5(x::text) FROM generate_series(0,10) x);
