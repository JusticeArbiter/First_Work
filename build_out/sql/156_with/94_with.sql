with cte(foo) as ( select 42 ) select * from ((select foo from cte)) q;
