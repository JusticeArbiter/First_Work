create rule foorule as on insert to foo where f1 < 100  do instead insert into foo2 values (f1);
