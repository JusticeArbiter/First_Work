#!/bin/bash

function charu_log(){
echo -e "******" >> $1 2>&1
echo -e $2 >> $1 2>&1
$2 >> $1 2>&1
return_id=`echo $?`
echo >> $1 2>&1
}

charu_log /home/highgo/backup_recovery_sh/scripts/ceshi/log.log /home/highgo/backup_recovery_sh/scripts/ceshi/st.sql
x=`echo $?`
echo $x
echo $return_id
#charu_log /home/highgo/backup_recovery_sh/scripts/ceshi/log.log "echo -e  \"local all all trust\" >> /home/highgo/backup_recovery_sh/scripts/ceshi/a.conf 2>&1"

#charu_log /home/highgo/backup_recovery_sh/scripts/ceshi/log.log "$HG_HOME/bin/pgbench -i 10 -s 1"
#charu_log /home/highgo/backup_recovery_sh/scripts/ceshi/log.log "$HG_HOME/bin/createdb db1"
#echo $?

#charu_log /home/highgo/backup_recovery_sh/scripts/ceshi/log.log "/home/highgo/hgdb/bin/psql -f hg01.txt"

#charu_log /home/highgo/backup_recovery_sh/scripts/ceshi/log.log "/home/highgo/hgdb/bin/createdb db1"

#export DATABASE=db1

#charu_log /home/highgo/backup_recovery_sh/scripts/ceshi/log.log "/home/highgo/hgdb/bin/pg_dump --verbose -f /home/highgo/backup_recovery_sh/scripts/ceshi/bf01 $DATABASE"
