#!/bin/bash

export DIR=/home/highgo/backup_recovery_sh/scripts/ceshi
export master_host=192.168.88.128
export standby_host=192.168.88.135
export mas_user=highgo
export sta_user=highgo

#ssh $mas_user@$standby_host 'date' >> $DIR/out 2>&1

#ssh highgo@192.168.88.135 scp /home/highgo/hgdb/data/pg_hba.conf highgo@192.168.88.128:/home/highgo/backup_recovery_sh/scripts/ceshi/

#scp highgo@192.168.88.135:/home/highgo/hgdb/data/pg_hba.conf /home/highgo/backup_recovery_sh/scripts/ceshi/

#ssh highgo@192.168.88.135 /home/highgo/hgdb/bin/pg_ctl  start  -W -D /home/highgo/hgdb/data 

#ssh -t highgo@192.168.88.135 /home/highgo/hgdb/bin/pg_ctl start -w >> /home/highgo/log

ssh -t highgo@192.168.88.135 /home/highgo/hgdb/bin/pg_ctl stop -w >> /home/highgo/log 

#ssh highgo@192.168.88.135 date
#ssh highgo@192.168.88.135 "/home/highgo/hgdb/bin/pg_ctl stop -D $HG_HOME/data"
