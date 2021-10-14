create function nochange(int) returns int  as 'select $1 limit 1' language sql stable;
