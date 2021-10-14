create function testfoo(a int, inout a int) returns int as $$ select 1;$$ language sql;
