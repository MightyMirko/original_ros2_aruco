#!/bin/sh
uid=$(eval "id -u")
gid=$(eval "id -g")
docker build --build-arg UID="$uid" --build-arg GID="$gid" -t ros2_aruco/ros:humble .


# if the start_docker.sh script is here run it
if [ -f start_docker.sh ]; then
    ./start_docker.sh
fi
