#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

sudo apt install -y silversearcher-ag
sudo apt install -y zsh
chsh -s $(which zsh)
[ ! -e "$HOME/.oh-my-zsh" ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "NEED TO LOGOUT FOR ZSH CHANGES TO TAKE EFFECT !!"
