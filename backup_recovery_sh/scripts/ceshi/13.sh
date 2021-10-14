#!/bin/bash

master=`ssh highgo@192.168.88.135 ps -ef | grep postgres | grep 'wal receivedasdr' | echo $?`
#id=`ssh highgo@192.168.88.135 "echo $?"` 
#if [ $? -eq 0 ]
#  then
#    echo -e "OK"
#  else
#    echo -e "NO"
#fi
echo $master
