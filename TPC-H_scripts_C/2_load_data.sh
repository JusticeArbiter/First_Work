#!/bin/bash

RESULTS=$1/2_load_data
LOGFILE=load_data.log

#create load data path
#print_log "----------delete old load_data path--------------"
rm -rf $RESULTS
#print_log "----------create new load_data path -------------"
mkdir -p $RESULTS

function loaddata_run() {
        # store the settings
        psql -h localhost -d $DBNAME -U $USER -c "select name,setting from pg_settings" > $RESULTS/settings.log 2> $RESULTS/settings.err

        echo "preparing TPC-H database"
        echo "  loading data begin...."

        LOAD_START_TIME=`date '+%Y-%m-%d %H:%M:%S'`
        echo -e "LOAD_START_TIME = $LOAD_START_TIME" > $RESULTS/time.log

        psql -h localhost -U $USER $DBNAME -a -f dss/create_load.sql >> $RESULTS/load.log 2> $RESULTS/load.err

        psql -h localhost -U $USER -a -c "copy nation from '$TPCH_HOME/nation.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        psql -h localhost -U $USER -a -c "copy region from '$TPCH_HOME/region.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        psql -h localhost -U $USER -a -c "copy part from '$TPCH_HOME/part.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        psql -h localhost -U $USER -a -c "copy supplier from '$TPCH_HOME/supplier.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        psql -h localhost -U $USER -a -c "copy partsupp from '$TPCH_HOME/partsupp.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        psql -h localhost -U $USER -a -c "copy customer from '$TPCH_HOME/customer.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        psql -h localhost -U $USER -a -c "copy orders from '$TPCH_HOME/orders.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        psql -h localhost -U $USER -a -c "copy lineitem from '$TPCH_HOME/lineitem.tbl' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &

        for (( rfi=1;rfi<=${STREAMS};rfi++ ))
        do 
          let rft=$rfi-1
          psql -h localhost -U $USER -a -c "copy orders${rft} from '$TPCH_HOME/orders.tbl.u${rfi}' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
          psql -h localhost -U $USER -a -c "copy lineitem${rft} from '$TPCH_HOME/lineitem.tbl.u${rfi}' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
          psql -h localhost -U $USER -a -c "copy delete${rft} from '$TPCH_HOME/delete.${rfi}' delimiter '|';" $DBNAME >> $RESULTS/load.log 2>> $RESULTS/load.err &
        done

        wait

        psql -h localhost -U $USER $DBNAME -a -f dss/key_index.sql >> $RESULTS/load.log 2> $RESULTS/load.err

        LOAD_END_TIME=`date '+%Y-%m-%d %H:%M:%S'`
        echo -e "LOAD_END_TIME = $LOAD_END_TIME" >> $RESULTS/time.log

        echo "  loading data end....."

        echo "  analyzing"
        psql -h localhost -U $USER $DBNAME -c "analyze" > $RESULTS/analyze.log 2> $RESULTS/analyze.err
        echo "load data finished Ok...."

}

#load into the database
loaddata_run  $RESULTS
