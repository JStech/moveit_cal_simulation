FROM ros:melodic-ros-base

# install OpenCV 3.4
RUN cd && git clone https://github.com/RoboticsYY/opencv_deb_install.git && \
    dpkg -i opencv_deb_install/OpenCV-3.4/OpenCV-3.4.5-x86_64-*

# install dependencies
RUN apt update && \
      apt install -y ros-melodic-catkin python-catkin-tools ros-melodic-gazebo-ros ros-melodic-gazebo-plugins \
      ros-melodic-gazebo-ros-control ros-melodic-joint-state-controller ros-melodic-position-controllers \
      ros-melodic-joint-trajectory-controller

# set up workspace
RUN mkdir -p ~/ws_moveit_cal/src && \
    cd ~/ws_moveit_cal/src && \
    wstool init . && \
    wstool merge -t . https://raw.githubusercontent.com/JStech/moveit_cal_simulation/main/moveit_cal_simulation.rosinstall && \
    wstool update -t . && \
    rosdep install -y --from-paths . --ignore-src --rosdistro melodic

# configure and build
RUN cd ~/ws_moveit_cal && \
    catkin config --extend /opt/ros/melodic --cmake-args -DOpenCV_DIR=/usr/local/share/OpenCV -DCMAKE_BUILD_TYPE=Release && \
    catkin build
