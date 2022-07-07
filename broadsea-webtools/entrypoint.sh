#!/bin/sh

# Running supervisord for first time then stop it
## This part run supervisord, check for CPU usage which decrease when the process stop running, if CPU usage is under 2.5% it stop the process
## This let the supervisor instanciate the webapi tables

echo "---------"
echo "Running Supervisor"
echo "---------"

/script/run_supervisord.sh &
supervisordPid=$!

while true; do
    supervisordPid=$(ps ax -o pid,cmd | grep "/usr/bin/supervisord" | head -1 | grep -o '[0-9]*' | head -1)
    cpuUsage=$(ps -p $supervisordPid -o pcpu | tail -1 | bc)
    cpuUsageCheck=$(echo "$cpuUsage > 0.5" | bc -l)
    
    if [ $cpuUsageCheck -eq "0" ] && [ $cpuUsage != "0" ]; then 
        echo "---------"
        echo "Stopping Supervisor and tomcat"
        echo "---------"

        javaPid=$(ps ax -o pid,cmd | grep "/usr/local/openjdk-8/bin/java" | head -1 | grep -o '[0-9]*' | head -1)
        kill -15 $supervisordPid
        kill -15 $javaPid
        break    
    fi

    echo "Waiting for end of first initialization [$cpuUsage]"
    sleep 1
done

# Writting the Source table
export PGPASSWORD=$POSTGRES_PASSWORD
sed "s/@schema_api/$WEB_API_SCHEMA_NAME/g;s/@schema_cdm/$CDM_SCHEMA_NAME/g;s/@schema_temp/$TEMP_SCHEMA_NAME/g;s/@db/$POSTGRES_DB/g;s/@user/$POSTGRES_USER/g;s/@password/$POSTGRES_PASSWORD/g" /sql/source_source_daimon.sql | psql -h  cdm -U $POSTGRES_USER -d $POSTGRES_DB 

/script/run_supervisord.sh