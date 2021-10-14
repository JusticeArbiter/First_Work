select regexp_substr('abc,abc,abc'::text,'[^,]+'::text,1::int4,2::int4);
