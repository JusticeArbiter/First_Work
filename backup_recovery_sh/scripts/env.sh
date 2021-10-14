#!/bin/bash

#HGDB
export PGHOME=/home/highgo/hgdb
export PATH=$PGHOME/bin:$PATH
export PGDATA=$PGHOME/data
export LD_LIBRARY_PATH=$PGHOME/lib:$LD_LIBRARY_PATH
export PGHOST=localhost
export PGPORT=5866
export PGUSER=highgo
export PGDATABASE=highgo

#test env
export BARE_DIR_PWD=`pwd`
export BARE_DIR=${BARE_DIR_PWD%/*}
export PHYHOT_DIR=$BARE_DIR/physics_hot
export PHYCOLD_DIR=$BARE_DIR/physics_cold
export LOGIC_DIR=$BARE_DIR/logic
export ARCHIVE_DIR=$BARE_DIR/archive
export DOUBLE_SYNC_DIR=$BARE_DIR/double_wal_sync
export DOUBLE_ASYNC_DIR=$BARE_DIR/double_wal_async
export SCRIPTS_DIR=$BARE_DIR_PWD
export SCR_SQL_DIR=$SCRIPTS_DIR/sql_dir
export DOUBLE_STASH_DIR=$SCRIPTS_DIR/double_sta_sh
export LOG_DIR=$BARE_DIR/log

#standby
export STA_SYSTEM_USER=highgo
export MASTER_HOST=192.168.100.241
export STADB_HOST=192.168.100.242
export STADB_PORT=5866
export STADB_USER=highgo
export STADB_DATABASE=highgo
export STADB_HOME=/home/highgo/hgdb

#initdb

#function initdb_select(){
#for((;;))
#do
#  echo -e "List of cryptographic algorithms:"
#  echo
#  echo -e "1. Do not use encryption algorithms"
#  encry=(aes-128 aes-192 aes-256 blowfish des 3des cast5)
#  encnum=${#encry[*]}
#  let encnum_2=$encnum+1
#  for (( count=0; count<$encnum; count+=1 ))
#  do
#    let f=count+2
#    echo -e "$f. ${encry[$count]} "
#  done
#  echo
#  echo -e "Please select encryption algorithm: \c"
#  read g

#  if [ $g -eq 1 ]
#    then
#      echo -e "Your choice is not encrypted"
#      encry_cho="none"
#      echo -e "#!/bin/bash" > $DOUBLE_STASH_DIR/initdb_sta_new.sh 2>&1
#      echo -e "encry_cho=$encry_cho" >> $DOUBLE_STASH_DIR/initdb_sta_new.sh 2>&1
#      cat $DOUBLE_STASH_DIR/initdb_sta_exm.sh >> $DOUBLE_STASH_DIR/initdb_sta_new.sh 2>&1
#      check_file $DOUBLE_STASH_DIR/initdb_sta_new.sh
#      read
#      break
#    elif [ $g -ge 2 -a $g -le $f ]
#      then
#        let h=$g-2
#        echo -e "Your choice is ${encry[$h]}"
#        encry_cho=${encry[$h]}
#        echo -e "#!/bin/bash" > $DOUBLE_STASH_DIR/initdb_sta_new.sh 2>&1
#        echo -e "encry_cho=$encry_cho" >> $DOUBLE_STASH_DIR/initdb_sta_new.sh 2>&1
#        cat $DOUBLE_STASH_DIR/initdb_sta_exm.sh >> $DOUBLE_STASH_DIR/initdb_sta_new.sh 2>&1
#        check_file $DOUBLE_STASH_DIR/initdb_sta_new.sh
#        read
#        break
#    else
#    echo -e "You muset enter 1--$encnum_2"
#    read
#  fi
#done
#}

function initdb_stat(){
if [[ $encry_cho == "none" ]]
  then
    echo -e "$PGHOME/bin/initdb -D $PGHOME/data"
    $PGHOME/bin/initdb -D $PGHOME/data
  else
    echo -e "$PGHOME/bin/initdb --data-encryption pgcrypto --key-url ldaps://192.168.100.222:636?cn=hgdb,dc=highgo,dc=com?123 -C $encry_cho --encryption_range $fdefenji -D $PGHOME/data"
    $PGHOME/bin/initdb --data-encryption pgcrypto --key-url ldaps://192.168.100.222:636?cn=hgdb,dc=highgo,dc=com?123 -C $encry_cho --encryption_range $fdefenji -D $PGHOME/data
fi
}

