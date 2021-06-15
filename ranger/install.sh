#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

sudo apt-get -y install caca-utils libimage-exiftool-perl w3m w3m-img
sudo apt-get install ranger caca-utils highlight atool w3m poppler-utils mediainfo

mkdir -p ~/.config/ranger

ln -fs $APP_PATH/rifle.conf ~/.config/ranger/rifle.conf
#ln -fs $APP_PATH/commands.py ~/.config/ranger/commands.py
ln -fs $APP_PATH/rc.conf ~/.config/ranger/rc.conf
ln -fs $APP_PATH/scope.sh ~/.config/ranger/scope.sh
