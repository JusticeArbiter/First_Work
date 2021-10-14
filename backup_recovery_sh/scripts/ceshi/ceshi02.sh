#!/bin/bash

function check_dir(){

for((;;))
do
  let b=0
  for dir in $*
  do
    if [ -e $dir -a -d $dir ]
      then
        echo -e "$dir"
        echo -e "OK"
      else
        echo -e "$dir"
        echo -e "NO"
        let b+=1
    fi
  done
  if [[ $b > 0 ]]
    then
      echo -e "nonono"
      read
    else
      break  
  fi
done
}

check_dir /home/highgo/ceshi/1 /home/highgo/ceshi/2 /home/highgo/ceshi/3 /home/highgo/ceshi/6
