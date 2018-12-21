#!/bin/sh
# Check for nvidia-docker-compose and use it otherwise use docker
if [ -x "$(command -v nvidia-docker-compose)" ]
then
  echo "nvidia-docker-compose"
else
  echo "docker-compose"
fi
