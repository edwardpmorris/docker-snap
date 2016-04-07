# Debian 8, Java 1.8, Maven 3.1.1 ESA-STEP-SNAP (devlopment)  Dockerfile
# compile and build development versions of SNAP + toolboxes
# https://hub.docker.com/r/jamesdbloom/docker-java8-maven/
# https://github.com/edwardpmorris/docker-snap

# FIXME: consider using :tag rather than latest
FROM jamesdbloom/docker-java8-maven:latest

MAINTAINER epmorris "edward.morris@uca.es"

LABEL snap_version='development' 

# create user group and install packages
RUN groupadd -r worker \
    && useradd -r -g worker worker \
    && mkdir /home/worker

# clone snap
WORKDIR /home/worker
RUN mkdir snap \
  && git clone https://github.com/senbox-org/snap-engine.git snap/snap-engine \
  && git clone https://github.com/senbox-org/snap-desktop.git snap/snap-desktop \
  && git clone https://github.com/senbox-org/s1tbx.git snap/s1tbx\
  && git clone https://github.com/senbox-org/s2tbx.git snap/s2tbx\
  && git clone https://github.com/senbox-org/s3tbx.git snap/s3tbx

RUN cd snap/snap-engine \
  && mvn clean install

RUN cd snap/snap-desktop \
  && mvn clean install

RUN cd snap/s1tbx \
  && mvn clean install

RUN cd snap/s2tbx \
  && mvn clean install

RUN cd snap/s3tbx \
  && mvn clean install
