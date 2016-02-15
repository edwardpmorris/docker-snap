# Debian 8, ESA-STEP-SNAP (unix_2_0_2)  Dockerfile
# https://github.com/edwardpmorris/docker-snap/debian8-esa-step-snap2

# pull base image (use a specific version tag ':tag')
FROM debian:8

# maintainer details
MAINTAINER edwardpmorris "edward.morris@uca.es"

# create user group
#RUN groupadd -r worker \
#    && useradd -r -g worker worker \
#    && mkdir /home/worker
#USER worker
#ENV HOME=/home/worker

# install packages
RUN apt-get update -y && apt-get install -y \ 
    nano \
    wget \
  && rm -fr /var/lib/apt/lists/*

# download (to home) snap from from http://step.esa.int/downloads/2.0
#WORKDIR $HOME
ENV TBX=esa-snap_sentinel_unix_2_0_2.sh \
  SNAP_URL="http://step.esa.int/downloads/2.0"
RUN wget http://step.esa.int/downloads/2.0/$TBX \ 
  && chmod +x $TBX

# start container with install script
#CMD ["sh", "$TBX"]
