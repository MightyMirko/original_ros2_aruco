##############################################################################
##                                 Base Image                               ##
##############################################################################
ARG ROS_DISTRO=humble
FROM ros:$ROS_DISTRO-ros-base AS base

RUN apt-get update && apt-get install --no-install-recommends -y \
    python3-pip \
    ros-$ROS_DISTRO-cv-bridge \
    ros-$ROS_DISTRO-tf2-tools \
    ros-$ROS_DISTRO-tf-transformations \
    && apt-get clean && rm -rf /var/lib/apt/lists/*



##############################################################################
WORKDIR /ros2_ws/src
COPY . ./ros2_aruco

##############################################################################
##                                 Build ROS and run                        ##
##############################################################################
WORKDIR /ros2_ws
RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build --symlink-install
RUN echo "source /home/$USER/ros2_ws/install/setup.bash" >> /home/$USER/.bashrc

RUN sed --in-place --expression \
    '$isource "/ros2_ws/install/setup.bash"' \
    /ros_entrypoint.sh


# CMD /bin/bash
CMD ["ros2", "launch", "ros2_aruco", "aruco_recognition.launch.py"]


