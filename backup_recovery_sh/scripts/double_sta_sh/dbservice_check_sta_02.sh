#!/bin/bash

#source env_sta.sh

#放到备库执行，检查数据库是否启动成功
for((;;))
do
  $PGHOME/bin/psql -c "select 1" > /dev/null 2>&1
  dbservice_sta_id_02=`echo $?`
  if [ $dbservice_sta_id_02 -eq 0 ]
    then
      echo -e "The standby server HighGo Database servic start successfully\t.............ok"
      break
    else
      echo -e "The standby server HighGo Database service failed to start,please check\t.............no"
      sleep 2
      continue
  fi
done
