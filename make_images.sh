# build base image
#docker build --tag="epmorris/debian8-snap3:base" snap3/debian8-snap3-base

#docker build --tag="epmorris/java8-maven3-git:snap_dev" java8-maven3-git-snap_dev


#docker build --tag="epmorris/alpine33-snap2:base" alpine33-snap2-base

docker build --tag="epmorris/debian8-snap3:on_build" snap3/debian8-snap3-on_build
#docker build --tag="epmorris/debian8-snap2:on_build_py" debian8-snap2-on_build_py

docker build --tag="epmorris/debian8-snap3:s1tbx" snap3/debian8-snap3-s1tbx
#docker build --tag="epmorris/debian8-snap2:s1tbx_py" debian8-snap2-s1tbx_py


#docker build --tag="epmorris/debian8-snap2:s2tbx" debian8-snap2-s2tbx

#docker build --tag="epmorris/debian8-snap2:s3tbx" debian8-step2-s3tbx