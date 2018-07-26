CloudHSM client container based on Ubuntu with CloudHSM client Installed.

Prerequisites:

  Container host Instance requires either an EC2 Instance Profile with IAM permissions that allow the container to pull 
  the CloudHSM Cluster information or you must pass the container IAM Access Key Credential Enviornment Variables. [1][2]
  Requires you to provide the CLUSTERID of an HSM Cluster with at least one running HSM in the same Region/VPC as the host.
  Cluster/HSM requires the proper Security Groups allowing the Instance/Container to contact it.
  For more infomation please see the CloudHSM documentation. [3] 

  [1] Using Instance Profiles - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html
  [2] Environment Variables - https://docs.aws.amazon.com/cli/latest/userguide/cli-environment.html
  [3] Getting Started with AWS CloudHSM - https://docs.aws.amazon.com/cloudhsm/latest/userguide/getting-started.html

Getting Started:

  docker volume create --name cloudhsm_data

  docker run -it -d --rm --name cloudhsm -v cloudhsm_data:/root/data/ walkerk1980/cloudhsm-base /bin/bash

  docker cp /path/to/customerCA.crt cloudhsm:/root/data/

  docker stop cloudhsm

  docker run -it -d -e CLUSTERID=cluster-5la5cwabs7v -v cloudhsm_data:/root/data --name cloudhsm -e REGION=us-west-2 walkerk1980/cloudhsm-base /usr/local/bin/startup.sh


Example commands once container is running:

  ensure that client is connected: docker logs cloudhsm

  connect to bash on container: docker exec -it cloudhsm 
  
  Within bash -  create CA: createCA.sh

  Within bash - CloudHSM Managment Utilitiy: /opt/cloudhsm/bin/cloudhsm_mgmt_util /opt/cloudhsm/etc/cloudhsm_mgmt_util.cfg

ENV VARS:

  CLUSTERID is for the Cluster Id of your initialized CloudHSM Cluster containing at least one running HSM.

  REGION is for the AWS Region that your CloudHSM Cluster is located  in.

  CASUBJECT (Optional) is for the subject of the local CA to be created.

  CAKEYPASS (Optional) is for the local CA private key password.


Internal Container Commands:

  createCA.sh - Set up the local CA using the information provided in CASUBJECT and CAKEYPASS. This will create an openssl CA and move it to the data volume

  cainfo.sh - Get info about the customerCA.crt in place within the container
