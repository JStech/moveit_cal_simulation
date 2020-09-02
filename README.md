Running MoveIt Calibration in simulation
========================================

OpenCV 3.2, which is what ships with Ubuntu 18.04, has a buggy ArUco implementation. These instructions assume you have
OpenCV 3.4 installed in /usr/local/.

Set up a new workspace using the included `moveit_cal_simulation.rosinstall`:

    mkdir -p ws_moveit_cal/src
    cd ws_moveit_cal/src
    wstool init .
    wstool merge -t . https://raw.githubusercontent.com/JStech/moveit_cal_simulation/master/moveit_cal_simulation.rosinstall
    wstool update -t .
    cd ..

Configure and build:

    catkin config --extend /opt/ros/melodic --cmake-args -DOpenCV_DIR=/usr/local/share/OpenCV -DCMAKE_BUILD_TYPE=Release
    catkin build
    roslaunch panda_moveit_config demo_gazebo.launch

From there, follow [the tutorial](https://github.com/JStech/moveit_tutorials/blob/new-calibration-tutorial/doc/hand_eye_calibration/hand_eye_calibration_tutorial.rst).
