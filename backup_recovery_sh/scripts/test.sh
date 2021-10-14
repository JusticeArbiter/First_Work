#!/bin/bash

source env.sh

#全局变量


#检查环境变量
echo
echo "Please make sure the environment variables:"
echo
#sleep 1
echo "************* Master Server HGDB ENV *************"
echo
echo "PGHOME=$PGHOME"
echo "PATH=$PATH"
echo "PGDATA=$PGDATA"
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
echo "PGHOST=$PGHOST"
echo "PGPORT=$PGPORT"
echo "PGUSER=$PGUSER"
echo "PGDATABASE=$PGDATABASE"
echo

echo "************* Master Server Test Directory *************"
echo
echo "BARE_DIR=$BARE_DIR"
echo "PHYHOT_DIR=$PHYHOT_DIR"
echo "PHYCOLD_DIR=$PHYCOLD_DIR"
echo "LOGIC_DIR=$LOGIC_DIR"
echo "ARCHIVE_DIR=$ARCHIVE_DIR"
echo "DOUBLE_SYNC_DIR=$DOUBLE_SYNC_DIR"
echo "DOUBLE_ASYNC_DIR=$DOUBLE_ASYNC_DIR"
echo "SCRIPTS_DIR=$SCRIPTS_DIR"
echo "SCR_SQL_DIR=$SCR_SQL_DIR"
echo "DOUBLE_STASH_DIR=$DOUBLE_STASH_DIR"
echo "LOG_DIR=$LOG_DIR"
echo

echo "************* Standby Server ENV *************"
echo
echo "STA_SYSTEM_USER=$STA_SYSTEM_USER"
echo "MASTER_HOST=$MASTER_HOST"
echo "STADB_HOST=$STADB_HOST"
echo "STADB_PORT=$STADB_PORT"
echo "STADB_USER=$STADB_USER"
echo "STADB_DATABASE=$STADB_DATABASE"
echo "STADB_HOME=$STADB_HOME"

#echo -n "Please enter Y/y or N/n: "
#read makesure_env
#if [ "$makesure_env" != "y" -a "$makesure_env" != "Y" ]
#  then
#    echo -e "Please to the $BARE_DIR/scripts/env.sh check environment variables\t.............no"
#    exit 1
#fi
#echo

#检查测试相关的主要文件夹，如有问题退出测试
for bare_dir in $BARE_DIR $PHYHOT_DIR $PHYCOLD_DIR $LOGIC_DIR $ARCHIVE_DIR $DOUBLE_SYNC_DIR $DOUBLE_ASYNC_DIR $SCRIPTS_DIR $SCR_SQL_DIR $DOUBLE_STASH_DIE $LOG_DIR
do
  if [ -e $bare_dir -a -d $bare_dir ]
    then
      echo -e "The directory $bare_dir\t.............ok"
    else
      echo -e "The directory $bare_dir\t.............no"
      exit 1
  fi
done

