select *, c is null as c_is_null  from jsonb_to_record('{"a":1, "b":{"c":16, "d":2}, "x":8}'::jsonb)  as t(a int, b jsonb, c text, x int);
