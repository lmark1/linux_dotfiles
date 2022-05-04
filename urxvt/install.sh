#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

# install urvxt
sudo apt-get -y install rxvt-unicode-256color

EXTENSION_PATH="/usr/lib/x86_64-linux-gnu/urxvt/perl"
sudo mkdir -p $EXTENSION_PATH

# link extensions
for file in `ls $MY_PATH/extensions/`; do
	sudo ln -fs $MY_PATH/extensions/$file $EXTENSION_PATH/$file
done

# TODO Check if there is Xdefaults - might be colliding
ln -fs $MY_PATH/dotXresources ~/.Xresources
xrdb ~/.Xresources
