#!/bin/bash

build=walkerk1980/cloudhsm-base

docker volume create --name cloudhsm_data
docker run -it -d --rm --name cloudhsm -v cloudhsm_data:/root/data/ $build /bin/bash
docker cp ./customerCA.crt cloudhsm:/root/data/
docker stop cloudhsm

docker run -it -d -e CLUSTERID=cluster-6lc5awaas7v -v cloudhsm_data:/root/data --name cloudhsm -e REGION=us-west-2 $build /usr/local/bin/startup.sh
