#!/bin/bash

set -o errexit
set +o nounset
set -o pipefail

# USER and GROUP env vars are supposed to be passed into a dev container (see build_with_docker's Makefile.in)
# so all processes inside of the dev container run as the user:group on host OS

# Check if any of them are blank and set defaults as needed
if [ -z $USER_ID ]; then
  USER_ID=0
fi
if [ -z $USER ]; then
  USER="root"
fi
if [ -z $GROUP_ID ]; then
  GROUP_ID=0
fi
if [ -z "$GROUP" ]; then
  GROUP="root"
fi

echo "Provisioning container with user=${USER_ID}(${USER}) group=${GROUP_ID}(${GROUP}) addl.groups=${GROUPS}"

if [ ! $(getent group $GROUP_ID) ]; then
  # Add if the group does not exist
  groupadd --gid $GROUP_ID ${GROUP// /_}
fi


if [ ! $(getent passwd $USER_ID) ]; then
  # If this user doesn't already exist - we will setup the new user

  # Add the user
  home_dir=/home/$USER
  useradd --shell /bin/bash -o --uid $USER_ID --gid $GROUP_ID $USER --home $home_dir

  # Add the user to more groups if needed (e.g. users sometime need to be part of video group to be able to read video resources
  # from a container
  if [ ! -z "$GROUPS" ]; then
     usermod -aG $GROUPS $USER
  fi

  # Ensure the home directory exists...  It may have beem mapped in as a volume
  # so there would be no need to create or chmod
  if [ ! -d "$home_dir" ]; then
    mkdir -p $home_dir
    chown $USER_ID:$GROUP_ID $home_dir
  fi

  # Allow the user no password sudo access
  mkdir -p /etc/sudoers.d
  echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER}
fi

exec su $USER "$@"
