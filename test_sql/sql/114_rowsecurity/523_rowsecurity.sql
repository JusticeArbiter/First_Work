CREATE POLICY p1 ON copy_rel_to USING (a % 2 = 0);
