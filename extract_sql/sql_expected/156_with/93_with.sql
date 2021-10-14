with cte(foo) as ( values(42) ) values((select foo from cte));
