#!/bin/bash
RESULTS=$1/5_run_throughput
LOGFILE=bench.log
RF_DATA=$TPCH_HOME/dss/rf_data
let STREAM=$STREAMS-1

#The path
rm -rf $RESULTS
mkdir -p $RESULTS/query_results $RESULTS/errors

rm -rf $RESULTS/rf_log
mkdir -p $RESULTS/rf_log



# arg1=start, arg2=end, format: %s.%N
function getTiming5() {
    start=$1
    end=$2
    q=$3
    start_s=$(echo $start | cut -d '.' -f 1)
    start_ns=$(echo $start | cut -d '.' -f 2)
    end_s=$(echo $end | cut -d '.' -f 1)
    end_ns=$(echo $end | cut -d '.' -f 2)
    time=$(( ( 10#$end_s - 10#$start_s ) * 1000 + ( 10#$end_ns / 1000000 - 10#$start_ns / 1000000 ) ))
    echo "$3=$time ms"
}

#run the tpch query streams  and  RF streams
function run_query1(){

  Q1_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q1_start_time="$Q1_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 21 3 18 5 11 7 6 20 17 12 16 15 13 10 2 8 14 19 9 22 1 4;
  do
    echo " running the streams1 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries1/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries1/$i.sql > $RESULTS/query_results/1_${i} \
    2> $RESULTS/errors/1_${i}
    sed -i '1d' $TPCH_HOME/dss/queries1/$i.sql
    echo " query $i in streams1  finished OK......."
  done
 
  Q1_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q1_end_time="$Q1_end_date >> $RESULTS/final.log
}

function run_query2(){

  Q2_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q2_start_time="$Q2_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 6 17 14 16 19 10 9 2 15 8 5 22 12 7 13 18 1 4 20 3 11 21;
  do
    echo " running the streams2 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries2/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries2/$i.sql > $RESULTS/query_results/2_${i} \
    2> $RESULTS/errors/2_${i}
    sed -i '1d' $TPCH_HOME/dss/queries2/$i.sql
    echo " query $i in streams2  finished OK......."
  done

  Q2_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q2_end_time="$Q2_end_date >> $RESULTS/final.log
}

function run_query3(){

  Q3_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q3_start_time="$Q3_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 8 5 4 6 17 7 1 18 22 14 9 10 15 11 20 2 21 19 13 16 12 3;
  do
    echo " running the streams3 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries3/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries3/$i.sql > $RESULTS/query_results/3_${i} \
    2> $RESULTS/errors/3_${i}
    sed -i '1d' $TPCH_HOME/dss/queries3/$i.sql
    echo " query $i in streams3  finished OK......."
  done

  Q3_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q3_end_time="$Q3_end_date >> $RESULTS/final.log
}

function run_query4(){

  Q4_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q4_start_time="$Q4_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 5 21 14 19 15 17 12 6 4 9 8 16 11 2 10 18 1 13 7 22 3 20;
  do
    echo " running the streams4 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries4/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries4/$i.sql > $RESULTS/query_results/4_${i} \
    2> $RESULTS/errors/4_${i}
    sed -i '1d' $TPCH_HOME/dss/queries4/$i.sql
    echo " query $i in streams4  finished OK......."
  done

  Q4_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q4_end_time="$Q4_end_date >> $RESULTS/final.log
}

function run_query5(){

  Q5_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q5_start_time="$Q5_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 21 15 4 6 7 16 19 18 14 22 11 13 3 1 2 5 8 20 12 17 10 9;
  do
    echo " running the streams5 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries5/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries5/$i.sql > $RESULTS/query_results/5_${i} \
    2> $RESULTS/errors/5_${i}
    sed -i '1d' $TPCH_HOME/dss/queries5/$i.sql
    echo " query $i in streams5  finished OK......."
  done

  Q5_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q5_end_time="$Q5_end_date >> $RESULTS/final.log
}

function run_query6(){

  Q6_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q6_start_time="$Q6_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 10 3 15 13 6 8 9 7 4 11 22 18 12 1 5 16 2 14 19 20 17 21;
  do
    echo " running the streams6 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries6/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries6/$i.sql > $RESULTS/query_results/6_${i} \
    2> $RESULTS/errors/6_${i}
    sed -i '1d' $TPCH_HOME/dss/queries6/$i.sql
    echo " query $i in streams6  finished OK......."
  done

  Q6_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q6_end_time="$Q6_end_date >> $RESULTS/final.log
}

function run_query7(){

  Q7_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q7_start_time="$Q7_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 18 8 20 21 2 4 22 17 1 11 9 19 3 13 5 7 10 16 6 14 15 12;
  do
    echo " running the streams7 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries7/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries7/$i.sql > $RESULTS/query_results/7_${i} \
    2> $RESULTS/errors/7_${i}
    sed -i '1d' $TPCH_HOME/dss/queries7/$i.sql
    echo " query $i in streams7  finished OK......."
  done

  Q7_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q7_end_time="$Q7_end_date >> $RESULTS/final.log
}

function run_query8(){

  Q8_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q8_start_time="$Q8_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 19 1 15 17 5 8 9 12 14 7 4 3 20 16 6 22 10 13 2 21 18 11;
  do
    echo " running the streams8 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries8/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries8/$i.sql > $RESULTS/query_results/8_${i} \
    2> $RESULTS/errors/8_${i}
    sed -i '1d' $TPCH_HOME/dss/queries8/$i.sql
    echo " query $i in streams8  finished OK......."
  done

  Q8_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q8_end_time="$Q8_end_date >> $RESULTS/final.log
}

function run_query9(){

  Q9_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q9_start_time="$Q9_start_date >> $RESULTS/final.log

  #run the 22 queries and count the time
  for i in 8 13 2 20 17 3 6 21 18 11 19 10 15 4 22 1 7 12 9 14 5 16;
  do
    echo " running the streams9 of query $i....... "
    #run query
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries9/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries9/$i.sql > $RESULTS/query_results/9_${i} \
    2> $RESULTS/errors/9_${i}
    sed -i '1d' $TPCH_HOME/dss/queries9/$i.sql
    echo " query $i in streams9  finished OK......."
  done

  Q9_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q9_end_time="$Q9_end_date >> $RESULTS/final.log
}

function run_rf(){
local m=$STREAM
   for i in `seq 1 $m`
   do

     echo "the RF1_$i.SQL was runing.........."

     echo -e "RF1_${i}_start_date=`date '+%Y-%m-%d %H:%M:%S.%N'`" >> $RESULTS/final.log
     #echo "RF1_${i}_start_time="${RF1_${i}_start_date} >> $RESULTS/query_results/final.log

     #Statistical time RF1
     start_rf1=$(date +%s.%N)
     psql -h localhost -U $USER $DBNAME -c "select insert$i();" > $RESULTS/rf_log/rf1_${i}.log 2> $RESULTS/rf_log/rf1_${i}_err.log
     end_rf1=$(date +%s.%N)
     getTiming5 ${start_rf1} ${end_rf1} RF1_$i >> $RESULTS/query_results/rf_time.log
     echo -e "RF1_${i}_end_date=`date '+%Y-%m-%d %H:%M:%S.%N'`" >> $RESULTS/final.log
     #echo "RF1_${i}_end_time="${RF1_${i}_end_date} >> $RESULTS/query_results/final.log

     echo "the RF1_$i.SQL was finished.........."
     echo "the RF2_$i.SQL was runing.........."

     echo -e "RF2_${i}_start_date=`date '+%Y-%m-%d %H:%M:%S.%N'`" >> $RESULTS/final.log
     #echo "RF2_${i}_start_time="${RF2_${i}_start_date} >> $RESULTS/query_results/final.log

     #Statistical time RF1
     start_rf2=$(date +%s.%N)
     psql -h localhost -U $USER $DBNAME -c "select delete$i();" > $RESULTS/rf_log/rf2_${i}.log 2> $RESULTS/rf_log/rf2_${i}_err.log
     end_rf2=$(date +%s.%N)
     getTiming5 ${start_rf2} ${end_rf2} RF2_$i >> $RESULTS/query_results/rf_time.log
     echo -e "RF2_${i}_end_date=`date '+%Y-%m-%d %H:%M:%S.%N'`" >> $RESULTS/final.log
     #echo "RF2_${i}_end_time="${RF2_${i}_end_date} >> $RESULTS/query_results/final.log

     echo "the RF2_$i.SQL was finished.........."
done
}

#generate the query log1 log2 logn  &&  gene
#echo "run the generate log path loop......"
#for i in `seq 2 $STREAMS`
#do
  #2 rf
#  if [ 1 -eq $i ];then
#    rm -rf $RESULTS/rf_log
#    mkdir -p $RESULTS/rf_log
#  fi
#done

#-----------------------------------------RUN TPCH Throughput--------------------------------------------
echo "run the tpch benchmark......"
start=$(date +%s.%N)
start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
echo "start_time="$start_date >> $RESULTS/final.log
#--------------------------------THE PART OF RF LOAD RF DATA TO DB------------------------------------------
echo "---------------------load refresh data to GP begin-----------------------------------"

#for i in `seq 2 $STREAMS`
#do
#   echo "Load :delete.$i"
#   psql -h localhost -d $DBNAME -U $USER -c "copy delete$i from '$TPCH_HOME/delete.$i' delimiter '|' null ''"

#done

#for n in `seq 2 $STREAMS`;
#do
#  echo "Load :insert.$n"
#  psql -h localhost -d $DBNAME -U $USER -c "copy orders$n from '$TPCH_HOME/orders.tbl.u$n' delimiter '|' null '';"
#  psql -h localhost -d $DBNAME -U $USER -c "copy lineitem$n from '$TPCH_HOME/lineitem.tbl.u$n' delimiter '|' null '';"
#done

for i in `seq 1 $STREAM`
do
  echo "then streams is :$i......."
  echo "run_query $i....."
  (run_query$i)&

  if [ 1 -eq $i ];then
    echo "run_rf $STREAM........"
    (run_rf $STREAM)&
  fi
done
wait
end=$(date +%s.%N)
end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
echo "end_time="$end_date >> $RESULTS/final.log
getTiming5 $start $end "results" >> $RESULTS/final.log
