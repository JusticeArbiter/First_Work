select regexp_count('hello,./Hello,hello,good'::text,'hello'::text,2::int4);
