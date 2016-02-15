# Docker containers for the Sentinel Application Platform
Docker containers including ESA-STEP Sentinel Application Platform (SNAP, http://step.esa.int/main/toolboxes/snap/) and Sentinel toolboxes jointly developed by Brockmann Consult, Array Systems Computing and C-S.

## Status
+ pre alpha, in development and may change at anytime without notice.
+ images not yet on Dockerhub.

## Versions
+ java8-maven-git For compiling developer versions of snap using netbeans.[TODO]
+ debian8-esa-step-snap2:install Base container ready to install snap and toolboxes (~550 Mb), not set to use GUI.
+ debian8-esa-step-snap2:s1tbx Base container with snap + s1tbx (~ 1Gb), no set to use GUI (made interactively, hence no Dockerfile).

## Dependencies

debian:8

## Installation

1.  [Install Docker](https://docs.docker.com/engine/installation/).

1. Download build from public [Docker Registry](https://index.docker.io/): `docker pull epmorris/debian8-esa-step-snap2:install`

(alternatively, you can build an image from Dockerfile: `docker build -t="epmorris/debian8-esa-step-snap2:install" github.com/edwardpmorris/docker-snap/debian8-esa-step-snap2`)


## Details

The snap installer is interactive; so far I have not found a way to automatically pass the install options during the docker build.
The base container builds debian:8 and downloads the snap install script.

To install snap in a container iteractively run the `:install` container by typing in a terminal:
```
docker run -it epmorris/debian-esa-step-snap2:install
```
The container will open in the terminal. 

+ Start the installer by typing `./$TBX`
+ Follow installation prompts (use the defaults or adjust and update commands below):
    + This will install ESA SNAP on your computer; OK [o, Enter]
    + Shall the installer try to remove these directories?; No [n, Enter]
    + Delete only SNAP-internal configuration data (recommended).?; No [n]
    + Where should ESA SNAP be installed?; [/usr/local/snap]
    + Which components should be installed?; [choose toolbox]
    + Create symlinks?; Yes [y, Enter] FIXME: is this needed, does not seem to have any effect?
    + Select the folder where you would like ESA SNAP to create symlinks, then click Next.; [/usr/local/bin]
    + Configure SNAP for use with Python?; No [n, Enter]
    + Run SNAP Desktop?; No [n]

+ add the snap bin to the container PATH by typing `PATH=$PATH:/usr/local/snap/bin`. FIXME: This does not appear to persist after commit.
+ Check all is installed ok by typing `gpt -h` in the container prompt; the help for the gpt command should appear.
+ If all is ok remove the install script by typing `rm $TBX`

+ With the docker container still open, open another terminal and get details about the container by typing `docker ps`. Note down the 'container id'. 
+ Commit the new image using the conatiner id and a suitable name:tag [`docker commit <container id> <name:tag>`] 
```
docker commit bfa6018090e6 epmorris/debian8-esa-step-snap2:s1tbx
```
+ Check the image is commited by typing `docker images` in the terminal; you should see your new image listed.
+ To finish, return to the container prompt and type `exit`.
+ Check container is closed by typing `docker ps` in a terminal.
+ Check the new container by opening a new terminal and typing:
```
docker run -it --rm epmorris/debian8-esa-step-snap2:s1tbx /usr/local/snap/bin/gpt -h
```

# TODO:

+ give use examples 
+ make completely automatic install when installer questions resolved.
+ adding vmoptions:
```
docker run -it -v /home/edward/snap/bin/gpt.vmoptions:/usr/local/snap/bin/gpt.vmoptions epmorris/debian8-esa-step-snap2:s1tbx
```
+ check why PATH assignment is not permenant in container
+ use ENTRYPOINT  and CMD in auto build to make 'surrogate' program?
