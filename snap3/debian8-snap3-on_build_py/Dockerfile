# Debian, ESA-STEP-SNAP Dockerfile
# https://github.com/edwardpmorris/docker-snap

FROM epmorris/debian8-snap3:base

MAINTAINER epmorris "edward.morris@uca.es"

LABEL snap_version='3.0.0 (31.03.2016 8:00)' 

## Setup Python ##
ONBUILD RUN apt-get update -y && apt-get install -y \
  python=2.7.9-1 \
  && rm -fr /var/lib/apt/lists/*

## Toolbox builds ##
# copy over install settings to WRKDIR
ONBUILD COPY snap2.varfile $HOME
ONBUILD RUN ./$TBX -q -varfile snap2.varfile \
  && rm $TBX \
  && rm snap2.varfile
ONBUILD ENV PATH=$PATH:/home/worker/snap/bin \
            SNAP_PATH=/home/worker/snap/bin
# set up snap python API
ONBUILD RUN $SNAP_PATH/snappy-conf /usr/bin/python /usr/local/lib/python2.7/dist-packages
