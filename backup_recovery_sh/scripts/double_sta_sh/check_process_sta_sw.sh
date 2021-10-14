#!/bin/bash

function output_important_sta_text(){
for impo_text in "$@"
do
  echo -e "\033[;;7m$impo_text\033[0m"
done
}

for((;;))
do
  standby_process=`ps -ef | grep postgres | grep 'wal sender'`
  if [ $? -eq 0 ]
    then
      echo -e "The Master Server process:"
      output_important_sta_text "$standby_process"
      break
    else
      output_important_sta_text "The Standby Server has no wal sender process,please check\t.............no"
      #read
      sleep 2 
      continue
  fi
done
