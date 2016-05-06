# Debian, miniconda, ESRIN-Sen2Cor Dockerfile
# https://github.com/edwardpmorris/docker-snap
# sen2cor on Conda https://anaconda.org/Terradue/sen2cor/

# pull base image (use a specific version tag ':tag')
FROM debian:8

# maintainer details
MAINTAINER epmorris "edward.morris@uca.es"

# update image labels
LABEL sen2cor_version='2.0.6' 

# miniconda INSTALL
# update and install packages
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

# install miniconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.0.5-Linux-x86_64.sh && \
    /bin/bash /Miniconda2-4.0.5-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda2-4.0.5-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH

# http://bugs.python.org/issue19846
# At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# Sen2Cor INSTALL
# install libopenjp2, sen2cor and create sen2cor configuration folder
RUN apt-get update -y && apt-get install -y \ 
      libopenjp2-7 \
    && rm -fr /var/lib/apt/lists/*

# install sen2cor and downgrade gdal to 1.10.1 (Bug: libgdal.so.20 not found)
RUN conda install -c terradue sen2cor=2.0.6  \
    && conda clean -t
RUN conda install -c osgeo gdal=1.10.1 \
    && conda clean -t

# update variables
ENV  GDAL_DATA /opt/conda/share/gdal
ENV  SEN2COR_BIN /opt/conda/lib/python2.7/site-packages/sen2cor
ENV  HOME /home/worker
ENV  SEN2COR_HOME $HOME/sen2cor

RUN mkdir -p ${SEN2COR_HOME}/cfg
RUN cp ${SEN2COR_BIN}/cfg/L2A_GIPP.xml ${SEN2COR_HOME}/cfg/

# create user group
RUN groupadd -r worker \
    && useradd -r -g worker worker

# set work directory to home
WORKDIR /home/worker
