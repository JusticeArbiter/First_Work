#!/bin/bash

function initdb(){
$HG_HOME/bin/initdb --data-encryption pgcrypto --key-url ldaps://192.168.100.119:636?cn=Manager,dc=highgo,dc=com?123 -C $1 --new-key -D $HG_HOME/data
}

echo -e "1. Do not use encryption algorithms"
encry=(aes-128 aes-192 aes-256 blowfish des 3des cast5)
encnum=${#encry[*]}
for (( count=0; count<$encnum; count+=1 ))
do
  let m=count+2
  echo -e "$m. ${encry[$count]} "

done
read x

if [ $x -eq 1 ]
  then
    $HG_HOME/bin/initdb -D $HG_HOME/data
  elif [ $x -ge 2 -a $x -le $m ]
    then
      let f=$x-2
      echo ${encry[$f]}
      initdb ${encry[$f]}

  else
    echo -e "faild input"
fi

#$HG_HOME/bin/initdb --data-encryption pgcrypto --key-url ldaps://192.168.100.119:636?cn=Manager,dc=highgo,dc=com?123 -C aes-256 --new-key -D $HG_HOME/data

