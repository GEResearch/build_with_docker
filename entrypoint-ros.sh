#!/bin/bash

### This script serves as an entry point into a run-time Docker container

#setup ROS environment - by now our app is compiled
source /$NAME/install/setup.bash

#provide an ability to run various commands out of this container 
exec "$@"
