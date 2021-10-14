create function testfoo(a int, out a int) returns int as $$ select $1;$$ language sql;
