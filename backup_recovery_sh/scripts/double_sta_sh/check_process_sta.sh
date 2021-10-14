#!/bin/bash

function output_important_sta_text(){
for impo_text in "$@"
do
  echo -e "\033[;;7m$impo_text\033[0m"
done
}

for((;;))
do
  standby_process=`ps -ef | grep postgres | grep 'wal receiver'`
  if [ $? -eq 0 ]
    then
      echo -e "The Standby Server process:"
      output_important_sta_text "$standby_process"
      break
    else
      output_important_sta_text "The Standby Server has no wal receiver process,please check\t.............no"
      #read
      sleep 2
      continue
  fi
done