#清空log
rm -rf $LOG_DIR/*

#检查各个脚本文件是否存在
for script_file in $SCRIPTS_DIR/env.sh $SCRIPTS_DIR/test.sh $SCRIPTS_DIR/physics_hot.sh $SCRIPTS_DIR/physics_cold.sh $SCRIPTS_DIR/logic.sh $SCRIPTS_DIR/archive.sh $SCRIPTS_DIR/double_wal_sync.sh $SCRIPTS_DIR/double_wal_async.sh $DOUBLE_STASH_DIR/check_dir_sta.sh $DOUBLE_STASH_DIR/check_file_sta.sh $DOUBLE_STASH_DIR/check_process_sta.sh $DOUBLE_STASH_DIR/check_process_sta_sw.sh $DOUBLE_STASH_DIR/dbservice_check_sta_01.sh $DOUBLE_STASH_DIR/dbservice_check_sta_02.sh $DOUBLE_STASH_DIR/dbservice_check_sta_03.sh $DOUBLE_STASH_DIR/delete_dir_check_sta.sh $DOUBLE_STASH_DIR/initdb_sta_exm.sh
do
  if [ -e $script_file -a -f $script_file ]
    then
      echo -e "The script file $script_file\t.............ok"
    else
      echo -e "The script file $script_file\t.............no"
      exit 1
  fi
done

#对重点输出的文本反色输出，便于查看
function output_important_text(){
for impo_text in "$@"
do
  echo -e "\033[;;7m$impo_text\033[0m"
done
}

#检查相关文件夹是否存在
function check_dir(){
for((;;))
do
  let b=0
  for newdir in $*
  do 
    if [ -e $newdir -a -d $newdir ]
      then
        echo -e "The directory $newdir\t.............ok"
      else
        echo -e "Please check the directory $newdir,creation failed\t.............no"
        let b+=1
        exit 1  
    fi
  done
  if [ $b -eq 0 ]
    then
      break
  fi
done
}

#检查相关文件是否存在
function check_file(){
for((;;))
do
  let c=0
  for newfile in $*
  do
    if [ -e $newfile -a -f $newfile ]
      then
        echo -e "The file $newfile\t.............ok"
      else
        echo -e "Please check the file $newfile,creation failed\t.............no"
        let c+=1
        exit 1
    fi
  done
  if [ $c -eq 0 ]
    then
      break
  fi
done
}

#向执行脚本的日志中打印信息
function output_log(){
echo -e "*******************************************" >> $1 2>&1
echo -e "`date +%Y-%m%d-%H%M%S`" >> $1 2>&1
echo -e "$2" >> $1 2>&1
$2 >> $1 2>&1
command_return_id=`echo $?`
echo >> $1 2>&1
}

#开始测试之前备份data数据库状态检查，data备份
function dbservice_check_01(){
for((;;))
do
  #check_db_service=`$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select 1" | sed -n "3p" | awk '{print $1}'`
  #执行一句select 1
  $PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select 1" > /dev/null 2>&1
  #取执行状态的返回id
  dbservice_id_01=`echo $?`
  #执行状态id为0说明psql执行正确，数据库状态正常
  if [ $dbservice_id_01 -eq 0 ]
    then
      echo -e "The HighGo Database service\t.............ok"
      #向日志文件中输出执行日志，取值执行时间，关闭数据库
      output_log $1 "$PGHOME/bin/pg_ctl stop -w -D $PGDATA -m fast"
      echo -e "Shut down HighGo database service\t.............ok"
    #如果执行psql返回为1，说明sql执行结果不正确，返回了ERROR等信息，检查脚本
    elif [ $dbservice_id_01 -eq 1 ]
      then
        echo -e "Please check the script for service check SQL\t.............no" 
        exit 1
    #如果执行psql状态返回为2，说明数据库已关闭，压缩备份data
    elif [ $dbservice_id_01 -eq 2 ]
      then
        echo -e "The HighGo Database service\t.............no"
        #判断data目录是否存在
        if [ -e $PGHOME/data -a -d $PGHOME/data ]
          then
            #data目录存在则向日志文件中输入操作日志，执行时间，备份压缩data，跳出for循环
            #output_log $1 "cp -rv $PGHOME/data $PGHOME/data_${daname_ba}_`date +%Y-%m%d-%H%M%S`"
            echo -e "Backup the directory data\t.............ok"
            break
          else
            #data目录不存在则data已被损坏，检查相关文件
            echo -e "The directory data does not exist,please check\t.............no"
            exit 1
        fi
    #如果psql执行的返回状态不是0，1，2，则说明出现了未知的错误
    else
      echo -e "Unknown Error,please check the HighGo Database and script for service check SQL\t.............no"
      exit 1
  fi
done
}

#判断清空目录是否成功
function empty_dir_check(){
for((;;))
do
  let d=0
  for empty_dir in $*
  do
    empty_count_01=`ls $empty_dir | wc -l`
    if [ $empty_count_01 -le 2 ]
      then
        echo -e "Empty the directory $empty_dir\t.............ok"
      else
        echo -e "Please check the directory $empty_dir,empty failed\t.............no"
        let d+=1
        exit 1
    fi
  done
  if [ $d -eq 0 ]
    then
      break
  fi
done
}

#检查数据库状态是否启动成功
function dbservice_check_02(){
for((;;))
do
  $PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select 1" > /dev/null 2>&1
  dbservice_id_02=`echo $?`
  if [ $dbservice_id_02 -eq 0 ]
    then
      echo -e "The HighGo Database servic start successfully\t.............ok"
      break
    else
      echo -e "The HighGo Database service failed to start,please check\t.............no"
      sleep 2
      continue
  fi
done
}

#停止数据库进程之后检查是否成功
function dbservice_check_03(){
for((;;))
do
  $PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c "select 1" > /dev/null 2>&1
  dbservice_id_03=`echo $?`
  if [ $dbservice_id_03 -eq 0 ]
    then
      echo -e "Stop the HighGo Database service failed,please check\t.............no"
      sleep 2
      continue
    else
      echo -e "Stop the HighGo Database service successfully\t.............ok"
      break
  fi
done
}

#删除文件夹后后检查是否删除成功
function delete_dir_check(){
for((;;))
do
  let e=0
  for deldir in $*
  do
    if [ -e $deldir -a -d $deldir ]
      then
        echo -e "The directory $deldir delete failed,please check\t.............no"
        let e+=1
        exit 1
      else
        echo -e "Delete the directory $deldir successfully\t.............ok"
    fi
  done
  if [ $e -eq 0 ]
    then
      break
  fi
done
}

#执行命令之后返回id的状态检查
function command_returnid_check(){
for ((;;))
do
  if [ $1 -eq 0 ]
    then
      echo -e "The $2 successfully\t.............ok"
      break
    else
      echo -e "The $2 failed,please check\t.............no"
      exit 1
  fi
done
}

#生成基础备份的脚本文件,recovery.conf文件
echo -e "Build the base backup script files and recovery.conf\t............."
test_time=`date +%Y-%m%d-%H%M%S`
echo -e "$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c \"select pg_start_backup('$test_time');\"" > $SCR_SQL_DIR/base_start.sh 2>&1
check_file $SCR_SQL_DIR/base_start.sh

echo -e "$PGHOME/bin/psql -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDATABASE -c \"select pg_stop_backup();\"" > $SCR_SQL_DIR/base_stop.sh 2>&1
check_file $SCR_SQL_DIR/base_stop.sh

echo -e "#HighGo Database Double WAL" > $SCR_SQL_DIR/recovery_sync.conf 2>&1
echo -e "standby_mode = 'on'" >> $SCR_SQL_DIR/recovery_sync.conf 2>&1
echo -e "primary_conninfo = 'host=$MASTER_HOST port=$STADB_PORT user=$STADB_USER application_name=standby_name'" >> $SCR_SQL_DIR/recovery_sync.conf 2>&1
echo -e "recovery_target_timeline = 'latest'" >> $SCR_SQL_DIR/recovery_sync.conf 2>&1
echo -e "trigger_file = '$STADB_HOME/trigger_file'" >> $SCR_SQL_DIR/recovery_sync.conf 2>&1
check_file $SCR_SQL_DIR/recovery_sync.conf

echo -e "#HighGo Database Double WAL" > $SCR_SQL_DIR/recovery_sync_master.conf 2>&1
echo -e "standby_mode = 'on'" >> $SCR_SQL_DIR/recovery_sync_master.conf 2>&1
echo -e "primary_conninfo = 'host=$STADB_HOST port=$STADB_PORT user=$STADB_USER application_name=standby_name'" >> $SCR_SQL_DIR/recovery_sync_master.conf 2>&1
echo -e "recovery_target_timeline = 'latest'" >> $SCR_SQL_DIR/recovery_sync_master.conf 2>&1
echo -e "trigger_file = '$STADB_HOME/trigger_file'" >> $SCR_SQL_DIR/recovery_sync_master.conf 2>&1
check_file $SCR_SQL_DIR/recovery_sync_master.conf

echo -e "#HighGo Database Double WAL" > $SCR_SQL_DIR/recovery_async.conf 2>&1
echo -e "standby_mode = 'on'" >> $SCR_SQL_DIR/recovery_async.conf 2>&1
echo -e "primary_conninfo = 'host=$MASTER_HOST port=$STADB_PORT user=$STADB_USER'" >> $SCR_SQL_DIR/recovery_async.conf 2>&1
echo -e "recovery_target_timeline = 'latest'" >> $SCR_SQL_DIR/recovery_async.conf 2>&1
echo -e "trigger_file = '$STADB_HOME/trigger_file'" >> $SCR_SQL_DIR/recovery_async.conf 2>&1
check_file $SCR_SQL_DIR/recovery_async.conf

echo -e "#HighGo Database Double WAL" > $SCR_SQL_DIR/recovery_async_master.conf 2>&1
echo -e "standby_mode = 'on'" >> $SCR_SQL_DIR/recovery_async_master.conf 2>&1
echo -e "primary_conninfo = 'host=$STADB_HOST port=$STADB_PORT user=$STADB_USER'" >> $SCR_SQL_DIR/recovery_async_master.conf 2>&1
echo -e "recovery_target_timeline = 'latest'" >> $SCR_SQL_DIR/recovery_async_master.conf 2>&1
echo -e "trigger_file = '$STADB_HOME/trigger_file'" >> $SCR_SQL_DIR/recovery_async_master.conf 2>&1
check_file $SCR_SQL_DIR/recovery_async_master.conf

#echo -e "#!/bin/bash" > $DOUBLE_STASH_DIR/env_sta.sh 2>&1
#echo -e "export PGHOME=$STADB_HOME" >> $DOUBLE_STASH_DIR/env_sta.sh 2>&1
#echo -e "export PGDATA=$STADB_HOME/data" >> $DOUBLE_STASH_DIR/env_sta.sh 2>&1
#check_file $DOUBLE_STASH_DIR/env_sta.sh

#read

#选择加密算法
#initdb_select

#物理热备份恢复
source physics_hot.sh

#物理冷备份恢复
source physics_cold.sh

#逻辑备份恢复
source logic.sh

#增量备份恢复
source archive.sh

#同步双机热备
source double_wal_sync.sh

#异步双机热备
source double_wal_async.sh

#主控制结构
#function main(){
#使用for循环实现菜单的输出
#for ((;;))
#do
#  echo -e "\t*************************************************"
#  echo -e "\t*\t\t\t\t\t\t*"
#  echo -e "\t*\t\tTest Menu\t\t\t*"
#  echo -e "\t*\t\t\t\t\t\t*"
#  echo -e "\t*\t1. Physics Hot Backup Recovery\t\t*"
#  echo -e "\t*\t2. Physics Cold Backup Recovery\t\t*"
#  echo -e "\t*\t3. Logic Backup Recovery\t\t*"
#  echo -e "\t*\t4. Archive Backup Recovery\t\t*"
#  echo -e "\t*\t5. Double HA WAL SYNC\t\t\t*"
#  echo -e "\t*\t6. Double HA WAL ASYNC\t\t\t*"
#  echo -e "\t*\t7. Quit\t\t\t\t\t*"
#  echo -e "\t*\t\t\t\t\t\t*"
#  echo -e "\t*************************************************"
#  echo -e "\nPlease Enter 1,2,3,4,5,6,7: \c"
#  read a
  #使用case控制结构控制测试选项
#  case $a in
#    1)
#      physics_hot
#      ;;
#    2)
#      physics_cold
#      ;;
#    3)
#      logic
#      ;;
#    4)
#      archive
#      ;;
#    5)
#      double_wal_sync
#      ;;
#    6)
#      double_wal_async
#      ;;
    #break跳出for循环
#    7)
#      break
#      ;;
    #当输入非1，2，3，4，5，6，7时提示输入非法
#    *)
#     echo -e "You must Enter 1,2,3,4,5,6,7\c"
#     read
#     ;;
#  esac
#done
#}


function main(){
for encry_cho in none aes-128 aes-192 aes-256 blowfish des 3des cast5
do

  #$PGHOME/bin/pg_ctl stop -w -D $PGHOME/data
  #rm -rf $PGHOME/data/*

  #fdelist=(r x s t a)
  #fdenum=${#fdelist[*]}

  if [[ "$encry_cho" == "none" ]]
    then

      #echo -e "bujiami"
      physics_hot
      physics_cold
      logic
      archive
      double_wal_sync
      double_wal_async
      

    #加密情况下，有七种加密算法，每种加密算法对应了31种分级加密情况
    else
      for fdefenji in r x s t a rx rs rt ra xs xt xa st sa ta rxs rxt rxa rst rsa rta xst xsa xta sta rxst rxsa rxta rsta xsta rxsta
      do

        #echo $jname $fdefenji
        physics_hot
        physics_cold
        logic
        archive
        double_wal_sync
        double_wal_async

      done
  fi

  #$PGHOME/bin/pg_ctl start -w -D $PGHOME/data


done
}


#相关测试前检查之后运行主控制程序，shell脚本不像C语言可以把各分支函数定义到main后面，shell需要先定义需要用到的各个分支函数，最后定义主函数main，最后调用各分支函数
main

