select regexp_substr('ABC,abc,ABC'::text,'abc'::text,1::int4,1::int4,'i');
