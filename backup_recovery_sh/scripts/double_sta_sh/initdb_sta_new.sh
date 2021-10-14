#!/bin/bash
encry_cho=cast5
if [[ $encry_cho == "none" ]]
  then
    echo -e "$PGHOME/bin/initdb -D $PGHOME/data"
    $PGHOME/bin/initdb -D $PGHOME/data
  else
    echo -e "$PGHOME/bin/initdb --data-encryption pgcrypto --key-url ldaps://192.168.100.119:636?cn=Manager,dc=highgo,dc=com?123 -C $encry_cho --new-key -D $PGHOME/data"
    $PGHOME/bin/initdb --data-encryption pgcrypto --key-url ldaps://192.168.100.119:636?cn=Manager,dc=highgo,dc=com?123 -C $encry_cho --new-key -D $PGHOME/data
fi
