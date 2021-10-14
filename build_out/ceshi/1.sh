#!/bin/bash

#m=`grep '^aaa\|bbb' b.txt` 
#cat a.txt | sed 's/^aaa/sdfsd/g' > a_1.txt



er=`cat postgresql.log | grep '^ERROR' | awk -F : '{print $2}' | awk '{print $1}'`
#wa=`cat postgresql.log | grep '^WARNING' | awk -F : '{print $2}' | awk '{print $1}'`
er=$(echo $er)
echo $er


#echo $m
#export DIR=/home/postgres/build_out/ceshi
#cat $DIR/tmp | sed "s/^ERROR:/ERROR $er:/g" | sed "s/^WARNING:/WARNING $wa:/g" > $DIR/out.b 2>&1
