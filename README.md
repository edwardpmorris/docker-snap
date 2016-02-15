# Docker containers for the Sentinel Application Platform
Docker containers including ESA-STEP Sentinel Application Platform (SNAP, http://step.esa.int/main/toolboxes/snap/) and Sentinel toolboxes jointly developed by Brockmann Consult, Array Systems Computing and C-S.

## Versions
+ java8-maven-git: For compiling developer versions of snap using netbeans.
+ debian8-esa-step-snap2: Base container ready to install snap and toolboxes, not set to use GUI.
+ debian8-esa-step-snap-s1tbx: Base container with snap + s1tbx, no set to use GUI.

## Details

The snap installer is interactive; so far I have not found a way to automatically pass the install options during the docker build.
The base container builds debian:8 and downloads the snap install script.

To install snap in a container iteractively run the `base_install` container by typing in a terminal:
```
docker run -it edwardpmorris/debian-esa-step-snap2:install
```
The container will open in the terminal. 

+ Start the installer by typing './$TBX'
+ Follow installation prompts (use the defaults or adjust and update commands below):
    + This will install ESA SNAP on your computer; OK [o, Enter]
    + Shall the installer try to remove these directories?; No [n, Enter]
    + Delete only SNAP-internal configuration data (recommended).?; No [n]
    + Where should ESA SNAP be installed?; [/usr/local/snap]
    + Which components should be installed?; [choose toolbox]
    + Create symlinks?; Yes [y, Enter] FIXME: is this needed?
    + Select the folder where you would like ESA SNAP to create symlinks, then click Next.; [/usr/local/bin]
    + Configure SNAP for use with Python?; No [n, Enter]
    + Run SNAP Desktop?; No [n]

+ add the snap bin to the container PATH by typing 'PATH=$PATH:/usr/local/snap/bin'.
+ Check all is installed ok using 'gpt -h'; the help for the gpt command should appear.
+ If all is ok remove the install script by typing `rm $TBX`

+ with the docker container still open, open another terminal and get details about the container by typing `docker ps`. Note down the 'container id'. 
+ commit the new image using the conatiner id and a suitable name:tag 
```
docker commit bfa6018090e6 epmorris/debian8-esa-step-snap2:s1tbx
```
+ check the image is commited by typing `docker images`
+ to finish return to the base container and type `exit`
+ check container is closed by typing `docker ps` in a terminal.
+ check the new container by typing:
```
docker run -it epmorris/debian8-esa-step-snap2:s1tbx /usr/local/snap/bin/gpt -h
```

# TODO:

+ make completely automatic install when installer questions resolved.
+ adding vmoptions:
```
docker run -it -v /home/edward/snap/bin/gpt.vmoptions:/usr/local/snap/bin/gpt.vmoptions epmorris/debian8-esa-step-snap2:s1tbx
```
+ check why PATH assignment is not permenant in container
+ use ENTRYPOINT  and CMD in auto build to make 'surrogate' program