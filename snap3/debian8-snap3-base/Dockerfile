# Debian, ESA-STEP-SNAP Dockerfile
# https://github.com/edwardpmorris/docker-snap

# pull base image (use a specific version tag ':tag')
FROM debian:8
# maintainer details
MAINTAINER epmorris "edward.morris@uca.es"
# update image labels
LABEL snap_version='3.0.0 (31.03.2016 8:00)' 
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
  TBX="esa-snap_sentinel_unix_3_0.sh" \
  SNAP_URL="http://step.esa.int/downloads/3.0/installers" \
  HOME=/home/worker
# set work directory to home and download snap
WORKDIR /home/worker
RUN wget $SNAP_URL/$TBX \ 
  && chmod +x $TBX
