COPY ( select "id" , 'id' , 'id""' ||t, ( id + 1 ) *id,t, "test1" . "t" from test1 where id=3 ) TO STDOUT 
