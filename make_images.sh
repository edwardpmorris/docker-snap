# build base image
docker build --tag="epmorris/debian8-snap2:base" debian8-snap2

docker build --tag="epmorris/debian8-snap2:s1tbx" debian8-snap2-s1tbx

docker build --tag="epmorris/debian8-snap2:s2tbx" debian8-snap2-s2tbx

docker build --tag="epmorris/debian8-snap2:s3tbx" debian8-step2-s3tbx