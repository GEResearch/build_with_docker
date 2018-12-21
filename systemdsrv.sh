#!/bin/bash

if [ $# -ne 2 ] || [ "$1" = "help" ]
then
    echo "Usage: "
    echo "  sudo ./systemdsrv.sh  help|install|uninstall  service_name"
    echo "       "
    echo "  must run this script in the same dir where 'service_name.service' file is located"
    exit 1
fi

if [ "$1" = "install" ]
then
  cp $2.service /etc/systemd/system
  systemctl daemon-reload
  systemctl enable $2
  systemctl start $2
elif [ "$1" = "uninstall" ]
then
  systemctl stop $2
  systemctl disable $2
  rm /etc/systemd/system/$2.service
else
  echo "Unsupported command '$1'"
fi

