#!/bin/sh
# Check for nvidia-docker and use it otherwise use docker
if [ -x "$(command -v nvidia-docker)" ]
then
  echo "nvidia-docker"
else
  echo "docker"
fi
