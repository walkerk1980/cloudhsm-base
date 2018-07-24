#!/bin/bash

echo 1000 >ca/serial
echo '' >ca/index.txt
/usr/local/bin/createCA.sh

/bin/cp /root/data/customerCA.crt /opt/cloudhsm/etc/customerCA.crt

/usr/local/bin/updateClientConfig.sh

/usr/local/bin/cloudhsmClient.sh

#/bin/bash
