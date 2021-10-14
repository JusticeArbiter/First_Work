DELETE FROM current_check WHERE CURRENT OF current_check_cursor RETURNING *;
