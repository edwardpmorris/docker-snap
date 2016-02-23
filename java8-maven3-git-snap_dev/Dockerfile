# Debian 8, Java 1.8, Maven 3.1.1 ESA-STEP-SNAP (devlopment)  Dockerfile
# compile and build development versions of SNAP
# https://hub.docker.com/r/jamesdbloom/docker-java8-maven/
# https://github.com/edwardpmorris/docker-snap

FROM jamesdbloom/docker-java8-maven:latest

MAINTAINER epmorris "edward.morris@uca.es"

LABEL snap_version='development' 

# create user group and install packages
RUN groupadd -r worker \
    && useradd -r -g worker worker \
    && mkdir /home/worker