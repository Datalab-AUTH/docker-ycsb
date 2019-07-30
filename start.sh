#!/bin/mksh

set -vex

# maor load
function config_workloads
{
    sed -i "s/recordcount=[0-9]*/recordcount=${RECNUM:=1000000}/g" \
        /opt/YCSB-*/workloads/workload*
    sed -i "s/operationcount=[0-9]*/operationcount=${OPNUM:=5000000}/g" \
        /opt/YCSB-*/workloads/workload*
        
    return
}

function load_data
{
    if [[ ! -e /.loaded_data ]]; then

        /opt/YCSB-*/bin/ycsb.sh load "${DBTYPE}" -s -P "workloads/workload${WORKLETTER}" "${DBARGS}" && touch /.loaded_data
    fi

    return
}

# exit message
trap 'echo "\n${progname} has finished\n"' EXIT

# make it easier to see logs in the rancher ui
sleep 5

# make sure all the params are set and go.
if [[ -z ${DBTYPE} || -z ${WORKLETTER} || -z ${DBARGS} ]]; then
  echo "Missing params! Exiting"
  exit 1
else
  # Add to support mongo ssl
  # Mount ca.pem to /etc/ssl/
  if [[ ${DBTYPE} == 'mongodb' || ${DBTYPE} == 'mongodb-async' ]]; then
    if [[ $DBARGS == *"ssl=true"* ]]; then
      keytool -import -alias cacert -storepass changeit \
      -keystore /usr/local/openjdk-8/jre/lib/security/cacerts -file /etc/ssl/ca.pem -noprompt
    fi
  fi

  config_workloads
  if [[ ! -z "${ACTION}" ]]; then
    eval ./bin/ycsb "${ACTION}" "${DBTYPE}" -s -P "workloads/workload${WORKLETTER}" "${DBARGS}"
  else
    load_data
    eval ./bin/ycsb run "${DBTYPE}" -s -P "workloads/workload${WORKLETTER}" "${DBARGS}"
  fi
fi
