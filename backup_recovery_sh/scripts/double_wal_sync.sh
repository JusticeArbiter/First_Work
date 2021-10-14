#!/bin/bash

#双机热备，通过流复制进行双机热备的测试
function double_wal_sync(){
#测试前配置
echo
echo -e "Please close the firewall or open the HighGo Database port(5866) before testing,and configure the highgo user trust of the master standby server"
#read

#删除双机热备文件夹下的所有文件
echo -e "Empty the directory $DOUBLE_SYNC_DIR\t............."
rm -rf $DOUBLE_SYNC_DIR/*
empty_dir_check $DOUBLE_SYNC_DIR

#创建双机热备项目下的各个文件夹
echo -e "Create the directory\t............."
mkdir $DOUBLE_SYNC_DIR/log
mkdir $DOUBLE_SYNC_DIR/data_backup
#检查目录是否创建成功
check_dir $DOUBLE_SYNC_DIR/log $DOUBLE_SYNC_DIR/data_backup

#操作备服务器
echo -e "Configuration the standby server\t............."
#在备服务器创建文件夹
output_log $DOUBLE_SYNC_DIR/log/log.log "ssh $STA_SYSTEM_USER@$STADB_HOST mkdir $STADB_HOME/double_check"
#把需要在备服务器执行的脚本scp到备服务器新建的文件夹下
output_log $DOUBLE_SYNC_DIR/log/log.log "scp -v $DOUBLE_STASH_DIR/* $STA_SYSTEM_USER@$STADB_HOST:$STADB_HOME/double_check/"
output_log $DOUBLE_SYNC_DIR/log/log.log "ssh $STA_SYSTEM_USER@$STADB_HOST chmod u+x $STADB_HOME/double_check/*"
#执行测试前的数据库服务检查，备份data
output_log $DOUBLE_SYNC_DIR/log/log.log "ssh $STA_SYSTEM_USER@$STADB_HOST export PGHOME=$STADB_HOME;export PGDATA=$STADB_HOME/data;$STADB_HOME/double_check/dbservice_check_sta_01.sh"
#删除备库data
ssh $STA_SYSTEM_USER@$STADB_HOST rm -rf $STADB_HOME/data
ssh $STA_SYSTEM_USER@$STADB_HOST "$STADB_HOME/double_check/delete_dir_check_sta.sh $STADB_HOME/data"

#主库备份data的新名字变量，易于区分各个项目之间的data备份
daname_ba=doublewal_sync

#开始测试前数据库状态检查，备份原data
dbservice_check_01 $DOUBLE_SYNC_DIR/log/log.log

#删除data目录
echo -e "Delete the directory $PGHOME/data\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "rm -rf $PGHOME/data"
delete_dir_check $PGHOME/data

#初始化数据库
echo -e "Init the HighGo Database\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "initdb_stat"
command_returnid_check $command_return_id "Initdb(HighGo Database)..."
check_dir $PGHOME/data

#备份配置文件
echo -e "Backup the database configuration file\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "mv $PGHOME/data/pg_hba.conf $PGHOME/data/pg_hba.conf.back"
output_log $DOUBLE_SYNC_DIR/log/log.log "cp $PGHOME/data/postgresql.conf $PGHOME/data/postgresql.conf.back"
check_file $PGHOME/data/pg_hba.conf.back $PGHOME/data/postgresql.conf.back

#修改数据库参数
echo -e "Modifying database configuration\t............."

echo -e "local all all trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e local all all trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all 127.0.0.1/32 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e host all all 127.0.0.1/32 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all 0.0.0.0/0 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e host all all 0.0.0.0/0 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host replication all 0.0.0.0/0 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e host replication all 0.0.0.0/0 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "host all all ::1/128 trust" >> $PGHOME/data/pg_hba.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e host all all ::1/128 trust >> $PGHOME/data/pg_hba.conf 2>&1"

echo -e "Modify the file $PGHOME/data/pg_hba.conf\t.............ok"

echo -e "logging_collector = on" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e logging_collector = on >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_directory = 'hgdb_log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e log_directory = 'hgdb_log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "log_filename = 'hgdb_double-%Y-%m-%d_%H%M%S.log'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e log_filename = 'hgdb_double-%Y-%m-%d_%H%M%S.log' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "listen_addresses = '*'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e listen_addresses = '*' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "wal_level = 'hot_standby'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e wal_level = 'hot_standby' >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "max_wal_senders = 2" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e max_wal_senders = 2 >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "wal_keep_segments = 500" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e wal_keep_segments = 500 >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "synchronous_commit = on" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e synchronous_commit = on >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "synchronous_standby_names = 'standby_name'" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e synchronous_standby_names = 'standby_name' >> $PGHOME/data/postgresql.conf 2>&1"
 
echo -e "hot_standby = on" >> $PGHOME/data/postgresql.conf 2>&1
output_log $DOUBLE_SYNC_DIR/log/log.log "echo -e hot_standby = on >> $PGHOME/data/postgresql.conf 2>&1"

echo -e "Modify the file $PGHOME/data/postgresql.conf\t.............ok"

#启动数据库服务
echo -e "Start the HighGo Databse service\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "$PGHOME/bin/pg_ctl start -w -D $PGHOME/data"
dbservice_check_02

#进行一次基础备份
echo -e "Start a base backup\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "$SCR_SQL_DIR/base_start.sh"
command_returnid_check $command_return_id "select pg_start_backup()"

#备份data到备库和double项目下
echo -e "Copy base data to stnadby server\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "scp -rv $PGHOME/data $STA_SYSTEM_USER@$STADB_HOST:$STADB_HOME/"
ssh $STA_SYSTEM_USER@$STADB_HOST "$STADB_HOME/double_check/check_dir_sta.sh $STADB_HOME/data"
echo -e "Backup the directory data\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "cp -rv $PGHOME/data $DOUBLE_SYNC_DIR/data_backup/data_base"
check_dir $DOUBLE_SYNC_DIR/data_backup/data_base

output_log $DOUBLE_SYNC_DIR/log/log.log "$SCR_SQL_DIR/base_stop.sh"
command_returnid_check $command_return_id "select pg_stop_backup()"
echo -e "Base backup succeeded\t.............ok"

#修改备库配置,拷贝生成的recovery.conf文件到备库
echo -e "Copy recovery.conf to the standby server\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "scp -v $SCR_SQL_DIR/recovery_sync.conf $STA_SYSTEM_USER@$STADB_HOST:$STADB_HOME/data/recovery.conf"
ssh $STA_SYSTEM_USER@$STADB_HOST "$STADB_HOME/double_check/check_file_sta.sh $STADB_HOME/data/recovery.conf"
output_log $DOUBLE_SYNC_DIR/log/log.log "ssh -t $STA_SYSTEM_USER@$STADB_HOST rm -rf $STADB_HOME/data/postmaster.pid"

#启动备库
echo -e "Start the stnadby server HighGo Database service\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "ssh -t $STA_SYSTEM_USER@$STADB_HOST $STADB_HOME/bin/pg_ctl start -w -D $STADB_HOME/data"
ssh -t $STA_SYSTEM_USER@$STADB_HOST "export PGHOME=$STADB_HOME;export PGDATA=$STADB_HOME/data;$STADB_HOME/double_check/dbservice_check_sta_02.sh"

#查询主库和备库的流复制进程
for((;;))
do
  master_process=`ps -ef | grep postgres | grep 'wal sender'`
  if [ $? -eq 0 ]
    then
      echo -e "The Master Server process:"
      output_important_text "$master_process"
      break
    else
      output_important_text "The Master Server has no wal sender process,please check\t.............no"
      sleep 2
  fi
  continue
done

ssh $STA_SYSTEM_USER@$STADB_HOST "$STADB_HOME/double_check/check_process_sta.sh"

#判断流复制是不是同步
for((;;))
do
  master_wal_stat=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select sync_state from pg_stat_replication" | sed -n "3p" | awk '{print $1}'`
  if [[ $master_wal_stat == "sync" ]]
    then
      output_important_text "The double-click Hot standby is synchronous replication\t.............ok"
      break
    else
      output_important_text "This double-click Hot sparing is not a synchronous copy,please check\t.............no"
      sleep 2
  fi
  continue
done

#主库使用pgbench插入数据
echo -e "Importing test data using pgbench\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "$PGHOME/bin/pgbench -h $PGHOST -p $PGPORT -U $PGUSER -i -s 10 $PGDATABASE"
command_returnid_check $command_return_id "pgbench -i -s 10"

for((;;))
do
  #主库查询结果
  validation_count_09=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
  output_important_text "The query result from Master server is $validation_count_09"

  #备库查询结果
  validation_count_10=`$PGHOME/bin/psql -h $STADB_HOST -p $STADB_PORT -U $STADB_USER -d $STADB_DATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
  output_important_text "The query resule from Standby server is $validation_count_10"

  if [[ $validation_count_09 == $validation_count_10 ]]
    then
      output_important_text "The Master Server and the Standby Server query results are identical\t.............ok"
      break
    else
      output_important_text "Different query results from Master server and Standby server\t.............no"
      sleep 2
  fi
  continue
done

#主备切换
#停止主库服务
echo -e "Master Server and Standby Server switching\t............."
echo -e "Stop the Master server database service\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "$PGHOME/bin/pg_ctl stop -w -D $PGHOME/data -m fast"
dbservice_check_03

#touch触发文件，备库升主库
echo -e "Create switch trigger file in the Standby server\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "ssh $STA_SYSTEM_USER@$STADB_HOST touch $STADB_HOME/trigger_file"
sleep 10
ssh $STA_SYSTEM_USER@$STADB_HOST "$STADB_HOME/double_check/check_file_sta.sh $STADB_HOME/data/recovery.done"

#原主库创建recovery.conf文件
echo -e "Create recovery.conf in the Master(old) Server\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "cp $SCR_SQL_DIR/recovery_sync_master.conf $PGHOME/data/recovery.conf"
check_file $PGHOME/data/recovery.conf

#启动备库(原主库)
echo -e "Start the Standby Server(old master)\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "$PGHOME/bin/pg_ctl start -w -D $PGHOME/data"
dbservice_check_02

#查询主库和备库的流复制进程

ssh $STA_SYSTEM_USER@$STADB_HOST "$STADB_HOME/double_check/check_process_sta_sw.sh"

for((;;))
do
  master_process=`ps -ef | grep postgres | grep 'wal receiver'`
  if [ $? -eq 0 ]
    then
      echo -e "The Standby Server process:"
      output_important_text "$master_process"
      break
    else
      output_important_text "The Standby Server has no wal receiver process,please check\t.............no"
      sleep 2
  fi
  continue
done

#判断流复制是不是同步
for((;;))
do
  master_wal_stat=`$PGHOME/bin/psql -h $STADB_HOST -p $STADB_PORT -U $STADB_USER -d $STADB_DATABASE -c "select sync_state from pg_stat_replication" | sed -n "3p" | awk '{print $1}'`
  if [[ $master_wal_stat == "sync" ]]
    then
      output_important_text "The double-click Hot standby is synchronous replication\t.............ok"
      break
    else
      output_important_text "This double-click Hot sparing is not a synchronous copy,please check\t.............no"
      sleep 2
  fi
  continue
done

#主库使用pgbench初始化数据
echo -e "Importing test data using pgbench\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "$PGHOME/bin/pgbench -h $STADB_HOST -p $STADB_PORT -U $STADB_USER -i -s 1 $STADB_DATABASE"
command_returnid_check $command_return_id "pgbench -i -s 1"

for((;;))
do

  #主库查询结果
  validation_count_11=`$PGHOME/bin/psql -h $STADB_HOST -p $STADB_PORT -U $STADB_USER -d $STADB_DATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
  output_important_text "The query result from Master server is $validation_count_11"

  #备库查询结果
  validation_count_12=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select count(*) from pgbench_accounts" | sed -n "3p" | awk '{print $1}'`
  output_important_text "The query resule from Standby server is $validation_count_12"


  if [ $validation_count_11 -eq $validation_count_12 ]
    then
      output_important_text "The Master Server and the Standby Server query results are identical\t.............ok"
      break
    else
      output_important_text "Different query results from Master server and Standby server\t.............no"
      sleep 2
  fi
  continue
done

output_important_text "The Double-click Hot Standby backup(sync) test success\t.............ok"

#停止主备库数据库服务
echo -e "Stop the Standby(old master) service\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "$PGHOME/bin/pg_ctl stop -w -D $PGHOME/data -m fast "
dbservice_check_03

echo -e "Stop the Master(old standby) service\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "ssh $STA_SYSTEM_USER@$STADB_HOST $STADB_HOME/bin/pg_ctl stop -w -D $STADB_HOME/data -m fast"
ssh $STA_SYSTEM_USER@$STADB_HOST "export PGHOME=$STADB_HOME;export PGDATA=$STADB_HOME/data;$STADB_HOME/double_check/dbservice_check_sta_03.sh"

#备份最终data文件
echo -e "Backup the last data\t............."
output_log $DOUBLE_SYNC_DIR/log/log.log "cp -rv $PGHOME/data $DOUBLE_SYNC_DIR/data_backup/data_master"
check_dir $DOUBLE_SYNC_DIR/data_backup/data_master
echo -e "Backup the last Master server data to directory $DOUBLE_SYNC_DIR/data_backup/data_master\t.............ok"

output_log $DOUBLE_SYNC_DIR/log/log.log "scp -rv $STA_SYSTEM_USER@$STADB_HOST:$STADB_HOME/data $DOUBLE_SYNC_DIR/data_backup/data_standby"
check_dir $DOUBLE_SYNC_DIR/data_backup/data_standby
echo -e "Backup the last Standby server data to directory $DOUBLE_SYNC_DIR/data_backup/data_standby\t.............ok"

echo -e "$encry_cho $fdefenji double_wal_sync : ok" >> $LOG_DIR/log.log

#read
}
