#!/bin/bash

echo "Running build_with_docker generic test script for ROS..."

### This script serves as a testing step within Docker-based buildpack
### after build.sh already took place by build.sh

#Test ROS code
cd bin/$ARCH
source /opt/ros/$ROS_DIST_VER/setup.bash

catkin run_tests $CATKIN_ARGS

