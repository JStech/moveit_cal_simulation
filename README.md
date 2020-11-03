Running MoveIt Calibration in simulation
========================================

### Available on Docker
If you prefer, you can skip the steps below and use the [Docker
image](https://hub.docker.com/repository/docker/jstechschulte/moveit_calibration_simulation)
instead.

### Avoid OpenCV 3.2
OpenCV 3.2, which is what ships with Ubuntu 18.04, has a buggy ArUco pose detection implementation. The instructions
below assume you have OpenCV 3.4 installed in `/usr/local/`. OpenCV 3.4 can be easily installed as follows:

    git clone https://github.com/RoboticsYY/opencv_deb_install.git
    sudo dpkg -i opencv_deb_install/OpenCV-3.4/OpenCV-3.4.5-x86_64-*

### Downloading and building MoveIt Calibration and simulation packages
If you haven't already, install `catkin`:

    sudo apt install ros-melodic-catkin python-catkin-tools

The simulation also requires Gazebo:

    sudo apt install ros-melodic-gazebo-ros ros-melodic-gazebo-plugins ros-melodic-gazebo-ros-control \
      ros-melodic-joint-state-controller ros-melodic-position-controllers ros-melodic-joint-trajectory-controller

Set up a new workspace using the included `moveit_cal_simulation.rosinstall`:

    mkdir -p ~/ws_moveit_cal/src
    cd ~/ws_moveit_cal/src
    wstool init .
    wstool merge -t . https://raw.githubusercontent.com/JStech/moveit_cal_simulation/main/moveit_cal_simulation.rosinstall
    wstool update -t .
    rosdep install -y --from-paths . --ignore-src --rosdistro melodic

Configure and build:

    cd ~/ws_moveit_cal
    catkin config --extend /opt/ros/melodic --cmake-args -DOpenCV_DIR=/usr/local/share/OpenCV -DCMAKE_BUILD_TYPE=Release
    catkin build
    roslaunch panda_moveit_config demo_gazebo.launch

From there, follow [the tutorial](https://ros-planning.github.io/moveit_tutorials/doc/hand_eye_calibration/hand_eye_calibration_tutorial.html).
