CloudHSM client container based on Ubuntu with CloudHSM client installed.
Private Openssl CA provided to sign CloudHSM Cluster Certificate.

Example Commands:

docker run -it -d -e CASUBJECT=example3.com -e REGION=us-west-2 -e CLUSTERID=cluster-6lc5awaas7v --name cloudhsm walkerk1980/cloudhsm-base /usr/local/bin/startup.sh

ENV VARS:

REGION is for the AWS Region you would like your Private CA to be created in.

CASUBJECT is for the subject of the local CA to be created.

CAKEYPASS is for the local CA private key password.

CLUSTERID is for the Cluster Id if reusing an existing cluster.
