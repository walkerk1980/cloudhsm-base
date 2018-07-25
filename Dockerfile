FROM ubuntu
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --assume-yes -y --yes -f dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --assume-yes -y --yes -f install -y openssl dnsutils nano tcpdump screen python3 python3-pip groff wget libedit2
RUN /usr/bin/pip3 install awscli
WORKDIR /root/
RUN /usr/bin/wget https://s3.amazonaws.com/cloudhsmv2-software/cloudhsm-client_latest_amd64.deb && /usr/bin/dpkg -i cloudhsm-client_latest_amd64.deb
WORKDIR /root/
COPY ca /root/setup_ca
COPY openssl_root.cnf /root/setup_ca/openssl_root.cnf
WORKDIR /root/setup_ca/
ENV CAKEYPASS=Password1
ENV CASUBJECT=example.com
ENV REGION=us-west-2
WORKDIR /root/
COPY startup.sh /usr/local/bin/startup.sh
COPY cloudhsmClient.sh /usr/local/bin/cloudhsmClient.sh
COPY createCA.sh /usr/local/bin/createCA.sh
COPY cainfo.sh /usr/local/bin/cainfo.sh
COPY updateClientConfig.sh /usr/local/bin/updateClientConfig.sh
