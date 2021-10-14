CREATE TRANSFORM FOR int LANGUAGE SQL (  FROM SQL WITH FUNCTION varchar_transform(internal),  TO SQL WITH FUNCTION int4recv(internal));
