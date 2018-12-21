#!/bin/bash

echo "Running build_with_docker generic package script for ROS..."

### This script serves as a deb packaging step within Docker-based buildpack

#$ARCH, $NAME, $VERSION, $OS_VERSION are supposed to be set by project's Makefile
NAME_VERSION="${NAME}_${VERSION}"

#Copy source of the project (and its depedent libraries if any) from current dir 
#to bin/$ARCH because of specifics of where dpkg-buildpackage wants
#source tar to be located and where we want resulting deb packages to be generated (i.e. in bin/$ARCH)
#rm -rf bin/$ARCH/src/*
#cp -R src bin/$ARCH

cd bin/$ARCH/src

# ROS env setup 
source /opt/ros/$ROS_DIST_VER/setup.bash


#### This needs to be done in each project if your project depends on the custom-built packages (i.e. recorded in rosdep/private.yaml)
### ROS rosdep refresh so depedencies in package.xml can be resolved against custom-built packages (e.g. translationlib from template_lib)
# sudo echo "yaml file:///.......rosdep/private.yaml" > /etc/ros/rosdep/sources.list.d/private.list

rosdep update

#dpkg-buildpackage requires sources to be tared this way
tar -czvf ros-$ROS_DIST_VER-$NAME_VERSION.orig.tar.gz $NAME

cd $NAME

#generate debian metadata for a particular OS and OS version
bloom-generate rosdebian --os-name ubuntu --os-version $OS_VERSION --ros-distro $ROS_DIST_VER

#Need to tweak debian/rules to source this workspace's setup.sh instead of standard ROS in /opt/ros
#because this translator package depends on translationlib that is being developed/compiled in the same catkin workspace
mv debian/rules debian/rules.tmp
sed "s|/opt/ros/${ROS_DIST_VER}/setup.sh|/${NAME}/bin/${ARCH}/install/setup.sh|g" debian/rules.tmp | \
sed "s|then|then export _CATKIN_SETUP_DIR=/${NAME}/bin/${ARCH}/install;|g"  > debian/rules

#For now, create only binary unsigned deb packages
#As the result, *.changes  and *.deb files will be created
#-d option skips apt dependency checking - this is needed only for packages that depend on the packages
#being developed/compiled in the same catkin workspace
dpkg-buildpackage -B -uc -d

