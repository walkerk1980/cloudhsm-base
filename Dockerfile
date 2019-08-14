FROM ubuntu:xenial
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --assume-yes -y --yes -f install -y \ 
  libjson-c2 \
  openssl \
  dnsutils \
  nano \
  tcpdump \
  screen \
  python \
  python3 \
  python3-pip \
  groff \
  wget \
  libedit2 \
  && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/update-alternatives --install /usr/bin/python python /usr/bin/python3 10
RUN /usr/bin/pip3 install awscli
WORKDIR /root/
RUN /usr/bin/wget https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/Xenial/cloudhsm-client_latest_amd64.deb && /usr/bin/dpkg -i cloudhsm-client_latest_amd64.deb
RUN /usr/bin/wget https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/Xenial/cloudhsm-client-dyn_latest_amd64.deb && /usr/bin/dpkg -i cloudhsm-client-dyn_latest_amd64.deb
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
COPY addHSM.sh /usr/local/bin/addHSM.sh
COPY updateClientConfig.sh /usr/local/bin/updateClientConfig.sh
