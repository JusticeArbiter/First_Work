#!/bin/bash
let a=1
for((;;))
do
  echo $a
  if [[ $a == 10 ]]
    then
      echo ok
      break
    else
      let a+=1
  fi
  continue
done
