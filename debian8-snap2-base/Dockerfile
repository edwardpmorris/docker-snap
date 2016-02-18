# Debian 8, ESA-STEP-SNAP (unix_2_0_2)  Dockerfile
# https://github.com/edwardpmorris/docker-snap

# pull base image (use a specific version tag ':tag')
FROM debian:8
# maintainer details
MAINTAINER epmorris "edward.morris@uca.es"
# update image labels
LABEL snap_version='2.0.2' 
# create user group and install packages
RUN groupadd -r worker \
    && useradd -r -g worker worker \
    && mkdir /home/worker
RUN apt-get update -y && apt-get install -y \ 
      nano \
      wget \
    && rm -fr /var/lib/apt/lists/*
# update variables
ENV \ 
  TBX="esa-snap_sentinel_unix_2_0_2.sh" \
  SNAP_URL="http://step.esa.int/downloads/2.0" \
  HOME=/home/worker
# set work directory to home and download snap
WORKDIR /home/worker
RUN wget $SNAP_URL/$TBX \ 
  && chmod +x $TBX
