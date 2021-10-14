#!/bin/bash

export TPCH_HOME=/home/vmgpadmin/tpch-tools/dbgen
export DBNAME='tpch'
export USER='vmgpadmin'
export PGPORT='15432'
export TPCH_LOG=/home/vmgpadmin/tpch-tools/tpch_test
export STREAMS=3


RESULTS=$TPCH_LOG/6_compare
LOGFILE=power.log

#drop the old log path 
rm -rf $RESULTS
mkdir -p $RESULTS/results $RESULTS/errors


#echo "--------generate the new query path $TPCH_HOME/dss/queries_compare"
#mkdir -p $TPCH_HOME/dss/queries_compare
echo "--------begin to generate query sql"
#generate the sql
#for i in `seq 1 22`;
#do
#  DSS_QUERY=dss/templates ./qgen $i > $TPCH_HOME/dss/queries_compare/$i.sql
#  sleep 1
#done

function getTiming4() {
    start=$1
    end=$2
    start_s=$(echo $start | cut -d '.' -f 1)
    start_ns=$(echo $start | cut -d '.' -f 2)
    end_s=$(echo $end | cut -d '.' -f 1)
    end_ns=$(echo $end | cut -d '.' -f 2)
    time=$(( ( 10#$end_s - 10#$start_s ) * 1000 + ( 10#$end_ns / 1000000 - 10#$start_ns / 1000000 ) ))
    echo "$time"
}

function run_query1(){
  #run the 22 queries and count the time
  for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22;
  do
    echo "the compare test querylist $i is running.........."
    #run query
    start=$(date +%s.%N)
    psql -h localhost -U $USER $DBNAME < $TPCH_HOME/dss/queries_compare/$i.sql > $RESULTS/results/$i 2> $RESULTS/errors/$i
    end=$(date +%s.%N)
    getTiming4 $start $end >> $RESULTS/beforetime.txt

    echo "the compare test querylist $i finished OK.........."
  done
}


echo "run the compare benchmark......"
echo "run_power_query....."
(run_query1)&
wait