# Docker containers for the Sentinel Application Platform
Docker containers including ESA-STEP Sentinel Application Platform (SNAP, http://step.esa.int/main/toolboxes/snap/) and Sentinel toolboxes jointly developed by Brockmann Consult, Array Systems Computing and C-S. Containers packaging utilities for Sentinel data are alos included.

## Status
+ pre alpha, in development and may change at anytime without notice
+ headless debian containers available 
+ images not yet on Dockerhub.

## Versions
+ [debian8-snap2:base]() Base container used to build snap and toolboxes (~550 Mb).
+ [debian8-snap2:s1tbx] Base container with snap + s1tbx (~ 1Gb), headless.
+ [debian8-snap2:s2tbx] Base container with snap + s2tbx (~ 1Gb), headless.
+ [debian8-snap2:s3tbx] Base container with snap + s3tbx (~ 1Gb), headless.

+ debian8-pythonX-snap2:base Base container with python used to build snap and toolboxes (~550 Mb) [TODO]
+ alpine3-pythonX-sentinelsat Python container with sentinelsat 0.6.4 a utility to search and download Sentinel-1 Imagery [TODO]
+ java8-maven-git-snapdev (https://hub.docker.com/r/jamesdbloom/docker-java8-maven/) For compiling developer versions of snap using netbeans.[TODO]

## Dependencies

+ [debian](https://hub.docker.com/_/debian/)
+ [alpine](https://hub.docker.com/_/alpine/)
+ [python](https://hub.docker.com/_/python/)
+ [docker-java8-maven](https://hub.docker.com/r/jamesdbloom/docker-java8-maven/)

## Details
The SNAP installer, created with [install4j](http://www.ej-technologies.com/products/install4j/overview.html) from [ej-technologies](http://www.ej-technologies.com/index.html), supports graphical, console and unattended installation (see [Install SNAP on the command line](https://senbox.atlassian.net/wiki/display/SNAP/Install+SNAP+on+the+command+line). 

The base container downloads the SNAP Unix installer and prepares the container ready for installation using the Dockerfile `ONBUILD` instruction. Upon initiating a build, the `snap2.varfile` which contains the specific build options is copied to the container and the unattended installation of SNAP within containers is done by passing the option `-q` and the 'instalation file' to the installer via the `-varfile` option (all these commands are found in the `:base` Dockerfile).

This keeps maintenance minimal (i.e., changes to the base container propagate), means the Dockerfiles for each build are more for adding metadata (labels, ect.) and builds can be easily adjusted.

## Installation

1.  [Install Docker](https://docs.docker.com/engine/installation/).

1. Choose your flavour!

+ Use a pre-made container (replace `:tag` with the version you want)
    + Download build from public [Docker Registry](https://index.docker.io/): `docker pull epmorris/debian8-snap2:s1tbx`
    + Alternatively, you can build an image from Dockerfile (replace `:tag` and the repository subdirectory with the version you want): `docker build -t="epmorris/debian8-snap2:s1tbx" github.com/edwardpmorris/docker-snap.git#:debian8-snap2-s1tbx`)
 
+ Build a custom container...

## Usage

To run a container (choose the container flavour using the `:tag` option) and view the help for the SNAP command line API, `gpt`, open a terminal and type:

```
docker run --rm epmorris/debian8-snap2:s1tbx gpt -h
```

+ adding vmoptions:
```
docker run -it -v /home/edward/snap/bin/gpt.vmoptions:/usr/local/snap/bin/gpt.vmoptions epmorris/debian8-esa-step-snap2:s1tbx
```
+ check why PATH assignment is not permenant in container

## Acknowledgements
Thanks to ESA-STEP Sentinel Application Platform and Sentinel toolboxes development teams for making SNAP freely available.
Thanks to Docker for their excellent tool.
Thanks to Marco and STEP forum members for their prompt answers.
EPM is supported by the EU-FP7 project 'Foreshore Assessment using Space Research' (FAST, http://www.fast-space-project.eu/).
