# Debian, miniconda, ESRIN-Sen2Cor Dockerfile
# https://github.com/edwardpmorris/docker-snap
# sen2cor from http://step.esa.int/main/third-party-plugins-2/sen2cor/

# pull base image (use a specific version tag ':tag')
FROM  continuumio/miniconda:4.0.5

# maintainer details
MAINTAINER epmorris "edward.morris@uca.es"

# update version label
LABEL sen2cor_version='2.2.1' 

# set some env variables
ENV SEN2COR_VERSION='2.2.1' \
    HOME=/home/worker

# install conda packages (install expects anaconda)
# FIXME: why is this needed? should mngr not meet dependencies?
RUN conda install --yes \
    pytables \
    psutil \
    scipy \
    scikit-image \
    && conda clean -i -l -t -y

# create user group set UID to volume
RUN mkdir /home/worker \
    && groupadd -r worker -g 1000 \
    && useradd -u 431 -r -g worker -d /home/worker -s /sbin/nologin -c "Docker image user" worker \
    && chown -R worker:worker /home/worker

# set work directory to home
WORKDIR $HOME

# download, check, extract and clean up sen2cor install from step.esa.int
# FIXME: improve verification, https://github.com/docker-library/official-images
# https not available?
ENV SEN2COR_DOWNLOAD_SHA256 81ac7bd389bdce6a24f780d067fbf89324fc6ac314c9d9c28da55d414d1e7d3e
RUN curl -fSL -o sen2cor-${SEN2COR_VERSION}.tar.gz "http://step.esa.int/thirdparties/sen2cor/${SEN2COR_VERSION}/sen2cor-${SEN2COR_VERSION}.tar.gz" \
    && echo "$SEN2COR_DOWNLOAD_SHA256 *sen2cor-${SEN2COR_VERSION}.tar.gz" | sha256sum -c - \
    && tar -xvzf sen2cor-${SEN2COR_VERSION}.tar.gz \
    && rm sen2cor-${SEN2COR_VERSION}.tar.gz

# add headless setup (interactive prompts commented, use defaut path options)
# FIXME: check if a 'default settings' flag exists for setup.py
# add L2A user settings
COPY setup.py $HOME/sen2cor-${SEN2COR_VERSION}
COPY L2A_GIPP.xml $HOME/sen2cor-${SEN2COR_VERSION}/cfg

# install sen2cor and fix permission issues
# FIXME: is this the 'best' way to do permissions?
# FIXME: cmd L2A_Bashrc does not seem to set env variables
ENV  GDAL_DATA=/opt/conda/lib/python2.7/site-packages/sen2cor-2.2.1-py2.7.egg/sen2cor/cfg/gdal_data \
     SEN2COR_BIN=/opt/conda/lib/python2.7/site-packages/sen2cor-2.2.1-py2.7.egg/sen2cor \
     SEN2COR_HOME=$HOME/sen2cor
RUN cd sen2cor-2.2.1 \
    && python setup.py install --quiet \
    && conda clean -i -l -t -y \
    && rm -rf $HOME/sen2cor-${SEN2COR_VERSION} \
    && chmod +x $HOME/sen2cor/L2A_Bashrc \
    && /bin/bash $HOME/sen2cor/L2A_Bashrc \
    && chown -R worker:worker $HOME/sen2cor \
    && chmod -R g+w $HOME/sen2cor \
    && chgrp -R worker $SEN2COR_BIN \
    && chmod -R g+w $SEN2COR_BIN/cfg

USER worker