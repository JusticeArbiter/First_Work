create function testfoo() returns record as $$  insert into foo values (1,2) returning *;  $$ language sql;
