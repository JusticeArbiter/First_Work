/* Multiple primary keys creation should fail */  CREATE TABLE inhg (x text, LIKE inhx INCLUDING INDEXES, PRIMARY KEY(x));
