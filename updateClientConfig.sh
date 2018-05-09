#!/bin/bash

cid=$(echo '`'$CLUSTERID'`')

eniip=$(aws cloudhsmv2 describe-clusters --region $REGION --query "Clusters[?ClusterId==$cid].{EniIp:Hsms[?State==\`ACTIVE\`].EniIp}"  --output text|cut -f2)

echo -e "\n\rQuerying for an active HSM in ClusterId $CLUSTERID in Region $REGION\n\r"

if [ "$(echo $eniip|wc -m)" -lt "8" ];then
  echo -e "\n\rHSM ENI IP Address is too short to be valid IPv4, something went wrong.\n\r\n\rAre cluster $CLUSTERID and an HSM Active in this Region?\n\r"
  exit -1
elif [ "$(echo $eniip|wc -m)" -gt "16" ];then
  echo -e "\n\rHSM ENI IP Address is too long to be valid IPv4, something went wrong.\n\r\n\rAre cluster $CLUSTERID and an HSM Active in this Region?\n\r"
  exit -1
fi

echo -e "\n\rUpdating client config with HSM IP: $eniip\n\r"

/opt/cloudhsm/bin/configure -a $eniip
