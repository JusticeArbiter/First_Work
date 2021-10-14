#!/bin/bash

source env.sh

echo -e "Are you sure Empty\n $PHYHOT_DIR\n $PHYCOLD_DIR\n $LOGIC_DIR\n $ARCHIVE_DIR\n $DOUBLE_SYNC_DIR\n $DOUBLE_ASYNC_DIR\n $LOG_DIR"
echo -n "Please enter Y/y or N/n: "
read makesure_dele
if [ "$makesure_dele" != "y" -a "$makesure_dele" != "Y" ]
  then
    exit 1
fi
echo

function empty_dir_check_02(){
for((;;))
do
  let z=0
  for empty_dir_02 in $*
  do
    empty_count_02=`ls $empty_dir_02 | wc -l`
    if [ $empty_count_02 -le 2 ]
      then
        echo -e "Empty the directory $empty_dir_02\t.............ok"
      else
        echo -e "Please check the directory $empty_dir_02,empty failed\t.............no"
        let z+=1
        read
    fi
  done
  if [ $z -eq 0 ]
    then
      break
  fi
done
}

function delete(){
for de_dir in $*
do 
  rm -rf $de_dir/*
  empty_dir_check_02 $de_dir
done
read
}

delete $PHYHOT_DIR $PHYCOLD_DIR $LOGIC_DIR $ARCHIVE_DIR $DOUBLE_SYNC_DIR $DOUBLE_ASYNC_DIR $LOG_DIR
