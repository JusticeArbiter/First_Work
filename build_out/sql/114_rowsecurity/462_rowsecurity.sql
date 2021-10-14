CREATE POLICY blog_1 ON blog USING (id % 2 = 0);
