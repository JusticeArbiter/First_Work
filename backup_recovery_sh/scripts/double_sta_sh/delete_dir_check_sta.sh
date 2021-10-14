#放到备库检查文件夹是否删除成功的脚本
for((;;))
do
  let x=0
  for stadeldir in $*
  do
    if [ -e $stadeldir -a -d $stadeldir ]
      then
        echo -e "The standby server directory $stadeldir delete failed,please check\t.............no"
        let x+=1
        #read
        sleep 2
        continue
      else
        echo -e "Delete the standby server directory $stadeldir successfully\t.............ok"
    fi
  done
  if [ $x -eq 0 ]
    then
      break
  fi
done
