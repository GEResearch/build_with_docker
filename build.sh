#!/bin/bash

echo "Running build_with_docker generic script for cmake project..."
mkdir -p bin/$ARCH/src
cp -R $NAME bin/$ARCH/src

#Compile cmake project
cd bin/$ARCH/src/$NAME
cmake .
make
