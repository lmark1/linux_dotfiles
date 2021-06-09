#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

sudo apt install -y python3-pip
sudo apt-get -y install neovim
sudo -H pip3 install wheel
sudo -H pip3 install neovim
sudo -H pip3 install neovim-remote
sudo apt install -y fonts-powerline
