#!/bin/bash

RESULTS=$1/4_run_power
LOGFILE=power.log
RF_DATA=$TPCH_HOME/dss/rf_data

#drop the old log path
rm -rf $RESULTS
mkdir -p $RESULTS/results $RESULTS/errors

function getTiming4() {
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

function run_query0(){
  #run the 22 queries and count the time

  Q_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q_start_time="$Q_start_date >> $RESULTS/final.log

  for i in 14 2 9 20 6 17 18 8 21 13 3 22 16 4 11 15 1 10 19 5 7 12;
  do
    echo "the power test querylist $i is running.........."
    #run query
    start=$(date +%s.%N)
    sed -i '1i\\\timing' $TPCH_HOME/dss/queries0/$i.sql
    psql -h localhost -a -U $USER $DBNAME < $TPCH_HOME/dss/queries0/$i.sql > $RESULTS/results/$i 2> $RESULTS/errors/$i
    sed -i '1d' $TPCH_HOME/dss/queries0/$i.sql
    end=$(date +%s.%N)
    getTiming4 $start $end $i >> $RESULTS/results.log
    echo "the power test querylist $i finished OK.........."
  done
  Q_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
  echo "Q_end_time="$Q_end_date >> $RESULTS/final.log
}

#run the rf streams
function run_rf1(){
    echo "run RF1..............."
    #run RF1
    echo "the power test RF1_1.SQL is runing.........."
#    start_insert=$(date +%s.%N)
#    psql -h localhost -U $USER $DBNAME -c "copy orders1 from '$TPCH_HOME/orders.tbl.u1' delimiter '|' null '';" > $RESULTS/results/rf1_1.log 2> /dev/null
#    end_insert=$(date +%s.%N)
#    getTiming4 $start_insert $end_insert RF1_1_copy_orders >> $RESULTS/results.log

#    start_insert=$(date +%s.%N)
#    psql -h localhost -U $USER $DBNAME -c "copy lineitem1 from '$TPCH_HOME/lineitem.tbl.u1' delimiter '|' null '';" > $RESULTS/results/rf1_1.log 2> /dev/null
#    end_insert=$(date +%s.%N)
#    getTiming4 $start_insert $end_insert RF1_1_copy_lineitem >> $RESULTS/results.log

    RF1_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
    echo "RF1_start_time="$RF1_start_date >> $RESULTS/final.log

    start_insert=$(date +%s.%N)
    psql -h localhost -U $USER $DBNAME -c 'select insert0();' > $RESULTS/results/rf1_1.log 2> $RESULTS/results/rf1_1_err.log
    end_insert=$(date +%s.%N)
    getTiming4 $start_insert $end_insert RF1_1_insert >> $RESULTS/results.log

    RF1_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
    echo "RF1_end_time="$RF1_end_date >> $RESULTS/final.log

    echo "the RF1_1.SQL finished OK.........."
    echo "run query.............."
}

function run_rf2(){
    #RUN RF2
    echo "run RF2.............."
    echo  "the power test RF2_1.SQL is  runing.........."

#    start_delete=$(date +%s.%N)
#    psql -h localhost -U $USER $DBNAME -c "copy delete1 from '$TPCH_HOME/delete.1' delimiter '|' null ''" > $RESULTS/results/rf2_1.log 2> /dev/null
#    end_delete=$(date +%s.%N)
#    getTiming4 $start_delete $end_delete RF2_1_copy >> $RESULTS/results.log

    RF2_start_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
    echo "RF2_start_time="$RF2_start_date >> $RESULTS/final.log

    start_delete=$(date +%s.%N)
    psql -h localhost -U $USER $DBNAME -c 'select delete0();' > $RESULTS/results/rf2_1.log 2> $RESULTS/results/rf2_1_err.log
    end_delete=$(date +%s.%N)
    getTiming4 $start_delete $end_delete RF2_1_delete >> $RESULTS/results.log

    RF2_end_date=$(date "+%Y-%m-%d %H:%M:%S.%N")
    echo "RF2_end_time="$RF2_end_date >> $RESULTS/final.log

    echo "the RF2_1.SQL finished  OK.........."
}

echo "run the Power benchmark......"
run_rf1
echo "run_power_query....."
run_query0
echo "run_power_refresh........"
run_rf2
wait
