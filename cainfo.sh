#!/bin/bash

echo -e "\n\rCA Certificate:\n\r"

openssl x509 -text -noout -in /opt/cloudhsm/etc/customerCA.crt

echo -e "\n\rCA Certificate PEM:\n\r"

cat /opt/cloudhsm/etc/customerCA.crt


#echo -e "\n\rClusteer Certificate:\n\r"

