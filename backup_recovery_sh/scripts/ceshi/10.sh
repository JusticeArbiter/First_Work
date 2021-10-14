aa=`psql -c "select * from pg_stat_replication" | tail -3 | head -1 | awk -F'|' '{print $16}'`
echo $aa
