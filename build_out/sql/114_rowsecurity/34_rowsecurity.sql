CREATE POLICY p1 ON document  USING (dlevel <= (SELECT seclv FROM uaccount WHERE pguser = current_user));
