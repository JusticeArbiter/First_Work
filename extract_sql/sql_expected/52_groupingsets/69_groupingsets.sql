select id, usort, grouping(id,usort), count(*) from (values (1,'1'::xid),(1,'2'::xid),(2,'1'::xid)) v(id,usort) group by grouping sets ((id), (usort));
