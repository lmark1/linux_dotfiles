#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

sudo apt install -y i3 i3blocks

# required for i3-layout-manager
sudo apt -y install jq rofi xdotool x11-xserver-utils indent libanyevent-i3-perl

sudo apt-get -y install lightdm

# for cpu usage in i3blocks
sudo apt-get -y install sysstat

# for brightness and volume control
sudo apt-get -y install xbacklight alsa-utils pulseaudio feh arandr

# for making gtk look better
sudo apt-get -y install lxappearance

# install useful gui utils
sudo apt-get -y install thunar rofi compton systemd

# copy fonts
# fontawesome 4.7
mkdir -p ~/.fonts
cp $APP_PATH/fonts/* ~/.fonts/

# link fonts.conf file
mkdir -p ~/.config/fontconfig
ln -sf $APP_PATH/fonts.conf ~/.config/fontconfig/fonts.conf