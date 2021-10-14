create function testfoo(a int) returns table(a int) as $$ select $1;$$ language sql;
