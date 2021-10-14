select usort, grouping(usort), count(*) from (values ('1'::xid),('2'::xid),('1'::xid)) v(usort) group by rollup(usort);
