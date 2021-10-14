select regexp_substr('abc,abc,abc'::text,'[^,]+'::text,2::int4);
