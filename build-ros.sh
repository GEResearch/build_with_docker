#!/bin/bash

### This script serves as a compilation step within Docker-based buildpack
echo "Running build_with_docker generic build script for ROS..."


#Figure out what packages to compile
if [ -d "./src" ]; then
  linkBasePath="../../../src/"
  if [ -z $PKGS ]; then   #if $PKGS is empty then get the list of all packages in the ROS workspace
    PKGS="$(ls ./src)"
  fi
else
  linkBasePath="../../../"
  if [ -z $PKGS ]; then   #if $PKGS is empty then get only name of the default ROS package in this ROS stack/repo
    PKGS=$NAME
  fi
fi

echo "Creating links to the ROS packages to be compiled: " $PKGS

# Create the directory structure to build with build_with_docker
mkdir -p bin/$ARCH/src
pushd bin/$ARCH/src

# Create links
for pkg in $PKGS;
do
  linkPath=$linkBasePath$pkg
  if [ ! -L $pkg ] ;
  then
    ln -s $linkPath $pkg
  fi
done

popd

#Compile ROS code and generate installable artifacts in install dir
cd bin/$ARCH
source /opt/ros/$ROS_DIST_VER/setup.bash

catkin init
catkin config --install
catkin build $CATKIN_ARGS


