SELECT attname, most_common_vals FROM pg_stats  WHERE tablename = 'current_check'  ORDER BY 1;
