#!/bin/bash

function check_dir(){
for((;;))
do
  let b=0
  for newdir in "$@"
  do 
    if [ -e $newdir -a -d $newdir ]
      then
        echo -e "The directory $newdir\t.............ok"
      else
        echo -e "Please check the directory $newdir,creation failed\t.............no"
        let b+=1
        read
    fi
  done 
  if [ $b -eq 0 ]
    then
      break
  fi
done
}

check_dir "ssh -t highgo@192.168.88.135:/home/highgo/hgdb/data"
