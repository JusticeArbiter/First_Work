#生成select语句，使用qgen可以对变量随机生成，这一操作后期可以直接加到脚本里面

for (( i=1;i<=22;i++ ))
do
  DSS_QUERY=./queries ./qgen ${i} > select/${i}.sql

  #dos2unix select2/${i}.sql
  sed -i 's/^M//g' select/${i}.sql
  #二选一，^M需要使用ctrl+v ctrl+m 输入

done

for (( i=1;i<=22;i++ )); do   DSS_QUERY=./queries ./qgen ${i} > select/${i}.sql;    sed -i 's/^M//g' select/${i}.sql done;





dbgen -vf -s 1

dbgen -v -U 2 -s 1

