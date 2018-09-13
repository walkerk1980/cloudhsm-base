#!/bin/bash

if [ -d /root/data/ca ]; then
  echo "CA has already been set up..."
  echo "CA is contained in /root/data/ca and symlink to this folder can be found at /root/ca"
  echo "exiting..."
  exit 1
fi

if [ ! -d /root/setup_ca ]; then
  echo "CA has already been set up or /root/setup_ca dir has moved.."
  exit 1
fi

cd /root/setup_ca/

/bin/echo -e "\n\rCreating Private Key using pasword specified in ENV VAR CAKEYPASS...\n\r"
/bin/echo -e "$CAKEYPASS\n\r" | openssl genrsa -aes256 -out private/root_private_key.pem -passout stdin 
/bin/chmod 400 private/root_private_key.pem
/bin/echo -e "\n\rCreating CA Certificate with subject using domain specified in ENV VAR CASUBJECT...\n\r"
/bin/echo -e "$CAKEYPASS\n\r" | openssl req -config openssl_root.cnf -key private/root_private_key.pem -passin stdin -new -x509 -days 730 -sha256 -extensions v3_ca -out certs/ca.pem -subj "/C=US/ST=Washington/L=Seattle/O=ExampleCompany/CN=$CASUBJECT"

/bin/mv /root/setup_ca /root/data/ca
/bin/ln -sf /root/data/ca /root/ca
