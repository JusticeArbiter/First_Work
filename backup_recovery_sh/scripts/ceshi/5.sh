#!/bin/bash

#echo -e "The second query result is 1000000"
#echo -e "\033[43;31;1mThe second query result is 1000000\033[0m"

function out(){
h=`echo $#`
for bl in "$@"
do 
  echo -e "\033[;;7m$bl\033[0m"

done
#for (( i=0; $i<=$h; i+=1 ))
#do
#echo -e "\033[;;7m$i\033[0m"

#done
}

#echo "HighGo Database"
out "China shandong HighGo Database 山东瀚高数据库" 
echo "China shandong HighGo Database 山东瀚高数据库"
#echo "HighGO Database"
