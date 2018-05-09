#!/bin/bash

echo 1000 >ca/serial
echo '' >ca/index.txt
/usr/local/bin/createCA.sh

/usr/sbin/service cloudhsm-client start

/bin/bash
