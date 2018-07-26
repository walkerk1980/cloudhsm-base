#!/bin/bash

cid=$(echo '`'$CLUSTERID'`')

if [ "$(echo $1|wc -c)"  -lt "2" ];then
  echo "Usage: addHSM.sh <Availability Zone letter>"
  echo "Example: addHSM.sh c"
  exit 0
fi

if [ "$(echo $1|wc -c)"  -gt "2" ];then
  echo "Enter only the letter of the AZ which you want to use."
  exit 1
fi

echo -e "\n\rAdding HSM in AZ $1 to Cluster: $cid\n\r"

aws cloudhsmv2 create-hsm --cluster-id $cid --availability-zone "$REGION"$1
