# Docker containers for the Sentinel Application Platform

Docker containers including ESA-STEP Sentinel Application Platform ([SNAP]( http://step.esa.int/main/toolboxes/snap/)) and Sentinel toolboxes jointly developed by Brockmann Consult, Array Systems Computing and C-S.

Some useful utlities containers are also included.

## Status
+ in early development and may change at anytime without notice
+ headless debian containers available 
+ images not yet on Dockerhub.

## Versions

### Headless SNAP with toolboxes, `gpt` command line API enabled
+ [debian8-snap2:base]() - Base container used to build SNAP and toolboxes (~550 Mb).
+ [debian8-snap2:on_build]() - Build instuctions (~550 Mb).
+ [debian8-snap2:s1tbx]()  - Base container with SNAP + S1TBX (~ 1 Gb).
+ [debian8-snap2:s2tbx]()  - Base container with SNAP + S2TBX (~ 1 Gb).
+ [debian8-snap2:s3tbx]()  - Base container with SNAP + S3TBX (~ 1 Gb).

### Headless SNAP with toolboxes, `gpt` command line API and `snappy` Python API enabled
+ [debian8-snap2:on_build_py]() - Build instuctions (~ 570 Mb).
+ [debian8-snap2:s1tbx_py]()  - Base container with SNAP + S1TBX (~ 1.1 Gb).
+ [debian8-snap2:s2tbx_py]()  - Base container with SNAP + S2TBX (~ 1.1 Gb).
+ [debian8-snap2:s3tbx_py]()  - Base container with SNAP + S3TBX (~ 1.1 Gb).

### Utilities
+ alpine3-pythonX-sentinelsat Python container with sentinelsat 0.6.4 a utility to search and download Sentinel-1 Imagery [TODO]
+ java8-maven-git-snap_dev - For compiling developer versions of snap using netbeans.[TODO]

## Dependencies

+ [debian](https://hub.docker.com/_/debian/)
+ [alpine](https://hub.docker.com/_/alpine/)
+ [python](https://hub.docker.com/_/python/)
+ [docker-java8-maven](https://hub.docker.com/r/jamesdbloom/docker-java8-maven/)

## Details
The SNAP installer, created with [install4j](http://www.ej-technologies.com/products/install4j/overview.html) from [ej-technologies](http://www.ej-technologies.com/index.html), supports graphical, console and unattended installation (see [Install SNAP on the command line](https://senbox.atlassian.net/wiki/display/SNAP/Install+SNAP+on+the+command+line). 

The base container downloads the SNAP Unix installer and prepares the container ready for installation using [Dockerfile `ONBUILD` instructions](https://docs.docker.com/engine/reference/builder/#onbuild). For improved maintenance ONBUILD instructions are stored in a seperate Dockerfile; meaning less builds of the base image. Upon initiating a specific build, the `snap2.varfile` which contains the build options is copied to the container and the unattended installation of SNAP within the container is done by passing the option `-q` and the 'instalation file' to the installer via the `-varfile` option (all these commands are found in the `:on_build` Dockerfile, whereas the instalations instructions are in `snap2.varfile`). The Dockerfiles in each build directory mainly add metadata (labels, ect.).

SNAP has 2 headless APIs, `gpt` a mature command line interface and `snappy` a Python API. To facilitate the communication with SNAP via `snappy` a set of containers that include Python 2.7 (from the Debian package distribution system) are also available, note the Python instalation is intentially minimal and 'frozen' to a debian package release. 

Note: An initial (quick) test with [1science/docker-alpine:3.3](https://github.com/1science/docker-alpine) suggested The SNAP installer does not work with the minimilist Docker image from Alpine Linux; Error unpacking jar files. The architecture or bitness (32/64) of the bundled JVM might not match your machine. However, on the Alpine Linux distribution site 64bit version are available. More research to be done! 

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

## Acknowledgements
Thanks to ESA-STEP Sentinel Application Platform and Sentinel toolboxes development teams for making SNAP freely available.
Thanks to Docker for their excellent tool.
Thanks to Marco and STEP forum members for their prompt answers.
EPM is supported by the EU-FP7 project 'Foreshore Assessment using Space Research' (FAST, http://www.fast-space-project.eu/).
