#!/bin/bash

if [ ! -d /root/data ]; then
  echo "data volume is not mounted at /root/data, exiting..."
  exit 1
fi

if [ -d /root/ca_setup ]; then
  echo 1000 >/root/ca_setup/serial
  echo '' >/root/ca_setup/index.txt
fi

if [ -d /root/data/ca ]; then
  ln -s /root/data/ca /root/ca
fi

/bin/cp /root/data/customerCA.crt /opt/cloudhsm/etc/customerCA.crt

/usr/local/bin/updateClientConfig.sh


/usr/local/bin/cloudhsmClient.sh


#/bin/bash
