# Debian 8, ESA-STEP-SNAP (unix_2_0_2)  Dockerfile
# https://github.com/edwardpmorris/docker-snap

FROM epmorris/debian8-snap2:base

MAINTAINER epmorris "edward.morris@uca.es"

LABEL snap_version='2.0.2' 

## Toolbox builds ##
# copy over install settings to WRKDIR
ONBUILD COPY snap2.varfile $HOME
ONBUILD RUN ./$TBX -q -varfile snap2.varfile \
  && rm $TBX \
  && rm snap2.varfile
ONBUILD ENV PATH=$PATH:/home/worker/snap/bin \
            SNAP_PATH=/home/worker/snap/bin
