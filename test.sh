#!/bin/sh

echo "Running build_with_docker generic script..."

#Assumtion for this script that compile already took place by build.sh
cd bin/$ARCH/src/$NAME

echo "Running all tests for arch: " $ARCH
make test
