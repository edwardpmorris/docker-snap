# Debian, ESA-STEP-SNAP  Dockerfile
# https://github.com/edwardpmorris/docker-snap

FROM epmorris/debian8-snap3:base

MAINTAINER epmorris "edward.morris@uca.es"

LABEL snap_version='3.0.0 (31.03.2016 8:00)' 

## Toolbox builds ##
# copy over install settings to WRKDIR
ONBUILD COPY snap2.varfile $HOME
ONBUILD RUN ./$TBX -q -varfile snap2.varfile \
  && rm $TBX \
  && rm snap2.varfile
ONBUILD ENV PATH=$PATH:/home/worker/snap/bin \
            SNAP_PATH=/home/worker/snap/bin
