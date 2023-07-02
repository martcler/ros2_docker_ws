# syntax=docker/dockerfile:1

# Choose ROS version & Define arguments
ARG BASE_IMAGE=ros
ARG BASE_TAG=humble
ARG WORKSPACE=ros2_docker_ws

# Import ROS
FROM ${BASE_IMAGE}:${BASE_TAG}

# Disable interactive content
ENV DEBIAN_FRONTEND=noninteractive 

# Import necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    git \
    bash-completion \
    build-essential \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${HOME}/${WORKSPACE}/src

WORKDIR ~/${WORKSPACE}
RUN /bin/bash -c "source source /opt/ros/${ROS_DISTRO}/setup.bash; colcon build --symlink-install"

# Clear the environment to avoid potential conflicts in future RUN commands
ENV CMAKE_PREFIX_PATH=${ROS_WS}/install:${CMAKE_PREFIX_PATH}